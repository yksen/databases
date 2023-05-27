<link rel="stylesheet" href="assets/styles.css" type="text/css">
<?php require_once "menu.php"; ?>

<div class="form-box">
    <h2>Sign Up</h2>
    <form method="post" action="signup.php">
        <div class="form-group">
            <label for="name">Name</label>
            <input type="text" id="name" name="name" required>
        </div>
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <label for="phone">Phone</label>
            <input type="text" id="phone" name="phone" required>
        </div>
        <div class="form-group">
            <label for="address">Address</label>
            <input type="text" id="address" name="address" required>
        </div>
        <div class="form-group">
            <input type="submit" value="Sign Up">
        </div>
    </form>
</div>

<?php
if (
    !empty($_POST["name"]) && !empty($_POST["email"]) && !empty($_POST["password"]) &&
    !empty($_POST["phone"]) && !empty($_POST["address"])
) {
    $name = $_POST["name"];
    $email = $_POST["email"];
    $password = md5($_POST["password"]);
    $phone = $_POST["phone"];
    $address = $_POST["address"];

    require_once "database-connection.php";

    $query = "SELECT * FROM users WHERE email = '$email'";
    $result = $database->query($query);
    if ($result->num_rows > 0) {
        echo "<script>alert('This email is already registered!');</script>";
    } else {
        $query = "INSERT INTO users (user_name, email, password, user_phone, user_address)
                  VALUES ('$name', '$email', '$password', '$phone', '$address')";
        $database->query($query);
    }
}
