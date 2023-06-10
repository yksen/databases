<link rel="stylesheet" href="assets/styles.css" type="text/css">
<?php
require_once "menu.php";
require_once "database-connection.php";

if (!empty($_POST["id"])) {
    $id = $_POST["id"];
    $query = "DELETE FROM restaurants WHERE id_restaurant = $id";
    $database->query($query);
}

$query = "SELECT * FROM restaurants WHERE is_approved = true";
$result = $database->query($query);
$restaurants = $result->fetch_all(MYSQLI_ASSOC);
?>

<div class="list">
    <?php foreach ($restaurants as $restaurant) { ?>
        <div class="list-item" onclick="location.href='restaurant.php?id=<?php echo $restaurant['id_restaurant']; ?>'">
            <?php if ($_SESSION["user_id"] == $restaurant["user_id"]) { ?>
                <form method='post' action='index.php'>
                <input type='hidden' name='id' value='<?php echo $restaurant['id_restaurant']; ?>'>
                <input class='delete-item' type='submit' value='Delete restaurant'>
                </form>
            <?php } ?>
            <div class="restaurant-name"><?php echo $restaurant["restaurant_name"]; ?></div>
            <div class="restaurant-cuisine"><?php echo $restaurant["cuisine"]; ?></div>
            <div class="restaurant-address"><?php echo $restaurant["restaurant_address"]; ?></div>
        </div>
    <?php } ?>
</div>