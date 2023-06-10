<link rel="stylesheet" href="assets/styles.css" type="text/css">
<?php
session_start();
require_once "menu.php";
require_once "database-connection.php";

if (empty($_SESSION["user_id"])) {
    header("Location: login.php");
    exit();
}

if (!empty($_POST["item_id"]) && !empty($_POST["quantity"])) {
    $comment = $_POST["comment"];
    $query = "INSERT INTO orders (user_id, comment) VALUES ({$_SESSION["user_id"]}, '$comment')";
    $database->query($query);
    $order_id = $database->insert_id;
    for ($key = 0; $key < count($_POST["item_id"]); $key++) {
        $item_id = $_POST["item_id"][$key];
        $quantity = $_POST["quantity"][$key];
        $query = "INSERT INTO order_items (order_id, item_id, quantity) VALUES ($order_id, $item_id, $quantity)";
        $database->query($query);
    }
}

if (!empty($_POST["order_id"])) {
    $order_id = $_POST["order_id"];
    $query = "DELETE FROM orders WHERE id_order = $order_id";
    $database->query($query);
}

$query = "SELECT * FROM orders
          JOIN order_items ON orders.id_order = order_items.order_id
          JOIN items ON order_items.item_id = items.id_item
          WHERE user_id = {$_SESSION["user_id"]}";
$result = $database->query($query);
$orderItems = $result->fetch_all(MYSQLI_ASSOC);
?>

<div class="list">
    <?php
    $current_order_id = null;
    foreach ($orderItems as $orderItem) { ?>
    <?php
        if ($current_order_id != $orderItem["id_order"]) {
            if ($current_order_id != null) echo "</ul></div>";
            $current_order_id = $orderItem["id_order"];
            echo "<div class='list-item' style='cursor: default;'>
                  <form method='post'>
                  <input type='hidden' name='order_id' value='{$orderItem["id_order"]}'>
                  <input class='delete-item' type='submit' value='Cancel order'>
                  </form>
                  <div class='order-date'>{$orderItem["date"]}</div>
                  <div class='order-comment'>{$orderItem["comment"]}</div>
                  <div class='order-total'>{$orderItem["total"]} zł</div>
                  <ul class='order-items'>";
        }
        $itemTotal = $orderItem["price"] * $orderItem["quantity"];
        echo "<li class='order-item'>{$orderItem["item_name"]} x{$orderItem["quantity"]}, {$orderItem["price"]} zł ({$itemTotal} zł)</li>";
    } ?>
</div>