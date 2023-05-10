<?php
function insertionSort(&$arr)
{
    $n = count($arr);
    for ($i = 1; $i < $n; $i++) {
        $key = $arr[$i];
        $j = $i - 1;
        while ($j >= 0 && $arr[$j] > $key) {
            $arr[$j + 1] = $arr[$j];
            $j = $j - 1;
        }
        $arr[$j + 1] = $key;
    }
}

$arr = array(5, 2, 4, 6, 1, 3);
insertionSort($arr);
echo implode(", ", $arr);
