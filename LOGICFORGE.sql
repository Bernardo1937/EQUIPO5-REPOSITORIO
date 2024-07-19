CREATE TABLE CATEGORIAS(
	idCategoria SERIAL,
	Nombre VARCHAR (40) NOT NULL,
	Descripcion VARCHAR (40) NOT NULL,
	PRIMARY KEY (idCategoria)
);

SELECT *FROM CATEGORIAS;

BEGIN;
INSERT INTO CATEGORIAS (Nombre,Descripcion)
VALUES ('Deportes','Calzado Deportivo')
COMMIT;

BEGIN;
INSERT INTO CATEGORIAS (Nombre,Descripcion)
VALUES ('Trabajo','Calzado Industrial')
COMMIT;

BEGIN;
INSERT INTO CATEGORIAS (Nombre,Descripcion)
VALUES ('Formal','Calzado Formal')
COMMIT;

BEGIN;
INSERT INTO CATEGORIAS (Nombre,Descripcion)
VALUES ('Casual','Calzado Casual')
COMMIT;

SELECT *FROM CATEGORIAS;

CREATE TABLE ROLES(
	idRol SERIAL,
	NombreRol VARCHAR (40) NOT NULL,
	PRIMARY KEY (idRol)
);

BEGIN;
INSERT INTO ROLES (NombreRol)
VALUES ('Administracion')
COMMIT;

BEGIN;
INSERT INTO ROLES (NombreRol)
VALUES ('Spervisor')
COMMIT;

BEGIN;
INSERT INTO ROLES (NombreRol)
VALUES ('Empleado')
COMMIT;

SELECT *FROM ROLES;

ROLLBACK;

BEGIN;
INSERT INTO ROLES (NombreRol)
VALUES ('Asistente')
COMMIT;

CREATE TABLE USUARIOS(
	idUsuario SERIAL,
	Nombre VARCHAR (40) NOT NULL,
	Correo VARCHAR (40) UNIQUE NOT NULL,
	contraseña VARCHAR NOT NULL,
	idRol INTEGER NOT NULL,
	PRIMARY KEY (idUsuario),
	FOREIGN KEY (idRol) REFERENCES ROLES (idRol)
);

DROP TABLE USUARIOS;

SELECT *FROM USUARIOS;

ROLLBACK;

BEGIN;
INSERT INTO USUARIOS (Nombre, Correo, contraseña,idRol)
VALUES ('Maria', 'maria@ejemplo', 'moty035', 2)
COMMIT;

BEGIN;
INSERT INTO USUARIOS (Nombre, Correo, contraseña,idRol)
VALUES ('Jhonatan', 'Tano@ejemplo', 'eliastano005', 1)
COMMIT;

BEGIN;
INSERT INTO USUARIOS (Nombre, Correo, contraseña,idRol)
VALUES ('Bernardo', 'amber@ejemplo', 'Amber1234', 4)
COMMIT;

BEGIN;
INSERT INTO USUARIOS (Nombre, Correo, contraseña,idRol)
VALUES ('Jimmy', 'jimmy@ejemplo', 'jimmy1234', 3)
COMMIT;

CREATE TABLE EMPLEADOS(
	idEmpleado SERIAL,
	Nombre VARCHAR (40) NOT NULL,
	ApellidoPaterno VARCHAR (40) NOT NULL,
	ApellidoMaterno VARCHAR (40) NOT NULL,
	Telefono BIGINT NOT NULL, 
	Correo VARCHAR (40) UNIQUE NOT NULL,
	Direccion VARCHAR (40) NOT NULL,
	idUsuario INTEGER NOT NULL,
	PRIMARY KEY (idEmpleado),
	FOREIGN KEY (idUsuario) REFERENCES USUARIOS (idUsuario)
);

BEGIN;
INSERT INTO EMPLEADOS (Nombre, ApellidoPaterno, ApellidoMaterno, Telefono, Correo, Direccion, idUsuario)
VALUES ('Maria Isabel', 'Carrera', 'Arano', '2711085270', 'moty@ejemplo', 'Av 10 Calle# 24', 1)
COMMIT;

