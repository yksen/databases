<?php
echo "<form method='post'>
<input type='text' name='nazwa' placeholder='Nazwa produktu'>
<input type='text' name='cena' placeholder='Cena'>
<input type='text' name='ilosc' placeholder='Stan magazynowy'>
<input type='submit' value='Dodaj'><br>";

require_once "credentials.php";
$connection = mysqli_connect($databaseHost, $databaseUser, $databasePassword, $databaseName);

if (mysqli_connect_errno()) {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
    exit();
}

if (!empty($_POST["nazwa"]) && !empty($_POST["cena"]) && !empty($_POST["ilosc"])) {
    $name = $_POST["nazwa"];
    $price = $_POST["cena"];
    $quantity = $_POST["ilosc"];
    if (!is_numeric($price) || !is_numeric($quantity) || is_float($quantity + 0)) {
        echo "Cena i ilość muszą być liczbami.";
        exit();
    }
    $query = "INSERT INTO produkty (nazwa, cena, ilosc) VALUES ('$name', '$price', '$quantity')";
    $result = mysqli_query($connection, $query);
    if ($result) {
        echo "Dodano produkt.";
    } else {
        echo "Nie udało się dodać produktu.";
    }
}
