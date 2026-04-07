-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-04-2026 a las 02:27:41
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `barberia`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `agenda_barbero` (IN `p_nombre` VARCHAR(50), IN `p_apellido` VARCHAR(50))   BEGIN
SELECT *
FROM vista_agenda_barbero
WHERE nombre = p_nombre
AND apellido = p_apellido;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `factura` (IN `p_venta` INT)   BEGIN
SELECT *
FROM vista_ventas_completa
WHERE id_venta = p_venta;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `productos_bajo_stock` ()   BEGIN
SELECT * FROM vista_stock_alertas
WHERE alerta = 'STOCK BAJO';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ventas_por_fecha` (IN `fecha_inicio` DATE, IN `fecha_fin` DATE)   BEGIN
SELECT *
FROM vista_ventas_completa
WHERE fecha BETWEEN fecha_inicio AND fecha_fin;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `barberos`
--

CREATE TABLE `barberos` (
  `id_barbero` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `especialidad` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `barberos`
--

INSERT INTO `barberos` (`id_barbero`, `nombre`, `apellido`, `telefono`, `especialidad`) VALUES
(1, 'Carlos', 'Ramirez', '311111111', 'Fade'),
(2, 'Luis', 'Morales', '322222222', 'Barba'),
(3, 'Mateo', 'Perez', '333333333', 'Corte'),
(4, 'David', 'Torres', '344444444', 'Fade'),
(5, 'Juan', 'Rojas', '355555555', 'Diseño'),
(6, 'Pedro', 'Diaz', '366666666', 'Corte'),
(7, 'Andres', 'Lopez', '377777777', 'Fade'),
(8, 'Camilo', 'Gomez', '388888888', 'Barba'),
(9, 'Jorge', 'Castro', '399999999', 'Corte'),
(10, 'Daniel', 'Vargas', '311000000', 'Fade');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citas`
--

