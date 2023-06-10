<link rel="stylesheet" href="assets/styles.css" type="text/css">
<?php
session_start();
require_once "menu.php";
require_once "database-connection.php";

$id = $_GET["id"];

if (empty($id)) {
    echo "<h1 class='alert'>Restaurant not found</h1>";
    exit();
}

if (!empty($_POST["update"])) {
    $query = "UPDATE restaurants SET
              restaurant_name = '" . $_POST["restaurant_name"] . "',
              restaurant_address = '" . $_POST["restaurant_address"] . "',
              restaurant_phone = '" . $_POST["restaurant_phone"] . "',
              cuisine = '" . $_POST["cuisine"] . "'
              WHERE id_restaurant = $id";
    $database->query($query);
}

if (!empty($_POST["edit"])) {
    $query = "UPDATE items SET
              item_name = '" . $_POST["item_name"] . "',
              description = '" . $_POST["description"] . "',
              price = " . $_POST["price"] . "
              WHERE id_item = " . $_POST["item_id"];
    $database->query($query);
}

if (!empty($_POST["delete"])) {
    $query = "DELETE FROM items WHERE id_item = " . $_POST["item_id"];
    $database->query($query);
}

if (!empty($_POST["add"])) {
    $item_name = $_POST["item_name"];
    $description = $_POST["description"];
    $price = $_POST["price"];

    $query = "INSERT INTO items (item_name, restaurant_id, description, price) VALUES ('$item_name', $id, '$description', $price)";
    $database->query($query);
}

$query = "SELECT * FROM restaurants WHERE id_restaurant = $id";
$result = $database->query($query);
$restaurant = $result->fetch_assoc();
$owner_id = $restaurant["user_id"];

if (empty($owner_id)) {
    echo "<h1 class='alert'>Restaurant not found</h1>";
    exit();
}

