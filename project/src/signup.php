<link rel="stylesheet" href="styles.css" type="text/css">
<?php require_once "menu.php"; ?>

<div class="form-box">
    <h2>Sign Up</h2>
    <form>
        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
        </div>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <input type="submit" value="Sign Up">
        </div>
    </form>
</div>