BEGIN;
INSERT INTO EMPLEADOS (Nombre, ApellidoPaterno, ApellidoMaterno, Telefono, Correo, Direccion, idUsuario)
VALUES ('Jhonatan David', 'Victoria', 'López', '2713168382', 'Tano@ejemplo', 'Av 10 Calle# 23', 2)
COMMIT;

BEGIN;
INSERT INTO EMPLEADOS (Nombre, ApellidoPaterno, ApellidoMaterno, Telefono, Correo, Direccion, idUsuario)
VALUES ('Juan Bernardo', 'Gomez', 'Galban', '2711087623', 'amber@ejemplo', 'Av 1 Calle# 3', 3)
COMMIT;

BEGIN;
INSERT INTO EMPLEADOS (Nombre, ApellidoPaterno, ApellidoMaterno, Telefono, Correo, Direccion, idUsuario)
VALUES ('Jimmy', 'Cardenas', 'Ramos', '2711081234', 'jimmy@ejemplo', 'Av 9 Calle# 6', 3)
COMMIT;

SELECT *FROM EMPLEADOS;

DROP TABLE VENTAS;

CREATE TABLE VENTAS(
	idVenta SERIAL,
	FechaVenta TIMESTAMP WITH TIME ZONE default NOW(),
	TotalVenta DECIMAL (15,2) NOT NULL,
	idEmpleado INTEGER NOT NULL,
	PRIMARY KEY (idVenta),
	FOREIGN KEY (idEmpleado) REFERENCES EMPLEADOS (idEmpleado)
);

BEGIN;
INSERT INTO VENTAS (FechaVenta, TotalVenta, idEmpleado)
VALUES (NOW(), 500.00, 1)
COMMIT;

BEGIN;
INSERT INTO VENTAS (FechaVenta, TotalVenta, idEmpleado)
VALUES (NOW(), 750.00, 4)
COMMIT;

BEGIN;
INSERT INTO VENTAS (FechaVenta, TotalVenta, idEmpleado)
VALUES (NOW(), 250.00, 4)
COMMIT;


ROLLBACK;

SELECT *FROM VENTAS;

CREATE TABLE PRODUCTOS(
	idProducto SERIAL,
	Nombre VARCHAR (40)NOT NULL,
	modelo VARCHAR (40) NOT NULL,
	Descripcion VARCHAR (40) NOT NULL,
	Talla DECIMAL (3,2) NOT NULL,
	Stock INTEGER NOT NULL,
	PrecioUnitario DECIMAL (15,2) NOT NULL,
	idCategoria INTEGER NOT NULL,
	PRIMARY KEY (idProducto),
	FOREIGN KEY (idCategoria) REFERENCES CATEGORIAS (idCategoria)
);

BEGIN;
INSERT INTO PRODUCTOS (Nombre, modelo, Descripcion, Talla, Stock, PrecioUnitario, idCategoria)
VALUES ('Waslie', 'Skin/Tech', 'Zapato deportivo', 7.50, 10, 219.00, 1)
COMMIT;
ROLLBACK;

BEGIN;
INSERT INTO PRODUCTOS (Nombre, modelo, Descripcion, Talla, Stock, PrecioUnitario, idCategoria)
VALUES ('La ppaagg', '607', 'Negro', 6.50, 12, 619.00, 3)
COMMIT;

BEGIN;
INSERT INTO PRODUCTOS (Nombre, modelo, Descripcion, Talla, Stock, PrecioUnitario, idCategoria)
VALUES ('Estilo personalizado', 'Top Sport', 'Ultra ligero', 8.00, 15, 388.00, 4)
COMMIT;

SELECT *FROM PRODUCTOS;

