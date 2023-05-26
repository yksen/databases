<?php
$samples = array("a", "b", "c", "d", "e");
$a = implode("</li><li>", $samples);
$result = "<ol><li>$a</li></ol>";
echo $result;
