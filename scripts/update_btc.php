<?php

require __DIR__ . '/../vendor/autoload.php';

$dotenv = new Dotenv\Dotenv( __DIR__  . "/..");
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


function getBTCWallets($conn)
{
    $wallets = [];
    $sql = "SELECT address FROM tracked_btc";
    $result = pg_query($conn, $sql);

    while ($row = pg_fetch_array($result, NULL, PGSQL_NUM))
    {
        $wallets[] = $row;
    }

    return $wallets;
    
}

function getBTCBalance($address) {
    $url = "https://blockchain.info/balance?active=${address}";
    $t = file_get_contents($url);
    $res = json_decode($t, $assoc = true);
    
    if ((!empty($res)) and ($res[$address] != null)) {
        return $res[$address];
    }
    else {
        throw new Exception("GET blockchain.info/balance wrong output: {$res} ");
    }
}

$wallets = getBTCWallets($conn);
$results = [];

foreach ($wallets as $w) {
    $balance = getBTCBalance($w[0]);
    $results[] = [
        "address" => $w[0],
        "balance" => $balance['final_balance']
    ];
}

$values = join(",\n", array_map( function ($r) {
    return "('{$r['address']}', {$r['balance']})";
}, $results));
    
$sql = <<<SQL
INSERT INTO latest_btc_wallet_data
(
  address,
  satoshi_balance,
  update_time
)

SELECT 
  t.address,
  t.balance,
  NOW()
FROM (VALUES {$values}) AS t (address, balance)

ON CONFLICT (address) DO UPDATE SET
  (satoshi_balance, update_time ) = (EXCLUDED.satoshi_balance, EXCLUDED.update_time);

SQL;

echo $sql;
pg_query($conn, $sql);

?>