USE Ventas_Tech_DB;
GO

--Consulta 1 Resumen ejecutivo mensual

SELECT 
	MONTH(fecha_venta) AS mes,
	SUM(cantidad * precio_unitario) AS total_facturado,
	COUNT(*) AS cantidad_pedidos,
	AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas

GROUP BY MONTH(fecha_venta);

--Consulta 2 Ranking de productos--

SELECT TOP 5 
	id_producto,
	SUM(cantidad) AS productos_vendidos,
	SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC

--Consulta 3 Clientes recurrentes--

SELECT 
	id_cliente,
	COUNT(*) AS numero_de_pedidos,
	SUM(cantidad * precio_unitario) AS total_facturado 
FROM ventas

GROUP BY id_cliente
HAVING COUNT(*) > 1

--Consulta 4 Productos por encima/debajo del promedio-- 

WITH facturacion_producto AS (
	SELECT id_producto,
	SUM(cantidad * precio_unitario) AS total_facturado
	FROM ventas 
	GROUP BY id_producto)

SELECT 
id_producto, 
total_facturado,
	CASE
	WHEN total_facturado >= (SELECT AVG(total_facturado) FROM facturacion_producto) THEN 'por encima'
	ELSE 'por debajo'
	END AS comparacion
	FROM facturacion_producto;

	--COMENTARIOS--
	--El producto 1 concentra el 60% de la facturación total sin mebargo no es el producto mas vendido--
	--Ningun cliente ha realizado mas de dos compras--
	--El 66,6% de las ventas tiene una facturación menor que el ticket_promedio--