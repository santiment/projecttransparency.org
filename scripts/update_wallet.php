<?php

require __DIR__ . '/../vendor/autoload.php';

$dotenv = new Dotenv\Dotenv( __DIR__ . "/..");
$dotenv->load();

$servername = getenv("DB_SERVER");
$database = getenv("DB_DATABASE");
$username = getenv("DB_USER");
$password = getenv("DB_PASSWORD");

// Create connection
$conn_string = "host=".$servername." dbname=". $database ." user=".$username." password=".$password;
$conn = pg_connect($conn_string);
if (!$conn) {
    $error = error_get_last();
    throw new Exception("Connection failed: " . $error["message"]);
}

//Set timezone
date_default_timezone_set("UTC");

/** 
 * @return array
 *
 */
function getWallets($conn)
{
    $wallets = [];
    $sql = "SELECT address FROM tracked_eth";
    $result = pg_query($conn, $sql);

    while ($row = pg_fetch_array($result, NULL, PGSQL_NUM))
    {
        $wallets[] = $row;
    }

    return $wallets;
}

/**
 * @param  $wallet array
 * @return array
 */
function getInternalTx($wallet)
{
    $txData = [];
    $txData['date'] = "No transfers yet";
    $txData['value'] = 0;

    $txRoute = 'http://api.etherscan.io/api?module=account&action=txlistinternal&address=' . $wallet . '&startblock=0&endblock=99999999&sort=asc&apikey=apitoken';
    $res = json_decode(file_get_contents($txRoute), $assoc = true);
    if (!empty($res)) {
        $lastIndex = array_slice($res['result'], -1);
        if (!empty($lastIndex[0]['timeStamp'])) {
            $txData['date'] = date("Y-m-d", $lastIndex[0]['timeStamp']);
        }
        if (!empty($lastIndex[0]['value'])) {

            $txData['value'] = round(($lastIndex[0]['value'] / 1000000000000000000), 2);
        }

        return $txData;
    } else {
        echo "API is down";
        throw new Exception("API is down");
    }

}

/**
 * @param  $wallet array
 * @return array
 */
function getOutgoingTx($wallet)
{
    $txData = [];
    $txData['date'] = "No recent transfers";
    $txData['value'] = 0;

    $txRoute = 'http://api.etherscan.io/api?module=account&action=txlist&address=' . $wallet . '&startblock=0&endblock=99999999&sort=asc&apikey=apitoken';
    $res = json_decode(file_get_contents($txRoute), $assoc = true);
    if (!empty($res)) {
        $lastIndex = array_slice($res['result'], -1);
        $txDate = null;
        $inValue = null;
        // echo $wallet;
        // echo "\n";
        // echo $lastIndex[0]['from'];
        // echo "\n";
        //Outgoing if same address as from as contract/wallet
        if ($lastIndex[0]['from'] === strtolower($wallet)) {
            echo 'found outgoing';
            if (!empty($lastIndex[0]['timeStamp'])) {
                $txData['date'] = date("Y-m-d", $lastIndex[0]['timeStamp']);
            }
            if (!empty($lastIndex[0]['value'])) {

                $txData['value'] = round(($lastIndex[0]['value'] / 1000000000000000000), 2);
            }
        }
        return $txData;
    } else {
        echo "API is down";
        throw new Exception("API is down");
    }

}

/**
 * @param  $address string
 * @return string
 */
function getBalance($address)
{
    $balanceRoute = 'https://api.etherscan.io/api?module=account&action=balance&address=' . $address . '&tag=latest&apikey=apitoken';
    $res = json_decode(file_get_contents($balanceRoute), $assoc = true);
    if (!empty($res)) {
        $balance = round($res['result'] / 1000000000000000000, 2);
        return $balance;
    } else {
        echo "API is down";
        throw new Exception("API is down");
    }
}


$whaleWallets = getWallets($conn);

foreach ($whaleWallets as $k => $wa) {
     //$internalTx = getInternalTx($wa[0]);
     //$outgoingTx = getOutgoingTx($wa[0]);
     $balance = getBalance($wa[0]);
     $walletAddress = $wa[0];
     //$walletName = $wa[1];
     //$ticker = $wa[2];
     //$lastInBalance = $internalTx['value'];
     //  $lastInDate = $internalTx['date'];
     //  $lastOutBalance = $outgoingTx['value'];
     //  $lastOutDate = $outgoingTx['date'];

     //  $sql = 'INSERT INTO wallet_data (name, address,	balance, last_incoming,last_outgoing, tx_out, tx_in,ticker,update_date) VALUES
     //   ("'.$walletName.'",
     //    "'.$walletAddress.'",
     //    '. $balance . ',
     //  "'.$lastInDate.'",
     //  "'.$lastOutDate.'",
     //  '.$lastOutBalance.',
     //  '. $lastInBalance.',
     //  "'.$ticker.'",
     //  NOW()
     //   )';

     $sql = <<<SQL
INSERT INTO latest_eth_wallet_data 
(
  address,
  balance,
  update_time
) 
VALUES 
(
  '{$walletAddress}',
  {$balance},
   NOW()
)
ON CONFLICT (address) DO UPDATE SET
  (balance, update_time ) = (EXCLUDED.balance,  EXCLUDED.update_time);

SQL;

     //echo $sql;
     pg_query($conn, $sql);
}

echo "ETH update successful\n";
// Run also btc updates. We add it here instead of changind the
// systemd script, because changing the script right now would require
// restart and IP change

function updateBTC() {
    require __DIR__ . "/update_btc.php";
};

updateBTC();
?>

