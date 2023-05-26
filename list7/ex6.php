<?php
require_once "database_connection.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $date = $_POST['data'];
    $query = "SELECT idz, klienci.nazwa, produkty.nazwa AS pnazwa, cena, sztuk FROM zamow
              JOIN klienci ON k_id = idk
              JOIN detal_zamow ON z_id = idz
              JOIN produkty ON p_id = idp
              WHERE DATE(data) = '$date'";
    $result = $database->query($query);
    $orders = $result->fetch_all(MYSQLI_ASSOC);

    if (empty($orders)) {
        echo "Nie ma zamówień z dnia $date.";
    } else {
        echo "<style>
                .styled {
                    background-color: #ccc;
                }
              </style>";
        echo "<table><tr><th>Zamówienie</th><th>Klient</th><th>Produkt</th><th>Liczba sztuk</th></tr>";
        $lastOrder = 0;
        $parity = 0;
        foreach ($orders as $order) {
            if ($order['idz'] != $lastOrder) {
                $lastOrder = $order['idz'];
                $parity = 1 - $parity;
            }
            echo ($parity == 0) ? "<tr>" : "<tr class='styled'>";
            echo "<td>$order[idz]</td>
                  <td>$order[nazwa]</td>
                  <td>$order[pnazwa]</td>
                  <td>$order[sztuk]</td>
                  </tr>";
        }
        echo "</table>";
    }
} else {
    echo "<form method='post'>
          <input type='date' name='data'>
          <input type='submit' value='Pokaż zamówienia'>
          </form>";
}
