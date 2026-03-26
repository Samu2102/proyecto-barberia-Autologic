
-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 26-03-2026 a las 13:29:15
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
-- Base de datos: `p-barberia`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_precio_producto` (IN `pid` INT, IN `nuevo_precio` DECIMAL(10,2))   BEGIN
UPDATE productos
SET precio = nuevo_precio
WHERE id_producto = pid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_cliente` (IN `pid` INT)   BEGIN
DELETE FROM clientes WHERE id_cliente = pid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_cliente` (IN `nombre` VARCHAR(60), IN `telefono` VARCHAR(15), IN `correo` VARCHAR(100))   BEGIN
INSERT INTO clientes(nombre, telefono, correo, fecha_registro)
VALUES(nombre, telefono, correo, CURDATE());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_citas_clientes` ()   BEGIN
SELECT c.id_cita, cl.nombre, c.fecha, c.hora
FROM citas c
INNER JOIN clientes cl ON c.id_cliente = cl.id_cliente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_ventas_productos` ()   BEGIN
SELECT v.id_venta, p.nombre, dv.cantidad, dv.subtotal
FROM ventas v
INNER JOIN detalle_venta dv ON v.id_venta = dv.id_venta
INNER JOIN productos p ON dv.id_producto = p.id_producto;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `barberos`
--

CREATE TABLE `barberos` (
  `id_barbero` int(11) NOT NULL,
  `nombre` varchar(60) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `barberos`
--

INSERT INTO `barberos` (`id_barbero`, `nombre`, `telefono`, `estado`) VALUES
(1, 'Carlos ', '999111111', 'activo'),
(2, 'Luis ', '999222222', 'activo'),
(3, 'Pedro ', '999333333', 'activo'),
(4, 'Mario', '999444444', 'activo'),
(5, 'Jose ', '999555555', 'activo'),
(6, 'Raul ', '999666666', 'activo'),
(7, 'Hugo ', '999777777', 'activo');

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
  `id_horario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `citas`
--

