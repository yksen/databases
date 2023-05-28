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
        <?php
        if (!empty($_SESSION["user_id"])) {
            echo "<button class='menu-button add-restaurant-button' onclick='window.location.href=\"add-restaurant.php\"'>
                      Add restaurant
                  </button>";
            if ($_SESSION["is_admin"]) {
                echo "<button class='menu-button requests-button' onclick='window.location.href=\"requests.php\"'>
                          Requests
                      </button>";
            }
            echo "<button class='menu-button' onclick='window.location.href=\"settings.php\"'>Settings</button>";
            echo "<button class='menu-button' onclick='window.location.href=\"logout.php\"'>Logout</button>";
        } else {
            echo "<button class='menu-button' onclick='window.location.href=\"login.php\"'>Login</button>
                  <button class='menu-button' onclick='window.location.href=\"signup.php\"'>Sign up</button>";
        }
        ?>
    </div>
</div>