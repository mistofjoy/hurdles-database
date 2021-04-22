--Creación de la db

CREATE SCHEMA hurdlesdb 
    DEFAULT CHARACTER SET utf8
    ;

--Colocando la db en predeterminado

USE hurdlesdb;

--Insertando tablas independientes

CREATE TABLE `hurdlesdb`.`stories` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `series_title` VARCHAR(70) NOT NULL,
    `story_numer` VARCHAR(3) NULL,
    `story_title` VARCHAR(70) NULL,
    `author` VARCHAR(45) NULL,
    `story_start_date` DATE NULL,
    `story_end_date` DATE NULL,
    PRIMARY KEY (`ID`)
    );

CREATE TABLE `hurdlesdb`.`events` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(70) NOT NULL,
    `date` DATE NULL,
    `detonators` TEXT NULL,
    `description` TEXT NULL,
    `consequences` TEXT NULL,
    PRIMARY KEY (`ID`)
    );

CREATE TABLE `hurdlesdb`.`lands` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    `geography` TEXT,
    `history` TEXT,
    `people` TEXT,
    `civilization` TEXT,
    PRIMARY KEY (`ID`)
    );

CREATE TABLE `hurdlesdb`.`organizations` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(70),
    `purpose` TEXT,
    `introduction` TEXT,
    `background` TEXT,
    PRIMARY KEY (`ID`)
    );

--Tablas dependientes

CREATE TABLE `hurdlesdb`.`locations` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `landID` INT NULL,
    `name` VARCHAR(70) NOT NULL,
    `description` TEXT NULL,
    PRIMARY KEY (`ID`),
    INDEX `lands_locations_idx` (`landID` ASC) VISIBLE,
    CONSTRAINT `lands_locations`
        FOREIGN KEY (`landID`)
        REFERENCES `hurdlesdb`.`lands` (`ID`)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
    );

CREATE TABLE `hurdlesdb`.`characters` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `first_name` VARCHAR(45) NOT NULL,
    `last_name` VARCHAR(45) NULL,
    `alternate_name` VARCHAR(45) NULL,
    `birth_gender` VARCHAR(6) NULL,
    `birth_date` DATE NULL,
    `birth_land` INT NULL,
    `birth_location` INT NULL,
    PRIMARY KEY (`ID`),
    INDEX `birth_land_idx` (`birth_land` ASC) VISIBLE,
    INDEX `birth_location_idx` (`birth_location` ASC) VISIBLE,
    CONSTRAINT `birth_land`
        FOREIGN KEY (`birth_land`)
        REFERENCES `hurdlesdb`.`lands` (`ID`)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CONSTRAINT `birth_location`
        FOREIGN KEY (`birth_location`)
        REFERENCES `hurdlesdb`.`locations` (`ID`)
        ON DELETE SET NULL
        ON UPDATE CASCADE
    );

CREATE TABLE `hurdlesdb`.`book_editions` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `storyID` INT NOT NULL,
    `language` VARCHAR(45) NULL,
    `translator` VARCHAR(70) NULL,
    `editor` VARCHAR(70) NULL,
    `publisher` VARCHAR(70) NULL,
    `publish_date` DATE NULL,
    `edition` INT NULL,
    `ISBN` CHAR(13) NULL,
    PRIMARY KEY (`ID`),
    INDEX `story_edition_idx` (`storyID` ASC) VISIBLE,
    CONSTRAINT `story_edition`
        FOREIGN KEY (`storyID`)
        REFERENCES `hurdlesdb`.`stories` (`ID`)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
    );

CREATE TABLE `hurdlesdb`.`character_profile` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `characterID` INT NOT NULL,
    `storyID` INT NOT NULL,
    `starting_age` INT NULL,
    `height` DECIMAL NULL,
    `weight` DECIMAL NULL,
    `hair_color` VARCHAR(20) NULL,
    `skin_color` VARCHAR(20) NULL,
    `eye_color` VARCHAR(20) NULL,
    `starting_occupation` VARCHAR(70) NULL,
    `powers` TINYINT NULL,
    `introduction` TEXT NULL,
    `background` TEXT NULL,
    `personality` TEXT NULL,
    `appearance` TEXT NULL,
    `abilities` TEXT NULL,
    PRIMARY KEY (`ID`),
    INDEX `characterID_idx` (`characterID` ASC) VISIBLE,
    INDEX `storyID_idx` (`storyID` ASC) VISIBLE,
    CONSTRAINT `characterID`
        FOREIGN KEY (`characterID`)
        REFERENCES `hurdlesdb`.`characters` (`ID`)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT `storyID`
        FOREIGN KEY (`storyID`)
        REFERENCES `hurdlesdb`.`stories` (`ID`)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
    );

-- tablas transitivas

