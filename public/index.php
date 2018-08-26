<?php

try {
    require __DIR__ . '/../vendor/autoload.php';

/* Load env variables 
   The .env file is in the main dirctory, and __DIR__ should equal /public.
*/
    $dotenv = new Dotenv\Dotenv(__DIR__ . "/..");
    $dotenv->load();
} catch (Exception $e) {
    error_log("Caught exception:" . ($e->getMessage()));
}

$sanbaseGraphQlUrl = getenv("SANBASE_GRAPHQL_URL");
$sanbaseGraphQlUsername = getenv("SANBASE_GRAPHQL_USERNAME");
$sanbaseGraphQlPassword = getenv("SANBASE_GRAPHQL_PASSWORD");

$sanbaseClient = new EUAutomation\GraphQL\Client($sanbaseGraphQlUrl);

$query = <<<'QUERY'
{
    allProjectsProjectTransparency {
        name,
        ticker,
        logoUrl,
        btcBalance,
        ethBalance,
        marketcapUsd,
        projectTransparencyStatus,
        projectTransparencyDescription,
        fundsRaisedIcos {
            currencyCode,
            amount
        }
    }
}
QUERY;

$headers = [
    "authorization" => "Basic ".base64_encode($sanbaseGraphQlUsername . ":" . $sanbaseGraphQlPassword)
];

try {
    $resp = $sanbaseClient->response($query, null, $headers);

    $projectsData = $resp->allProjectsProjectTransparency;
} catch (Exception $e) {
    echo 'Caught exception: ',  $e, "\n";
}

/* get ETH PRICE */
setlocale(LC_MONETARY, 'en_US');

// TODO: get eth & btc price from sanbase as well
$ethPrice = 0;
$priceResult = json_decode(file_get_contents('https://api.coinbase.com/v2/prices/ETH-USD/sell'),true);
$ethPrice = $priceResult['data']['amount'];

/* get BTC Price */
$btcPrice = 0;
$btcPriceResult = json_decode(file_get_contents('https://api.coinbase.com/v2/prices/BTC-USD/sell'), true);
$btcPrice = $btcPriceResult['data']['amount'];
$satoshiPrice = $btcPrice / 100000000;


/* get balances */

foreach($projectsData as $project)
{
    if(!is_null($project->btcBalance) or !is_null($project->ethBalance))
    {
        $usdBalance = 0;
        if(!is_null($project->btcBalance))
        {
            $project->btcBalance = floatval($project->btcBalance)/100000000;
            $usdBalance+=$project->btcBalance*$btcPrice;
        }
        if(!is_null($project->ethBalance))
        {
            $project->ethBalance = floatval($project->ethBalance);
            $usdBalance+=$project->ethBalance*$ethPrice;
        }
        $project->usdBalance = $usdBalance;
    }
    else
    {
        $project->usdBalance = NULL;
    }
}
unset($project);

$totalMarketCap = array_reduce( $projectsData, function ($aggregate, $project) {
    if ( !is_null($project->marketcapUsd)) {
        $aggregate += floatval($project->marketcapUsd);
    };

    return $aggregate;
}, 0);


function balanceStr($project) {

    //Write USD balance
    if ( is_null($project->usdBalance) ) {
        return "Verifying";
    }

    $result = $result . "$" . number_format( $project->usdBalance, 0);

    //Write BTC balance (if any)
    if (!is_null($project->btcBalance) and $project->btcBalance > 0.049) {
        $result = $result . "<br/>Ƀ" . number_format( $project->btcBalance, 1);
    }

    //Write ETH balance (if any)
    if (!is_null($project->ethBalance) and $project->ethBalance > 0.049) {
        $result = $result . "<br/>Ξ" . number_format( $project->ethBalance, 1);
    }

    return $result;
}

function marketCapStr($project) {

    if (!is_null($project->marketcapUsd)) {
        return "$". number_format( floatval($project->marketcapUsd), 0);
    }
    else
    {
        return 'Verifying';
    }
}


/* Static project data */

$certified = '<div class="rating certified"><img src="img/certified.png" />Certified</div>';
$verifying = '<div class="rating verifying"><img src="img/verifying.png" />Verifying</div>';
$preico = '<div class="rating preico"><img src="img/preico.png" />Pre-ICO</div>';

