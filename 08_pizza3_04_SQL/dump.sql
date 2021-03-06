-- MySQL Script generated by MySQL Workbench
-- Tue Oct 20 19:36:52 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema OCPizza
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema OCPizza
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `OCPizza` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema default_schema
-- -----------------------------------------------------
USE `OCPizza` ;

-- -----------------------------------------------------
-- Table `OCPizza`.`Pizzeria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCPizza`.`Pizzeria` (
  `pizzeria_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `shortDescription` VARCHAR(100) NOT NULL,
  `imageName` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`pizzeria_id`),
  UNIQUE INDEX `name` (`name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `OCPizza`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCPizza`.`Order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `order_number` INT NULL,
  `date` DATETIME NULL,
  `amount` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `is_paid` TINYINT NULL,
  `withdrawal` VARCHAR(45) NULL,
  `Pizzeria_pizzeria_id` INT NOT NULL,
  PRIMARY KEY (`order_id`, `Pizzeria_pizzeria_id`),
  INDEX `fk_Order_Pizzeria1_idx` (`Pizzeria_pizzeria_id` ASC) VISIBLE,
  CONSTRAINT `fk_Order_Pizzeria1`
    FOREIGN KEY (`Pizzeria_pizzeria_id`)
    REFERENCES `OCPizza`.`Pizzeria` (`pizzeria_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OCPizza`.`Invoice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCPizza`.`Invoice` (
  `invoice_id` INT NOT NULL AUTO_INCREMENT,
  `invoice_number` INT NULL,
  `payment_date` DATETIME NULL,
  `payment_mode` VARCHAR(40) NULL,
  `Order_order_id` INT NOT NULL,
  PRIMARY KEY (`invoice_id`),
  INDEX `fk_Invoice_Order1_idx` (`Order_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_Invoice_Order1`
    FOREIGN KEY (`Order_order_id`)
    REFERENCES `OCPizza`.`Order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OCPizza`.`Role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCPizza`.`Role` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OCPizza`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCPizza`.`Address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(255) NOT NULL,
  `additional_information` VARCHAR(255) NULL,
  `postal_code` INT NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `phone_number` INT(20) NOT NULL,
  `latitude` FLOAT NULL,
  `longitude` FLOAT NULL,
  `is_default_address` TINYINT NULL,
  `Pizzeria_pizzeria_id` INT NOT NULL,
  PRIMARY KEY (`address_id`, `Pizzeria_pizzeria_id`),
  INDEX `fk_Address_Pizzeria1_idx` (`Pizzeria_pizzeria_id` ASC) VISIBLE,
  CONSTRAINT `fk_Address_Pizzeria1`
    FOREIGN KEY (`Pizzeria_pizzeria_id`)
    REFERENCES `OCPizza`.`Pizzeria` (`pizzeria_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OCPizza`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCPizza`.`Customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `account_number` VARCHAR(100) NULL,
  `first_name` VARCHAR(50) NULL,
  `last_name` VARCHAR(50) NULL,
  `birthday` DATETIME NULL,
  `email` VARCHAR(100) NULL,
  `login` VARCHAR(100) NULL,
  `password` VARCHAR(100) NULL,
  `token` VARCHAR(100) NULL,
  `Address_address_id` INT NOT NULL,
  `Order_order_id` INT NOT NULL,
  `Order_Pizzeria_pizzeria_id` INT NOT NULL,
  PRIMARY KEY (`customer_id`, `Order_order_id`, `Order_Pizzeria_pizzeria_id`),
  INDEX `fk_Customer_Address1_idx` (`Address_address_id` ASC) VISIBLE,
  INDEX `fk_Customer_Order1_idx` (`Order_order_id` ASC, `Order_Pizzeria_pizzeria_id` ASC) VISIBLE,
  CONSTRAINT `fk_Customer_Address1`
    FOREIGN KEY (`Address_address_id`)
    REFERENCES `OCPizza`.`Address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer_Order1`
    FOREIGN KEY (`Order_order_id` , `Order_Pizzeria_pizzeria_id`)
    REFERENCES `OCPizza`.`Order` (`order_id` , `Pizzeria_pizzeria_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OCPizza`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCPizza`.`Employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `account_status` INT NULL,
  `first_name` VARCHAR(50) NULL,
  `last_name` VARCHAR(50) NULL,
  `birthday` DATETIME NULL,
  `email` VARCHAR(100) NULL,
  `login` VARCHAR(100) NULL,
  `password` VARCHAR(100) NULL,
  `token` VARCHAR(100) NULL,
  `Pizzeria_pizzeria_id` INT NOT NULL,
  `Order_order_id` INT NOT NULL,
  `Order_Pizzeria_pizzeria_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`, `Pizzeria_pizzeria_id`, `Order_order_id`, `Order_Pizzeria_pizzeria_id`),
  INDEX `fk_Employee_Pizzeria1_idx` (`Pizzeria_pizzeria_id` ASC) VISIBLE,
  INDEX `fk_Employee_Order1_idx` (`Order_order_id` ASC, `Order_Pizzeria_pizzeria_id` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_Pizzeria1`
    FOREIGN KEY (`Pizzeria_pizzeria_id`)
    REFERENCES `OCPizza`.`Pizzeria` (`pizzeria_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_Order1`
    FOREIGN KEY (`Order_order_id` , `Order_Pizzeria_pizzeria_id`)
    REFERENCES `OCPizza`.`Order` (`order_id` , `Pizzeria_pizzeria_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OCPizza`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCPizza`.`Menu` (
  `menu_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `description` VARCHAR(255) NULL,
  `image_ name` VARCHAR(45) NULL,
  `price` DECIMAL(10) NULL,
  PRIMARY KEY (`menu_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OCPizza`.`Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCPizza`.`Item` (
  `item_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `description` VARCHAR(255) NULL,
  `image_name` VARCHAR(45) NULL,
  `price` DECIMAL(10) NULL,
  PRIMARY KEY (`item_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OCPizza`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCPizza`.`Category` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `description` VARCHAR(255) NULL,
  `image_name` VARCHAR(45) NULL,
  `parent_category_id` INT NOT NULL,
  PRIMARY KEY (`category_id`),
  INDEX `fk_parent_category_idx` (`parent_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_parent_category`
    FOREIGN KEY (`parent_category_id`)
    REFERENCES `OCPizza`.`Category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OCPizza`.`CategoryHasItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCPizza`.`CategoryHasItem` (
  `category_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  PRIMARY KEY (`category_id`, `item_id`),
  INDEX `fk_Category_has_Item_Item1_idx` (`item_id` ASC) VISIBLE,
  INDEX `fk_Category_has_Item_Category1_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_category_has_Item_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `OCPizza`.`Category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_category_has_item_item`
    FOREIGN KEY (`item_id`)
    REFERENCES `OCPizza`.`Item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OCPizza`.`Note`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCPizza`.`Note` (
  `item_id` INT NOT NULL,
  `description` INT NOT NULL,
  CONSTRAINT `fk_item_id`
    FOREIGN KEY (`item_id`)
    REFERENCES `OCPizza`.`Item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OCPizza`.`Recipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCPizza`.`Recipe` (
  `item_id` INT NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `preparation_time_in_seconds` INT NULL,
  INDEX `fk_item_id_idx` (`item_id` ASC) VISIBLE,
  PRIMARY KEY (`item_id`),
  CONSTRAINT `fk_item_id`
    FOREIGN KEY (`item_id`)
    REFERENCES `OCPizza`.`Item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OCPizza`.`Ingredient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCPizza`.`Ingredient` (
  `ingredient_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `description` VARCHAR(255) NULL,
  `price` DECIMAL(10) NULL,
  PRIMARY KEY (`ingredient_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OCPizza`.`EmployeeHasRole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCPizza`.`EmployeeHasRole` (
  `Role_role_id` INT NOT NULL,
  `Employee_employee_id` INT NOT NULL,
  PRIMARY KEY (`Role_role_id`, `Employee_employee_id`),
  INDEX `fk_Role_has_Employee_Employee1_idx` (`Employee_employee_id` ASC) VISIBLE,
  INDEX `fk_Role_has_Employee_Role1_idx` (`Role_role_id` ASC) VISIBLE,
  CONSTRAINT `fk_Role_has_Employee_Role1`
    FOREIGN KEY (`Role_role_id`)
    REFERENCES `OCPizza`.`Role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Role_has_Employee_Employee1`
    FOREIGN KEY (`Employee_employee_id`)
    REFERENCES `OCPizza`.`Employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OCPizza`.`OrderHasMenu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCPizza`.`OrderHasMenu` (
  `Order_order_id` INT NOT NULL,
  `Menu_menu_id` INT NOT NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`Order_order_id`, `Menu_menu_id`),
  INDEX `fk_Order_has_Menu_Menu1_idx` (`Menu_menu_id` ASC) VISIBLE,
  INDEX `fk_Order_has_Menu_Order1_idx` (`Order_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_Order_has_Menu_Order1`
    FOREIGN KEY (`Order_order_id`)
    REFERENCES `OCPizza`.`Order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_has_Menu_Menu1`
    FOREIGN KEY (`Menu_menu_id`)
    REFERENCES `OCPizza`.`Menu` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OCPizza`.`RecipeHasIngredient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCPizza`.`RecipeHasIngredient` (
  `Recipe_item_id` INT NOT NULL,
  `Ingredient_ingredient_id` INT NOT NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`Recipe_item_id`, `Ingredient_ingredient_id`),
  CONSTRAINT `fk_Recipe_has_Ingredient_Ingredient1`
    FOREIGN KEY (`Recipe_item_id` , `Ingredient_ingredient_id`)
    REFERENCES `OCPizza`.`Ingredient` (`ingredient_id` , `ingredient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recipe_has_Ingredient_Recipe`
    FOREIGN KEY (`Recipe_item_id`)
    REFERENCES `OCPizza`.`Recipe` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OCPizza`.`Stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCPizza`.`Stock` (
  `Ingredient_ingredient_id` INT NOT NULL,
  `Pizzeria_pizzeria_id` INT NOT NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`Ingredient_ingredient_id`, `Pizzeria_pizzeria_id`),
  INDEX `fk_Ingredient_has_Pizzeria_Pizzeria1_idx` (`Pizzeria_pizzeria_id` ASC) VISIBLE,
  INDEX `fk_Ingredient_has_Pizzeria_Ingredient1_idx` (`Ingredient_ingredient_id` ASC) VISIBLE,
  CONSTRAINT `fk_Ingredient_has_Pizzeria_Ingredient1`
    FOREIGN KEY (`Ingredient_ingredient_id`)
    REFERENCES `OCPizza`.`Ingredient` (`ingredient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ingredient_has_Pizzeria_Pizzeria1`
    FOREIGN KEY (`Pizzeria_pizzeria_id`)
    REFERENCES `OCPizza`.`Pizzeria` (`pizzeria_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OCPizza`.`MenuHasItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCPizza`.`MenuHasItem` (
  `Item_item_id` INT NOT NULL,
  `Menu_menu_id` INT NOT NULL,
  PRIMARY KEY (`Item_item_id`, `Menu_menu_id`),
  INDEX `fk_Item_has_Menu_Menu1_idx` (`Menu_menu_id` ASC) VISIBLE,
  INDEX `fk_Item_has_Menu_Item1_idx` (`Item_item_id` ASC) VISIBLE,
  CONSTRAINT `fk_Item_has_Menu_Item1`
    FOREIGN KEY (`Item_item_id`)
    REFERENCES `OCPizza`.`Item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_has_Menu_Menu1`
    FOREIGN KEY (`Menu_menu_id`)
    REFERENCES `OCPizza`.`Menu` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OCPizza`.`OrderHasItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCPizza`.`OrderHasItem` (
  `Order_order_id` INT NOT NULL,
  `Item_item_id` INT NOT NULL,
  PRIMARY KEY (`Order_order_id`, `Item_item_id`),
  INDEX `fk_Order_has_Item_Item1_idx` (`Item_item_id` ASC) VISIBLE,
  INDEX `fk_Order_has_Item_Order1_idx` (`Order_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_Order_has_Item_Order1`
    FOREIGN KEY (`Order_order_id`)
    REFERENCES `OCPizza`.`Order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_has_Item_Item1`
    FOREIGN KEY (`Item_item_id`)
    REFERENCES `OCPizza`.`Item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `OCPizza`.`Pizzeria`
-- -----------------------------------------------------
START TRANSACTION;
USE `OCPizza`;
INSERT INTO `OCPizza`.`Pizzeria` (`pizzeria_id`, `name`, `description`, `shortDescription`, `imageName`) VALUES (1, 'OC Pizza Angers', 'Top pizza. Venez vite ! ', 'Au top !', 'pizza_angers.png');
INSERT INTO `OCPizza`.`Pizzeria` (`pizzeria_id`, `name`, `description`, `shortDescription`, `imageName`) VALUES (2, 'OC Pizza Clichy', 'Top pizza. Venez vite ! ', 'Au top !', 'pizza_clichy.png');
INSERT INTO `OCPizza`.`Pizzeria` (`pizzeria_id`, `name`, `description`, `shortDescription`, `imageName`) VALUES (3, 'OC Pizzay Aubergenville', 'Top pizza. Venez vite ! ', 'Au top !', 'pizza_aubergenville.png');
INSERT INTO `OCPizza`.`Pizzeria` (`pizzeria_id`, `name`, `description`, `shortDescription`, `imageName`) VALUES (4, 'OC Pizza Enghien', 'Top pizza. Venez vite ! ', 'Au top !', 'pizza_enghien.png');
INSERT INTO `OCPizza`.`Pizzeria` (`pizzeria_id`, `name`, `description`, `shortDescription`, `imageName`) VALUES (5, 'Oc Pizza Rouen', 'Top pizza. Venez vite ! ', 'Au top !', 'pizza_rouen.png');
INSERT INTO `OCPizza`.`Pizzeria` (`pizzeria_id`, `name`, `description`, `shortDescription`, `imageName`) VALUES (6, 'OC Pizza Beauvais', 'Top pizza. Venez vite ! ', 'Au top !', 'pizza_beauvais.png');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OCPizza`.`Order`
-- -----------------------------------------------------
START TRANSACTION;
USE `OCPizza`;
INSERT INTO `OCPizza`.`Order` (`order_id`, `order_number`, `date`, `amount`, `state`, `is_paid`, `withdrawal`, `Pizzeria_pizzeria_id`) VALUES (1, 01, '12/09/2020', '18', 'Delivered', true, 'Delivery', 1);
INSERT INTO `OCPizza`.`Order` (`order_id`, `order_number`, `date`, `amount`, `state`, `is_paid`, `withdrawal`, `Pizzeria_pizzeria_id`) VALUES (2, 02, '13/09/2020', '46', 'Delivered', true, 'Take away', 1);
INSERT INTO `OCPizza`.`Order` (`order_id`, `order_number`, `date`, `amount`, `state`, `is_paid`, `withdrawal`, `Pizzeria_pizzeria_id`) VALUES (3, 03, '13/09/2020', '78,56', 'Delivered', true, 'Delivery', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OCPizza`.`Invoice`
-- -----------------------------------------------------
START TRANSACTION;
USE `OCPizza`;
INSERT INTO `OCPizza`.`Invoice` (`invoice_id`, `invoice_number`, `payment_date`, `payment_mode`, `Order_order_id`) VALUES (1, 2345, '12/09/2020', 'Card', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OCPizza`.`Role`
-- -----------------------------------------------------
START TRANSACTION;
USE `OCPizza`;
INSERT INTO `OCPizza`.`Role` (`role_id`, `name`) VALUES (1, 'Delivery man');
INSERT INTO `OCPizza`.`Role` (`role_id`, `name`) VALUES (2, 'Pizzaiolo');
INSERT INTO `OCPizza`.`Role` (`role_id`, `name`) VALUES (3, 'Manager');
INSERT INTO `OCPizza`.`Role` (`role_id`, `name`) VALUES (4, 'Cashier');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OCPizza`.`Address`
-- -----------------------------------------------------
START TRANSACTION;
USE `OCPizza`;
INSERT INTO `OCPizza`.`Address` (`address_id`, `address`, `additional_information`, `postal_code`, `city`, `phone_number`, `latitude`, `longitude`, `is_default_address`, `Pizzeria_pizzeria_id`) VALUES (1, '18 rue de la niche', NULL, 95120, 'Ermont', 0103050709, 48.686219, 2.534542, true, DEFAULT);
INSERT INTO `OCPizza`.`Address` (`address_id`, `address`, `additional_information`, `postal_code`, `city`, `phone_number`, `latitude`, `longitude`, `is_default_address`, `Pizzeria_pizzeria_id`) VALUES (2, '20 rue de paris', NULL, 92110, 'Clichy', 0204060810, 48.897692, 2.307513, true, DEFAULT);
INSERT INTO `OCPizza`.`Address` (`address_id`, `address`, `additional_information`, `postal_code`, `city`, `phone_number`, `latitude`, `longitude`, `is_default_address`, `Pizzeria_pizzeria_id`) VALUES (3, '5 Rue des Cailloux', '1er étage, code porte 2345', 92110, 'Clichy', 0434433443, 48.896736, 2.306302, true, DEFAULT);
INSERT INTO `OCPizza`.`Address` (`address_id`, `address`, `additional_information`, `postal_code`, `city`, `phone_number`, `latitude`, `longitude`, `is_default_address`, `Pizzeria_pizzeria_id`) VALUES (4, '5 rue d\'Angers', NULL, 49000, 'Angers', 0130454647, 47.492432, -0.562563, true, 1);
INSERT INTO `OCPizza`.`Address` (`address_id`, `address`, `additional_information`, `postal_code`, `city`, `phone_number`, `latitude`, `longitude`, `is_default_address`, `Pizzeria_pizzeria_id`) VALUES (5, '7 rue de Clichy', NULL, 92110, 'Clichy', 0149343432, 48.903103, 2.304850, true, 2);
INSERT INTO `OCPizza`.`Address` (`address_id`, `address`, `additional_information`, `postal_code`, `city`, `phone_number`, `latitude`, `longitude`, `is_default_address`, `Pizzeria_pizzeria_id`) VALUES (6, '30 rue de la patience', NULL, 78410, 'Aubergenville', 0234345664, 48.959507, 1.855102, true, 3);
INSERT INTO `OCPizza`.`Address` (`address_id`, `address`, `additional_information`, `postal_code`, `city`, `phone_number`, `latitude`, `longitude`, `is_default_address`, `Pizzeria_pizzeria_id`) VALUES (7, '12 rue du général leclerc', NULL, 95880, 'Enghien-les-bains', 0123394955, 48.969772, 2.307348, true, 4);
INSERT INTO `OCPizza`.`Address` (`address_id`, `address`, `additional_information`, `postal_code`, `city`, `phone_number`, `latitude`, `longitude`, `is_default_address`, `Pizzeria_pizzeria_id`) VALUES (8, '34 rue de la mairie', NULL, 76000, 'Rouen', 0102030302, 49.446658, 1.078434, true, 5);
INSERT INTO `OCPizza`.`Address` (`address_id`, `address`, `additional_information`, `postal_code`, `city`, `phone_number`, `latitude`, `longitude`, `is_default_address`, `Pizzeria_pizzeria_id`) VALUES (9, '20 allée du petit chemin', NULL, 60000, 'Beauvais', 1678765434, 49.453990, 2.078885, true, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OCPizza`.`Customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `OCPizza`;
INSERT INTO `OCPizza`.`Customer` (`customer_id`, `account_number`, `first_name`, `last_name`, `birthday`, `email`, `login`, `password`, `token`, `Address_address_id`, `Order_order_id`, `Order_Pizzeria_pizzeria_id`) VALUES (1, '123456', 'Franck', 'Dupont', '12/01/1960', 'fdupont@gmail.com', 'fdupont', 'fdupont90$', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9', 1, DEFAULT, DEFAULT);
INSERT INTO `OCPizza`.`Customer` (`customer_id`, `account_number`, `first_name`, `last_name`, `birthday`, `email`, `login`, `password`, `token`, `Address_address_id`, `Order_order_id`, `Order_Pizzeria_pizzeria_id`) VALUES (2, '123457', 'Edouard', 'Godet', '15/03/1987', 'egodet@yahoo.fr', 'egodet', 'titietgrosminet98', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCOP', 2, DEFAULT, DEFAULT);
INSERT INTO `OCPizza`.`Customer` (`customer_id`, `account_number`, `first_name`, `last_name`, `birthday`, `email`, `login`, `password`, `token`, `Address_address_id`, `Order_order_id`, `Order_Pizzeria_pizzeria_id`) VALUES (3, '123458', 'Marie', 'Lac', '27/10/1990', 'mlac@gmail.com', 'mlac', 'yoyolili45', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJD', 3, DEFAULT, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OCPizza`.`Employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `OCPizza`;
INSERT INTO `OCPizza`.`Employee` (`employee_id`, `account_status`, `first_name`, `last_name`, `birthday`, `email`, `login`, `password`, `token`, `Pizzeria_pizzeria_id`, `Order_order_id`, `Order_Pizzeria_pizzeria_id`) VALUES (1, 1, 'Pierre', 'Lignole', '12/12/2000', 'plignole@free.fr', 'plignole', 'djdijz@dijd9', 'DIUZHD9892372HDIZHDIUHDIUZ', 1, DEFAULT, DEFAULT);
INSERT INTO `OCPizza`.`Employee` (`employee_id`, `account_status`, `first_name`, `last_name`, `birthday`, `email`, `login`, `password`, `token`, `Pizzeria_pizzeria_id`, `Order_order_id`, `Order_Pizzeria_pizzeria_id`) VALUES (2, 2, 'Camille', 'Poussin', '03/03/2002', 'cpoussin@orange.fr', 'cpoussin', 'tetedndndn998', 'IDUZHIUZH78Y238476GUEGYFZ', 1, DEFAULT, DEFAULT);
INSERT INTO `OCPizza`.`Employee` (`employee_id`, `account_status`, `first_name`, `last_name`, `birthday`, `email`, `login`, `password`, `token`, `Pizzeria_pizzeria_id`, `Order_order_id`, `Order_Pizzeria_pizzeria_id`) VALUES (3, 3, 'Marouane', 'Hedi', '04/04/1989', 'mhedi@ocpizzagroup.fr', 'mhedi', 'diuzhaduih6735$', 'DZOIHA9Y9237YDG297863GdDF', 1, DEFAULT, DEFAULT);
INSERT INTO `OCPizza`.`Employee` (`employee_id`, `account_status`, `first_name`, `last_name`, `birthday`, `email`, `login`, `password`, `token`, `Pizzeria_pizzeria_id`, `Order_order_id`, `Order_Pizzeria_pizzeria_id`) VALUES (4, 4, 'Eric', 'Durand', '04/05/1988', 'edurand@gmail.com', 'edurand', NULL, NULL, DEFAULT, DEFAULT, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OCPizza`.`Menu`
-- -----------------------------------------------------
START TRANSACTION;
USE `OCPizza`;
INSERT INTO `OCPizza`.`Menu` (`menu_id`, `name`, `description`, `image_ name`, `price`) VALUES (1, 'Big', 'Une pizza grand format, une boisson grand format, un dessert grand format.', 'big_menu.png', 16);
INSERT INTO `OCPizza`.`Menu` (`menu_id`, `name`, `description`, `image_ name`, `price`) VALUES (2, 'Medium', 'Une pizza format moyen, une boisson format moyen, un dessert format moyen.', 'medium_menu.png', 12);
INSERT INTO `OCPizza`.`Menu` (`menu_id`, `name`, `description`, `image_ name`, `price`) VALUES (3, 'Small', 'Une petite pizza, une petite boisson, un petit dessert.', 'small_menu.png', 8);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OCPizza`.`Item`
-- -----------------------------------------------------
START TRANSACTION;
USE `OCPizza`;
INSERT INTO `OCPizza`.`Item` (`item_id`, `name`, `description`, `image_name`, `price`) VALUES (1, '4 fromages grand format', 'Grand pizza aux 4 fromages', 'pizza_4_cheeses.png', 12);
INSERT INTO `OCPizza`.`Item` (`item_id`, `name`, `description`, `image_name`, `price`) VALUES (2, 'Coca Cola big', 'Une grand bouteille de Coca Cola', 'coca_bottle.png', 3);
INSERT INTO `OCPizza`.`Item` (`item_id`, `name`, `description`, `image_name`, `price`) VALUES (3, 'Fondant au chocolat big', 'Un grand fondant au chocolat', 'melting_chocolate_big.png', 4);
INSERT INTO `OCPizza`.`Item` (`item_id`, `name`, `description`, `image_name`, `price`) VALUES (4, 'Fanta', 'Canette de Fanta format 33cl', 'fanta_can.png', 1.5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OCPizza`.`Category`
-- -----------------------------------------------------
START TRANSACTION;
USE `OCPizza`;
INSERT INTO `OCPizza`.`Category` (`category_id`, `name`, `description`, `image_name`, `parent_category_id`) VALUES (1, 'Boissons', 'Boissons allant de la canette de Coca Cola à la bouteille de Fanta', 'drink.png', DEFAULT);
INSERT INTO `OCPizza`.`Category` (`category_id`, `name`, `description`, `image_name`, `parent_category_id`) VALUES (2, 'Canettes', 'Canettes', 'cans_cat.png', 1);
INSERT INTO `OCPizza`.`Category` (`category_id`, `name`, `description`, `image_name`, `parent_category_id`) VALUES (3, 'Bouteilles', 'Bouteilles', 'bottles_cat.png', 1);
INSERT INTO `OCPizza`.`Category` (`category_id`, `name`, `description`, `image_name`, `parent_category_id`) VALUES (4, 'Pizzas', 'Pizzas', 'pizzas_cat.png', DEFAULT);
INSERT INTO `OCPizza`.`Category` (`category_id`, `name`, `description`, `image_name`, `parent_category_id`) VALUES (5, 'Desserts', 'Desserts', 'dessert.png', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OCPizza`.`CategoryHasItem`
-- -----------------------------------------------------
START TRANSACTION;
USE `OCPizza`;
INSERT INTO `OCPizza`.`CategoryHasItem` (`category_id`, `item_id`) VALUES (2, 4);
INSERT INTO `OCPizza`.`CategoryHasItem` (`category_id`, `item_id`) VALUES (4, 1);
INSERT INTO `OCPizza`.`CategoryHasItem` (`category_id`, `item_id`) VALUES (3, 2);
INSERT INTO `OCPizza`.`CategoryHasItem` (`category_id`, `item_id`) VALUES (5, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OCPizza`.`Note`
-- -----------------------------------------------------
START TRANSACTION;
USE `OCPizza`;
INSERT INTO `OCPizza`.`Note` (`item_id`, `description`) VALUES (1, Sans Edam);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OCPizza`.`Recipe`
-- -----------------------------------------------------
START TRANSACTION;
USE `OCPizza`;
INSERT INTO `OCPizza`.`Recipe` (`item_id`, `description`, `preparation_time_in_seconds`) VALUES (1, '1. Faîtes préchauffez votre four (210 C°). Etalez la pâte et recouvrez-la du coulis de tomate.\n2. Ajoutez la mozzarella préalablement coupée en petit dés. Mettez ensuite le gorgonzola découpé en dés et des 1/2 rondelles de chèvre. Ajouter le parmesan et l\'origan.\n3. Faîtes cuire 20 minutes, une fois sortie du four, poivrez votre pizza 4 fromages.', 1200);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OCPizza`.`Ingredient`
-- -----------------------------------------------------
START TRANSACTION;
USE `OCPizza`;
INSERT INTO `OCPizza`.`Ingredient` (`ingredient_id`, `name`, `description`, `price`) VALUES (1, 'Edam', 'Fromage de type Edam', 0.5);
INSERT INTO `OCPizza`.`Ingredient` (`ingredient_id`, `name`, `description`, `price`) VALUES (2, 'Parmesan', 'Fromage de type Parmesan', 0.5);
INSERT INTO `OCPizza`.`Ingredient` (`ingredient_id`, `name`, `description`, `price`) VALUES (3, 'Mozzarella', 'Fromage de type Mozzarella', 0.5);
INSERT INTO `OCPizza`.`Ingredient` (`ingredient_id`, `name`, `description`, `price`) VALUES (4, 'Gorgonzola', 'Fromage de type Gorgonzola', 0.5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OCPizza`.`EmployeeHasRole`
-- -----------------------------------------------------
START TRANSACTION;
USE `OCPizza`;
INSERT INTO `OCPizza`.`EmployeeHasRole` (`Role_role_id`, `Employee_employee_id`) VALUES (1, 1);
INSERT INTO `OCPizza`.`EmployeeHasRole` (`Role_role_id`, `Employee_employee_id`) VALUES (2, 2);
INSERT INTO `OCPizza`.`EmployeeHasRole` (`Role_role_id`, `Employee_employee_id`) VALUES (3, 3);
INSERT INTO `OCPizza`.`EmployeeHasRole` (`Role_role_id`, `Employee_employee_id`) VALUES (4, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OCPizza`.`OrderHasMenu`
-- -----------------------------------------------------
START TRANSACTION;
USE `OCPizza`;
INSERT INTO `OCPizza`.`OrderHasMenu` (`Order_order_id`, `Menu_menu_id`, `quantity`) VALUES (1, 2, 2);
INSERT INTO `OCPizza`.`OrderHasMenu` (`Order_order_id`, `Menu_menu_id`, `quantity`) VALUES (2, 1, 2);
INSERT INTO `OCPizza`.`OrderHasMenu` (`Order_order_id`, `Menu_menu_id`, `quantity`) VALUES (2, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OCPizza`.`RecipeHasIngredient`
-- -----------------------------------------------------
START TRANSACTION;
USE `OCPizza`;
INSERT INTO `OCPizza`.`RecipeHasIngredient` (`Recipe_item_id`, `Ingredient_ingredient_id`, `quantity`) VALUES (1, 1, 2);
INSERT INTO `OCPizza`.`RecipeHasIngredient` (`Recipe_item_id`, `Ingredient_ingredient_id`, `quantity`) VALUES (1, 2, 3);
INSERT INTO `OCPizza`.`RecipeHasIngredient` (`Recipe_item_id`, `Ingredient_ingredient_id`, `quantity`) VALUES (1, 3, 3);
INSERT INTO `OCPizza`.`RecipeHasIngredient` (`Recipe_item_id`, `Ingredient_ingredient_id`, `quantity`) VALUES (1, 4, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OCPizza`.`Stock`
-- -----------------------------------------------------
START TRANSACTION;
USE `OCPizza`;
INSERT INTO `OCPizza`.`Stock` (`Ingredient_ingredient_id`, `Pizzeria_pizzeria_id`, `quantity`) VALUES (1, 1, 47);
INSERT INTO `OCPizza`.`Stock` (`Ingredient_ingredient_id`, `Pizzeria_pizzeria_id`, `quantity`) VALUES (2, 1, 50);
INSERT INTO `OCPizza`.`Stock` (`Ingredient_ingredient_id`, `Pizzeria_pizzeria_id`, `quantity`) VALUES (3, 1, 2);
INSERT INTO `OCPizza`.`Stock` (`Ingredient_ingredient_id`, `Pizzeria_pizzeria_id`, `quantity`) VALUES (4, 1, 38);
INSERT INTO `OCPizza`.`Stock` (`Ingredient_ingredient_id`, `Pizzeria_pizzeria_id`, `quantity`) VALUES (1, 2, 78);
INSERT INTO `OCPizza`.`Stock` (`Ingredient_ingredient_id`, `Pizzeria_pizzeria_id`, `quantity`) VALUES (2, 2, 48);
INSERT INTO `OCPizza`.`Stock` (`Ingredient_ingredient_id`, `Pizzeria_pizzeria_id`, `quantity`) VALUES (3, 2, 22);
INSERT INTO `OCPizza`.`Stock` (`Ingredient_ingredient_id`, `Pizzeria_pizzeria_id`, `quantity`) VALUES (4, 2, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OCPizza`.`MenuHasItem`
-- -----------------------------------------------------
START TRANSACTION;
USE `OCPizza`;
INSERT INTO `OCPizza`.`MenuHasItem` (`Item_item_id`, `Menu_menu_id`) VALUES (1, 1);
INSERT INTO `OCPizza`.`MenuHasItem` (`Item_item_id`, `Menu_menu_id`) VALUES (2, 1);
INSERT INTO `OCPizza`.`MenuHasItem` (`Item_item_id`, `Menu_menu_id`) VALUES (3, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OCPizza`.`OrderHasItem`
-- -----------------------------------------------------
START TRANSACTION;
USE `OCPizza`;
INSERT INTO `OCPizza`.`OrderHasItem` (`Order_order_id`, `Item_item_id`) VALUES (1, 4);

COMMIT;

