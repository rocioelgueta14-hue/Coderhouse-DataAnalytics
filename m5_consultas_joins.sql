USE Ventas_Tech_DB;
GO

--Consulta 1 INNER JOIN-
SELECT 
v.id_venta,
v.fecha_venta,
c.nombre AS nombre_cliente,
p.nombre_producto,
cat.nombre_categoria,
v.precio_unitario,
v.cantidad,
c.ciudad,
(v.cantidad * v.precio_unitario) AS total_venta
FROM 
ventas v

INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria;

--hallazgo: se puede ver que la categoría con mas cantidad de ventas es la de Computación--

--Consulta 2 clientes sin ventas--

 SELECT 
 c.id_cliente,
 c.nombre AS nombre_cliente,
 c.email,
 c.fecha_registro
 FROM clientes c

 LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
 WHERE v.id_cliente IS NULL;

 --hallazgo: podemos observar que todos los clientes registrados han comprado al menos una vez-- 


 --Consulta 3 productos sin ventas--

 SELECT 
 p.id_producto,
 p.nombre_producto,
 cat.nombre_categoria,
 p.precio

 FROM productos p 

 LEFT JOIN ventas v ON v.id_producto=p.id_producto
 INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
 WHERE v.id_producto IS NULL;

 --hallazgo: podemos observar que el único producto que no se ha vendido ha sido el Soporte Notebook metálico, se podría revisar si el precio es muy alto o la gente no lo conoce--

 --Consulta 4 UNION ALL--

 SELECT 
    v.id_venta,
    v.fecha_venta,
    v.id_cliente,
    v.id_producto,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta,
    'Online' AS canal
FROM ventas v
WHERE v.fecha_venta < '2024-03-10'

UNION ALL

SELECT 
    v.id_venta,
    v.fecha_venta,
    v.id_cliente,
    v.id_producto,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta,
    'Física' AS canal
FROM ventas v
WHERE v.fecha_venta >= '2024-03-10';

--hallazgo: se observa que el canal Física es el que más ha vendido, es decir que la mayoría de las ventas se hizo en la tienda física--

 