if ($_SESSION["user_id"] == $owner_id) { ?>
    <div class="form-box" style="position: absolute; left: 0;">
        <form method='post' action='restaurant.php?id=<?php echo $id; ?>'>
            <input type='hidden' name='id' value='<?php echo $id; ?>'>
            <div class="form-group">
                <label for="restaurant_name">Restaurant name</label>
                <input type="text" name="restaurant_name" value="<?php echo $restaurant["restaurant_name"]; ?>" required>
            </div>
            <div class="form-group">
                <label for="restaurant_address">Restaurant address</label>
                <input type="text" name="restaurant_address" value="<?php echo $restaurant["restaurant_address"]; ?>" required>
            </div>
            <div class="form-group">
                <label for="restaurant_phone">Restaurant phone</label>
                <input type="text" name="restaurant_phone" value="<?php echo $restaurant["restaurant_phone"]; ?>" required>
            </div>
            <div class="form-group">
                <label for="cuisine">Cuisine</label>
                <input type="text" name="cuisine" value="<?php echo $restaurant["cuisine"]; ?>" required>
            </div>
            <div class="form-group">
                <input type='hidden' name='update' value='true'>
                <input type="submit" value="Edit restaurant">
            </div>
        </form>
    </div>
<?php } ?>
<div class="menu-container">
    <?php
    if ($_SESSION["user_id"] == $owner_id) { ?>
        <div class="menu-item">
            <form method='post' action='restaurant.php?id=<?php echo $id; ?>'>
                <input type='text' name='item_name' placeholder='Item name' required>
                <input type='text' name='description' placeholder='Description' required>
                <input type='text' name='price' placeholder='Price' required>
                <input type='hidden' name='add' value='true'>
                <input type='submit' value='Add item'>
            </form>
        </div>
    <?php
    }

    $query = "SELECT * FROM items WHERE restaurant_id = $id";
    $result = $database->query($query);
    $menu = $result->fetch_all(MYSQLI_ASSOC);

    if (empty($menu) && $_SESSION["user_id"] != $owner_id) {
        echo "<h1 class='alert'>This restaurant offers no items</h1>";
        exit();
    }
    ?>
    <script>
        var cart = new Map();

        function addToCart(item) {
            document.querySelector("#submit-order").style.visibility = "visible";
            document.querySelector("#comment").style.visibility = "visible";
            let cartContainer = document.querySelector(".cart form");
            if (cart.has(item.id)) {
                cart.get(item.id).count++;
                document.querySelector("#item" + item.id + "_count").value++;
                document.querySelector("#item" + item.id + " span").innerHTML = item.name + " x" +
                    cart.get(item.id).count + ", " + item.price + " zł (" + cart.get(item.id).count * item.price + " zł)";
            } else {
                cart.set(item.id, {
                    count: 1,
                    name: item.name,
                    price: item.price
                });
                cartContainer.appendChild(document.createElement("div"));
                cartContainer.lastChild.classList.add("cart-item");
                cartContainer.lastChild.id = "item" + item.id;
                document.querySelector("#item" + item.id).innerHTML =
                    "<div class='cart-item' id='item" + item.id + "'>" +
                    "<input type='number' name='item_id[]' value='" + item.id + "' hidden>" +
                    "<input id='item" + item.id + "_count' type='number' name='quantity[]' value='1' hidden>" +
                    "<button type='button' onclick='decreaseCount(" + item.id + ")' >-</button>" +
                    "<button type='button' onclick='addToCart(" + JSON.stringify(item) + ")'>+</button>" +
                    "<span>" + item.name + ", " + item.price + " zł</span></div>";
            }
        }

        function removeFromCart(itemId) {
            cart.delete(itemId);
            document.querySelector("#item" + itemId).remove();
            if (cart.size == 0) {
                document.querySelector("#submit-order").style.visibility = "hidden";
                document.querySelector("#comment").style.visibility = "hidden";
            }
        }

        function decreaseCount(itemId) {
            if (cart.get(itemId).count > 1) {
                cart.get(itemId).count--;
                document.querySelector("#item" + itemId + "_count").value--;
                document.querySelector("#item" + itemId + " span").innerHTML = cart.get(itemId).name + " x" +
                    cart.get(itemId).count + ", " + cart.get(itemId).price + " zł (" +
                    cart.get(itemId).count * cart.get(itemId).price + " zł)";
            } else {
                removeFromCart(itemId);
            }
        }
    </script>
    <div class="cart">
        <form method="post" action="orders.php">
            <input id='submit-order' type='submit' value='Submit order' style='visibility: hidden;'>
            <input id='comment' type="text" name="comment" placeholder="Comment" style="visibility: hidden;">
        </form>
    </div>
    <?php foreach ($menu as $item) { ?>
        <div class="menu-item">
            <?php if ($_SESSION["user_id"] == $owner_id) { ?>
                <form method='post' action='restaurant.php?id=<?php echo $id; ?>'>
                    <input type='hidden' name='id' value='<?php echo $id; ?>'>
                    <input type='hidden' name='item_id' value='<?php echo $item["id_item"]; ?>'>
                    <input type='hidden' name='delete' value='true'>
                    <input class='delete-item' type='submit' value='x'>
                </form>
                <form method='post' action='restaurant.php?id=<?php echo $id; ?>'>
                    <input type='text' name='item_name' value='<?php echo $item["item_name"]; ?>' required>
                    <input type='text' name='description' value='<?php echo $item["description"]; ?>' required>
                    <input type='number' name='price' value='<?php echo $item["price"]; ?>' required>
                    <input type='hidden' name='item_id' value='<?php echo $item["id_item"]; ?>'>
                    <input type='hidden' name='edit' value='true'>
                    <input class='edit-item' type='submit' value='Edit'>
                </form>
                <?php } else { ?>
                    <div><?php echo $item["item_name"]; ?></div>
                    <div><?php echo $item["description"]; ?></div>
                    <div><?php echo $item["price"] . " zł"; ?></div>
                <?php } ?>
                <input type='submit' value='Add to cart' onclick='addToCart(
                <?php echo "{id: " . $item["id_item"] . ", name: \"" . $item["item_name"] . "\", price: " . $item["price"] . "}"; ?>)'>
        </div>
    <?php
    }
    ?>
</div>
<?php
