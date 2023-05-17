<?php
function getMonthAsArray($days, $firstDay)
{
    $result = array(array());
    $week = 0;
    for ($i = 0; $i < $firstDay; $i++) {
        $result[$week][$i] = "  ";
    }
    for ($i = $firstDay; $i < $firstDay + $days; $i++) {
        $result[$week][$i] = str_pad($i - $firstDay + 1, 2, " ", STR_PAD_LEFT);
        if ($i % 7 == 6) {
            $week++;
            $result[$week] = array();
        }
    }
    for ($i = $firstDay + $days; $i < ($week + 1) * 7; $i++) {
        $result[$week][$i] = "  ";
    }
    return $result;
}

function displayMonth($month)
{
    $result = "<table border='1'><th>";
    $result .= implode("</th><th>", array("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"));
    $result .= "</th>";
    foreach ($month as $week) {
        $result .= "<tr><td>";
        $result .= implode("</td><td>", $week);
        $result .= "</td></tr>";
    }
    echo $result . "</table>";
}

$month = getMonthAsArray(28, 5);
displayMonth($month);