<?php
require_once "database_connection.php";

$query = "SELECT DATE(data), SUM(cena * sztuk) FROM zamow
          JOIN detal_zamow ON idz = z_id
          JOIN produkty ON idp = p_id
          GROUP BY DATE(data)
          ORDER BY DATE(data)";
$result = mysqli_query($database, $query);

echo "<table>";
echo "<th>Data</th><th>Suma</th>";
while ($row = $result->fetch_row())
    echo "<tr><td>$row[0]</td><td>$row[1]</td></tr>";
echo "</table>";
