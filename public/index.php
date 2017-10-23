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

/* Connect to database */
$servername = getenv("DB_SERVER");
$database = getenv("DB_DATABASE");
$username = getenv("DB_USER");
$password = getenv("DB_PASSWORD");

// error_log("Connecting:".$servername.$database.$username.$password);
    

// Create connection
$conn_string = "host=".$servername." dbname=". $database ." user=".$username." password=".$password;
$conn = pg_connect($conn_string);
if (!$conn) {
    $error = error_get_last();
    throw new Exception("Connection failed: " . $error["message"]);
}

/* get ETH PRICE */
setlocale(LC_MONETARY, 'en_US');

$ethPrice = 0;
$priceResult = json_decode(file_get_contents('https://api.coinbase.com/v2/prices/ETH-USD/sell'),true);
$ethPrice = $priceResult['data']['amount'];

/* get BTC Price */
$btcPrice = 0;
$btcPriceResult = json_decode(file_get_contents('https://api.coinbase.com/v2/prices/BTC-USD/sell'), true);
$btcPrice = $btcPriceResult['data']['amount'];
$satoshiPrice = $btcPrice / 100000000;



/* Projects to be displayed 
   NOTICE: The order of which they are displayed  equeals the order of the tickers given here
*/

$tickers = array("ANT", "CFI", "DAP", "DNT", "DNA", "RSC", "EXP/LAB", "GAT", "HSR", "PREB", "ICN", "IND", "LKK", "ART", "MCI", "SAN", "VIC");

/* get balances */

function getWallets($ticker_list) {
    $wallets = [];

    global $conn;
    global $ethPrice;
    global $satoshiPrice;

    
    $quoted = array_map( function ($token) { return "'".$token."'"; }, $ticker_list );
    $sql_tickers = join(", ", $quoted);

    /* Get current wallet data */
    $sql = <<<SQL

SELECT
  ticker,
  eth_balance,
  satoshi_balance

FROM 
  (
    SELECT
      ticker,
      SUM(latest_eth_wallet_data.balance) AS eth_balance
    FROM
      project,
      project_eth_address,
      latest_eth_wallet_data
    WHERE
      project.id = project_eth_address.project_id AND
      project_eth_address.address = latest_eth_wallet_data.address

    GROUP BY
      ticker
  ) as eth

  NATURAL FULL OUTER JOIN

  (
    SELECT
      ticker,
      SUM(latest_btc_wallet_data.satoshi_balance) AS satoshi_balance
    FROM
      project,
      project_btc_address,
      latest_btc_wallet_data
    WHERE
      project.id = project_btc_address.project_id AND
      project_btc_address.address = latest_btc_wallet_data.address

    GROUP BY
      ticker
  ) as btc;

SQL;

//     $sql = <<<SQL
// SELECT
//   ticker,
//   SUM(latest_eth_wallet_data.balance) AS eth_balance,
//   SUM(latest_btc_wallet_data.satoshi_balance) AS satoshi_balance,

// FROM
//   project,
//   project_eth_address,
//   latest_eth_wallet_data,
//   latest_btc_wallet_data

// WHERE
//   project.id = project_eth_address.project_id AND
//   project_eth_address.address = latest_eth_wallet_data.address

// GROUP BY
//   ticker

// SQL;

    $result = pg_query($conn, $sql);

    while ($row = pg_fetch_assoc($result)) {
        $ticker = $row['ticker'];
        $wallets[$ticker]['eth_balance'] = $row['eth_balance'];
        $satoshi_balance = $row['satoshi_balance'];
        $wallets[$ticker]['btc_balance'] = $satoshi_balance / 100000000;
        $wallets[$ticker]['usd_balance'] = ($row['eth_balance'] * $ethPrice)
                                         + ($satoshi_balance * $satoshiPrice);
    }

    /* Get current market cap */

    $sql = <<<QUERY

SELECT
  p.ticker as ticker,
  c.id as id,
  c.market_cap_usd as market_cap_usd
FROM
  project as p,
  latest_coinmarketcap_data as c
WHERE
  p.coinmarketcap_id = c.id AND
  p.ticker in ({$sql_tickers});

QUERY;

    //$sql = "SELECT * FROM cmm_data WHERE ticker in (".$sql_tickers.")";
    //error_log($sql);
    $result = pg_query($conn, $sql);

    while ($row = pg_fetch_assoc($result)) {
        //error_log($row['ticker'] . " ". $row['id']);
        $ticker = $row['ticker'];
        $wallets[$ticker]['market_cap'] = $row['market_cap_usd'];
    }

    return $wallets;

}

