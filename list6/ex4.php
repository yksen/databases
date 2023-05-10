<?php
function getMonthAsArray($days, $firstDay)
{
    $result = array(array());
    $week = 0;
    for ($i = 0; $i < $firstDay; $i++) {
        $result[$week][$i] = "";
    }
    for ($i = $firstDay; $i < $firstDay + $days; $i++) {
        $result[$week][$i] = $i - $firstDay + 1;
        if ($i % 7 == 6) {
            $week++;
            $result[$week] = array();
        }
    }
    for ($i = $firstDay + $days; $i < ($week + 1) * 7; $i++) {
        $result[$week][$i] = "";
    }
    return $result;
}

$month = getMonthAsArray(30, 3);
for ($i = 0; $i < count($month); $i++) {
    printf("%s\n", implode(", ", $month[$i]));
}
