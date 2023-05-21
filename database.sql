
DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `name` VARCHAR(100) DEFAULT NULL,
  `category` VARCHAR(20) DEFAULT NULL,
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (`username`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;




SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `vehicles`;
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE `vehicles` (
  `Vec_RegNo` VARCHAR(50) NOT NULL,
  `VecNo` INT(50) DEFAULT NULL,
  `Model` VARCHAR(50) DEFAULT NULL,
  `Capacity` INT(3) DEFAULT NULL,
  `DateBought` DATE DEFAULT NULL,
  `Insurance_status` VARCHAR(100) DEFAULT NULL,
  `Date_Insured` DATE DEFAULT NULL,
  `Insurance_Expiry` DATE DEFAULT NULL,
  PRIMARY KEY (`Vec_RegNo`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;



SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `emp`;
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE `emp` (
  `empNo` INT(4) NOT NULL,
  `Sname` VARCHAR(25) DEFAULT NULL,
  `Fname` VARCHAR(25) DEFAULT NULL,
  `Lname` VARCHAR(25) DEFAULT NULL,
  `Gender` VARCHAR(10) DEFAULT NULL,
  `DOB` DATE DEFAULT NULL,
  `Designation` VARCHAR(50) DEFAULT NULL,
  `Telephone` INT(10) DEFAULT NULL,
  `E_Mail` VARCHAR(50) DEFAULT NULL,
  `Address` VARCHAR(100) DEFAULT NULL,
  PRIMARY KEY (`empNo`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;


SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `passenger`;
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE `passenger` (
  `Pass_No` INT(4) NOT NULL,
  `Pass_Name` VARCHAR(100) DEFAULT NULL,
  `Address` VARCHAR(100) DEFAULT NULL,
  `Tel_no` INT(10) DEFAULT NULL,
  `Date_of_Travels` DATE DEFAULT NULL,
  `Depot` VARCHAR(25) DEFAULT NULL,
  `To_place` VARCHAR(50) DEFAULT NULL,
  `Pay_status` VARCHAR(25) DEFAULT NULL,
  `booked_status` VARCHAR(25) DEFAULT NULL,
  PRIMARY KEY (`Pass_No`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;


SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `booking`;
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE `booking` (
  `Booking_No` INT(4) NOT NULL,
  `Pass_no` INT(4) DEFAULT NULL,
  `PassName` VARCHAR(25) DEFAULT NULL,
  `vec_RegNo` VARCHAR(50) DEFAULT NULL,
  `SeatNo` INT(2) DEFAULT NULL,
  `Date_of_Travel` DATE DEFAULT NULL,
  `Time_of_Travel` VARCHAR(10) DEFAULT NULL,
  `Pass_From` VARCHAR(25) DEFAULT NULL,
  `Destination` VARCHAR(50) DEFAULT NULL,
  `Amount` DECIMAL(10,2) DEFAULT NULL,
  PRIMARY KEY (`Booking_No`),
  KEY `passno_fk11` (`Pass_no`),
  KEY `vec_regno_fk11` (`Vec_RegNo`),
  CONSTRAINT `passno_fk11` FOREIGN KEY (`Pass_no`) REFERENCES `passenger` (`Pass_No`) ON DELETE CASCADE,
  CONSTRAINT `vec_regno_fk11` FOREIGN KEY (`vec_RegNo`) REFERENCES `vehicles` (`Vec_RegNo`) ON DELETE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=latin1;


SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `payment`;
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE `payment` (
  `Payment_no` INT(4) NOT NULL,
  `Pass_No` INT(4) DEFAULT NULL,
  `Pass_name` VARCHAR(50) DEFAULT NULL,
  `Payment_mode` VARCHAR(25) DEFAULT NULL,
  `Date_payment` DATE DEFAULT NULL,
  `amount_paid` DECIMAL(10,2) DEFAULT NULL,
  `received_by` VARCHAR(25) DEFAULT NULL,
  PRIMARY KEY (`Payment_no`),
  KEY `pass_no_fk` (`Pass_No`),
  CONSTRAINT `pass_no_fk` FOREIGN KEY (`Pass_No`) REFERENCES `passenger` (`Pass_No`) ON DELETE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=latin1;


SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `route`;
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE `route` (
  `Route_No` INT(4) NOT NULL,
  `RouteName` VARCHAR(100) DEFAULT NULL,
  `Depot` VARCHAR(100) DEFAULT NULL,
  `Destination` VARCHAR(100) DEFAULT NULL,
  `Distance` VARCHAR(20) DEFAULT NULL,
  `Fare_charged` DECIMAL(10,2) DEFAULT NULL,
  PRIMARY KEY (`Route_No`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;



CREATE TABLE `scheduling` (
  `Vec_no` int(5) DEFAULT NULL,
  `Vec_reg` varchar(50) DEFAULT NULL,
  `Route_no` int(4) DEFAULT  NULL,
  `Route_name` varchar(50) DEFAULT NULL,
  `empno` int(4) DEFAULT NULL,
  `Driver_name` varchar(50) DEFAULT NULL,
  `Date_Scheduled` date DEFAULT NULL,
  `Dept_time` varchar(10) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  KEY `route_no_fk1` (`Route_no`),
  KEY `empno_fk1` (`empno`),
  KEY `username_fk1` (`username`),
  KEY `vec_regno_fk1` (`Vec_reg`),
  CONSTRAINT `empno_fk1` FOREIGN KEY (`empno`) REFERENCES `emp` (`empNo`),
  CONSTRAINT `route_no_fk1` FOREIGN KEY (`Route_no`) REFERENCES `route` (`Route_No`),
  CONSTRAINT `username_fk1` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  CONSTRAINT `vec_regno_fk1` FOREIGN KEY (`Vec_reg`) REFERENCES `vehicles` (`Vec_RegNo`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;




DELIMITER $$

CREATE TRIGGER BUS_FARE_CHARGES_CHECK BEFORE INSERT ON ROUTE
    FOR EACH ROW BEGIN
           IF NEW.FARE_CHARGED < 0 THEN
               SET NEW.FARE_CHARGED = 0;
           ELSEIF NEW.FARE_CHARGED > 0 THEN
               SET NEW.FARE_CHARGED = NEW.FARE_CHARGED + (NEW.FARE_CHARGED*0.18);
           END IF;
       END;
$$

DELIMITER ;