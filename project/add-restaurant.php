<link rel="stylesheet" href="assets/styles.css" type="text/css">
<?php
session_start();
require_once "menu.php";

if (empty($_SESSION["user_id"])) {
    header("Location: login.php");
}

if (!empty($_POST["name"]) && !empty($_POST["address"]) && !empty($_POST["phone"]) && !empty($_POST["cuisine"])) {
    $user_id = $_SESSION["user_id"];
    $name = $_POST["name"];
    $address = $_POST["address"];
    $phone = $_POST["phone"];
    $cuisine = $_POST["cuisine"];

    require_once "database-connection.php";

    $query = "INSERT INTO restaurants (user_id, restaurant_name, restaurant_phone, restaurant_address, cuisine)
              VALUES ('$user_id', '$name', '$phone', '$address', '$cuisine')";
    $database->query($query);
    header("Location: index.php");
}
?>

<div class='form-box'>
    <h2>Add restaurant</h2>
    <form method='post' action='add-restaurant.php'>
        <div class='form-group'>
            <label for='name'>Name</label>
            <input type='text' id='name' name='name' required>
        </div>
        <div class='form-group'>
            <label for='address'>Address</label>
            <input type='text' id='address' name='address' required>
        </div>
        <div class='form-group'>
            <label for='phone'>Phone</label>
            <input type='text' id='phone' name='phone' required>
        </div>
        <div class='form-group'>
            <label for='cuisine'>Cuisine</label>
            <input type='cuisine' id='cuisine' name='cuisine' required>
        </div>
        <div class='form-group'>
            <input type='submit' value='Add restaurant'>
        </div>
    </form>
</div>