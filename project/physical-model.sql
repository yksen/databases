SET DEFAULT_STORAGE_ENGINE=INNODB;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
    `id_user` int UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_admin` boolean NOT NULL DEFAULT FALSE,
    `user_name` varchar(50) NOT NULL,
    `email` varchar(50) NOT NULL,
    `password` varchar(32) NOT NULL,
    `user_phone` varchar(15) NOT NULL,
    `user_address` varchar(50) NOT NULL,
    PRIMARY KEY (`id_user`)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
    `id_item` int UNSIGNED NOT NULL AUTO_INCREMENT,
    `item_name` varchar(50) NOT NULL,
    `description` varchar(255) NOT NULL,
    PRIMARY KEY (`id_item`)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
    `id_order` int UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` int UNSIGNED NOT NULL,
    `date` timestamp NOT NULL,
    `comment` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id_order`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id_user`)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items` (
    `id_order_item` int UNSIGNED NOT NULL AUTO_INCREMENT,
    `order_id` int UNSIGNED NOT NULL,
    `item_id` int UNSIGNED NOT NULL,
    `quantity` int UNSIGNED NOT NULL,
    PRIMARY KEY (`id_order_item`),
    FOREIGN KEY (`order_id`) REFERENCES `orders` (`id_order`),
    FOREIGN KEY (`item_id`) REFERENCES `items` (`id_item`)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `restaurants`;
CREATE TABLE `restaurants` (
    `id_restaurant` int UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` int UNSIGNED NOT NULL,
    `is_approved` boolean NOT NULL DEFAULT FALSE,
    `restaurant_name` varchar(50) NOT NULL,
    `restaurant_phone` varchar(15) NOT NULL,
    `restaurant_address` varchar(50) NOT NULL,
    `cuisine` varchar(50) NOT NULL,
    PRIMARY KEY (`id_restaurant`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id_user`)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `restaurant_items`;
CREATE TABLE `restaurant_items` (
    `id_restaurant_item` int UNSIGNED NOT NULL AUTO_INCREMENT,
    `restaurant_id` int UNSIGNED NOT NULL,
    `item_id` int UNSIGNED NOT NULL,
    `price` float(10, 2) NOT NULL,
    PRIMARY KEY (`id_restaurant_item`),
    FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id_restaurant`),
    FOREIGN KEY (`item_id`) REFERENCES `items` (`id_item`)
) DEFAULT CHARSET=utf8;