function statusStr($project) {

    if($project->projectTransparencyStatus == "Certified") {
        return '<div class="rating certified"><img src="img/certified.png" />Certified</div>';
    } else if($project->projectTransparencyStatus == "Verifying") {
        return '<div class="rating verifying"><img src="img/verifying.png" />Verifying</div>';
    } else {
        return '<div class="rating preico"><img src="img/preico.png" />'. $project->projectTransparencyStatus .'</div>';
    }
}

function collectedStr($project) {

    $count = count($project->fundsRaisedIcos);
    $text = "";
    for ($i = 0; $i < $count; $i++) {
        $currencyAmount = $project->fundsRaisedIcos[$i];

        if(!is_null($currencyAmount->currencyCode) and !is_null($currencyAmount->amount)) {
            if($i > 0) {
                if($i < $count - 1) {
                    $text = $text . ", ";
                } else {
                    $text = $text . " and ";
                }
            }

            if($currencyAmount->currencyCode == "ETH") {
                $text = $text . "Ξ";
            } else if($currencyAmount->currencyCode == "BTC") {
                $text = $text . "Ƀ";
            } else if($currencyAmount->currencyCode == "USD") {
                $text = $text . "$";
            } else {
                $text = $text . $currencyAmount->currencyCode . " ";
            }

            $amount = floatval($currencyAmount->amount);
            $text = $text . number_format( $amount, 0);
        }
    }

    return $text;
}

function displayProject($project) {

    $marketCap = marketCapStr($project);
    $balance = balanceStr($project);
    $status = statusStr($project);
    $collected = collectedStr($project);

    return <<<PROJECT
<div class="project">
  <div class="info">
    <div class="projectid"><img src="img/projects/{$project->logoUrl}" />{$project->name}</div>
    <div class="numbers">
      <div class="marketcap"><label>Market Cap</label>{$marketCap}</div>
      <div class="collected"><label>Collected</label>{$collected}</div>
      <div class="balance"><label>Balance</label>{$balance}</div>
    </div>
    {$status}
  </div>
  <div class="description">
    <p>{$project->projectTransparencyDescription}</p>
  </div>
</div>  
PROJECT;
    
}

$projectView = join("\n",array_map( "displayProject", $projectsData));
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="icon" type="image/png" href="img/favicon2.png" />
    <!-- Bootstrap CSS, then custom -->
    <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous"> -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Nunito:100,300,400,700" rel="stylesheet">
    <script src="https://use.fontawesome.com/6f993f4769.js"></script>
    <link href="css/style.css" rel="stylesheet">
    <!-- Global Site Tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-84150740-2"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments)};
        gtag('js', new Date());
        gtag('config', 'UA-84150740-2');
    </script>
</head>
<body id="wrap" class="colorblend">