INSERT INTO `citas` (`id_cita`, `fecha`, `hora`, `estado`, `id_cliente`, `id_barbero`, `id_horario`) VALUES
(1, '2025-02-01', '10:00:00', 'pendiente', 1, 1, 1),
(2, '2025-02-02', '11:00:00', 'pendiente', 2, 2, 2),
(3, '2025-02-03', '12:00:00', 'pendiente', 3, 3, 3),
(4, '2025-02-04', '13:00:00', 'pendiente', 4, 4, 4),
(5, '2025-02-05', '14:00:00', 'pendiente', 5, 5, 5),
(6, '2025-02-06', '15:00:00', 'pendiente', 6, 6, 6),
(7, '2025-02-07', '16:00:00', 'pendiente', 7, 7, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `nombre` varchar(60) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `nombre`, `telefono`, `correo`, `fecha_registro`) VALUES
(1, 'Juan Perez', '111111111', 'juan@mail.com', '2025-01-01'),
(2, 'Ana Lopez', '222222222', 'ana@mail.com', '2025-01-02'),
(3, 'Carlos Ruiz', '333333333', 'carlos@mail.com', '2025-01-03'),
(4, 'Maria Diaz', '444444444', 'maria@mail.com', '2025-01-04'),
(5, 'Luis Gomez', '555555555', 'luis@mail.com', '2025-01-05'),
(6, 'Pedro Torres', '666666666', 'pedro@mail.com', '2025-01-06'),
(7, 'Sofia Ramos', '777777777', 'sofia@mail.com', '2025-01-07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_servicios`
--

CREATE TABLE `detalles_servicios` (
  `id_detalle_servicio` int(11) NOT NULL,
  `id_cita` int(11) DEFAULT NULL,
  `id_servicio` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalles_servicios`
--

INSERT INTO `detalles_servicios` (`id_detalle_servicio`, `id_cita`, `id_servicio`, `cantidad`, `precio`, `subtotal`) VALUES
(1, 1, 1, 1, 40000.00, 40000.00),
(2, 2, 2, 1, 60000.00, 60000.00),
(3, 3, 3, 1, 30000.00, 30000.00),
(4, 4, 4, 1, 70000.00, 70000.00),
(5, 5, 5, 1, 100000.00, 100000.00),
(6, 6, 6, 1, 15000.00, 15000.00),
(7, 7, 7, 1, 120000.00, 120000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pagos`
--

CREATE TABLE `detalle_pagos` (
  `id_detalle_pago` int(11) NOT NULL,
  `id_venta` int(11) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `id_detalle_servicio` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `id_detalle_venta` int(11) NOT NULL,
  `id_venta` int(11) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`id_detalle_venta`, `id_venta`, `id_producto`, `cantidad`, `precio`, `subtotal`) VALUES
(1, 1, 1, 2, 10000.00, 20000.00),
(2, 2, 2, 1, 12000.00, 12000.00),
(3, 3, 3, 3, 15000.00, 45000.00),
(4, 4, 4, 1, 20000.00, 20000.00),
(5, 5, 5, 2, 5000.00, 10000.00),
(6, 6, 6, 1, 30000.00, 30000.00),
(7, 7, 7, 1, 150000.00, 150000.00);

--
-- Disparadores `detalle_venta`
--
DELIMITER $$
CREATE TRIGGER `calcular_subtotal` BEFORE INSERT ON `detalle_venta` FOR EACH ROW BEGIN
SET NEW.subtotal = NEW.cantidad * NEW.precio;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disminuir_stock` AFTER INSERT ON `detalle_venta` FOR EACH ROW BEGIN
UPDATE productos
SET stock = stock - NEW.cantidad
WHERE id_producto = NEW.id_producto;
END
$$
DELIMITER ;

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
(1, 1, 'Lunes', '09:00:00', '12:00:00'),
(2, 1, 'Lunes', '13:00:00', '18:00:00'),
(3, 2, 'Lunes', '09:00:00', '12:00:00'),
(4, 2, 'Lunes', '13:00:00', '18:00:00'),
(5, 3, 'Lunes', '10:00:00', '14:00:00'),
(6, 3, 'Lunes', '15:00:00', '19:00:00'),
(7, 1, 'Martes', '09:00:00', '12:00:00'),
(8, 1, 'Martes', '13:00:00', '18:00:00'),
(9, 4, 'Martes', '09:00:00', '13:00:00'),
(10, 4, 'Martes', '14:00:00', '18:00:00'),
(11, 5, 'Martes', '10:00:00', '14:00:00'),
(12, 5, 'Martes', '15:00:00', '19:00:00'),
(13, 2, 'Miercoles', '09:00:00', '12:00:00'),
(14, 2, 'Miercoles', '13:00:00', '18:00:00'),
(15, 3, 'Miercoles', '10:00:00', '14:00:00'),
(16, 3, 'Miercoles', '15:00:00', '19:00:00'),
(17, 6, 'Miercoles', '09:00:00', '13:00:00'),
(18, 6, 'Miercoles', '14:00:00', '18:00:00'),
(19, 1, 'Jueves', '09:00:00', '12:00:00'),
(20, 1, 'Jueves', '13:00:00', '18:00:00'),
(21, 4, 'Jueves', '09:00:00', '13:00:00'),
(22, 4, 'Jueves', '14:00:00', '18:00:00'),
(23, 7, 'Jueves', '10:00:00', '14:00:00'),
(24, 7, 'Jueves', '15:00:00', '19:00:00'),
(25, 2, 'Viernes', '09:00:00', '12:00:00'),
(26, 2, 'Viernes', '13:00:00', '18:00:00'),
(27, 5, 'Viernes', '09:00:00', '13:00:00'),
(28, 5, 'Viernes', '14:00:00', '18:00:00'),
(29, 6, 'Viernes', '10:00:00', '14:00:00'),
(30, 6, 'Viernes', '15:00:00', '19:00:00'),
(31, 1, 'Sabado', '08:00:00', '12:00:00'),
(32, 1, 'Sabado', '13:00:00', '17:00:00'),
(33, 3, 'Sabado', '08:00:00', '12:00:00'),
(34, 3, 'Sabado', '13:00:00', '17:00:00'),
(35, 7, 'Sabado', '09:00:00', '14:00:00'),
(36, 4, 'Domingo', '09:00:00', '14:00:00'),
(37, 6, 'Domingo', '09:00:00', '14:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_movimientos`
--

CREATE TABLE `inventario_movimientos` (
  `id_movimiento` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `id_proveedor` int(11) DEFAULT NULL,
  `tipo_movimiento` varchar(20) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `descripcion` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario_movimientos`
--

INSERT INTO `inventario_movimientos` (`id_movimiento`, `id_producto`, `id_proveedor`, `tipo_movimiento`, `cantidad`, `fecha`, `descripcion`) VALUES
(1, 1, 1, 'entrada', 10, '2025-01-01', 'Ingreso'),
(2, 2, 2, 'entrada', 20, '2025-01-02', 'Ingreso'),
(3, 3, 3, 'salida', 5, '2025-01-03', 'Venta'),
(4, 4, 4, 'entrada', 15, '2025-01-04', 'Ingreso'),
(5, 5, 5, 'salida', 3, '2025-01-05', 'Venta'),
(6, 6, 6, 'entrada', 8, '2025-01-06', 'Ingreso'),
(7, 7, 7, 'salida', 2, '2025-01-07', 'Venta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id_pago` int(11) NOT NULL,
  `id_detalle_pago` int(11) DEFAULT NULL,
  `metodo` varchar(30) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `total` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pagos`
--

INSERT INTO `pagos` (`id_pago`, `id_detalle_pago`, `metodo`, `fecha`, `total`) VALUES
(1, 1, 'efectivo', '2025-02-01', 40000),
(2, 2, 'tarjeta', '2025-02-02', 75000),
(3, 3, 'efectivo', '2025-02-03', 30000),
(4, 4, 'tarjeta', '2025-02-04', 56000),
(5, 5, 'efectivo', '2025-02-05', 12000),
(6, 6, 'tarjeta', '2025-02-06', 60000),
(7, 7, 'efectivo', '2025-02-07', 100000);

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
(1, 'Gel', 'Fijador para cabello', 48, 20000.00),
(2, 'Cera', 'Moldeador de cabello', 39, 25000.00),
(3, 'Shampoo', 'Limpieza capilar', 57, 30000.00),
(4, 'Aceite', 'Aceite para barba', 29, 28000.00),
(5, 'Peine', 'Accesorio de peinado', 18, 12000.00),
(6, 'Tijeras', 'Herramienta profesional', 9, 60000.00),
(7, 'Navaja', 'Navaja de afeitar', 14, 50000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id_proveedor` int(11) NOT NULL,
  `nombre` varchar(60) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id_proveedor`, `nombre`, `telefono`, `correo`) VALUES
(1, 'Distribuidora Barber Pro', '3201112233', 'contacto@barberpro.com'),
(2, 'Productos Capilares Colombia', '3202223344', 'ventas@capilares.co'),
(3, 'Importadora Style Hair', '3203334455', 'info@stylehair.com'),
(4, 'Suministros Barber Shop SAS', '3204445566', 'ventas@barbershop.com'),
(5, 'Cosmeticos Elite', '3205556677', 'contacto@elitecosmeticos.com'),
(6, 'Hair Tools Colombia', '3206667788', 'soporte@hairtools.co'),
(7, 'Beauty Supply Bogotá', '3207778899', 'ventas@beautysupply.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre`, `descripcion`) VALUES
(1, 'Administrador', NULL),
(2, 'Cliente', NULL),
(3, 'Barbero', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `id_servicio` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` varchar(120) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `duracion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `servicios`
--

INSERT INTO `servicios` (`id_servicio`, `nombre`, `descripcion`, `precio`, `duracion`) VALUES
(1, 'Corte', 'Corte normal', 15000.00, 30),
(2, 'Barba', 'Arreglo barba', 10000.00, 20),
(3, 'Cejas', 'Cejas', 2000.00, 5),
(4, 'Diseño corte', 'Corte con diseño', 2000.00, 8),
(5, 'Corte + Barba', 'Corte y barba', 25000.00, 40),
(6, 'Corte + Barba + Cejas', 'Corte, barba y cejas', 27000.00, 60),
(7, 'Corte + Barba + Cejas + Diseño', 'Corte, barba, cejas y deseño', 29000.00, 60);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `estado` varchar(20) DEFAULT NULL,
  `ultimo_ingreso` datetime DEFAULT NULL,
  `id_rol` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `usuario`, `password`, `estado`, `ultimo_ingreso`, `id_rol`) VALUES
(1, 'Administrador', '123', 'activo', '2024-02-01 00:00:00', 1),
(2, 'Cliente', '123', 'activo', '2024-02-01 00:00:00', 2),
(3, 'Barbero', '123', 'activo', '2024-02-01 00:00:00', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id_venta` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id_venta`, `fecha`, `total`, `id_cliente`) VALUES
(1, '2024-02-10', 35000.00, 1),
(2, '2024-02-10', 22000.00, 2),
(3, '2024-02-10', 47000.00, 3),
(4, '2024-02-11', 22000.00, 4),
(5, '2024-02-11', 35000.00, 5),
(6, '2024-02-11', 57000.00, 6),
(7, '2024-02-12', 179000.00, 7);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_citas_detalle`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_citas_detalle` (
`id_cita` int(11)
,`cliente` varchar(60)
,`barbero` varchar(60)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_inventario`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_inventario` (
`nombre` varchar(60)
,`tipo_movimiento` varchar(20)
,`cantidad` int(11)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_citas_detalle`
--
DROP TABLE IF EXISTS `vista_citas_detalle`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_citas_detalle`  AS SELECT `c`.`id_cita` AS `id_cita`, `cl`.`nombre` AS `cliente`, `b`.`nombre` AS `barbero` FROM ((`citas` `c` join `clientes` `cl` on(`c`.`id_cliente` = `cl`.`id_cliente`)) join `barberos` `b` on(`c`.`id_barbero` = `b`.`id_barbero`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_inventario`
--
DROP TABLE IF EXISTS `vista_inventario`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_inventario`  AS SELECT `p`.`nombre` AS `nombre`, `i`.`tipo_movimiento` AS `tipo_movimiento`, `i`.`cantidad` AS `cantidad` FROM (`inventario_movimientos` `i` join `productos` `p` on(`i`.`id_producto` = `p`.`id_producto`)) ;

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
  ADD KEY `fk_cita_horario` (`id_horario`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`),
  ADD KEY `idx_cliente_nombre` (`nombre`);

--
-- Indices de la tabla `detalles_servicios`
--
ALTER TABLE `detalles_servicios`
  ADD PRIMARY KEY (`id_detalle_servicio`),
  ADD KEY `id_cita` (`id_cita`),
  ADD KEY `id_servicio` (`id_servicio`);

--
-- Indices de la tabla `detalle_pagos`
--
ALTER TABLE `detalle_pagos`
  ADD PRIMARY KEY (`id_detalle_pago`),
  ADD KEY `id_venta` (`id_venta`),
  ADD KEY `fk_detalle_servicio_pago` (`id_detalle_servicio`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`id_detalle_venta`),
  ADD KEY `id_venta` (`id_venta`),
  ADD KEY `id_producto` (`id_producto`);

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
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id_pago`),
  ADD KEY `id_detalle_pago` (`id_detalle_pago`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `idx_producto_nombre` (`nombre`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id_proveedor`);

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
  ADD KEY `id_cliente` (`id_cliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `barberos`
--
ALTER TABLE `barberos`
  MODIFY `id_barbero` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `citas`
--
ALTER TABLE `citas`
  MODIFY `id_cita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `detalles_servicios`
--
ALTER TABLE `detalles_servicios`
  MODIFY `id_detalle_servicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `detalle_pagos`
--
ALTER TABLE `detalle_pagos`
  MODIFY `id_detalle_pago` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `id_detalle_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `horarios_barbero`
--
ALTER TABLE `horarios_barbero`
  MODIFY `id_horario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT de la tabla `inventario_movimientos`
--
ALTER TABLE `inventario_movimientos`
  MODIFY `id_movimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id_pago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id_servicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `citas`
--
ALTER TABLE `citas`
  ADD CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  ADD CONSTRAINT `fk_cita_horario` FOREIGN KEY (`id_horario`) REFERENCES `horarios_barbero` (`id_horario`);

--
-- Filtros para la tabla `detalles_servicios`
--
ALTER TABLE `detalles_servicios`
  ADD CONSTRAINT `detalles_servicios_ibfk_1` FOREIGN KEY (`id_cita`) REFERENCES `citas` (`id_cita`),
  ADD CONSTRAINT `detalles_servicios_ibfk_2` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id_servicio`);

--
-- Filtros para la tabla `detalle_pagos`
--
ALTER TABLE `detalle_pagos`
  ADD CONSTRAINT `detalle_pagos_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`),
  ADD CONSTRAINT `fk_detalle_servicio_pago` FOREIGN KEY (`id_detalle_servicio`) REFERENCES `detalles_servicios` (`id_detalle_servicio`);

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`),
  ADD CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`);

--
-- Filtros para la tabla `horarios_barbero`
--
ALTER TABLE `horarios_barbero`
  ADD CONSTRAINT `horarios_barbero_ibfk_1` FOREIGN KEY (`id_barbero`) REFERENCES `barberos` (`id_barbero`);

--
-- Filtros para la tabla `inventario_movimientos`
--
ALTER TABLE `inventario_movimientos`
  ADD CONSTRAINT `inventario_movimientos_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
  ADD CONSTRAINT `inventario_movimientos_ibfk_2` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
