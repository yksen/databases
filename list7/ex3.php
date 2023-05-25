<?php
require_once "database_connection.php";

$clients = [];
$products = [];

$result = $database->query("SELECT idk, nazwa FROM klienci");
while ($row = $result->fetch_row())
    $clients[] = $row;
$result->close();

echo "<form method='post'>
<select name='client'>"
    . implode("", array_map(function ($client) {
        return "<option value='$client[0]'>$client[1]</option>";
    }, $clients)) . "
</select>
<input type='submit' value='Order'>
</form>";

if (!empty($_POST["client"])) {
    $date = date("Y-m-d H:i:s");
    $query = "INSERT INTO zamow (k_id, data) VALUES ('$_POST[client]', '$date')";
    $result = $database->query($query);
    if ($result) {
        echo "Order added.";
    } else {
        echo "Failed to add order.";
    }
}
