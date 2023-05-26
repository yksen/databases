<?php
require_once "database_connection.php";

$clients = [];
$products = [];

$result = $database->query("SELECT idk, nazwa FROM klienci");
while ($row = $result->fetch_row())
    $clients[] = $row;
$result->close();

echo "<form method='post'>
<select name='klient'>"
    . implode("", array_map(function ($client) {
        return "<option value='$client[0]'>$client[1]</option>";
    }, $clients)) . "
</select>
<input name='data' type='datetime-local' value='" . date("Y-m-d\TH:i:s") . "' step=1>
<input type='submit' value='Dodaj'>
</form>";

if (!empty($_POST["klient"]) && !empty($_POST["data"])) {
    $query = "INSERT INTO zamow (k_id, data) VALUES ('$_POST[klient]', '$_POST[data]')";
    $result = $database->query($query);
    if ($result) {
        echo "Zamówienie dodane.";
    } else {
        echo "Nie udało się dodać zamówienia.";
        echo "<br>" . $database->error;
        echo "<br>" . $_POST["data"];
    }
}
