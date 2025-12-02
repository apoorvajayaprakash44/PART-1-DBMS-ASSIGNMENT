-- MySQL Workbench Forward Engineering (Spotify Version)

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema spotify_streaming
-- -----------------------------------------------------

DROP SCHEMA IF EXISTS `spotify_streaming` ;

CREATE SCHEMA IF NOT EXISTS `spotify_streaming`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci ;

USE `spotify_streaming` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `UserID` INT NOT NULL,
  `FullName` VARCHAR(80) NOT NULL,
  `Email` VARCHAR(120) NOT NULL,
  `Phone` VARCHAR(15) NULL,
  `Country` VARCHAR(40) NULL,
  `DateOfBirth` DATE NULL,
  `CreatedAt` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`UserID`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  UNIQUE INDEX `Phone_UNIQUE` (`Phone` ASC) VISIBLE
) ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `subscription_plan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `subscription_plan` ;

CREATE TABLE IF NOT EXISTS `subscription_plan` (
  `PlanID` INT NOT NULL,
  `PlanName` VARCHAR(50) NOT NULL,
  `MonthlyPrice` DECIMAL(10,2) NOT NULL,
  `MaxDevices` TINYINT NOT NULL,
  `IsFamilyPlan` VARCHAR(3) NOT NULL DEFAULT 'No',
  PRIMARY KEY (`PlanID`),
  UNIQUE INDEX `PlanName_UNIQUE` (`PlanName` ASC) VISIBLE
) ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `user_subscription`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_subscription` ;

