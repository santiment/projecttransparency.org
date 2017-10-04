<?php
/**
 * Created by PhpStorm.
 * User: jhildings
 * Date: 2017-08-05
 * Time: 15:46
 */

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

$result = json_decode(file_get_contents('https://api.coinmarketcap.com/v1/ticker/'),true);

// Process coins in order reverse to the market valuation. In this way
// we can deal with the fake "ICN" coin which otherwise overwrites the
// real market cap with a very small number

$result = array_reverse($result);

$values_array = array_map( function ($r){
    $id = pg_escape_string($r['id']);
    $name = pg_escape_string($r['name']);
    
    $mc = $r['market_cap_usd'];
    if (!is_numeric($mc)) {
        //echo "ERROR:", json_encode($r), "\n";
        $mc = 'null';
    }

    $pr = $r['price_usd'];
    if(!is_numeric($pr))
    {
        $pr = 'null';
    }

    $smb = pg_escape_string($r['symbol']);

    $lu = $r['last_updated'];
    if (!is_numeric($lu)) {
        $lu = 0;
    }

    return "('{$id}','{$name}', '{$smb}', {$pr}, {$mc}, to_timestamp({$lu}) )";
    
}, $result);

$values = join(",\n", $values_array);

$sql = <<<SQL
INSERT INTO latest_coinmarketcap_data (id, name, symbol, price_usd, market_cap_usd, update_time)
VALUES {$values}

ON CONFLICT (id) DO UPDATE SET 
  (name, symbol, price_usd, market_cap_usd, update_time) = 
  (EXCLUDED.name, EXCLUDED.symbol, EXCLUDED.price_usd, EXCLUDED.market_cap_usd, EXCLUDED.update_time)
SQL;

echo $sql;
echo "\n";
$qr = pg_query($conn, $sql);


?>
