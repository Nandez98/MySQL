select * from detalleticket;
select * from producto;
-- 1. En la BB.DD. supermercado necesito crear una vista llamada 
-- “margentrasaduanas”  que  muestre  el  margen  que  tiene  el 
-- supermercado en cada producto después de pagar también la 
-- comisión  que  aduanas  le  fija  por  cada  producto  importado,  dicha 
-- comisión  es  equivalente  al  5%  del  precio  fijado  por  el  proveedor. 
-- Dicho margen se calcula mediante la siguiente expresión
create view margentrasaduanas as SELECT  descripcion,  pvp-pproveedor-pproveedor*0.05 
FROM producto;

select * from margentrasaduanas;
-- 2. En la misma base de datos crear una vista llamada 
-- “productosyarticulosporcompra” que muestre el número de productos 
-- y el total de artículos adquiridos en cada compra
create view productosyarticulosporcompra as select codticket, sum(cantidad) as total_productos
from detalleticket
group by codticket;

select * from productosyarticulosporcompra;
-- 3. Sobre la misma base de datos crear una vista llamada 
-- “costeporproducto”  que  muestre  el  coste  ocasionado  por  cada 
-- producto en cada ticket. 
create view costeporproducto as select d.codticket, (p.pvp * d.cantidad) as coste, p.descripcion
from detalleticket d, producto p
where d.producto = p.codproducto;

select * from costeporproducto;
-- 4.Sobre la misma base de datos crear una vista llamada “costeporticket” 
-- que muestre el coste de cada ticket,
-- es decir, cuanto paga el cliente por cada ticket
alter view costeporticket as select d.codticket, sum(d.cantidad * p.pvp) as precio
from detalleticket d, producto p
where d.producto = p.codproducto
group by codticket;

select * from costeporticket;
-- 5. Sobre la misma base de datos crear una vista llamada “cobro” 
-- que muestre cuanto cobra en total el supermercado.
create view cobro as select sum(d.cantidad * p.pvp) as precio
from detalleticket d, producto p
where d.producto = p.codproducto;

select * from cobro;
-- 6.	Sobre la misma base de datos crear una vista llamada “gananciaporproducto” 
-- que muestre cuanto gana en el supermercado por cada producto en cada ticket,
-- sin tener en cuenta lo de aduanas.
-- Ganancia es (pvp - pproveedor) * cantidad
create view gananciaporproducto as select p.descripcion, ((p.pvp - p.pproveedor) * d.cantidad) as ganancia
from detalleticket d, producto p
where d.producto = p.codproducto
group by p.descripcion;

select * from gananciaporproducto;
-- 7.	Sobre la misma base de datos crear una vista llamada “gananciaporticket” 
-- que muestre cuanto gana en el supermercado por cada ticket,
-- teniendo en cuenta lo de aduanas.
-- La cuenta es sum((p.pvp - p.pproveedor*1.05) * dt.cantidad)
create view gananciaporticket as select d.codticket, ((p.pvp - p.pproveedor*1.05) * d.cantidad) as ganancia
from detalleticket d, producto p
where d.producto = p.codproducto
order by d.codticket;

select * from gananciaporticket;

-- 8.	Sobre la misma base de datos crear una vista llamada “gananciatotal” 
-- que muestre cuanto gana en el supermercado en total,
-- teniendo en cuenta lo de aduanas.

create view gananciatotal as select sum((p.pvp - p.pproveedor*1.05) * d.cantidad) as ganancia
from detalleticket d, producto p
where d.producto = p.codproducto;

select * from gananciatotal;