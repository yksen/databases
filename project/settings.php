<link rel="stylesheet" href="assets/styles.css" type="text/css">
<?php
require_once "menu.php";
require_once "database-connection.php";

session_start();

if (empty($_SESSION["user_id"])) {
    header("Location: index.php");
}

if (!empty($_POST["name"]) && !empty($_POST["email"]) && !empty($_POST["phone"]) && !empty($_POST["address"])) {
    $name = $_POST["name"];
    $email = $_POST["email"];
    $phone = $_POST["phone"];
    $address = $_POST["address"];

    $query = "UPDATE users
              SET user_name = '$name', email = '$email', user_phone = '$phone', user_address = '$address'
              WHERE id_user = " . $_SESSION["user_id"];
    $database->query($query);
}

$query = "SELECT * FROM users WHERE id_user = " . $_SESSION["user_id"];
$result = $database->query($query);
$row = $result->fetch_assoc();

?>

<div class="form-box">
    <h2>Settings</h2>
    <form method="post" action="settings.php">
        <div class="form-group">
            <label for="name">Name</label>
            <input type="text" id="name" name="name" value="<?php echo $row["user_name"]; ?>" required>
        </div>
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" value="<?php echo $row["email"]; ?>" required>
        </div>
        <div class="form-group">
            <label for="phone">Phone</label>
            <input type="text" id="phone" name="phone" value="<?php echo $row["user_phone"]; ?>" required>
        </div>
        <div class="form-group">
            <label for="address">Address</label>
            <input type="text" id="address" name="address" value="<?php echo $row["user_address"]; ?>" required>
        </div>
        <div class="form-group">
            <input type="submit" value="Save">
        </div>
    </form>
</div>