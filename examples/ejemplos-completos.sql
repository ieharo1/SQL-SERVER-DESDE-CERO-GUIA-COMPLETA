-- ============================================================================
-- EJEMPLOS COMPLETOS DE SQL SERVER
-- ============================================================================
-- Colección de ejemplos prácticos para cada tema del curso
-- ============================================================================

USE master;
GO

-- ============================================================================
-- 1. CREACIÓN DE BASE DE DATOS
-- ============================================================================

-- Crear base de datos para ejemplos
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'EjemplosSQL')
BEGIN
    CREATE DATABASE EjemplosSQL;
    PRINT 'Base de datos EjemplosSQL creada.';
END
GO

USE EjemplosSQL;
GO

-- ============================================================================
-- 2. CREACIÓN DE TABLAS CON EJEMPLOS
-- ============================================================================

-- Tabla de Categorías
IF OBJECT_ID('dbo.Categorias', 'U') IS NOT NULL
    DROP TABLE dbo.Categorias;

CREATE TABLE dbo.Categorias (
    CategoriaID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(500),
    Activo BIT DEFAULT 1
);
GO

-- Tabla de Productos
IF OBJECT_ID('dbo.Productos', 'U') IS NOT NULL
    DROP TABLE dbo.Productos;

CREATE TABLE dbo.Productos (
    ProductoID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(200) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL CHECK (Precio >= 0),
    Stock INT DEFAULT 0,
    CategoriaID INT FOREIGN KEY REFERENCES Categorias(CategoriaID),
    FechaCreacion DATETIME DEFAULT GETDATE()
);
GO

-- Tabla de Clientes
IF OBJECT_ID('dbo.Clientes', 'U') IS NOT NULL
    DROP TABLE dbo.Clientes;

CREATE TABLE dbo.Clientes (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Apellido NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) UNIQUE,
    Telefono NVARCHAR(20),
    Ciudad NVARCHAR(100),
    FechaRegistro DATETIME DEFAULT GETDATE()
);
GO

-- Tabla de Pedidos
IF OBJECT_ID('dbo.Pedidos', 'U') IS NOT NULL
    DROP TABLE dbo.Pedidos;

CREATE TABLE dbo.Pedidos (
    PedidoID INT PRIMARY KEY IDENTITY(1,1),
    ClienteID INT FOREIGN KEY REFERENCES Clientes(ClienteID),
    FechaPedido DATETIME DEFAULT GETDATE(),
    Total DECIMAL(10,2),
    Estado NVARCHAR(50) DEFAULT 'Pendiente'
);
GO

-- Tabla de Detalle de Pedidos
IF OBJECT_ID('dbo.DetallePedidos', 'U') IS NOT NULL
    DROP TABLE dbo.DetallePedidos;

CREATE TABLE dbo.DetallePedidos (
    DetalleID INT PRIMARY KEY IDENTITY(1,1),
    PedidoID INT FOREIGN KEY REFERENCES Pedidos(PedidoID),
    ProductoID INT FOREIGN KEY REFERENCES Productos(ProductoID),
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    Subtotal AS (Cantidad * PrecioUnitario)
);
GO

-- ============================================================================
-- 3. INSERTAR DATOS DE EJEMPLO
-- ============================================================================

-- Insertar categorías
INSERT INTO dbo.Categorias (Nombre, Descripcion) VALUES
('Electrónica', 'Productos electrónicos y tecnología'),
('Ropa', 'Vestimenta y accesorios'),
('Hogar', 'Artículos para el hogar'),
('Deportes', 'Equipamiento deportivo');
GO

-- Insertar productos
INSERT INTO dbo.Productos (Nombre, Precio, Stock, CategoriaID) VALUES
('Smart TV 55"', 899.99, 10, 1),
('Laptop 15"', 1299.99, 5, 1),
('Smartphone', 699.99, 20, 1),
('Camiseta Básica', 29.99, 100, 2),
('Pantalón Jeans', 59.99, 50, 2),
('Juego de Sábanas', 79.99, 30, 3),
('Set de Ollas', 199.99, 15, 3),
('Balón de Fútbol', 34.99, 40, 4);
GO

-- Insertar clientes
INSERT INTO dbo.Clientes (Nombre, Apellido, Email, Telefono, Ciudad) VALUES
('Juan', 'Pérez', 'juan.perez@email.com', '555-0101', 'Quito'),
('María', 'García', 'maria.garcia@email.com', '555-0102', 'Guayaquil'),
('Carlos', 'López', 'carlos.lopez@email.com', '555-0103', 'Cuenca'),
('Ana', 'Martínez', 'ana.martinez@email.com', '555-0104', 'Quito'),
('Pedro', 'Sánchez', 'pedro.sanchez@email.com', '555-0105', 'Manta');
GO

