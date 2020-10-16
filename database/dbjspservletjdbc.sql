CREATE DATABASE `dbjspservletjdbc`;
USE `dbjspservletjdbc`;

CREATE TABLE `roles` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(255) NOT NULL,
	`code` VARCHAR(255) NOT NULL,
	`createddate` TIMESTAMP NULL,
	`modifieddate` TIMESTAMP NULL,
	`createdby` VARCHAR(255) NULL,
	`modifiedby` VARCHAR(255) NULL,
    CONSTRAINT `pk_id` PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `roles` (`name`, `code`) 
VALUES ('admin','ROLE_ADMIN'),
		('user','ROLE_USER');

CREATE TABLE `users` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`username` VARCHAR(150) NOT NULL,
	`password` VARCHAR(150) NOT NULL,
	`fullname` VARCHAR(150) NULL,
	`status` INT NOT NULL,
	`roleid` BIGINT NOT NULL,
	`createddate` TIMESTAMP NULL,
	`modifieddate` TIMESTAMP NULL,
	`createdby` VARCHAR(255) NULL,
	`modifiedby` VARCHAR(255) NULL,
    CONSTRAINT `pk_id` PRIMARY KEY (`id`),
    CONSTRAINT `fk_users_roles` FOREIGN KEY (`roleid`) 
    REFERENCES `roles`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `users` (`username`, `password`, `fullname`, `status`, `roleid`) 
VALUES ('admin', '123123', 'Nguyễn Hữu Nghĩa', 1, 1), 
		('nhnghia', '123123', 'Nghĩa Nguyễn', 1, 2);

CREATE TABLE `categories` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(255) NOT NULL,
	`code` VARCHAR(255) NOT NULL,
	`createddate` TIMESTAMP NULL,
	`modifieddate` TIMESTAMP NULL,
	`createdby` VARCHAR(255) NULL,
	`modifiedby` VARCHAR(255) NULL,
    CONSTRAINT `pk_id` PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `categories` (`name`, `code`) 
VALUES ('Thể thao','the-thao'),
		('Sức khỏe','suc-khoe'),
		('Giáo dục','giao-duc'),
        ('Nhịp sống','nhip-song'),
		('Thế giới','the-gioi');

CREATE TABLE `news` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`title` VARCHAR(255) NULL,
	`thumbnail` VARCHAR(255) NULL,
	`shortdescription` TEXT NULL,
	`content` TEXT NULL,
	`categoryid` BIGINT NOT NULL,
	`createddate` TIMESTAMP NULL,
	`modifieddate` TIMESTAMP NULL,
	`createdby` VARCHAR(255) NULL,
	`modifiedby` VARCHAR(255) NULL,
    CONSTRAINT `pk_id` PRIMARY KEY (`id`),
    CONSTRAINT `fk_news_categories` FOREIGN KEY (`categoryid`) 
    REFERENCES `categories`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `comments` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`content` TEXT NOT NULL,
	`userid` BIGINT NOT NULL,
	`newsid` BIGINT NOT NULL,
	`createddate` TIMESTAMP NULL,
	`modifieddate` TIMESTAMP NULL,
	`createdby` VARCHAR(255) NULL,
	`modifiedby` VARCHAR(255) NULL,
    CONSTRAINT `pk_id` PRIMARY KEY (`id`),
    CONSTRAINT `fk_comments_users` FOREIGN KEY (`userid`) 
    REFERENCES `users`(`id`),
    CONSTRAINT `fk_comments_news` FOREIGN KEY (`newsid`) 
    REFERENCES `news`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


