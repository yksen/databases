<link rel="stylesheet" href="assets/styles.css" type="text/css">
<?php
session_start();
require_once "menu.php";
require_once "database-connection.php";

if (!empty($_GET["id"])) {
    $id = $_GET["id"];

    if (!empty($_POST["item_name"]) && !empty($_POST["description"]) && !empty($_POST["price"])) {
        $item_name = $_POST["item_name"];
        $description = $_POST["description"];
        $price = $_POST["price"];

        $query = "INSERT INTO items (item_name, description)
                  VALUES ('$item_name', '$description')";
        $database->query($query);

        $query = "SELECT id_item FROM items WHERE item_name = '$item_name'";
        $result = $database->query($query);
        $item_id = $result->fetch_row()[0][0];

        $query = "INSERT INTO restaurant_items (restaurant_id, item_id, price)
                  VALUES ('$id', '$item_id', '$price')";
        $database->query($query);
        echo $database->error;
    }

    $query = "SELECT * FROM items
              RIGHT JOIN restaurant_items ON id_item = id_restaurant_item
              RIGHT JOIN restaurants ON id_restaurant = restaurant_id
              WHERE id_restaurant = $id";
    $result = $database->query($query);
    $menu = $result->fetch_all(MYSQLI_ASSOC);

    if ($_SESSION["user_id"] == $menu[0]["user_id"]) { ?>
        <form method='post'>
            <input type='text' name='item_name' placeholder='Item name' required>
            <input type='text' name='description' placeholder='Description' required>
            <input type='text' name='price' placeholder='Price' required>
            <input type='submit' value='Add item'>
        </form>
    <?php
    }
    ?>
    <div class="menu-container">
        <?php foreach ($menu as $item) { ?>
            <div class="menu-item">
                <div class="menu-item-name"><?php echo $item["item_name"]; ?></div>
                <div class="menu-item-description"><?php echo $item["description"]; ?></div>
                <div class="menu-item-price"><?php echo $item["price"]; ?></div>
            </div>
        <?php
        }
        ?>
    </div>
<?php
}
