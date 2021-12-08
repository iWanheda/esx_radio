CREATE TABLE `user_radio` (
  `id` int(11) NOT NULL,
  `name` varchar(75) NOT NULL,
  `url` varchar(255) NOT NULL,
  `owner` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `user_radio`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `user_radio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;