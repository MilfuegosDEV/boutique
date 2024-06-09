-- Crear la base de datos MomentosBoutiqueBD si no existe
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'MomentosBoutiqueBD')
BEGIN
    CREATE DATABASE MomentosBoutiqueBD;
END
GO

-- Usar la base de datos MomentosBoutiqueBD
USE MomentosBoutiqueBD;
GO

-- Desconectar todas las conexiones a la base de datos MomentosBoutiqueBD
USE master;
GO
ALTER DATABASE MomentosBoutiqueBD SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

-- Eliminar la base de datos MomentosBoutiqueBD
DROP DATABASE IF EXISTS MomentosBoutiqueBD;

-- Tabla para roles
CREATE TABLE Roles (
    ID_Rol INT PRIMARY KEY,
    Nombre VARCHAR(50)
);

-- Insertar datos en la tabla Roles
INSERT INTO Roles (ID_Rol, Nombre) VALUES 
(1, 'Administrador'),
(2, 'Usuario Normal');

-- Tabla para usuarios
CREATE TABLE Usuarios (
    ID_Usuario INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Usuario VARCHAR(20),
    Contraseña VARCHAR(50),
    ID_Rol INT,
    FOREIGN KEY (ID_Rol) REFERENCES Roles(ID_Rol)
);
-- Tabla para registro de actividad
CREATE TABLE RegistroActividad (
    ID_Registro INT PRIMARY KEY,
    FechaHora DATETIME,
    ID_Usuario INT,
    ActividadRealizada VARCHAR(200),
    FOREIGN KEY (ID_Usuario) REFERENCES Usuarios(ID_Usuario)
);

-- Tabla para empleados
CREATE TABLE Empleados (
    ID_Empleado INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Email VARCHAR(100),
    Direccion VARCHAR(200),
    Ciudad VARCHAR(100),
    Telefono VARCHAR(20),
    FechaContratacion DATE,
    ID_Rol INT,
    FOREIGN KEY (ID_Rol) REFERENCES Roles(ID_Rol)
);


-- Insertar datos en la tabla Usuarios
INSERT INTO Usuarios (ID_Usuario, Nombre, Usuario, Contraseña, ID_Rol) VALUES
(1, 'Administrador1', 'admin1', 'contraseña123', 1),
(2, 'Usuario1', 'usuario1', 'contraseña456', 2);

-- Tabla para categorías de ropa
CREATE TABLE CategoriasRopa (
    ID_Categoria INT PRIMARY KEY,
    Nombre VARCHAR(50)
);

-- Tabla para tipos de ropa
CREATE TABLE TiposRopa (
    ID_Tipo INT PRIMARY KEY,
    Nombre VARCHAR(50)
);
-- Tabla para tallas de ropa
CREATE TABLE Tallas (
    ID_Talla INT PRIMARY KEY,
    Nombre VARCHAR(10)
);

-- Tabla para colores de ropa
CREATE TABLE Colores (
    ID_Color INT PRIMARY KEY,
    Nombre VARCHAR(20)
);


-- Tabla para productos de ropa
CREATE TABLE ProductosRopa (
    ID_Producto INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Descripcion TEXT,
    Precio DECIMAL(10,2),
    Stock INT,
    ID_Categoria INT,
    ID_Tipo INT,
    ID_Talla INT,
    ID_Color INT,
    FOREIGN KEY (ID_Categoria) REFERENCES CategoriasRopa(ID_Categoria),
    FOREIGN KEY (ID_Tipo) REFERENCES TiposRopa(ID_Tipo),
    FOREIGN KEY (ID_Talla) REFERENCES Tallas(ID_Talla),
    FOREIGN KEY (ID_Color) REFERENCES Colores(ID_Color)
);

-- Tabla para movimientos de inventario (entradas y salidas)
CREATE TABLE MovimientosInventario (
    ID_Movimiento INT PRIMARY KEY,
    FechaMovimiento DATE,
    TipoMovimiento VARCHAR(20), -- Entrada o salida
    ID_Producto INT,
    Cantidad INT,
    FOREIGN KEY (ID_Producto) REFERENCES ProductosRopa(ID_Producto)
);

-- Tabla para ajustes de stock
CREATE TABLE AjustesStock (
    ID_Ajuste INT PRIMARY KEY,
    FechaAjuste DATE,
    ID_Producto INT,
    CantidadAnterior INT,
    CantidadNueva INT,
    Motivo VARCHAR(100),
    FOREIGN KEY (ID_Producto) REFERENCES ProductosRopa(ID_Producto)
);


-- Tabla para el carrito de compras
CREATE TABLE CarritoCompras (
    ID_Carrito INT PRIMARY KEY,
    ID_Usuario INT,
    ID_Producto INT,
    Cantidad INT,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuarios(ID_Usuario),
    FOREIGN KEY (ID_Producto) REFERENCES ProductosRopa(ID_Producto)
);


-- Tabla para facturación
CREATE TABLE Facturacion (
    ID_Factura INT PRIMARY KEY,
    Fecha DATE,
    ID_Producto INT,
    Cantidad INT,
    Total DECIMAL(10,2),
    ID_Usuario INT,
    FOREIGN KEY (ID_Producto) REFERENCES ProductosRopa(ID_Producto),
    FOREIGN KEY (ID_Usuario) REFERENCES Usuarios(ID_Usuario)
);

-- Tabla para sugerencias
CREATE TABLE Sugerencias (
    ID_Sugerencia INT PRIMARY KEY,
    Mensaje TEXT,
    Fecha DATE,
    ID_Usuario INT,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuarios(ID_Usuario)
);

-- Tabla para consultas
CREATE TABLE Consultas (
    ID_Consulta INT PRIMARY KEY,
    Mensaje TEXT,
    Fecha DATE,
    ID_Usuario INT,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuarios(ID_Usuario)
);
-- Tabla para clientes
CREATE TABLE Clientes (
    ID_Cliente INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Email VARCHAR(100),
    Direccion VARCHAR(200),
    Ciudad VARCHAR(100),
    Telefono VARCHAR(20),
    FechaRegistro DATE
);

-- Tabla para historial de compras de clientes
CREATE TABLE HistorialCompras (
    ID_HistorialCompra INT PRIMARY KEY,
    ID_Cliente INT,
    ID_Factura INT,
    FechaCompra DATE,
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente),
    FOREIGN KEY (ID_Factura) REFERENCES Facturacion(ID_Factura)
);
