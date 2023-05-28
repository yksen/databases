<link rel="stylesheet" href="assets/styles.css" type="text/css">
<?php
require_once "menu.php";

if (empty($_SESSION["user_id"] || $_SESSION["is_admin"] != "admin")) {
    header("Location: index.php");
}
?>