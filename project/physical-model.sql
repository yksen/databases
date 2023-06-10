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
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

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
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

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
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
    `id_order` int UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` int UNSIGNED NOT NULL,
    `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `comment` varchar(255) DEFAULT NULL,
    `total` float(10, 2) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id_order`),
    KEY `user_id` (`user_id`),
    CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id_user`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

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
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

delimiter |

CREATE TRIGGER calculate_total AFTER INSERT ON `order_items`
FOR EACH ROW
BEGIN
    UPDATE orders SET total = (
        SELECT SUM(price * quantity)
        FROM items JOIN order_items ON items.id_item = order_items.item_id
        WHERE order_items.order_id = NEW.order_id
    )
    WHERE id_order = NEW.order_id;
END;
|

CREATE TRIGGER update_total AFTER UPDATE ON `order_items`
FOR EACH ROW
BEGIN
    UPDATE orders SET total = (
        SELECT SUM(price * quantity)
        FROM items JOIN order_items ON items.id_item = order_items.item_id
        WHERE order_items.order_id = NEW.order_id
    )
    WHERE id_order = NEW.order_id;
END;
|

delimiter ;

INSERT INTO `users` (`is_admin`, `user_name`, `email`, `password`, `user_phone`, `user_address`) VALUES
(true, 'admin', 'admin@email.com', md5('admin'), '123456789', 'Admins address'),
(false, 'user', 'user@email.com', md5('user'), '456789123', 'Users address'),
(false, 'user2', 'user2@email.com', md5('user2'), '000101000', 'User2s address'),
(false, 'user3', 'user3@email.com', md5('user3'), '999333666', 'User3s address'),
(false, 'user4', 'user4@email.com', md5('user4'), '718293465', 'User4s address');

INSERT INTO `restaurants` (`user_id`, `is_approved`, `restaurant_name`, `restaurant_phone`, `restaurant_address`, `cuisine`) VALUES
(1, true, 'Restaurant 1', '125231789', 'Address 1', 'Cuisine 1'),
(2, false, 'Restaurant 2', '475424323', 'Address 2', 'Cuisine 2'),
(1, true, 'Restaurant 3', '001246300', 'Address 3', 'Cuisine 3'),
(4, false, 'Restaurant 4', '996873666', 'Address 4', 'Cuisine 4'),
(5, true, 'Restaurant 5', '713468765', 'Address 5', 'Cuisine 5');

INSERT INTO `items` (`restaurant_id`, `item_name`, `description`, `price`) VALUES
(1, 'Item 1', 'Description 1', 1.00),
(1, 'Item 2', 'Description 2', 2.00),
(1, 'Item 3', 'Description 3', 3.00),
(2, 'Item 4', 'Description 4', 4.00),
(2, 'Item 5', 'Description 5', 5.00),
(2, 'Item 6', 'Description 6', 6.00),
(3, 'Item 7', 'Description 7', 7.00),
(3, 'Item 8', 'Description 8', 8.00),
(3, 'Item 9', 'Description 9', 9.00),
(4, 'Item 10', 'Description 10', 10.00),
(4, 'Item 11', 'Description 11', 11.00),
(4, 'Item 12', 'Description 12', 12.00),
(5, 'Item 13', 'Description 13', 13.00),
(5, 'Item 14', 'Description 14', 14.00),
(5, 'Item 15', 'Description 15', 15.00);

INSERT INTO `orders` (`user_id`, `comment`) VALUES
(2, 'Comment 1'),
(3, 'Comment 2'),
(2, 'Comment 3'),
(4, 'Comment 4'),
(5, 'Comment 5');

INSERT INTO `order_items` (`order_id`, `item_id`, `quantity`) VALUES
(1, 1, 1),
(1, 2, 2),
(1, 3, 3),
(2, 4, 4),
(2, 5, 5),
(2, 6, 6),
(3, 7, 7),
(3, 8, 8),
(3, 9, 9),
(4, 10, 10),
(4, 11, 11),
(4, 12, 12),
(5, 13, 13),
(5, 14, 14),
(5, 15, 15);