<div class="wrapper">

    <div class="header">
        <img src="img/san_icon.png" />
        <h1>Project Transparency</h1>
        <p>Leading members of the blockchain and cryptocurrency industry unite to
        launch Project Transparency, a voluntary disclosure standard which aims to
        bring self governance and greater transparency for investors and the community.
            <a href="https://docs.google.com/forms/d/e/1FAIpQLSfGQjirTQfR9oZ_9hWjhfZTEjFkx4Gcavp7sfxYAFPNhTCxoQ/viewform" target="_blank">Contact us with questions</a></p>
        <a class="button home" onclick="shLearn()">Learn More</a>
        <a class="button home" href="https://docs.google.com/forms/d/e/1FAIpQLScsfn5pRQ8gQrrT_7tsEcyNHbM96hTNyk9MUCtJSY-_MWgHcw/viewform" target="_blank">Submit a Project</a>
    </div>

    <div class="content">
        <div class="project total">
            <p>Total Represented Market Cap <span>$<?php echo number_format($totalMarketCap, 0); ?></p>
       </div>
       <?php echo $projectView; ?>
    </div>

    <div class="footer">
        <a href="https://santiment.net" target="_blank"><img src="img/logo_footer.png" /></a>
        <!-- <p><a href="https://santiment.net" target="_blank">santiment.net</a> &bull; <a href="https://sanbase.io" target="_blank">sanbase.io</a></p> -->
    </div>

    <div id="learn" class="learn-wrapper">
        <div class="learn-content">
            <div id="close" onclick="shLearn()">
                <i class="fa fa-close"></i>
            </div>
            <h2>PROJECT TRANSPARENCY LAUNCHED BY SIXTEEN INDUSTRY LEADERS, EMBARGOED UNTIL ICO SUMMIT, 2 OCTOBER 2017 (VIENNA, AUSTRIA)</h2>
            <h3>Aragon, Cofound.it, District0x, Encrypgen, Etherisc, Hcash, Iconomi, Indorse, Lykke, Santiment, Dappbase, GATCOIN,
            Iconiq Lab, Virgil Capital, Musiconomi and Maecenas</h3>
            <p><em>Goal to create a self regulated, industry led movement toward greater transparency and accountability within
            the Blockchain sector for investors and the community</em></p>
            <ul>
                <li>16 pre and post ICO projects, accelerators, professional services & hedge fund in the blockchain and the
                cryptocurrency industry unite to launch this self regulated initiative</li>
                <li>Project Transparency represents > $650M USD in market capitalisation</li>
                <li>Aim to improve regulatory procedures and disclosure within digital currency sector</li>
                <li>Ambition for industry-wide adoption of Project Transparency for clearer disclosures</li>
            </ul>
            <p>Santiment, (<a href="https://santiment.net" target="_blank">santiment.net</a>) the world’s first crypto-market datafeed
            platform, today announces at the Vienna ICO-Summit that it
            has worked with 15 other projects to launch Project Transparency. The voluntary initiative aims to encourage disclosure
            of wallets controlled by a project and provide a voluntary explanation of any expenditure greater than 0.5% of the
            funds collected.</p>
            <p>Santiment joins a number of ethical, industry leading digital asset industry players including Aragon, Cofound.it,
            District0x, Encrypgen, Etherisc, Hcash, Iconomi, Indorse, Lykke, Santiment, Dappbase, GATCOIN, Iconiq Lab, Virgil Capital,
            Musiconomi and Maecenas to present the long term ambition is to provide potential investors and the community with greater transparency and
            accountability for funds raised as the ICO space sees greater regulatory scrutiny in many markets and even legal restriction
            in China and Korea.</p>
            <p>Maksim Balashevich, CEO and Founder of Santiment, said: "With the rapid rise of digital currencies and proliferation of
            ICOs, investors increasingly want security regarding their funds and transparency on how they are administered. Santiment
            was developed to provide insight and transparency to investors looking to enter illiquid and highly volatile markets,
            Project Transparency affirms our commitment to improving governance in the Blockchain sector."</p>
            <p>Santiment has confirmed that it will provide funding for Project Transparency’s web page (www.ProjectTransparency.org)
            and for manpower to process applications and keep the initiative staffed. Any Blockchain project can join the initiative,
            the only criteria is to disclose the wallets controlled, funds held and explain any expenditures over 0.5% of the funds
            raised.</p>
            <p>With more than $650M USD of market capitalisation represented by Project Transparency, there is significant momentum for this
            industry led initiative. The evolution of next generation levels of transparency is important as it matures and continues its
            journey towards self governance in the tokenized economy. Taiyang Zhang CEO of pre-ICO project Dappbase, and GATCOIN’s Simon
            Cheong explained that their support for Project Transparency stemmed from their imminent funding goals and the investor
            interest for this voluntary disclosure: "transparency drives better, sustainable business. And that's what we want."</p>
            <p><strong>About Santiment:</strong> Santiment is a platform for accessing cryptocurrency data, sharing insights, and
            learning about how crypto markets work. We welcome data scientists, crypto traders and investors, and anyone passionate
            about promoting trust and transparency to create a better society for all people.</p>
            <br />
            <p><strong>Contact for Santiment.net</strong><br />
               <a href="mailto:team@santiment.net">team@santiment.net</a></p>
        </div>
    </div>

</div>

<script type="text/javascript">
    function shLearn() {
        var x = document.getElementById('learn');
        if (x.style.display === 'block') {
            x.style.display = 'none';
            document.getElementById("wrap").classList.remove('noscroll');
        } else {
            x.style.display = 'block';
            document.getElementById("wrap").classList.add('noscroll');
        }
    }
</script>

</body>
</html>
