<link rel="stylesheet" href="assets/styles.css" type="text/css">
<?php
session_start();
require_once "menu.php";

if (empty($_SESSION["user_id"]) || !$_SESSION["is_admin"]) {
    header("Location: index.php");
}

require_once "database-connection.php";

if (!empty($_GET["id"])) {
    $id = $_GET["id"];
    $query = "UPDATE restaurants SET is_approved = true WHERE id_restaurant = $id";
    $database->query($query);
}

$query = "SELECT * FROM restaurants
          JOIN users ON id_user = user_id
          WHERE is_approved = false";
$result = $database->query($query);
$requests = $result->fetch_all(MYSQLI_ASSOC);

if (empty($requests)) {
    echo "<h1 style='text-align: center;'>No requests</h1>";
    exit();
}
?>

<div class="requests-container">
    <?php foreach ($requests as $request) { ?>
        <div class="request">
            <div class="field">
                <label>Restaurant's Name:</label>
                <span><?php echo $request["restaurant_name"]; ?></span>
            </div>
            <div class="field">
                <label>Restaurant's Address:</label>
                <span><?php echo $request["restaurant_address"]; ?></span>
            </div>
            <div class="field">
                <label>Restaurant's Phone:</label>
                <span><?php echo $request["restaurant_phone"]; ?></span>
            </div>
            <div class="field">
                <label>Owner's Name:</label>
                <span><?php echo $request["user_name"]; ?></span>
            </div>
            <div class="field">
                <label>Owner's Phone:</label>
                <span><?php echo $request["user_phone"]; ?></span>
            </div>
            <div class="field">
                <label>Email:</label>
                <span><?php echo $request["email"]; ?></span>
            </div>
            <div style="display: flex; justify-content: center;">
                <a class="menu-button" href="requests.php?id=<?php echo $request["id_restaurant"]; ?>">Approve</a>
            </div>
        </div>
    <?php } ?>
</div>