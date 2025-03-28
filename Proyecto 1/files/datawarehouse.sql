-- Create the Proveedor table
CREATE TABLE Proveedor (
    id_proveedor INT PRIMARY KEY IDENTITY(1,1),
    codigo VARCHAR(20) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    numero VARCHAR(20) NULL,
    web CHAR(1) NULL
);

-- Create the Cliente table
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY IDENTITY(1,1),
    codigo VARCHAR(20) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    numero VARCHAR(20) NULL
);

-- Create the Producto table
CREATE TABLE Producto (
    id_producto INT PRIMARY KEY IDENTITY(1,1),
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    categoria VARCHAR(50) NOT NULL
);

-- Create the Sucursal table

CREATE TABLE Sucursal (
    id_sucursal INT PRIMARY KEY IDENTITY(1,1),
    codigo VARCHAR(20) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    region VARCHAR(50) NOT NULL,
    departamento VARCHAR(50) NOT NULL
);

-- Create the Vendedor table
CREATE TABLE Vendedor (
    id_vendedor INT PRIMARY KEY IDENTITY(1,1),
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    vacacionista BIT NOT NULL
);

-- Create the Compra table
CREATE TABLE Compra (
    id INT PRIMARY KEY IDENTITY(1,1),
    id_proveedor INT FOREIGN KEY REFERENCES Proveedor(id_proveedor),
    id_producto INT FOREIGN KEY REFERENCES Producto(id_producto),
    id_sucursal INT FOREIGN KEY REFERENCES Sucursal(id_sucursal),
    fecha DATE NOT NULL,
    unidades INT NOT NULL,
    costo_unitario DECIMAL(10, 2) NOT NULL
);

-- Create the Venta table
CREATE TABLE Venta (
    id INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT FOREIGN KEY REFERENCES Cliente(id_cliente),
    id_vendedor INT FOREIGN KEY REFERENCES Vendedor(id_vendedor),
    id_producto INT FOREIGN KEY REFERENCES Producto(id_producto),
    id_sucursal INT FOREIGN KEY REFERENCES Sucursal(id_sucursal),
    fecha DATE NOT NULL,
    unidades INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL
);
