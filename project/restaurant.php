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

$query = "SELECT user_id FROM restaurants WHERE id_restaurant = $id";
$result = $database->query($query);
$owner_id = $result->fetch_assoc()["user_id"];

if (empty($owner_id)) {
    echo "<h1 class='alert'>Restaurant not found</h1>";
    exit();
}

?>
<div class="menu-container">
    <?php
    if ($_SESSION["user_id"] == $owner_id) { ?>
        <div class="menu-item">
            <form method='post'>
                <input type='text' name='item_name' placeholder='Item name' required>
                <input type='text' name='description' placeholder='Description' required>
                <input type='text' name='price' placeholder='Price' required>
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
            let cartContainer = document.querySelector(".cart");
            if (cart.has(item.id)) {
                cart.set(item.id, {
                    count: cart.get(item.id).count + 1,
                    name: item.name,
                    price: item.price
                });
                document.querySelector("#item" + item.id + " span").innerHTML = "x" + cart.get(item.id).count + " " +
                    item.name + ", " + item.price + " zł (" + cart.get(item.id).count * item.price + " zł)";
            } else {
                cart.set(item.id, {
                    count: 1,
                    name: item.name,
                    price: item.price
                });
                cartContainer.innerHTML += "<div id='item" + item.id + "'><span>" + item.name + ", " + item.price + " zł" +
                    "</span><input type='submit' value='-' onclick='decreaseCount(" + item.id + ")'>" +
                    "<input type='submit' value='+' onclick='addToCart(" + JSON.stringify(item) + ")'></div>";
            }
        }

        function removeFromCart(itemId) {
            cart.delete(itemId);
            document.querySelector("#item" + itemId).remove();
        }

        function decreaseCount(itemId) {
            if (cart.get(itemId).count > 1) {
                cart.set(itemId, {
                    count: cart.get(itemId).count - 1,
                    name: cart.get(itemId).name,
                    price: cart.get(itemId).price
                });
                document.querySelector("#item" + itemId + " span").innerHTML = "x" + cart.get(itemId).count + " " +
                    cart.get(itemId).name + ", " + cart.get(itemId).price + " zł (" + cart.get(itemId).count * cart.get(itemId).price + " zł)";
            } else {
                removeFromCart(itemId);
            }
        }

        function submitOrder() {
            let order = [];
            if (cart.size == 0) {
                alert("Your cart is empty");
                return;
            }
            for (let [key, value] of cart) {
                order.push({
                    id: key,
                    count: value.count
                });
            }
            let orderJSON = JSON.stringify(order);
            let restaurantId = <?php echo $id; ?>;
            let request = new XMLHttpRequest();
            request.open("POST", "restaurant.php", true);
            request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            request.send("order=" + orderJSON + "&restaurant_id=" + restaurantId);
            request.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    window.location.href = "index.php";
                }
            };
        }
    </script>
    <div class="cart">
        <input type='submit' value='Submit order' onclick='submitOrder()'>
    </div>
    <?php foreach ($menu as $item) { ?>
        <div class="menu-item">
            <div><?php echo $item["item_name"]; ?></div>
            <div><?php echo $item["description"]; ?></div>
            <div><?php echo $item["price"]; ?></div>
            <input type='submit' value='Add to cart' onclick='addToCart(
                <?php echo "{id: " . $item["id_item"] . ", name: \"" . $item["item_name"] . "\", price: " . $item["price"] . "}"; ?>)'>
        </div>
    <?php
    }
    ?>
</div>
<?php
