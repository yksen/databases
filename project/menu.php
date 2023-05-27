<?php session_start(); ?>

<div class="topbar">
    <div class="logo" onclick="window.location.href='index.php'">
        <svg class="logo">
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
            echo "<button class='menu-button' onclick='window.location.href=\"logout.php\"'>Logout</button>";
        } else {
            echo "<button class='menu-button' onclick='window.location.href=\"login.php\"'>Login</button>
                  <button class='menu-button' onclick='window.location.href=\"signup.php\"'>Sign up</button>";
        }
        ?>
    </div>
</div>