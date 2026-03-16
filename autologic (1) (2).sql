-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-03-2026 a las 15:33:33
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `autologic`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `citas_barbero` (IN `idbarbero` INT)   BEGIN

SELECT *
FROM citas
WHERE id_barbero = idbarbero;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `citas_por_fecha` (IN `fecha_buscar` DATE)   BEGIN

SELECT *
FROM citas
WHERE fecha = fecha_buscar;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_cliente` (IN `nom` VARCHAR(50), IN `tel` VARCHAR(15), IN `cor` VARCHAR(100))   BEGIN

INSERT INTO clientes(nombre,telefono,correo,fecha_registro)
VALUES(nom,tel,cor,CURDATE());

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_servicios` ()   BEGIN

SELECT * FROM servicios;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `productos_bajo_stock` ()   BEGIN

SELECT *
FROM productos
WHERE stock < 10;

END$$

DELIMITER ;

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
(1, '2026-03-10', '09:00:00', 'completada', 1, 2, 1),
(2, '2026-03-10', '10:00:00', 'completada', 2, 3, 2),
(3, '2026-03-10', '11:00:00', 'completada', 3, 4, 3),
(4, '2026-03-11', '09:00:00', 'programada', 4, 5, 4),
(5, '2026-03-11', '10:00:00', 'programada', 5, 2, 1),
(6, '2026-03-11', '11:00:00', 'programada', 6, 3, 2),
(7, '2026-03-12', '09:00:00', 'programada', 7, 4, 3),
(8, '2026-03-12', '10:00:00', 'programada', 8, 5, 4),
(9, '2026-03-12', '11:00:00', 'programada', 9, 2, 5),
(10, '2026-03-13', '09:00:00', 'programada', 10, 3, 6);

--
-- Disparadores `citas`
--
DELIMITER $$
CREATE TRIGGER `evitar_cita_repetida` BEFORE INSERT ON `citas` FOR EACH ROW BEGIN

IF EXISTS(
SELECT *
FROM citas
WHERE fecha = NEW.fecha
AND hora = NEW.hora
AND id_barbero = NEW.id_barbero
)

THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'El barbero ya tiene una cita en esa hora';

