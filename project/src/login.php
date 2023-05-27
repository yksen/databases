<link rel="stylesheet" href="styles.css" type="text/css">
<?php require_once "menu.php"; ?>

<div class="form-box">
    <h2>Login</h2>
    <form>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <input type="submit" value="Login">
        </div>
    </form>
</div>