CREATE TABLE compras_temp (
    Fecha NVARCHAR(255),
    CodProveedor NVARCHAR(255),
    NombreProveedor NVARCHAR(255),
    DireccionProveedor NVARCHAR(255),
    NumeroProveedor NVARCHAR(255),
    WebProveedor NVARCHAR(255),
    CodProducto NVARCHAR(255),
    NombreProducto NVARCHAR(255),
    MarcaProducto NVARCHAR(255),
    Categoria NVARCHAR(255),
    SodSuSursal NVARCHAR(255),
    NombreSucursal NVARCHAR(255),
    DireccionSucursal NVARCHAR(255),
    Region NVARCHAR(255),
    Departamento NVARCHAR(255),
    Unidades NVARCHAR(255),
    CostoU NVARCHAR(255)
);


CREATE TABLE ventas_temp (
    Fecha NVARCHAR(255),
    CodigoCliente NVARCHAR(255),
    NombreCliente NVARCHAR(255),
    TipoCliente NVARCHAR(255),
    DireccionCliente NVARCHAR(255),
    NumeroCliente NVARCHAR(255),
    CodVendedor NVARCHAR(255),
    NombreVendedor NVARCHAR(255),
    Vacacionista NVARCHAR(255),
    CodProducto NVARCHAR(255),
    NombreProducto NVARCHAR(255),
    MarcaProducto NVARCHAR(255),
    Categoria NVARCHAR(255),
    SodSuSursal NVARCHAR(255),
    NombreSucursal NVARCHAR(255),
    DireccionSucursal NVARCHAR(255),
    Region NVARCHAR(255),
    Departamento NVARCHAR(255),
    Unidades NVARCHAR(255),
    PrecioUnitario NVARCHAR(255)
);
