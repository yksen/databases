<link rel="stylesheet" href="assets/styles.css" type="text/css">
<?php
require_once "menu.php";
require_once "database-connection.php";

$query = "SELECT * FROM restaurants WHERE is_approved = true";
$result = $database->query($query);
$restaurants = $result->fetch_all(MYSQLI_ASSOC);
?>

<div class="restaurant-list">
    <?php foreach ($restaurants as $restaurant) { ?>
        <div class="restaurant-item" onclick="location.href='restaurant.php?id=<?php echo $restaurant['id_restaurant']; ?>'">
            <div class="restaurant-name"><?php echo $restaurant["restaurant_name"]; ?></div>
            <div class="restaurant-cuisine"><?php echo $restaurant["cuisine"]; ?></div>
            <div class="restaurant-address"><?php echo $restaurant["restaurant_address"]; ?></div>
        </div>
    <?php } ?>
</div>