CREATE TABLE INVENTARIO(
	idInventario SERIAL,
	Cantidad INTEGER NOT NULL,
	FechaActualizacion TIMESTAMP NOT NULL,
	idProducto INTEGER NOT NULL,
	PRIMARY KEY (idInventario),
	FOREIGN KEY (idProducto) REFERENCES PRODUCTOS (idProducto)
);

BEGIN;
INSERT INTO INVENTARIO (Cantidad, FechaActualizacion,idProducto)
VALUES (10, NOW(), 1)
COMMIT;

BEGIN;
INSERT INTO INVENTARIO (Cantidad, FechaActualizacion,idProducto)
VALUES (12, NOW(), 2)
COMMIT;

BEGIN;
INSERT INTO INVENTARIO (Cantidad, FechaActualizacion,idProducto)
VALUES (15, NOW(), 3)
COMMIT;

CREATE TABLE DETALLE_VENTA(
	idDetalleVenta SERIAL,
	cantidad INTEGER NOT NULL,
	idVenta INTEGER NOT NULL,
	idProducto INTEGER NOT NULL,
	PRIMARY KEY (idDetalleVenta),
	FOREIGN KEY (idVenta) REFERENCES  VENTAS (idVenta),
	FOREIGN KEY (idProducto) REFERENCES PRODUCTOS (idProducto)
);

BEGIN;
INSERT INTO DETALLE_VENTA (cantidad, idVenta, idProducto)
VALUES (1, 1, 1)
COMMIT;
ROLLBACK;

BEGIN;
INSERT INTO DETALLE_VENTA (cantidad, idVenta, idProducto)
VALUES (2, 2, 2)
COMMIT;

BEGIN;
INSERT INTO DETALLE_VENTA (cantidad, idVenta, idProducto)
VALUES (1, 3, 3)
COMMIT;

CREATE OR REPLACE VIEW ventas_jimmy AS
SELECT p.Nombre, v.FechaVenta
FROM PRODUCTOS p JOIN DETALLE_VENTA dv
ON p.idProducto = dv.idProducto
JOIN VENTAS v 
ON dv.idVenta = v.idVenta
JOIN EMPLEADOS e
ON v.idEmpleado = e.idEmpleado 
WHERE e.Nombre = 'Jimmy'

SELECT *FROM ventas_jimmy;

CREATE OR REPLACE VIEW descripcion_talla_venta_jimmy AS
SELECT p.Descripcion, p.Talla 
FROM PRODUCTOS p JOIN DETALLE_VENTA dv
ON p.idProducto = dv.idProducto 
JOIN VENTAS v
ON dv.idVenta = v.idVenta
JOIN EMPLEADOS e
ON v.idEmpleado = e.idEmpleado
WHERE e.Nombre ='Jimmy'

SELECT *FROM descripcion_talla_venta_jimmy;

CREATE OR REPLACE VIEW empleados_usuarios AS
SELECT e.idEmpleado, e.Nombre, e.ApellidoPaterno, e.ApellidoMaterno, e.Telefono, e.Correo, e.Direccion, u.idUsuario, u.contraseña, u.idRol
FROM EMPLEADOS e JOIN USUARIOS u
ON e.idUsuario = u.idUsuario

SELECT *FROM empleados_usuarios;

CREATE OR REPLACE VIEW descripcion_cantidad AS
SELECT c.Nombre, dv.cantidad
FROM CATEGORIAS c JOIN PRODUCTOS p
ON c.idCategoria = p.idCategoria
JOIN DETALLE_VENTA dv
ON p.idProducto = dv.idProducto
JOIN VENTAS v
ON dv.idVenta = v.idVenta
JOIN EMPLEADOS e
ON v.idEmpleado = e.idEmpleado
WHERE e.Nombre = 'Maria Isabel'

SELECT * FROM descripcion_cantidad;
































/*Bitacora registro de operaciones*/

CREATE TABLE bitacora_base_de_datos(
    timestamp_ TIMESTAMP WITH TIME ZONE default NOW(),
    nombre_disparador text,
    tipo_disparador text,
    nivel_disparador text,
    comando text
);