END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `nombre`, `telefono`, `correo`, `fecha_registro`) VALUES
(1, 'Carlos Rodriguez', '3045678921', 'carlos.rodriguez@gmail.com', '2026-01-05'),
(2, 'Luis Gomez', '3056781234', 'luis.gomez@gmail.com', '2026-01-07'),
(3, 'Mateo Sanchez', '3067812345', 'mateo.sanchez@gmail.com', '2026-01-10'),
(4, 'David Ramirez', '3078921345', 'david.ramirez@gmail.com', '2026-01-12'),
(5, 'Kevin Martinez', '3089012345', 'kevin.martinez@gmail.com', '2026-01-15'),
(6, 'Santiago Herrera', '3092345678', 'santiago@gmail.com', '2026-01-18'),
(7, 'Juan Lopez', '3103456789', 'juan.lopez@gmail.com', '2026-01-20'),
(8, 'Camilo Vargas', '3114567890', 'camilo@gmail.com', '2026-01-22'),
(9, 'Felipe Castro', '3125678901', 'felipe@gmail.com', '2026-01-25'),
(10, 'Andres Molina', '3136789012', 'andres@gmail.com', '2026-01-27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios_barbero`
--

CREATE TABLE `horarios_barbero` (
  `id_horario` int(11) NOT NULL,
  `id_barbero` int(11) DEFAULT NULL,
  `dia` varchar(15) DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `hora_fin` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `horarios_barbero`
--

INSERT INTO `horarios_barbero` (`id_horario`, `id_barbero`, `dia`, `hora_inicio`, `hora_fin`) VALUES
(1, 2, 'Lunes', '08:00:00', '17:00:00'),
(2, 3, 'Lunes', '09:00:00', '18:00:00'),
(3, 4, 'Martes', '08:00:00', '17:00:00'),
(4, 5, 'Martes', '09:00:00', '18:00:00'),
(5, 2, 'Miercoles', '08:00:00', '17:00:00'),
(6, 3, 'Jueves', '08:00:00', '17:00:00'),
(7, 4, 'Viernes', '08:00:00', '17:00:00'),
(8, 5, 'Viernes', '09:00:00', '18:00:00'),
(9, 2, 'Sabado', '08:00:00', '16:00:00'),
(10, 3, 'Sabado', '09:00:00', '16:00:00');

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
  `descripcion` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario_movimientos`
--

INSERT INTO `inventario_movimientos` (`id_movimiento`, `id_producto`, `tipo_movimiento`, `cantidad`, `fecha`, `descripcion`) VALUES
(1, 1, 'entrada', 20, '2026-02-01', 'Compra inicial gel'),
(2, 2, 'entrada', 15, '2026-02-01', 'Compra inicial cera'),
(3, 3, 'entrada', 25, '2026-02-01', 'Compra inicial shampoo'),
(4, 4, 'entrada', 10, '2026-02-01', 'Compra inicial aceite'),
(5, 5, 'entrada', 30, '2026-02-01', 'Compra inicial navajas'),
(6, 6, 'entrada', 40, '2026-02-01', 'Compra inicial peines'),
(7, 7, 'entrada', 12, '2026-02-01', 'Compra inicial tijeras'),
(8, 8, 'entrada', 18, '2026-02-01', 'Compra inicial talco'),
(9, 9, 'entrada', 14, '2026-02-01', 'Compra inicial atomizador'),
(10, 10, 'entrada', 16, '2026-02-01', 'Compra inicial crema barba');

--
-- Disparadores `inventario_movimientos`
--
DELIMITER $$
CREATE TRIGGER `actualizar_stock` AFTER INSERT ON `inventario_movimientos` FOR EACH ROW BEGIN

IF NEW.tipo_movimiento = 'entrada' THEN
UPDATE productos
SET stock = stock + NEW.cantidad
WHERE id_producto = NEW.id_producto;

ELSE

UPDATE productos
SET stock = stock - NEW.cantidad
WHERE id_producto = NEW.id_producto;

END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id_pago` int(11) NOT NULL,
  `id_cita` int(11) DEFAULT NULL,
  `metodo` varchar(30) DEFAULT NULL,
  `monto` decimal(10,2) DEFAULT NULL,
  `fecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pagos`
--

INSERT INTO `pagos` (`id_pago`, `id_cita`, `metodo`, `monto`, `fecha`) VALUES
(1, 1, 'Efectivo', 15000.00, '2026-03-10'),
(2, 2, 'Tarjeta', 20000.00, '2026-03-10'),
(3, 3, 'Nequi', 12000.00, '2026-03-10'),
(4, 4, 'Efectivo', 25000.00, '2026-03-11'),
(5, 5, 'Tarjeta', 15000.00, '2026-03-11'),
(6, 6, 'Nequi', 20000.00, '2026-03-11'),
(7, 7, 'Efectivo', 12000.00, '2026-03-12'),
(8, 8, 'Tarjeta', 25000.00, '2026-03-12'),
(9, 9, 'Nequi', 15000.00, '2026-03-12'),
(10, 10, 'Efectivo', 30000.00, '2026-03-13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(60) DEFAULT NULL,
  `descripcion` varchar(120) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `descripcion`, `stock`, `precio`) VALUES
(1, 'Gel Fijador', 'Gel para peinados', 40, 9000.00),
(2, 'Cera Capilar', 'Cera para cabello', 30, 13000.00),
(3, 'Shampoo Barber', 'Shampoo profesional', 50, 16000.00),
(4, 'Aceite Barba', 'Aceite hidratante', 20, 19000.00),
(5, 'Navajas', 'Navajas desechables', 60, 6000.00),
(6, 'Peine', 'Peine profesional', 80, 4000.00),
(7, 'Tijeras', 'Tijeras barberia', 24, 28000.00),
(8, 'Talco', 'Talco refrescante', 36, 7000.00),
(9, 'Atomizador', 'Spray de agua', 28, 8000.00),
(10, 'Crema Barba', 'Crema hidratante', 32, 15000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre`, `descripcion`) VALUES
(1, 'Administrador', 'Control total del sistema'),
(2, 'Barbero', 'Encargado de realizar los servicios'),
(3, 'Cliente', 'Usuario que agenda citas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `id_servicio` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(120) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `duracion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `servicios`
--

INSERT INTO `servicios` (`id_servicio`, `nombre`, `descripcion`, `precio`, `duracion`) VALUES
(1, 'Corte Clasico', 'Corte tradicional', 15000.00, 30),
(2, 'Fade', 'Corte degradado', 20000.00, 40),
(3, 'Barba', 'Arreglo de barba', 12000.00, 20),
(4, 'Corte + Barba', 'Servicio completo', 25000.00, 50),
(5, 'Diseño Capilar', 'Diseños en el cabello', 15000.00, 20),
(6, 'Corte Premium', 'Incluye lavado', 30000.00, 60),
(7, 'Lavado Capilar', 'Lavado profesional', 10000.00, 15),
(8, 'Barba Premium', 'Barba con aceite', 20000.00, 30),
(9, 'Corte Infantil', 'Corte para niños', 12000.00, 25),
(10, 'Corte Ejecutivo', 'Corte formal', 28000.00, 45);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  `id_rol` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `telefono`, `correo`, `password`, `estado`, `id_rol`) VALUES
(1, 'Alejandro Perdomo', '3004581290', 'alejandro.perdomo@autologic.com', '123', 'activo', 1),
(2, 'Daniel Moreno', '3014527781', 'daniel.moreno@autologic.com', '123', 'activo', 2),
(3, 'Sebastian Torres', '3017865421', 'sebastian.torres@autologic.com', '123', 'activo', 2),
(4, 'Juan Camilo Rojas', '3024569871', 'juan.rojas@autologic.com', '123', 'activo', 2),
(5, 'Andres Gutierrez', '3031456879', 'andres.gutierrez@autologic.com', '123', 'activo', 2),
(6, 'Carlos Rodriguez', '3045678921', 'carlos.rodriguez@gmail.com', '123', 'activo', 3),
(7, 'Luis Gomez', '3056781234', 'luis.gomez@gmail.com', '123', 'activo', 3),
(8, 'Mateo Sanchez', '3067812345', 'mateo.sanchez@gmail.com', '123', 'activo', 3),
(9, 'David Ramirez', '3078921345', 'david.ramirez@gmail.com', '123', 'activo', 3),
(10, 'Kevin Martinez', '3089012345', 'kevin.martinez@gmail.com', '123', 'activo', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id_venta` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `id_cita` int(11) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id_venta`, `fecha`, `total`, `id_cita`, `id_cliente`) VALUES
(11, '2026-03-10', 15000.00, 1, 1),
(12, '2026-03-10', 20000.00, 2, 2),
(13, '2026-03-10', 12000.00, 3, 3),
(14, '2026-03-11', 25000.00, 4, 4),
(15, '2026-03-11', 15000.00, 5, 5),
(16, '2026-03-11', 20000.00, 6, 6),
(17, '2026-03-12', 12000.00, 7, 7),
(18, '2026-03-12', 25000.00, 8, 8),
(19, '2026-03-12', 15000.00, 9, 9),
(20, '2026-03-13', 30000.00, 10, 10);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_citas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_citas` (
`id_cita` int(11)
,`fecha` date
,`hora` time
,`cliente` varchar(60)
,`barbero` varchar(60)
,`servicio` varchar(50)
,`precio` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_inventario`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_inventario` (
`id_producto` int(11)
,`nombre` varchar(60)
,`stock` int(11)
,`precio` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_citas`
--
DROP TABLE IF EXISTS `vista_citas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_citas`  AS SELECT `c`.`id_cita` AS `id_cita`, `c`.`fecha` AS `fecha`, `c`.`hora` AS `hora`, `cl`.`nombre` AS `cliente`, `u`.`nombre` AS `barbero`, `s`.`nombre` AS `servicio`, `s`.`precio` AS `precio` FROM (((`citas` `c` join `clientes` `cl` on(`c`.`id_cliente` = `cl`.`id_cliente`)) join `usuarios` `u` on(`c`.`id_barbero` = `u`.`id_usuario`)) join `servicios` `s` on(`c`.`id_servicio` = `s`.`id_servicio`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_inventario`
--
DROP TABLE IF EXISTS `vista_inventario`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_inventario`  AS SELECT `productos`.`id_producto` AS `id_producto`, `productos`.`nombre` AS `nombre`, `productos`.`stock` AS `stock`, `productos`.`precio` AS `precio` FROM `productos` ;

--
-- Índices para tablas volcadas
--

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
-- Indices de la tabla `horarios_barbero`
--
ALTER TABLE `horarios_barbero`
  ADD PRIMARY KEY (`id_horario`),
  ADD KEY `id_barbero` (`id_barbero`);

--
-- Indices de la tabla `inventario_movimientos`
--
ALTER TABLE `inventario_movimientos`
  ADD PRIMARY KEY (`id_movimiento`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id_pago`),
  ADD KEY `id_cita` (`id_cita`);

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
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `id_rol` (`id_rol`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `fk_venta_cita` (`id_cita`),
  ADD KEY `fk_venta_cliente` (`id_cliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

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
-- AUTO_INCREMENT de la tabla `horarios_barbero`
--
ALTER TABLE `horarios_barbero`
  MODIFY `id_horario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `inventario_movimientos`
--
ALTER TABLE `inventario_movimientos`
  MODIFY `id_movimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id_pago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id_servicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `citas`
--
ALTER TABLE `citas`
  ADD CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  ADD CONSTRAINT `citas_ibfk_2` FOREIGN KEY (`id_barbero`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `citas_ibfk_3` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id_servicio`);

--
-- Filtros para la tabla `horarios_barbero`
--
ALTER TABLE `horarios_barbero`
  ADD CONSTRAINT `horarios_barbero_ibfk_1` FOREIGN KEY (`id_barbero`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `inventario_movimientos`
--
ALTER TABLE `inventario_movimientos`
  ADD CONSTRAINT `inventario_movimientos_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`);

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`id_cita`) REFERENCES `citas` (`id_cita`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `fk_venta_cita` FOREIGN KEY (`id_cita`) REFERENCES `citas` (`id_cita`),
  ADD CONSTRAINT `fk_venta_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