CREATE TABLE `hurdlesdb`.`events_locations` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `eventID` INT NOT NULL,
    `locationID` INT NULL,
    PRIMARY KEY (`ID`),
    INDEX `eventID_idx` (`eventID` ASC) VISIBLE,
    INDEX `locationID_idx` (`locationID` ASC) VISIBLE,
    CONSTRAINT `eventsLocation_events`
        FOREIGN KEY (`eventID`)
        REFERENCES `hurdlesdb`.`events` (`ID`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT `eventsLocation_locations`
        FOREIGN KEY (`locationID`)
        REFERENCES `hurdlesdb`.`locations` (`ID`)
        ON DELETE SET NULL
        ON UPDATE CASCADE
    );

CREATE TABLE `hurdlesdb`.`character_event` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `characterID` INT NULL,
    `eventID` INT NOT NULL,
    PRIMARY KEY (`ID`),
    INDEX `characterID_idx` (`characterID` ASC) VISIBLE,
    INDEX `eventID_idx` (`eventID` ASC) VISIBLE,
    CONSTRAINT `characterEvent_character`
        FOREIGN KEY (`characterID`)
        REFERENCES `hurdlesdb`.`characters` (`ID`)
        ON DELETE NO ACTION
        ON UPDATE CASCADE,
    CONSTRAINT `characterEvent_event`
        FOREIGN KEY (`eventID`)
        REFERENCES `hurdlesdb`.`events` (`ID`)
        ON DELETE CASCADE
        ON UPDATE CASCADE  
    );

CREATE TABLE `hurdlesdb`.`story_event` (
    `ID` INT NOT NULL,
    `storyID` INT NOT NULL,
    `eventID` INT NULL,
    PRIMARY KEY (`ID`),
    INDEX `storyEvent_story_idx` (`storyID` ASC) VISIBLE,
    INDEX `storyEvent_events_idx` (`eventID` ASC) VISIBLE,
    CONSTRAINT `storyEvent_story`
        FOREIGN KEY (`storyID`)
        REFERENCES `hurdlesdb`.`stories` (`ID`)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT `storyEvent_events`
        FOREIGN KEY (`eventID`)
        REFERENCES `hurdlesdb`.`events` (`ID`)
        ON DELETE SET NULL
        ON UPDATE CASCADE
    );

CREATE TABLE `hurdlesdb`.`org_land` (
    `ID` INT NOT NULL,
    `orgID` INT NULL,
    `landID` INT NOT NULL,
    PRIMARY KEY (`ID`),
    INDEX `orgLand_organizations_idx` (`orgID` ASC) VISIBLE,
    INDEX `orgLand_lands_idx` (`landID` ASC) VISIBLE,
    CONSTRAINT `orgLand_organizations`
        FOREIGN KEY (`orgID`)
        REFERENCES `hurdlesdb`.`organizations` (`ID`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT `orgLand_lands`
        FOREIGN KEY (`landID`)
        REFERENCES `hurdlesdb`.`lands` (`ID`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
    );

CREATE TABLE `hurdlesdb`.`org_characters` (
    `ID` INT NOT NULL,
    `orgID` INT NULL,
    `characterID` INT NULL,
    PRIMARY KEY (`ID`),
    INDEX `orgCharacters_organizations_idx` (`orgID` ASC) VISIBLE,
    INDEX `orgCharacters_characterProfile_idx` (`characterID` ASC) VISIBLE,
    CONSTRAINT `orgCharacters_organizations`
        FOREIGN KEY (`orgID`)
        REFERENCES `hurdlesdb`.`organizations` (`ID`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT `orgCharacters_characterProfile`
        FOREIGN KEY (`characterID`)
        REFERENCES `hurdlesdb`.`character_profile` (`ID`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
    );

CREATE TABLE `hurdlesdb`.`org_story` (
    `ID` INT NOT NULL,
    `orgID` INT NULL,
    `storyID` INT NULL,
    PRIMARY KEY (`ID`),
    INDEX `orgStory_organizations_idx` (`orgID` ASC) VISIBLE,
    INDEX `orgStory_stories_idx` (`storyID` ASC) VISIBLE,
    CONSTRAINT `orgStory_organizations`
        FOREIGN KEY (`orgID`)
        REFERENCES `hurdlesdb`.`organizations` (`ID`)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CONSTRAINT `orgStory_stories`
        FOREIGN KEY (`storyID`)
        REFERENCES `hurdlesdb`.`stories` (`ID`)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
    );

CREATE TABLE `hurdlesdb`.`org_events` (
    `ID` INT NOT NULL,
    `orgID` INT NULL,
    `eventID` INT NOT NULL,
    PRIMARY KEY (`ID`),
    INDEX `orgEvents_organizations_idx` (`orgID` ASC) VISIBLE,
    INDEX `orgEvents_events_idx` (`eventID` ASC) VISIBLE,
    CONSTRAINT `orgEvents_organizations`
        FOREIGN KEY (`orgID`)
        REFERENCES `hurdlesdb`.`organizations` (`ID`)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CONSTRAINT `orgEvents_events`
        FOREIGN KEY (`eventID`)
        REFERENCES `hurdlesdb`.`events` (`ID`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
    );