CREATE OR REPLACE FUNCTION bitacora_universal() RETURNS TRIGGER AS $operaciones$
DECLARE
BEGIN
    INSERT INTO bitacora_base_de_datos(
           nombre_disparador,
           tipo_disparador,
           nivel_disparador,
           comando)
    VALUES(
          TG_NAME,
          TG_WHEN,
          TG_LEVEL,
          TG_OP
    );
    RETURN NULL;
END;
$operaciones$ LANGUAGE plpgsql;

CREATE TRIGGER bitacora_empresas AFTER INSERT OR UPDATE OR DELETE
    ON CATEGORIAS
    FOR EACH ROW
    EXECUTE PROCEDURE bitacora_universal();

CREATE TRIGGER bitacora_empresas AFTER INSERT OR UPDATE OR DELETE
    ON ROLES
    FOR EACH ROW
    EXECUTE PROCEDURE bitacora_universal();

CREATE TRIGGER bitacora_empresas AFTER INSERT OR UPDATE OR DELETE
    ON USUARIOS
    FOR EACH ROW
    EXECUTE PROCEDURE bitacora_universal();

CREATE TRIGGER bitacora_empresas AFTER INSERT OR UPDATE OR DELETE
    ON EMPLEADOS
    FOR EACH ROW
    EXECUTE PROCEDURE bitacora_universal();

CREATE TRIGGER bitacora_empresas AFTER INSERT OR UPDATE OR DELETE
    ON VENTAS
    FOR EACH ROW
    EXECUTE PROCEDURE bitacora_universal();

CREATE TRIGGER bitacora_empresas AFTER INSERT OR UPDATE OR DELETE
    ON PRODUCTOS
    FOR EACH ROW
    EXECUTE PROCEDURE bitacora_universal();

CREATE TRIGGER bitacora_empresas AFTER INSERT OR UPDATE OR DELETE
    ON INVENTARIO
    FOR EACH ROW
    EXECUTE PROCEDURE bitacora_universal();

CREATE TRIGGER bitacora_empresas AFTER INSERT OR UPDATE OR DELETE
    ON DETALLE_VENTA
    FOR EACH ROW
    EXECUTE PROCEDURE bitacora_universal();

/*Generar 2 triggers mas*/


CREATE OR REPLACE FUNCTION proteger_datos()
	RETURNS TRIGGER AS $proteger_datos$
	BEGIN 
	IF (TG_OP= 'DELETE') THEN
	RETURN NULL;
	END IF;
	RETURN NEW;
	END
$proteger_datos$ LANGUAGE plpgsql;

CREATE TRIGGER proteger_datos
	BEFORE DELETE ON CATEGORIAS
	FOR EACH ROW 
EXECUTE FUNCTION proteger_datos();

CREATE TRIGGER proteger_datos
	BEFORE DELETE ON ROLES
	FOR EACH ROW 
EXECUTE FUNCTION proteger_datos();

CREATE TRIGGER proteger_datos
	BEFORE DELETE ON USUARIOS
	FOR EACH ROW 
EXECUTE FUNCTION proteger_datos();

CREATE TRIGGER proteger_datos
	BEFORE DELETE ON EMPLEADOS
	FOR EACH ROW 
EXECUTE FUNCTION proteger_datos();

CREATE TRIGGER proteger_datos
	BEFORE DELETE ON VENTAS
	FOR EACH ROW 
EXECUTE FUNCTION proteger_datos();

CREATE TRIGGER proteger_datos
	BEFORE DELETE ON PRODUCTOS
	FOR EACH ROW 
EXECUTE FUNCTION proteger_datos();

CREATE TRIGGER proteger_datos
	BEFORE DELETE ON INVENTARIO
	FOR EACH ROW 
EXECUTE FUNCTION proteger_datos();

CREATE TRIGGER proteger_datos
	BEFORE DELETE ON DETALLE_VENTA
	FOR EACH ROW 
EXECUTE FUNCTION proteger_datos();























