<?php session_start(); ?>

<title>Order food online</title>

<div class="topbar">
    <div class="logo-container">
        <svg class="logo" onclick="window.location.href='index.php'">
            <image class="logo" href="assets/logo.svg" alt="logo" />
        </svg>
    </div>
    <div class="search-bar">
        <input type="text" placeholder="Search...">
    </div>
    <div class="menu-buttons">
        <?php if (!empty($_SESSION["user_id"])) { ?>
            <a class='menu-button add-restaurant-button' href='add-restaurant.php'>
                Add restaurant
            </a>
            <?php if ($_SESSION["is_admin"]) { ?>
                <a class='menu-button requests-button' href='requests.php'>Requests</a>
            <?php } ?>
            <a class='menu-button' href='settings.php'>Settings</a>
            <a class='menu-button' href='logout.php'>Logout</a>
        <?php } else { ?>
            <a class='menu-button' href='login.php'>Login</a>
            <a class='menu-button' href='signup.php'>Sign up</a>
        <?php } ?>
    </div>
</div>