$walletData = getWallets($tickers);

$totalMarketCap = array_reduce( $walletData, function ($aggregate, $wallet) {
    if ( array_key_exists('market_cap', $wallet)) {
        $aggregate += $wallet['market_cap'];
    };

    return $aggregate;
}, 0);


function balanceStr($ticker) {
    global $walletData;

    $result = "";

    if( !array_key_exists($ticker, $walletData )) {
        return "Verifying";
    }
    $wallet = $walletData[$ticker];


    //Write USD balance
    if ( !array_key_exists('usd_balance', $wallet) ) {
        return "Verifying";
    }

    $result = $result . "$" . number_format( $wallet['usd_balance'], 0);

    //Write BTC balance (if any)
    if (array_key_exists('btc_balance', $wallet) and $wallet['btc_balance'] > 0.049) {
        $result = $result . "<br/>Ƀ" . number_format( $walletData[$ticker]['btc_balance'], 1);
    }

    //Write ETH balance (if any)
    if (array_key_exists('eth_balance', $wallet) and ($walletData[$ticker]['eth_balance']> 0.049)) {
        $result = $result . "<br/>Ξ" . number_format( $walletData[$ticker]['eth_balance'], 1);
    }

    return $result;
}

function marketCapStr($ticker) {
    global $walletData;

    if (array_key_exists( $ticker, $walletData) and
        array_key_exists( 'market_cap', $walletData[$ticker])) {
        return "$". number_format( $walletData[$ticker]['market_cap'], 0);
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

$projectData = [];
$projectData = [
    "ANT" => [
        "img" => "img/projects/aragon.png",
        "projectid" => "Aragon",
        "collected" => "Ξ275,000.0",
        "status" => $certified,
        "description" => "Manage entire organisations using the blockchain."
    ],

    "PREA" => [
        "img" => "img/projects/attores.png",
        "projectid" => "Attores",
        "collected" => "",
        "status" => $verifying,
        "description" => "Blockchain applications & smart contracts (digital signatures and certificates)."
    ],

    "AVT" => [
            "img" => "img/projects/aventus.png",
            "projectid" => "Aventus",
            "collected" => "",
            "status" => $verifying,
            "description" => "Aventus is creating a fair, secure, and transparent protocol for ticket exchange that solves problems the biggest problems in the industry."
        ],

    "CFI" => [
        "img" => "img/projects/cofoundit.png",
        "projectid" => "Cofound.it",
        "collected" => "Ξ56,565",
        "status" => $verifying,
        "description" => "Distributed global platform that connects exceptional startups, experts and investors worldwide."
    ],

    "DAP" => [
        "img" => "img/projects/dappbase.png",
        "projectid" => "Dappbase",
        "collected" => "",
        "status" => $preico,
        "description" => "Powerful and accessible tools for decentralized app development."
    ],

    "DNT" => [
        "img" => "img/projects/district0x.png",
        "projectid" => "district0x",
        "collected" => "Ξ43,170.0",
        "status" => $certified,
        "description" => "A network of decentralized marketplaces and communities."
    ],

    "DNA" => [
        "img" => "img/projects/encrypgen.png",
        "projectid" => "Encrypgen",
        "collected" => "",
        "status" => $verifying,
        "description" => "Enchanced security for safe cloud storage and sharing of genomic data."
    ],

    "RSC" => [
        "img" => "img/projects/etherisc.png",
        "projectid" => "Etherisc",
        "collected" => "Ξ100.369",
        "status" => $verifying,
        "description" => "A decentralized insurance and reinsurance marketplace."
    ],

    "EXP/LAB" => [
            "img" => "img/projects/expanse.png",
            "projectid" => "Expanse/Tokenlab",
            "collected" => "",
            "status" => $preico,
            "description" => "Expanse is a dAapp development organization that also has its own Ethereum compatible blockchain. Our latest project is Tokenlab."
        ],

    "GAT" => [
        "img" => "img/projects/gatcoin.png",
        "projectid" => "Gatcoin",
        "collected" => "",
        "status" => $preico,
        "description" => "Global distributed shopping platform."
    ],

    "HSR" => [
        "img" => "img/projects/hcash.png",
        "projectid" => "Hshare",
        "collected" => "Ƀ21,000",
        "status" => $verifying,
        "description" => "A decentralized and open-source cross-platform cryptocurrency."
    ],

    "PREB" => [
        "img" => "img/projects/iconiqlab.png",
        "projectid" => "Iconiq Lab",
        "collected" => "",
        "status" => $preico,
        "description" => "Seed funding wallet and accelerator that helps crypto, blockchain and technology startups run their own ICOs."
    ],

    "ICN" => [
        "img" => "img/projects/iconomi.png",
        "projectid" => "Iconomi",
        "collected" => '$10,395,054',
        "status" => $certified,
        "description" => "Investment fund management platform for the decentralized economy."
    ],

    "IND" => [
        "img" => "img/projects/indorse.png",
        "projectid" => "Indorse",
        "collected" => 'Ξ27,422',
        "status" => $verifying,
        "description" => "Decentralised professional networking platform."
    ],

    "LKK" => [
        "img" => "img/projects/lykke.png",
        "projectid" => "Lykke",
        "collected" => "Ξ264,399",
        "status" => $verifying,
        "description" => "Blockchain-based marketplace where financial instruments can be traded and settled P2P."
    ],

    "ART" => [
        "img" => "img/projects/maecenas.png",
        "projectid" => "Maecenas",
        "collected" => "Ξ48,555",
        "status" => $verifying,
        "description" => "Decentralized art investment platform — where anyone can own a piece of a Picasso."
    ],

    "MCI" => [
        "img" => "img/projects/musiconomi.png",
        "projectid" => "Musiconomi",
        "collected" => "Ξ17,648",
        "status" => $verifying,
        "description" => "A global music economy that works for everyone."
    ],

    "SAN" => [
        "img" => "img/projects/santiment.png",
        "projectid" => "Santiment",
        "collected" => "Ξ45,000.0",
        "status" => $certified,
        "description" => "Datafeeds and transparency platform for the crypto-markets."
    ],

    "SNT" => [
        "img" => "img/projects/status.png",
        "projectid" => "Status.im",
        "collected" => "Ξ299343.1",
        "status" => $certified,
        "description" => "Open source mobile client built entirely on Ethereum technologies."
    ],

    "VIC" => [
        "img" => "img/projects/virgilcapital.png",
        "projectid" => "Virgil Capital",
        "collected" => "",
        "status" => $preico,
        "description" => "Investment firm that specializes in real estate and angel investing."
    ]
   
];


function displayProject($ticker) {
    
    global $projectData;

    $data = $projectData[$ticker];
    $marketCap = marketCapStr($ticker);
    $balance = balanceStr($ticker);

    return <<<PROJECT
<div class="project">
  <div class="info">
    <div class="projectid"><img src="{$data['img']}" />{$data['projectid']}</div>
    <div class="numbers">
      <div class="marketcap"><label>Market Cap</label>{$marketCap}</div>
      <div class="collected"><label>Collected</label>{$data['collected']}</div>
      <div class="balance"><label>Balance</label>{$balance}</div>
    </div>
    {$data['status']}
  </div>
  <div class="description">
    <p>{$data['description']}</p>
  </div>
</div>  
PROJECT;
    
}

$projectView = join("\n",array_map( "displayProject", $tickers));
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
            <p><strong>About Santiment:</strong> Santiment is the world's first crypto-market big data network, combining market datafeeds, sentiment
            analysis, blockchain analytics, and everything else crypto-traders need for this emerging market. Built by traders for traders,
            the network gives participants an information edge over the competitors thanks to machine learning and the wisdom of the crowd.</p>
            <br />
            <p><strong>Contact for Santiment.net</strong><br />
               Dorjee Sun: <a href="mailto:dorjee.s@santiment.net">dorjee.s@santiment.net</a><br />
               Contact: +61 416 292 245<br />
               WhatsApp: +65 9777 0416<br />
               Skype: dorjee.sun</p>
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
