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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
    KEY `user_id` (`user_id`),
    CONSTRAINT `restaurants_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id_user`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
    `id_item` int UNSIGNED NOT NULL AUTO_INCREMENT,
    `restaurant_id` int UNSIGNED NOT NULL,
    `item_name` varchar(50) NOT NULL,
    `description` varchar(255) NOT NULL,
    `price` float(10, 2) NOT NULL,
    PRIMARY KEY (`id_item`),
    KEY `restaurant_id` (`restaurant_id`),
    CONSTRAINT `items_ibfk_1` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id_restaurant`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
    `id_order` int UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` int UNSIGNED NOT NULL,
    `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `comment` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id_order`),
    KEY `user_id` (`user_id`),
    CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id_user`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items` (
    `id_order_item` int UNSIGNED NOT NULL AUTO_INCREMENT,
    `order_id` int UNSIGNED NOT NULL,
    `item_id` int UNSIGNED NOT NULL,
    `quantity` int UNSIGNED NOT NULL,
    PRIMARY KEY (`id_order_item`),
    KEY `order_id` (`order_id`),
    KEY `item_id` (`item_id`),
    CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id_order`) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`id_item`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