-- Insertar pedidos
INSERT INTO dbo.Pedidos (ClienteID, Total, Estado) VALUES
(1, 929.98, 'Entregado'),
(2, 1359.98, 'Enviado'),
(3, 89.98, 'Pendiente'),
(4, 199.99, 'Procesando'),
(5, 34.99, 'Entregado');
GO

-- Insertar detalle de pedidos
INSERT INTO dbo.DetallePedidos (PedidoID, ProductoID, Cantidad, PrecioUnitario) VALUES
(1, 1, 1, 899.99),
(1, 4, 1, 29.99),
(2, 2, 1, 1299.99),
(2, 8, 1, 34.99),
(2, 4, 1, 29.99),
(3, 4, 2, 29.99),
(3, 5, 1, 59.99),
(4, 7, 1, 199.99),
(5, 8, 1, 34.99);
GO

-- ============================================================================
-- 4. CONSULTAS SELECT BÁSICAS
-- ============================================================================

-- Seleccionar todas las columnas
SELECT * FROM dbo.Categorias;

-- Seleccionar columnas específicas
SELECT Nombre, Precio, Stock FROM dbo.Productos;

-- Seleccionar con alias
SELECT 
    Nombre AS Producto,
    Precio AS 'Precio Unitario',
    Stock AS 'Existencias'
FROM dbo.Productos;

-- Seleccionar valores únicos
SELECT DISTINCT CategoriaID FROM dbo.Productos;

-- Seleccionar con TOP
SELECT TOP 5 * FROM dbo.Productos;

-- Seleccionar con COUNT
SELECT COUNT(*) AS TotalProductos FROM dbo.Productos;
GO

-- ============================================================================
-- 5. CONSULTAS CON WHERE
-- ============================================================================

-- Filtrar por condición simple
SELECT * FROM dbo.Productos WHERE Precio > 100;

-- Filtrar por múltiples condiciones
SELECT * FROM dbo.Productos 
WHERE Precio > 50 AND Stock > 20;

-- Filtrar con IN
SELECT * FROM dbo.Productos 
WHERE CategoriaID IN (1, 3);

-- Filtrar con LIKE
SELECT * FROM dbo.Clientes 
WHERE Nombre LIKE 'J%';

-- Filtrar con BETWEEN
SELECT * FROM dbo.Productos 
WHERE Precio BETWEEN 50 AND 500;

-- Filtrar con IS NULL
SELECT * FROM dbo.Clientes 
WHERE Telefono IS NULL;
GO

-- ============================================================================
-- 6. CONSULTAS CON ORDER BY
-- ============================================================================

-- Ordenar ascendente
SELECT Nombre, Precio FROM dbo.Productos 
ORDER BY Precio ASC;

-- Ordenar descendente
SELECT Nombre, Precio FROM dbo.Productos 
ORDER BY Precio DESC;

-- Ordenar por múltiples columnas
SELECT * FROM dbo.Productos 
ORDER BY CategoriaID, Precio DESC;
GO

-- ============================================================================
-- 7. FUNCIONES DE AGREGACIÓN
-- ============================================================================

-- SUM
SELECT SUM(Precio) AS TotalPrecios FROM dbo.Productos;

-- AVG
SELECT AVG(Precio) AS PrecioPromedio FROM dbo.Productos;

-- MIN y MAX
SELECT MIN(Precio) AS PrecioMinimo, MAX(Precio) AS PrecioMaximo 
FROM dbo.Productos;

-- COUNT con GROUP BY
SELECT 
    CategoriaID,
    COUNT(*) AS CantidadProductos,
    AVG(Precio) AS PrecioPromedio
FROM dbo.Productos
GROUP BY CategoriaID;

-- HAVING
SELECT 
    CategoriaID,
    COUNT(*) AS CantidadProductos
FROM dbo.Productos
GROUP BY CategoriaID
HAVING COUNT(*) > 1;
GO

-- ============================================================================
-- 8. JOIN - COMBINAR TABLAS
-- ============================================================================

-- INNER JOIN
SELECT 
    p.Nombre AS Producto,
    c.Nombre AS Categoria,
    p.Precio
FROM dbo.Productos p
INNER JOIN dbo.Categorias c ON p.CategoriaID = c.CategoriaID;

-- LEFT JOIN
SELECT 
    c.Nombre AS Cliente,
    p.PedidoID,
    p.Total