CREATE TABLE IF NOT EXISTS `user_subscription` (
  `SubscriptionID` INT NOT NULL,
  `UserID` INT NOT NULL,
  `PlanID` INT NOT NULL,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NULL,
  `IsActive` VARCHAR(3) NOT NULL DEFAULT 'Yes',
  `AutoRenew` VARCHAR(3) NOT NULL DEFAULT 'Yes',
  PRIMARY KEY (`SubscriptionID`),
  INDEX `UserID_idx` (`UserID` ASC) VISIBLE,
  INDEX `PlanID_idx` (`PlanID` ASC) VISIBLE,
  CONSTRAINT `user_subscription_ibfk_1`
    FOREIGN KEY (`UserID`)
    REFERENCES `user` (`UserID`),
  CONSTRAINT `user_subscription_ibfk_2`
    FOREIGN KEY (`PlanID`)
    REFERENCES `subscription_plan` (`PlanID`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `artist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `artist` ;

CREATE TABLE IF NOT EXISTS `artist` (
  `ArtistID` INT NOT NULL,
  `ArtistName` VARCHAR(100) NOT NULL,
  `Country` VARCHAR(40) NULL,
  `DebutYear` SMALLINT NULL,
  PRIMARY KEY (`ArtistID`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `album`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `album` ;

CREATE TABLE IF NOT EXISTS `album` (
  `AlbumID` INT NOT NULL,
  `ArtistID` INT NOT NULL,
  `AlbumTitle` VARCHAR(120) NOT NULL,
  `ReleaseDate` DATE NULL,
  `Genre` VARCHAR(40) NULL,
  PRIMARY KEY (`AlbumID`),
  INDEX `ArtistID_idx` (`ArtistID` ASC) VISIBLE,
  CONSTRAINT `album_ibfk_1`
    FOREIGN KEY (`ArtistID`)
    REFERENCES `artist` (`ArtistID`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `track`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `track` ;

CREATE TABLE IF NOT EXISTS `track` (
  `TrackID` INT NOT NULL,
  `AlbumID` INT NOT NULL,
  `TrackTitle` VARCHAR(120) NOT NULL,
  `DurationSeconds` SMALLINT NOT NULL,
  `ExplicitFlag` VARCHAR(3) NOT NULL DEFAULT 'No',
  `PopularityScore` TINYINT NULL,
  PRIMARY KEY (`TrackID`),
  INDEX `AlbumID_idx` (`AlbumID` ASC) VISIBLE,
  CONSTRAINT `track_ibfk_1`
    FOREIGN KEY (`AlbumID`)
    REFERENCES `album` (`AlbumID`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `playlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `playlist` ;

CREATE TABLE IF NOT EXISTS `playlist` (
  `PlaylistID` INT NOT NULL,
  `UserID` INT NOT NULL,
  `PlaylistName` VARCHAR(100) NOT NULL,
  `IsPublic` VARCHAR(3) NOT NULL DEFAULT 'Yes',
  `CreatedAt` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`PlaylistID`),
  INDEX `UserID_idx` (`UserID` ASC) VISIBLE,
  CONSTRAINT `playlist_ibfk_1`
    FOREIGN KEY (`UserID`)
    REFERENCES `user` (`UserID`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `playlist_track`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `playlist_track` ;

CREATE TABLE IF NOT EXISTS `playlist_track` (
  `PlaylistID` INT NOT NULL,
  `TrackID` INT NOT NULL,
  `AddedAt` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`PlaylistID`, `TrackID`),
  INDEX `TrackID_idx` (`TrackID` ASC) VISIBLE,
  CONSTRAINT `playlist_track_ibfk_1`
    FOREIGN KEY (`PlaylistID`)
    REFERENCES `playlist` (`PlaylistID`),
  CONSTRAINT `playlist_track_ibfk_2`
    FOREIGN KEY (`TrackID`)
    REFERENCES `track` (`TrackID`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `device`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `device` ;

CREATE TABLE IF NOT EXISTS `device` (
  `DeviceID` INT NOT NULL,
  `UserID` INT NOT NULL,
  `DeviceType` VARCHAR(30) NOT NULL,   -- Mobile, Desktop, SmartSpeaker
  `OS` VARCHAR(30) NULL,
  `RegisteredAt` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`DeviceID`),
  INDEX `UserID_idx` (`UserID` ASC) VISIBLE,
  CONSTRAINT `device_ibfk_1`
    FOREIGN KEY (`UserID`)
    REFERENCES `user` (`UserID`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `listening_session`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `listening_session` ;

CREATE TABLE IF NOT EXISTS `listening_session` (
  `SessionID` BIGINT NOT NULL,
  `UserID` INT NOT NULL,
  `TrackID` INT NOT NULL,
  `DeviceID` INT NULL,
  `ListenedAt` DATETIME NOT NULL,
  `SecondsPlayed` SMALLINT NULL,
  PRIMARY KEY (`SessionID`),
  INDEX `UserID_idx` (`UserID` ASC) VISIBLE,
  INDEX `TrackID_idx` (`TrackID` ASC) VISIBLE,
  INDEX `DeviceID_idx` (`DeviceID` ASC) VISIBLE,
  CONSTRAINT `listening_session_ibfk_1`
    FOREIGN KEY (`UserID`)
    REFERENCES `user` (`UserID`),
  CONSTRAINT `listening_session_ibfk_2`
    FOREIGN KEY (`TrackID`)
    REFERENCES `track` (`TrackID`),
  CONSTRAINT `listening_session_ibfk_3`
    FOREIGN KEY (`DeviceID`)
    REFERENCES `device` (`DeviceID`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `payment` ;

CREATE TABLE IF NOT EXISTS `payment` (
  `PaymentID` INT NOT NULL,
  `SubscriptionID` INT NOT NULL,
  `PaymentDate` DATETIME NOT NULL,
  `Amount` DECIMAL(10,2) NOT NULL,
  `PaymentMethod` VARCHAR(20) NULL,    -- Card, UPI, NetBanking
  `Status` VARCHAR(20) NOT NULL DEFAULT 'Success',
  PRIMARY KEY (`PaymentID`),
  INDEX `SubscriptionID_idx` (`SubscriptionID` ASC) VISIBLE,
  CONSTRAINT `payment_ibfk_1`
    FOREIGN KEY (`SubscriptionID`)
    REFERENCES `user_subscription` (`SubscriptionID`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;