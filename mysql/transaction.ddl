DROP TABLE IF EXISTS users;

CREATE TABLE
    IF NOT EXISTS users (
        `id` CHAR(36) COLLATE utf8mb4_unicode_ci NOT NULL,
        `name` VARCHAR(20) NOT NULL,
        `created_at` DATETIME DEFAULT NULL,
        `updated_at` DATETIME DEFAULT NULL,
        PRIMARY KEY (`id`)
    ) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS task_priorities;

CREATE TABLE
    IF NOT EXISTS task_priorities (
        `id` CHAR(36) COLLATE utf8mb4_unicode_ci NOT NULL,
        `value` INT UNSIGNED NOT NULL,
        `created_at` DATETIME DEFAULT NULL,
        `updated_at` DATETIME DEFAULT NULL,
        PRIMARY KEY (`id`)
    ) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS tasks;

CREATE TABLE
    IF NOT EXISTS tasks (
        `id` CHAR(36) COLLATE utf8mb4_unicode_ci NOT NULL,
        `title` VARCHAR(20) NOT NULL,
        `text` VARCHAR(20) NOT NULL,
        `user_id` CHAR(36) COLLATE utf8mb4_unicode_ci NOT NULL,
        `priority_id` CHAR(36) COLLATE utf8mb4_unicode_ci NOT NULL,
        `created_at` DATETIME DEFAULT NULL,
        `updated_at` DATETIME DEFAULT NULL,
        PRIMARY KEY (`id`),
        FOREIGN KEY (`user_id`) REFERENCES users(`id`),
        FOREIGN KEY (`priority_id`) REFERENCES task_priorities(`id`)
    ) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS task_has_priorities;

CREATE TABLE
    IF NOT EXISTS task_has_priorities (
        `id` INT AUTO_INCREMENT NOT NULL,
        `task_id` CHAR(36) COLLATE utf8mb4_unicode_ci NOT NULL,
        `priority_id` CHAR(36) COLLATE utf8mb4_unicode_ci NOT NULL,
        `created_at` DATETIME DEFAULT NULL,
        `updated_at` DATETIME DEFAULT NULL,
        PRIMARY KEY (`id`),
        FOREIGN KEY (`task_id`) REFERENCES tasks(`id`),
        FOREIGN KEY (`priority_id`) REFERENCES task_priorities(`id`)
    ) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;