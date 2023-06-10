<link rel="stylesheet" href="assets/styles.css" type="text/css">
<?php
session_start();
session_destroy();
header("Location: index.php");
?>