CREATE TABLE `citas` (
  `id_cita` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_barbero` int(11) DEFAULT NULL,
  `id_servicio` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `citas`
--

INSERT INTO `citas` (`id_cita`, `fecha`, `hora`, `estado`, `id_cliente`, `id_barbero`, `id_servicio`) VALUES
(1, '2026-04-01', '08:00:00', 'Pendiente', 1, 1, NULL),
(2, '2026-04-01', '09:00:00', 'Pendiente', 2, 1, NULL),
(3, '2026-04-01', '10:00:00', 'Pendiente', 3, 2, NULL),
(4, '2026-04-01', '11:00:00', 'Pendiente', 4, 3, NULL),
(5, '2026-04-01', '12:00:00', 'Pendiente', 5, 4, NULL),
(6, '2026-04-01', '13:00:00', 'Pendiente', 6, 4, NULL),
(7, '2026-04-01', '14:00:00', 'Pendiente', 7, 5, NULL),
(8, '2026-04-01', '15:00:00', 'Pendiente', 8, 6, NULL),
(9, '2026-04-01', '16:00:00', 'Pendiente', 9, 7, NULL),
(10, '2026-04-01', '17:00:00', 'Pendiente', 10, 8, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `nombre`, `apellido`, `telefono`, `correo`) VALUES
(1, 'Juan', 'Perez', '300111111', 'juan@gmail.com'),
(2, 'Carlos', 'Lopez', '300222222', 'carlos@gmail.com'),
(3, 'Luis', 'Gomez', '300333333', 'luis@gmail.com'),
(4, 'Pedro', 'Martinez', '300444444', 'pedro@gmail.com'),
(5, 'Mateo', 'Torres', '300555555', 'mateo@gmail.com'),
(6, 'David', 'Rojas', '300666666', 'david@gmail.com'),
(7, 'Andres', 'Castro', '300777777', 'andres@gmail.com'),
(8, 'Jorge', 'Diaz', '300888888', 'jorge@gmail.com'),
(9, 'Camilo', 'Vargas', '300999999', 'camilo@gmail.com'),
(10, 'Daniel', 'Mora', '301000000', 'daniel@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `id_detalle` int(11) NOT NULL,
  `id_venta` int(11) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`id_detalle`, `id_venta`, `id_producto`, `cantidad`, `precio`, `subtotal`) VALUES
(1, 1, 1, 2, 10000.00, 20000.00),
(2, 1, 2, 1, 8000.00, 8000.00),
(3, 2, 3, 1, 15000.00, 15000.00),
(4, 3, 4, 2, 5000.00, 10000.00);

--
-- Disparadores `detalle_venta`
--
DELIMITER $$
CREATE TRIGGER `descontar_stock` AFTER INSERT ON `detalle_venta` FOR EACH ROW BEGIN
UPDATE productos
SET stock = stock - NEW.cantidad
WHERE id_producto = NEW.id_producto;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_movimientos`
--

CREATE TABLE `inventario_movimientos` (
  `id_movimiento` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `tipo_movimiento` varchar(20) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario_movimientos`
--

INSERT INTO `inventario_movimientos` (`id_movimiento`, `id_producto`, `tipo_movimiento`, `cantidad`, `fecha`, `descripcion`) VALUES
(1, 2, 'ALERTA', 5, '2026-04-06', 'Stock Bajo'),
(2, 3, 'ALERTA', 2, '2026-04-06', 'Stock Bajo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `stock_min` int(11) DEFAULT 5,
  `stock_max` int(11) DEFAULT 20
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `stock_min`, `stock_max`) VALUES
(1, 'Cera', 'Cera cabello', 10000.00, 8, 5, 20),
(2, 'Gel', 'Gel cabello', 8000.00, 5, 5, 20),
(3, 'Shampoo', 'Shampoo', 15000.00, 2, 5, 20),
(4, 'Peine', 'Peine', 5000.00, 13, 5, 20),
(5, 'Navaja', 'Navaja', 3000.00, 20, 5, 20),
(6, 'Spray', 'Spray', 9000.00, 7, 5, 20),
(7, 'Talco', 'Talco', 6000.00, 8, 5, 20),
(8, 'Aceite', 'Aceite', 12000.00, 5, 5, 20),
(9, 'Crema', 'Crema', 11000.00, 4, 5, 20),
(10, 'Toalla', 'Toalla', 7000.00, 18, 5, 20);

--
-- Disparadores `productos`
--
DELIMITER $$
CREATE TRIGGER `alerta_stock` AFTER UPDATE ON `productos` FOR EACH ROW BEGIN
IF NEW.stock <= 5 THEN
INSERT INTO inventario_movimientos
(id_producto,tipo_movimiento,cantidad,fecha,descripcion)
VALUES
(NEW.id_producto,'ALERTA',NEW.stock,CURDATE(),'Stock Bajo');
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre_rol` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre_rol`) VALUES
(1, 'Administrador'),
(2, 'Barbero'),
(3, 'Cliente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `id_servicio` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `duracion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `usuario` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `id_rol` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id_venta` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_barbero` int(11) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id_venta`, `fecha`, `id_cliente`, `id_barbero`, `total`) VALUES
(1, '2026-04-01', 1, 1, 0.00),
(2, '2026-04-01', 2, 2, 0.00),
(3, '2026-04-01', 3, 3, 0.00);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_agenda_barbero`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_agenda_barbero` (
`nombre` varchar(50)
,`apellido` varchar(50)
,`fecha` date
,`hora` time
,`cliente` varchar(101)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_stock_alertas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_stock_alertas` (
`id_producto` int(11)
,`nombre` varchar(50)
,`stock` int(11)
,`alerta` varchar(12)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_ventas_completa`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_ventas_completa` (
`id_venta` int(11)
,`cliente` varchar(101)
,`fecha` date
,`productos` mediumtext
,`total_articulos` decimal(32,0)
,`total` decimal(32,2)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_agenda_barbero`
--
DROP TABLE IF EXISTS `vista_agenda_barbero`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_agenda_barbero`  AS SELECT `b`.`nombre` AS `nombre`, `b`.`apellido` AS `apellido`, `c`.`fecha` AS `fecha`, `c`.`hora` AS `hora`, concat(`cl`.`nombre`,' ',`cl`.`apellido`) AS `cliente` FROM ((`citas` `c` join `barberos` `b` on(`c`.`id_barbero` = `b`.`id_barbero`)) join `clientes` `cl` on(`c`.`id_cliente` = `cl`.`id_cliente`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_stock_alertas`
--
DROP TABLE IF EXISTS `vista_stock_alertas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_stock_alertas`  AS SELECT `productos`.`id_producto` AS `id_producto`, `productos`.`nombre` AS `nombre`, `productos`.`stock` AS `stock`, CASE WHEN `productos`.`stock` <= 5 THEN 'STOCK BAJO' WHEN `productos`.`stock` >= 20 THEN 'STOCK MAXIMO' ELSE 'STOCK NORMAL' END AS `alerta` FROM `productos` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_ventas_completa`
--
DROP TABLE IF EXISTS `vista_ventas_completa`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_ventas_completa`  AS SELECT `v`.`id_venta` AS `id_venta`, concat(`c`.`nombre`,' ',`c`.`apellido`) AS `cliente`, `v`.`fecha` AS `fecha`, group_concat(concat(`p`.`nombre`,' x',`dv`.`cantidad`) separator ',') AS `productos`, sum(`dv`.`cantidad`) AS `total_articulos`, sum(`dv`.`subtotal`) AS `total` FROM (((`ventas` `v` join `clientes` `c` on(`v`.`id_cliente` = `c`.`id_cliente`)) join `detalle_venta` `dv` on(`v`.`id_venta` = `dv`.`id_venta`)) join `productos` `p` on(`dv`.`id_producto` = `p`.`id_producto`)) GROUP BY `v`.`id_venta` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `barberos`
--
ALTER TABLE `barberos`
  ADD PRIMARY KEY (`id_barbero`);

--
-- Indices de la tabla `citas`
--
ALTER TABLE `citas`
  ADD PRIMARY KEY (`id_cita`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_barbero` (`id_barbero`),
  ADD KEY `id_servicio` (`id_servicio`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_venta` (`id_venta`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `inventario_movimientos`
--
ALTER TABLE `inventario_movimientos`
  ADD PRIMARY KEY (`id_movimiento`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id_servicio`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `id_rol` (`id_rol`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_barbero` (`id_barbero`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `barberos`
--
ALTER TABLE `barberos`
  MODIFY `id_barbero` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `citas`
--
ALTER TABLE `citas`
  MODIFY `id_cita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `inventario_movimientos`
--
ALTER TABLE `inventario_movimientos`
  MODIFY `id_movimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id_servicio` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `citas`
--
ALTER TABLE `citas`
  ADD CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  ADD CONSTRAINT `citas_ibfk_2` FOREIGN KEY (`id_barbero`) REFERENCES `barberos` (`id_barbero`),
  ADD CONSTRAINT `citas_ibfk_3` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id_servicio`);

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`),
  ADD CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`);

--
-- Filtros para la tabla `inventario_movimientos`
--
ALTER TABLE `inventario_movimientos`
  ADD CONSTRAINT `inventario_movimientos_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  ADD CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`id_barbero`) REFERENCES `barberos` (`id_barbero`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