FROM dbo.Clientes c
LEFT JOIN dbo.Pedidos p ON c.ClienteID = p.ClienteID;

-- RIGHT JOIN
SELECT 
    c.Nombre AS Categoria,
    p.Nombre AS Producto
FROM dbo.Productos p
RIGHT JOIN dbo.Categorias c ON p.CategoriaID = c.CategoriaID;

-- FULL OUTER JOIN
SELECT 
    c.Nombre AS Cliente,
    p.PedidoID
FROM dbo.Clientes c
FULL OUTER JOIN dbo.Pedidos p ON c.ClienteID = p.ClienteID;

-- CROSS JOIN (producto cartesiano)
SELECT 
    c.Nombre AS Categoria,
    ci.Nombre AS Ciudad
FROM dbo.Categorias c
CROSS JOIN (SELECT DISTINCT Ciudad FROM dbo.Clientes) ci;

-- SELF JOIN
SELECT 
    e1.Nombre AS Empleado,
    e2.Nombre AS Supervisor
FROM Empleados e1
LEFT JOIN Empleados e2 ON e1.SupervisorID = e2.EmpleadoID;
GO

-- ============================================================================
-- 9. SUBCONSULTAS
-- ============================================================================

-- Subconsulta en WHERE
SELECT Nombre, Precio 
FROM dbo.Productos 
WHERE Precio > (SELECT AVG(Precio) FROM dbo.Productos);

-- Subconsulta en SELECT
SELECT 
    c.Nombre,
    (SELECT COUNT(*) FROM dbo.Pedidos p WHERE p.ClienteID = c.ClienteID) AS TotalPedidos
FROM dbo.Clientes c;

-- Subconsulta en FROM
SELECT 
    Categoria,
    AVG(Precio) AS PrecioPromedio
FROM (
    SELECT 
        cat.Nombre AS Categoria,
        p.Precio
    FROM dbo.Productos p
    INNER JOIN dbo.Categorias cat ON p.CategoriaID = cat.CategoriaID
) AS Subconsulta
GROUP BY Categoria;

-- EXISTS
SELECT Nombre 
FROM dbo.Categorias c
WHERE EXISTS (
    SELECT 1 FROM dbo.Productos p WHERE p.CategoriaID = c.CategoriaID
);
GO

-- ============================================================================
-- 10. CREACIÓN DE ÍNDICES
-- ============================================================================

-- Índice simple
CREATE INDEX IX_Productos_Nombre ON dbo.Productos(Nombre);

-- Índice compuesto
CREATE INDEX IX_Productos_Categoria_Precio 
ON dbo.Productos(CategoriaID, Precio);

-- Índice único
CREATE UNIQUE INDEX IX_Clientes_Email ON dbo.Clientes(Email);

-- Índice filtrado
CREATE INDEX IX_Productos_StockBajo 
ON dbo.Productos(Stock) 
WHERE Stock < 20;

-- Ver índices existentes
SELECT 
    t.name AS Tabla,
    i.name AS Indice,
    i.type_desc AS Tipo
FROM sys.indexes i
INNER JOIN sys.tables t ON i.object_id = t.object_id
WHERE t.name IN ('Productos', 'Clientes', 'Pedidos');
GO

-- ============================================================================
-- 11. STORED PROCEDURES
-- ============================================================================

