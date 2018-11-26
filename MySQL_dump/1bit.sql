-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Ноя 26 2018 г., 04:18
-- Версия сервера: 10.1.34-MariaDB
-- Версия PHP: 7.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `1bit`
--

-- --------------------------------------------------------

--
-- Структура таблицы `todos`
--

CREATE TABLE `todos` (
  `id` int(11) NOT NULL,
  `id_user` smallint(6) NOT NULL,
  `todo` varchar(255) NOT NULL,
  `todo_status` tinyint(1) NOT NULL DEFAULT '0',
  `check_status` tinyint(1) NOT NULL DEFAULT '0',
  `date` datetime NOT NULL,
  `date_deadline` datetime DEFAULT NULL,
  `date_check` datetime DEFAULT NULL,
  `date_complete` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `todos`
--

INSERT INTO `todos` (`id`, `id_user`, `todo`, `todo_status`, `check_status`, `date`, `date_deadline`, `date_check`, `date_complete`) VALUES
(1, 2, 'Подготовить отчет', 1, 1, '2018-11-21 09:00:00', '2018-11-25 18:00:00', '2018-11-22 14:30:00', '2018-11-22 14:20:00'),
(2, 2, 'Сдать фотографии', 1, 1, '2018-11-21 10:00:00', '2018-11-25 10:00:00', '2018-11-26 01:48:57', '2018-11-26 05:09:52'),
(3, 2, 'Спасти мир', 1, 1, '2018-11-23 16:46:30', '2018-12-14 12:00:00', '2018-11-26 01:50:00', '2018-11-26 05:09:55'),
(4, 30, 'Проверить задачи юзеров', 0, 1, '2018-11-26 02:39:44', '2018-11-28 09:00:00', '2018-11-26 02:40:16', NULL),
(5, 30, 'Спасти мир', 0, 0, '2018-11-26 02:41:38', '2018-11-30 09:00:00', NULL, NULL),
(6, 30, 'Тест', 0, 0, '2018-11-26 02:42:43', '2018-11-28 09:00:00', NULL, NULL),
(7, 31, 'test для роджерса', 0, 1, '2018-11-26 03:20:19', '2018-11-28 14:00:00', '2018-11-26 03:20:30', NULL),
(8, 2, 'Тест Задача', 1, 1, '2018-11-26 05:12:55', '2018-11-15 23:43:00', '2018-11-26 05:18:58', '2018-11-26 05:18:24');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` smallint(6) NOT NULL,
  `login` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `password`, `status`) VALUES
(1, 'Jameson', '123456', 'admin'),
(2, 'Piter', 'maryjane', 'user'),
(30, 'superman', 'lois', 'admin'),
(31, 'America', 'carter', 'user'),
(32, 'ironman', 'piter', 'user');

-- --------------------------------------------------------

--
-- Структура таблицы `users_date`
--

CREATE TABLE `users_date` (
  `id` smallint(6) NOT NULL,
  `id_user` smallint(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `positions` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users_date`
--

INSERT INTO `users_date` (`id`, `id_user`, `name`, `positions`) VALUES
(1, 1, 'Джона Джеймсон', 'Босс'),
(2, 2, 'Питер Паркер', 'Фотограф'),
(10, 30, 'Кларк Кент', 'репортер'),
(11, 31, 'Стив Роджерс', 'Мужик со щитом'),
(12, 32, 'Тони Старк', 'Инженер');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `todos`
--
ALTER TABLE `todos`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users_date`
--
ALTER TABLE `users_date`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `todos`
--
ALTER TABLE `todos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT для таблицы `users_date`
--
ALTER TABLE `users_date`
  MODIFY `id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
