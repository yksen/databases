<link rel="stylesheet" href="assets/styles.css" type="text/css">
<?php
session_start();
require_once "menu.php";
?>

<div class="form-box">
    <h2>Login</h2>
    <form method="post" action="login.php">
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <input type="submit" value="Login">
        </div>
    </form>
</div>

<?php
if (!empty($_POST["email"]) && !empty($_POST["password"])) {
    $email = $_POST["email"];
    $password = md5($_POST["password"]);

    require_once "database-connection.php";

    $query = "SELECT * FROM users WHERE email = '$email' AND password = '$password'";
    $result = $database->query($query);
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $_SESSION["user_id"] = $row["id_user"];
        header("Location: index.php");
    } else {
        echo "<script>alert('Invalid email or password!');</script>";
    }
}
