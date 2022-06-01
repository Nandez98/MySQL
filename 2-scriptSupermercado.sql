
-- Tener creada previamente la bbdd supermercado
use supermercado;

CREATE TABLE detalleticket (
    codticket   INTEGER NOT NULL,
    linea       INTEGER NOT NULL,
    producto    INTEGER NOT NULL,
    cantidad    INTEGER NOT NULL
);

ALTER TABLE detalleticket ADD CONSTRAINT PRIMARY KEY(codticket, linea);

CREATE TABLE producto (
    codproducto INTEGER NOT NULL PRIMARY KEY,
    descripcion VARCHAR(100),
    pvp         FLOAT,
    pproveedor  FLOAT
);

ALTER TABLE detalleticket ADD CONSTRAINT FK_detalleticket_producto_producto FOREIGN KEY (producto) REFERENCES producto(codproducto);

INSERT INTO producto VALUES (1,'Lampara multicolor', 35, 30);
INSERT INTO producto VALUES (2,'Lampara roja', 45, 30);
INSERT INTO producto VALUES (3,'Lampara verde', 35, 25);

INSERT INTO detalleticket VALUES (1,1,2,3);
INSERT INTO detalleticket VALUES (1,2,3,3);
INSERT INTO detalleticket VALUES (2,1,1,2);
INSERT INTO detalleticket VALUES (2,2,2,1);