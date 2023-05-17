<?php
echo "<form method='get'>
<input type='number' name='n'>
<input type='submit' value='Wyślij'>
</form>";
if (isset($_GET['n'])) {
    $n = $_GET['n'];
    echo "<table border='1'>";
    for ($i = 0; $i <= $n; $i++) {
        echo "<tr>";
        for ($j = 0; $j <= $n; $j++) {
            echo "<td>" . $i * $j . "</td>";
        }
        echo "</tr>";
    }
    echo "</table>";
}
