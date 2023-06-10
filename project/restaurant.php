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
            <div><?php echo $item["item_name"]; ?></div>
            <div><?php echo $item["description"]; ?></div>
            <div><?php echo $item["price"] . " zł"; ?></div>
            <input type='submit' value='Add to cart' onclick='addToCart(
                <?php echo "{id: " . $item["id_item"] . ", name: \"" . $item["item_name"] . "\", price: " . $item["price"] . "}"; ?>)'>
        </div>
    <?php
    }
    ?>
</div>
<?php
