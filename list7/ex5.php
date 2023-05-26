<?php
require_once "database_connection.php";

if (is_numeric($_GET["zamowienie"])) {
    $orderId = $_GET["zamowienie"];
    $query = "SELECT * FROM zamow 
              JOIN detal_zamow ON idz = z_id
              JOIN produkty ON idp = p_id
              WHERE idz = $orderId";
    $result = $database->query($query);
    $order = $result->fetch_all(MYSQLI_ASSOC);
    $result->close();
    if (empty($order)) {
        echo "Nie ma takiego zamówienia.";
        exit();
    }
} else {
    echo "Niepoprawny parametr.";
    exit();
}

$products = $database->query("SELECT * FROM produkty");

echo "<form method='post'>
      <table><tr><th>Produkt</th><th>Liczba sztuk</th><th>Usuń</th></tr>";
foreach ($order as $key => $product) {
    echo "<tr><td>$product[nazwa]</td>
          <td><input type='number' name='sztuk[]' value='$product[sztuk]'></td>
          <td><input type='checkbox' name='usun[]' value='$product[idd]'></td></tr>";
}
echo "<tr><td><select name='produkt'>
      <option value=''>Wybierz produkt</option>";
foreach ($products as $product) {
    echo "<option value='$product[idp]'>$product[nazwa]</option>";
}
echo "</select></td><td><input type='number' name='sztukDodany'></td><td></td></tr>
      </table>
      <input type='submit' value='Zapisz'>
      </form>";

if (!empty($_POST["sztuk"])) {
    $pieces = $_POST["sztuk"];
    $delete = $_POST["usun"];
    foreach ($order as $key => $product) {
        $id = $product["idd"];
        $query = "UPDATE detal_zamow SET sztuk = $pieces[$key] WHERE idd = $id";
        $result = $database->query($query);
        if (!$result) {
            echo "Nie udało się zaktualizować zamówienia.<br>$database->error";
            exit();
        }
    }
    echo "Zaktualizowano zamówienie.";
}

echo "<br>";

if (!empty($delete)) {
    foreach ($delete as $key => $id) {
        $query = "DELETE FROM detal_zamow WHERE idd = $id";
        $result = $database->query($query);
        if (!$result) {
            echo "Nie udało się usunąć produktu.<br>$database->error";
            exit();
        }
    }
    echo "Usunięto produkt.";
}

echo "<br>";

if (!empty($_POST["produkt"]) && !empty($_POST["sztukDodany"])) {
    $product = $_POST["produkt"];
    $pieces = $_POST["sztukDodany"];
    $query = "INSERT INTO detal_zamow (z_id, p_id, sztuk) VALUES ($orderId, $product, $pieces)";
    $result = $database->query($query);
    if ($result) {
        echo "Dodano produkt do zamówienia.";
    } else {
        echo "Nie udało się dodać produktu do zamówienia.<br>$database->error";
    }
}
