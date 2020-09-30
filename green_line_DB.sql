-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Anstallda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Anstallda` (
  `Anstalld-ID` INT NOT NULL,
  `Anstallda_Anstalld-ID` INT NULL,
  `Arbetsgivare` VARCHAR(45) NULL,
  `eNamn` VARCHAR(45) NULL,
  `fNamn` VARCHAR(45) NULL,
  `Verksamhet-ID` VARCHAR(45) NULL,
  PRIMARY KEY (`Anstalld-ID`, `Anstallda_Anstalld-ID`),
  INDEX `fk_Anstallda_Anstallda1_idx` (`Anstallda_Anstalld-ID` ASC) VISIBLE,
  CONSTRAINT `fk_Anstallda_Anstallda1`
    FOREIGN KEY (`Anstallda_Anstalld-ID`)
    REFERENCES `mydb`.`Anstallda` (`Anstalld-ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Kund`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Kund` (
  `Kund-ID` INT NOT NULL,
  `KundNamn` VARCHAR(45) NULL,
  `Telefon` VARCHAR(45) NULL,
  `Adress` VARCHAR(45) NULL,
  `PostOrt` VARCHAR(45) NULL,
  `PostNr` VARCHAR(45) NULL,
  `AnstallningsID` VARCHAR(45) NULL,
  `BankNr` VARCHAR(45) NULL,
  `OrgNr` VARCHAR(45) NULL,
  `Anstallda_Anstalld-ID` INT NULL,
  `Anstallda_Anstallda_Anstalld-ID` INT NULL,
  PRIMARY KEY (`Kund-ID`, `Anstallda_Anstalld-ID`, `Anstallda_Anstallda_Anstalld-ID`),
  INDEX `fk_Kund_Anstallda1_idx` (`Anstallda_Anstalld-ID` ASC, `Anstallda_Anstallda_Anstalld-ID` ASC) VISIBLE,
  CONSTRAINT `fk_Kund_Anstallda1`
    FOREIGN KEY (`Anstallda_Anstalld-ID` , `Anstallda_Anstallda_Anstalld-ID`)
    REFERENCES `mydb`.`Anstallda` (`Anstalld-ID` , `Anstallda_Anstalld-ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`KundOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`KundOrder` (
  `KundOrder-ID` INT NOT NULL,
  `Kund-ID` VARCHAR(45) NULL,
  `OrderDatum` VARCHAR(45) NULL,
  `OrderLagd` VARCHAR(45) NULL,
  `OrderLeverans` VARCHAR(45) NULL,
  `Status` VARCHAR(45) NULL,
  `kommentar` VARCHAR(45) NULL,
  `Kund_Kund-ID` INT NOT NULL,
  PRIMARY KEY (`KundOrder-ID`, `Kund_Kund-ID`),
  INDEX `fk_KundOrder_Kund1_idx` (`Kund_Kund-ID` ASC) VISIBLE,
  CONSTRAINT `fk_KundOrder_Kund1`
    FOREIGN KEY (`Kund_Kund-ID`)
    REFERENCES `mydb`.`Kund` (`Kund-ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Betalning`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Betalning` (
  `Kund-ID` INT NOT NULL,
  `Kund_Kund-ID` INT NOT NULL,
  `BankNr` VARCHAR(45) NULL,
  `Betalning` VARCHAR(45) NULL,
  PRIMARY KEY (`Kund-ID`, `Kund_Kund-ID`),
  INDEX `fk_Betalning_Kund_idx` (`Kund_Kund-ID` ASC) VISIBLE,
  CONSTRAINT `fk_Betalning_Kund`
    FOREIGN KEY (`Kund_Kund-ID`)
    REFERENCES `mydb`.`Kund` (`Kund-ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ravara`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ravara` (
  `Ravara-ID` INT NOT NULL,
  `RavaraNamn` VARCHAR(45) NULL,
  `RavaraRad` VARCHAR(45) NULL,
  `RavaraPris` VARCHAR(45) NULL,
  `RavaraAntal` VARCHAR(45) NULL,
  PRIMARY KEY (`Ravara-ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produkt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produkt` (
  `Produkt-ID` INT NOT NULL,
  `ProduktNamn` VARCHAR(45) NULL,
  `ProduktRad` VARCHAR(45) NULL,
  `ProduktPris` VARCHAR(45) NULL,
  `ProduktAntal` VARCHAR(45) NULL,
  `Ravara_Ravara-ID` INT NOT NULL,
  PRIMARY KEY (`Produkt-ID`, `Ravara_Ravara-ID`),
  INDEX `fk_Produkt_Ravara1_idx` (`Ravara_Ravara-ID` ASC) VISIBLE,
  CONSTRAINT `fk_Produkt_Ravara1`
    FOREIGN KEY (`Ravara_Ravara-ID`)
    REFERENCES `mydb`.`Ravara` (`Ravara-ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OrderInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OrderInfo` (
  `Orderinfo-ID` INT NOT NULL,
  `OrderLista-ID` VARCHAR(45) NULL,
  `Produkt-ID` VARCHAR(45) NULL,
  `KvantitetOrder` VARCHAR(45) NULL,
  `ProduktPris` VARCHAR(45) NULL,
  `KundOrder_Order-ID` INT NOT NULL,
  `KundOrder_Kund_Kund-ID` INT NOT NULL,
  `Produkt_Produkt-ID` INT NOT NULL,
  PRIMARY KEY (`Orderinfo-ID`, `KundOrder_Order-ID`, `KundOrder_Kund_Kund-ID`, `Produkt_Produkt-ID`),
  INDEX `fk_OrderInfo_KundOrder1_idx` (`KundOrder_Order-ID` ASC, `KundOrder_Kund_Kund-ID` ASC) VISIBLE,
  INDEX `fk_OrderInfo_Produkt1_idx` (`Produkt_Produkt-ID` ASC) VISIBLE,
  CONSTRAINT `fk_OrderInfo_KundOrder1`
    FOREIGN KEY (`KundOrder_Order-ID` , `KundOrder_Kund_Kund-ID`)
    REFERENCES `mydb`.`KundOrder` (`KundOrder-ID` , `Kund_Kund-ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderInfo_Produkt1`
    FOREIGN KEY (`Produkt_Produkt-ID`)
    REFERENCES `mydb`.`Produkt` (`Produkt-ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RavaraOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RavaraOrder` (
  `Inkop-ID` INT NOT NULL,
  `InkopDatum` VARCHAR(45) NULL,
  `Inkop-Saldo` VARCHAR(45) NULL,
  `Inkop-Typ` VARCHAR(45) NULL,
  `Inventering-ID` VARCHAR(45) NULL,
  PRIMARY KEY (`Inkop-ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Verksamhet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Verksamhet` (
  `Verksamhet-ID` INT NOT NULL,
  `Arbetsgivare` VARCHAR(45) NULL,
  `Telefon` VARCHAR(45) NULL,
  `Adress` VARCHAR(45) NULL,
  `PostNr` VARCHAR(45) NULL,
  `OrgNr2` VARCHAR(45) NULL,
  `RavaraOrder_Inkop-ID` INT NOT NULL,
  `Anstallda_Anstalld-ID` INT NOT NULL,
  `Anstallda_Anstallda_Anstalld-ID` INT NOT NULL,
  PRIMARY KEY (`Verksamhet-ID`, `RavaraOrder_Inkop-ID`, `Anstallda_Anstalld-ID`, `Anstallda_Anstallda_Anstalld-ID`),
  INDEX `fk_Verksamhet_RavaraOrder1_idx` (`RavaraOrder_Inkop-ID` ASC) VISIBLE,
  INDEX `fk_Verksamhet_Anstallda1_idx` (`Anstallda_Anstalld-ID` ASC, `Anstallda_Anstallda_Anstalld-ID` ASC) VISIBLE,
  CONSTRAINT `fk_Verksamhet_RavaraOrder1`
    FOREIGN KEY (`RavaraOrder_Inkop-ID`)
    REFERENCES `mydb`.`RavaraOrder` (`Inkop-ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Verksamhet_Anstallda1`
    FOREIGN KEY (`Anstallda_Anstalld-ID` , `Anstallda_Anstallda_Anstalld-ID`)
    REFERENCES `mydb`.`Anstallda` (`Anstalld-ID` , `Anstallda_Anstalld-ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Inventering`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Inventering` (
  `Inventering-ID` INT NOT NULL,
  `Produkt-ID` VARCHAR(45) NULL,
  `Ravara-ID` VARCHAR(45) NULL,
  `Verksamhets-ID` VARCHAR(45) NULL,
  `leverantor-ID` VARCHAR(45) NULL,
  `moms` VARCHAR(45) NULL,
  `Pris` VARCHAR(45) NULL,
  `Ravara_Ravara-ID` INT NOT NULL,
  `Produkt_Produkt-ID` INT NOT NULL,
  `Produkt_Ravara_Ravara-ID` INT NOT NULL,
  `RavaraOrder_Inkop-ID` INT NOT NULL,
  PRIMARY KEY (`Inventering-ID`, `Ravara_Ravara-ID`, `Produkt_Produkt-ID`, `Produkt_Ravara_Ravara-ID`, `RavaraOrder_Inkop-ID`),
  INDEX `fk_Inventering_Ravara1_idx` (`Ravara_Ravara-ID` ASC) VISIBLE,
  INDEX `fk_Inventering_Produkt1_idx` (`Produkt_Produkt-ID` ASC, `Produkt_Ravara_Ravara-ID` ASC) VISIBLE,
  INDEX `fk_Inventering_RavaraOrder1_idx` (`RavaraOrder_Inkop-ID` ASC) VISIBLE,
  CONSTRAINT `fk_Inventering_Ravara1`
    FOREIGN KEY (`Ravara_Ravara-ID`)
    REFERENCES `mydb`.`Ravara` (`Ravara-ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventering_Produkt1`
    FOREIGN KEY (`Produkt_Produkt-ID` , `Produkt_Ravara_Ravara-ID`)
    REFERENCES `mydb`.`Produkt` (`Produkt-ID` , `Ravara_Ravara-ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventering_RavaraOrder1`
    FOREIGN KEY (`RavaraOrder_Inkop-ID`)
    REFERENCES `mydb`.`RavaraOrder` (`Inkop-ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
