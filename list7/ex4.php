<?php
require_once "database_connection.php";

if (is_numeric($_GET["klient"])) {
    $id = $_GET["klient"];
    $result = $database->query("SELECT * FROM klienci WHERE idk = $id");
    $client = $result->fetch_assoc();
    $result->close();
    if (empty($client)) {
        echo "Nie ma takiego klienta.";
        exit();
    }
} else {
    echo "Niepoprawny parametr.";
    exit();
}

echo "<form method='post'>
<input type='text' name='nazwa' placeholder='Nazwa' value='$client[nazwa]'>
<input type='text' name='miasto' placeholder='Miasto' value='$client[miasto]'>
<input type='text' name='adres' placeholder='Adres' value='$client[adres]'>
<input type='text' name='telefon' placeholder='Telefon' value='$client[telefon]'>
<input type='checkbox' name='usun' value='0'> Usuń klienta<br>
<input type='submit' value='Zapisz'>
</form>";

if (isset($_POST["usun"])) {
    $query = "DELETE FROM klienci WHERE idk = $id";
    $result = $database->query($query);
    if ($result) {
        echo "Usunięto klienta.";
    } else {
        echo "Nie udało się usunąć klienta.";
    }
    exit();
}

if (!empty($_POST["nazwa"]) && !empty($_POST["miasto"]) && !empty($_POST["adres"]) && !empty($_POST["telefon"])) {
    $name = $_POST["nazwa"];
    $city = $_POST["miasto"];
    $address = $_POST["adres"];
    $phone = $_POST["telefon"];
    $query = "UPDATE klienci 
              SET nazwa = '$name', miasto = '$city', adres = '$address', telefon = '$phone'
              WHERE idk = $id";
    $result = $database->query($query);
    if ($result) {
        echo "Zaktualizowano dane klienta.";
    } else {
        echo "Nie udało się zaktualizować danych klienta.";
    }
}
