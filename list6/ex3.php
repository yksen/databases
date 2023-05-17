<?php
$rgbValues = array(0x00, 0x33, 0x66, 0x99, 0xCC, 0xFF);
$rows = 6;

$result = "<table>\n";
for ($row = 0; $row < $rows * $rows; $row++) {
    $result .= "<tr>\n";
    for ($col = 0; $col < $rows; $col++) {
        $result .= "<td style='background-color: rgb(";
        $result .= $rgbValues[$col] . ", ";
        $result .= $rgbValues[$row % $rows] . ", ";
        $result .= $rgbValues[$row / $rows] . ");'>";
        $result .= "</td>\n";
    }
    $result .= "</tr>\n";
}
$result .= "</table>\n";
echo $result;