-- Procedure simple
IF OBJECT_ID('dbo.sp_ObtenerProductos', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ObtenerProductos;
GO

CREATE PROCEDURE dbo.sp_ObtenerProductos
    @CategoriaID INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        p.ProductoID,
        p.Nombre,
        p.Precio,
        p.Stock,
        c.Nombre AS Categoria
    FROM dbo.Productos p
    LEFT JOIN dbo.Categorias c ON p.CategoriaID = c.CategoriaID
    WHERE @CategoriaID IS NULL OR p.CategoriaID = @CategoriaID
    ORDER BY p.Nombre;
END
GO

-- Ejecutar procedure
EXEC dbo.sp_ObtenerProductos;
EXEC dbo.sp_ObtenerProductos @CategoriaID = 1;
GO

-- Procedure con parámetros de salida
IF OBJECT_ID('dbo.sp_ObtenerTotalPedidos', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ObtenerTotalPedidos;
GO

CREATE PROCEDURE dbo.sp_ObtenerTotalPedidos
    @ClienteID INT,
    @TotalPedidos INT OUTPUT,
    @TotalGastado DECIMAL(10,2) OUTPUT
AS
BEGIN
    SELECT 
        @TotalPedidos = COUNT(*),
        @TotalGastado = ISNULL(SUM(Total), 0)
    FROM dbo.Pedidos
    WHERE ClienteID = @ClienteID;
END
GO

-- Ejecutar con parámetros de salida
DECLARE @Pedidos INT, @Gastado DECIMAL(10,2);
EXEC dbo.sp_ObtenerTotalPedidos 
    @ClienteID = 1, 
    @TotalPedidos = @Pedidos OUTPUT, 
    @TotalGastado = @Gastado OUTPUT;
SELECT @Pedidos AS TotalPedidos, @Gastado AS TotalGastado;
GO

-- ============================================================================
-- 12. TRIGGERS
-- ============================================================================

-- Trigger AFTER INSERT
IF OBJECT_ID('dbo.trg_Pedidos_Insert', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trg_Pedidos_Insert;
GO

CREATE TRIGGER dbo.trg_Pedidos_Insert
ON dbo.Pedidos
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Actualizar el total del pedido
    UPDATE p
    SET Total = (
        SELECT SUM(dp.Subtotal)
        FROM dbo.DetallePedidos dp
        WHERE dp.PedidoID = inserted.PedidoID
    )
    FROM dbo.Pedidos p
    INNER JOIN inserted ON p.PedidoID = inserted.PedidoID;
    
    PRINT 'Pedido creado. Total actualizado.';
END
GO

-- Trigger AFTER UPDATE
IF OBJECT_ID('dbo.trg_Productos_Update', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trg_Productos_Update;
GO

CREATE TRIGGER dbo.trg_Productos_Update
ON dbo.Productos
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Registrar cambio de precio
    IF UPDATE(Precio)
    BEGIN
        INSERT INTO dbo.HistorialPrecios (
            ProductoID, PrecioAnterior, PrecioNuevo, FechaCambio
        )
        SELECT 
            d.ProductoID,
            d.Precio,
            i.Precio,
            GETDATE()
        FROM deleted d
        INNER JOIN inserted i ON d.ProductoID = i.ProductoID;
    END
END
GO

-- ============================================================================
-- 13. VISTAS
-- ============================================================================

-- Crear vista
IF OBJECT_ID('dbo.vw_VentasPorCliente', 'V') IS NOT NULL
    DROP VIEW dbo.vw_VentasPorCliente;
GO

CREATE VIEW dbo.vw_VentasPorCliente
AS
SELECT 
    c.ClienteID,
    c.Nombre + ' ' + c.Apellido AS Cliente,
    c.Email,
    COUNT(p.PedidoID) AS TotalPedidos,
    SUM(p.Total) AS TotalGastado,
    AVG(p.Total) AS TicketPromedio
FROM dbo.Clientes c
LEFT JOIN dbo.Pedidos p ON c.ClienteID = p.ClienteID
GROUP BY c.ClienteID, c.Nombre, c.Apellido, c.Email;
GO

-- Consultar vista
SELECT * FROM dbo.vw_VentasPorCliente
ORDER BY TotalGastado DESC;
GO

-- ============================================================================
-- 14. TABLA TEMPORAL
-- ============================================================================

-- Tabla temporal local
CREATE TABLE #TempProductos (
    ProductoID INT,
    Nombre NVARCHAR(200),
    Precio DECIMAL(10,2)
);

INSERT INTO #TempProductos
SELECT ProductoID, Nombre, Precio FROM dbo.Productos WHERE Precio > 100;

SELECT * FROM #TempProductos;
-- La tabla se elimina automáticamente al cerrar la sesión
GO

-- ============================================================================
-- 15. TRANSACCIONES
-- ============================================================================

BEGIN TRANSACTION;

BEGIN TRY
    -- Insertar pedido
    INSERT INTO dbo.Pedidos (ClienteID, Total, Estado)
    VALUES (1, 0, 'Pendiente');
    
    DECLARE @NuevoPedidoID INT = SCOPE_IDENTITY();
    
    -- Insertar detalle
    INSERT INTO dbo.DetallePedidos (PedidoID, ProductoID, Cantidad, PrecioUnitario)
    VALUES (@NuevoPedidoID, 1, 2, 899.99);
    
    -- Actualizar stock
    UPDATE dbo.Productos
    SET Stock = Stock - 2
    WHERE ProductoID = 1;
    
    COMMIT TRANSACTION;
    PRINT 'Transacción completada exitosamente.';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error en la transacción: ' + ERROR_MESSAGE();
END CATCH
GO

PRINT '=== EJEMPLOS COMPLETOS DE SQL SERVER EJECUTADOS ===';
GO
