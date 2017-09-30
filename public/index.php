<?php
require __DIR__ . '/../vendor/autoload.php';

/* Load env variables 
   The .env file is in the main dirctory, and __DIR__ should equal /public.
*/

$dotenv = new Dotenv\Dotenv(__DIR__ . "/..");
$dotenv->load();

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



/* Projects to be displayed 
   NOTICE: The order of which they are displayed  equeals the order of the tickers given here
*/

$tickers = array("ANT","CFI", "DNT", "DNA", "HSR", "ICN", "LKK", "SAN", "SNT");

/* get balances */

function getWallets($ticker_list) {
    $wallets = [];

    global $conn;
    global $ethPrice;

    
    $quoted = array_map( function ($token) { return "'".$token."'"; }, $ticker_list );
    $sql_tickers = join(", ", $quoted);

    /* Get current wallet data */

    $sql = "SELECT * FROM wallet_data WHERE ticker in (".$sql_tickers.")";

    $sql = <<<SQL
SELECT 
  ticker,
  project_eth_address.address AS address,
  latest_eth_wallet_data.balance AS balance

FROM 
  project,
  project_eth_address,
  latest_eth_wallet_data

WHERE
  project.id = project_eth_address.project_id AND
  project_eth_address.address = latest_eth_wallet_data.address;
SQL;

    $result = pg_query($conn, $sql);

    while ($row = pg_fetch_assoc($result)) {
        $ticker = $row['ticker'];
        $wallets[$ticker]['balance'] = $row['balance'];
        $wallets[$ticker]['usd_balance'] = $row['balance'] * $ethPrice;
    }

    /* Get current market cap */

    $sql = "SELECT * FROM cmm_data WHERE ticker in (".$sql_tickers.")";
    $result = pg_query($conn, $sql);

    while ($row = pg_fetch_assoc($result)) {
        $ticker = $row['ticker'];
        $wallets[$ticker]['market_cap'] = $row['market_cap'];
    }

    return $wallets;

}

$walletData = getWallets($tickers);

function balanceStr($ticker) {
    global $walletData;
    if ($walletData[$ticker]['balance'] == null) {
        return "No data";
    }
    return "$". number_format( $walletData[$ticker]['usd_balance'], 0)
              . "<br/>Ξ" . number_format( $walletData[$ticker]['balance'], 1);
}

function marketCapStr($ticker) {
    global $walletData;

    if ($walletData[$ticker]['market_cap'] == null) {
        return "Verifying";
    }
    return "$". number_format( $walletData[$ticker]['market_cap'], 0);
}


/* Static project data */

$certified = '<div class="rating certified"><img src="img/certified.png" />Certified</div>';
$verifying = '<div class="rating verifying"><img src="img/verifying.png" />Verifying</div>';

$projectData = [];
$projectData = [
    "ANT" => [
        "img" => "img/projects/aragon.png",
        "projectid" => "Aragon",
        "collected" => "Ξ275,000.0",
        "status" => $certified,
        "description" => "Manage entire organisations using the blockchain."
    ],

    "CFI" => [
        "img" => "img/projects/cofoundit.png",
        "projectid" => "Cofound.it",
        "collected" => "Ξ56,565",
        "status" => $verifying,
        "description" => "Distributed global platform that connects exceptional startups, experts and investors worldwide."
    ],

    "DNT" => [
        "img" => "img/projects/district0x.png",
        "projectid" => "district0x",
        "collected" => "Ξ43,170.0",
        "status" => $certified,
        "description" => "A network of decentralized marketplaces and communities"
    ],

    "DNA" => [
        "img" => "img/projects/encrypgen.png",
        "projectid" => "Encrypgen",
        "collected" => "Ξ43,170.0",
        "status" => $certified,
        "description" => "Enchanced security for safe cloud storage and sharing of genomic data."
    ],

    "HSR" => [
        "img" => "img/projects/hcash.png",
        "projectid" => "Hshare",
        "collected" => "BTC21,000",
        "status" => $verifying,
        "description" => "A decentralized and open-source cross-platform cryptocurrency."
    ],

    "ICN" => [
        "img" => "img/projects/iconomi.png",
        "projectid" => "Iconomi",
        "collected" => '$10,395,054',
        "status" => $certified,
        "description" => "Investment fund management platform for the decentralized economy."
    ],

    "LKK" => [
        "img" => "img/projects/lykke.png",
        "projectid" => "Lykke",
        "collected" => "Ξ264,399",
        "status" => $verifying,
        "description" => "Blockchain-based marketplace where financial instruments can be traded and settled P2P."
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
    <script async src=“https://www.googletagmanager.com/gtag/js?id=UA-84150740-2“></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments)};
        gtag('js', new Date());
        gtag('config', 'UA-84150740-2');
    </script>
</head>
<body class="colorblend">

<div class="wrapper">

    <div class="header">
        <img src="img/san_icon.png" />
        <h1>Project Transparency</h1>
        <p>Santiment introduces the first financial reporting system for blockchain projects.
            Today’s top teams are leading the way reporting their earnings and expenditures –
            so you can make informed investment decisions.</p>
        <a class="button home" onclick="shLearn()">Learn More</a>
        <a class="button home" href="https://docs.google.com/forms/d/e/1FAIpQLScsfn5pRQ8gQrrT_7tsEcyNHbM96hTNyk9MUCtJSY-_MWgHcw/viewform" target="_blank">Submit a Project</a>
    </div>

    <div class="content">
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
            <h2>Santiment Project Transparency Initiative</h2>
            <p>Santiment is teaming with leading blockchain projects to create a "self-governing" movement that aims to
                reduce potential regulatory crackdowns. In the spirit of traditional financial reporting by publicly-traded companies,
                Project Transparency is starting as a very simple voluntary disclosure of wallets controlled by a project and an
                explanation of any expenditure > 0.5% of the funds collected.</p>
            <h3>What is certification?</h3>
            <p>"Certification" means that a project has opened the following information to the public:</p>
            <ul>
                <li>Funds raised (all sources, not just ETH)</li>
                <li>Any presale conducted and its details (% of tokens & amt $ raised)</li>
                <li>% of tokens held by the project</li>
                <li>Contract address</li>
                <li>Project wallet addresses</li>
                <li>More transparency metrics in the future</li>
            </ul>
            <h3>How it works</h3>
            <ol>
                <li>A project signs up expressing their interest to be certified: <a href="https://docs.google.com/forms/d/e/1FAIpQLScsfn5pRQ8gQrrT_7tsEcyNHbM96hTNyk9MUCtJSY-_MWgHcw/viewform" target="_blank">Signup here</a></li>
                <li>We will post the project as "Verifying" on the Project Transparency website</li>
                <li>Once information is verified and complete, we'll update the project status to "Certified"</li>
                <li>Visitors may click on each project to find out more information</li>
            </ol>
        </div>
    </div>


</div>

<script type="text/javascript">
    function shLearn() {
        var x = document.getElementById('learn');
        if (x.style.display === 'block') {
            x.style.display = 'none';
        } else {
            x.style.display = 'block';
        }
    }
</script>

</body>
</html>
