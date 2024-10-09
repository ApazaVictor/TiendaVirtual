CREATE TABLE pedido (
  id_pedido INT PRIMARY KEY,
  id_usuario INT,
  fecha_pedido DATE,
  estado VARCHAR2(10)
);

CREATE TABLE notificacion (
  id_notificacion INT PRIMARY KEY,
  id_pedido INT,
  mensaje VARCHAR2(255),
  leido NUMBER(1)
);

CREATE TABLE usuario (
  id_usuario INT PRIMARY KEY,
  nombre VARCHAR2(50),
  apellido VARCHAR2(50),
  correo VARCHAR2(20),
  telefono VARCHAR2(21),
  direccion VARCHAR2(50),
  ciudad VARCHAR2(50),
  estado VARCHAR2(10),
  id_rol INT,
  id_cupon_descuento INT,
  fecha_creacion DATE,
  fecha_actualizacion DATE,
  usuario_creacion INT,
  usuario_actualizacion INT
);

CREATE TABLE rol (
  id_rol INT PRIMARY KEY,
  nombre_rol VARCHAR2(50)
);

CREATE TABLE cupon_descuento (
  id_cupon_descuento INT PRIMARY KEY,
  id_usuario INT
);

CREATE TABLE producto (
  id_producto INT PRIMARY KEY,
  id_categoria INT,
  stock INT,
  nombre_producto VARCHAR2(255),
  descripcion VARCHAR2(255),
  precio DECIMAL(10, 2),
  imagen VARCHAR2(100),
  fecha_creacion DATE,
  fecha_actualizacion DATE,
  usuario_creacion INT,
  usuario_actualizacion INT
);

CREATE TABLE devolucion (
  id_devolucion INT PRIMARY KEY,
  id_pedido INT,
  id_detalle_pedido INT,
  motivo_devolucion VARCHAR2(255),
  fecha_devolucion TIMESTAMP,
  estado VARCHAR2(10)
);

CREATE TABLE ofertas_especiales (
  id_ofertas_especiales INT PRIMARY KEY,
  id_producto INT,
  ofertas_descripcion VARCHAR2(50),
  fecha_inicio DATE,
  fecha_final DATE
);

CREATE TABLE reseña_producto (
  id_reseña_producto INT PRIMARY KEY,
  id_usuario INT,
  id_producto INT,
  calificacion INT,
  comentario VARCHAR2(255)
);

CREATE TABLE categorias (
  id_categoria INT PRIMARY KEY,
  nombre_categoria VARCHAR2(50),
  descripcion VARCHAR2(255),
  fecha_creacion DATE,
  fecha_actualizacion DATE,
  usuario_creacion INT,
  usuario_actualizacion INT
);

CREATE TABLE direccion_envio (
  id_direccion_envio INT PRIMARY KEY,
  id_pedido INT,
  direccion VARCHAR2(100),
  lugar_referencia VARCHAR2(50)
);

CREATE TABLE detalle_envio (
  id_detalle_envio INT PRIMARY KEY,
  id_direccion_envio INT,
  id_pedido INT,
  transportista VARCHAR2(50),
  estado VARCHAR2(10)
);

CREATE TABLE pago (
  id_pago INT PRIMARY KEY,
  id_pedido INT,
  id_metodo_pago INT,
  monto DECIMAL(10, 2),
  fechas_pago TIMESTAMP
);

CREATE TABLE metodo_pago (
  id_metodo_pago INT PRIMARY KEY,
  nombre_metodo VARCHAR2(50),
  estado VARCHAR2(10)
);

CREATE TABLE detalle_pedido (
  id_detalle_pedido INT PRIMARY KEY,
  id_producto INT,
  id_pedido INT,
  id_usuario INT,
  cantidad INT,
  precio_unitario DECIMAL(10, 2),
  subtotal DECIMAL(10, 2),
  estado VARCHAR2(10)
);

CREATE TABLE descuento (
  id_descuento INT PRIMARY KEY,
  id_ofertas_especiales INT,
  id_cupon_descuento INT,
  descripcion VARCHAR2(50),
  descuento_porcentaje DECIMAL(5, 2)
);

CREATE TABLE Tipo_Documento (
    id_Tipo_Documento INT PRIMARY KEY,
    Nombre VARCHAR2(50),
    Sigla VARCHAR2(50),
    Estado VARCHAR2(50),
    Orden INT
);

CREATE SEQUENCE SQ_TD
MINVALUE 1
START WITH 1
INCREMENT BY 1;

-- CREAR UN TRIGGER PARA EL AUTO INCREMENTO
CREATE OR REPLACE TRIGGER TRG_TD
BEFORE INSERT ON Tipo_Documento
FOR EACH ROW
BEGIN
    SELECT SQ_TD.NEXTVAL INTO :NEW.id_Tipo_Documento FROM DUAL;
END;
/


ALTER TABLE notificacion 
ADD CONSTRAINT FK_notificacion_id_pedido 
FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido);

ALTER TABLE usuario 
ADD CONSTRAINT FK_usuario_id_rol 
FOREIGN KEY (id_rol) REFERENCES rol(id_rol);

ALTER TABLE usuario 
ADD CONSTRAINT FK_usuario_id_cupon_descuento 
FOREIGN KEY (id_cupon_descuento) REFERENCES cupon_descuento(id_cupon_descuento);

ALTER TABLE cupon_descuento 
ADD CONSTRAINT FK_cupon_descuento_id_usuario 
FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);

ALTER TABLE producto 
ADD CONSTRAINT FK_producto_id_categoria 
FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria);

ALTER TABLE devolucion 
ADD CONSTRAINT FK_devolucion_id_pedido 
FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido);

ALTER TABLE devolucion 
ADD CONSTRAINT FK_devolucion_id_detalle_pedido 
FOREIGN KEY (id_detalle_pedido) REFERENCES detalle_pedido(id_detalle_pedido);

ALTER TABLE ofertas_especiales 
ADD CONSTRAINT FK_ofertas_especiales_id_producto 
FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

ALTER TABLE reseña_producto 
ADD CONSTRAINT FK_reseña_producto_id_usuario 
FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);

ALTER TABLE reseña_producto 
ADD CONSTRAINT FK_reseña_producto_id_producto 
FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

ALTER TABLE direccion_envio 
ADD CONSTRAINT FK_direccion_envio_id_pedido 
FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido);

ALTER TABLE detalle_envio 
ADD CONSTRAINT FK_detalle_envio_id_direccion_envio 
FOREIGN KEY (id_direccion_envio) REFERENCES direccion_envio(id_direccion_envio);

ALTER TABLE detalle_envio 
ADD CONSTRAINT FK_detalle_envio_id_pedido 
FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido);

ALTER TABLE pago 
ADD CONSTRAINT FK_pago_id_pedido 
FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido);

ALTER TABLE pago 
ADD CONSTRAINT FK_pago_id_metodo_pago 
FOREIGN KEY (id_metodo_pago) REFERENCES metodo_pago(id_metodo_pago);

ALTER TABLE detalle_pedido 
ADD CONSTRAINT FK_detalle_pedido_id_pedido 
FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido);

ALTER TABLE detalle_pedido 
ADD CONSTRAINT FK_detalle_pedido_id_producto 
FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

ALTER TABLE detalle_pedido 
ADD CONSTRAINT FK_detalle_pedido_id_usuario 
FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);

ALTER TABLE descuento 
ADD CONSTRAINT FK_descuento_id_ofertas_especiales 
FOREIGN KEY (id_ofertas_especiales) REFERENCES ofertas_especiales(id_ofertas_especiales);

ALTER TABLE descuento 
ADD CONSTRAINT FK_descuento_id_cupon_descuento 
FOREIGN KEY (id_cupon_descuento) REFERENCES cupon_descuento(id_cupon_descuento);


-- Insertar datos en la tabla rol
INSERT INTO rol (id_rol, nombre_rol) VALUES (1, 'Administrador');
INSERT INTO rol (id_rol, nombre_rol) VALUES (2, 'Usuario');
INSERT INTO rol (id_rol, nombre_rol) VALUES (3, 'Invitado');
INSERT INTO rol (id_rol, nombre_rol) VALUES (4, 'Vendedor');
INSERT INTO rol (id_rol, nombre_rol) VALUES (5, 'Cliente');
INSERT INTO rol (id_rol, nombre_rol) VALUES (6, 'Gerente');
INSERT INTO rol (id_rol, nombre_rol) VALUES (7, 'Supervisor');
INSERT INTO rol (id_rol, nombre_rol) VALUES (8, 'Analista');
INSERT INTO rol (id_rol, nombre_rol) VALUES (9, 'Desarrollador');
INSERT INTO rol (id_rol, nombre_rol) VALUES (10, 'Tester');
INSERT INTO rol (id_rol, nombre_rol) VALUES (11, 'Consultor');
INSERT INTO rol (id_rol, nombre_rol) VALUES (12, 'Especialista');
INSERT INTO rol (id_rol, nombre_rol) VALUES (13, 'Coordinador');
INSERT INTO rol (id_rol, nombre_rol) VALUES (14, 'Asistente');
INSERT INTO rol (id_rol, nombre_rol) VALUES (15, 'Asesor');

-- Insertar datos en la tabla metodo_pago
INSERT INTO metodo_pago (id_metodo_pago, nombre_metodo, estado) VALUES (1, 'Tarjeta de Crédito', 'Activo');
INSERT INTO metodo_pago (id_metodo_pago, nombre_metodo, estado) VALUES (2, 'PayPal', 'Activo');
INSERT INTO metodo_pago (id_metodo_pago, nombre_metodo, estado) VALUES (3, 'Transferencia Bancaria', 'Activo');
INSERT INTO metodo_pago (id_metodo_pago, nombre_metodo, estado) VALUES (4, 'Efectivo', 'Activo');
INSERT INTO metodo_pago (id_metodo_pago, nombre_metodo, estado) VALUES (5, 'Cheque', 'Activo');
INSERT INTO metodo_pago (id_metodo_pago, nombre_metodo, estado) VALUES (6, 'Bitcoin', 'Activo');
INSERT INTO metodo_pago (id_metodo_pago, nombre_metodo, estado) VALUES (7, 'Apple Pay', 'Activo');
INSERT INTO metodo_pago (id_metodo_pago, nombre_metodo, estado) VALUES (8, 'Google Pay', 'Activo');
INSERT INTO metodo_pago (id_metodo_pago, nombre_metodo, estado) VALUES (9, 'Samsung Pay', 'Activo');
INSERT INTO metodo_pago (id_metodo_pago, nombre_metodo, estado) VALUES (10, 'Amazon Pay', 'Activo');
INSERT INTO metodo_pago (id_metodo_pago, nombre_metodo, estado) VALUES (11, 'Alipay', 'Activo');
INSERT INTO metodo_pago (id_metodo_pago, nombre_metodo, estado) VALUES (12, 'WeChat Pay', 'Activo');
INSERT INTO metodo_pago (id_metodo_pago, nombre_metodo, estado) VALUES (13, 'Venmo', 'Activo');
INSERT INTO metodo_pago (id_metodo_pago, nombre_metodo, estado) VALUES (14, 'Zelle', 'Activo');
INSERT INTO metodo_pago (id_metodo_pago, nombre_metodo, estado) VALUES (15, 'Cash App', 'Activo');

-- Insertar datos en la tabla categorias
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (1, 'Electrónica', 'Productos electrónicos', SYSDATE, SYSDATE, 1, 1);
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (2, 'Ropa', 'Ropa y accesorios', SYSDATE, SYSDATE, 1, 1);
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (3, 'Hogar', 'Productos para el hogar', SYSDATE, SYSDATE, 1, 1);
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (4, 'Deportes', 'Productos deportivos', SYSDATE, SYSDATE, 1, 1);
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (5, 'Belleza', 'Productos de belleza', SYSDATE, SYSDATE, 1, 1);
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (6, 'Juguetes', 'Juguetes y juegos', SYSDATE, SYSDATE, 1, 1);
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (7, 'Libros', 'Libros y literatura', SYSDATE, SYSDATE, 1, 1);
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (8, 'Salud', 'Productos de salud', SYSDATE, SYSDATE, 1, 1);
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (9, 'Automotriz', 'Productos automotrices', SYSDATE, SYSDATE, 1, 1);
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (10, 'Jardinería', 'Productos de jardinería', SYSDATE, SYSDATE, 1, 1);
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (11, 'Mascotas', 'Productos para mascotas', SYSDATE, SYSDATE, 1, 1);
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (12, 'Tecnología', 'Productos tecnológicos', SYSDATE, SYSDATE, 1, 1);
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (13, 'Moda', 'Productos de moda', SYSDATE, SYSDATE, 1, 1);
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (14, 'Decoración', 'Productos de decoración', SYSDATE, SYSDATE, 1, 1);
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (15, 'Alimentos', 'Productos alimenticios', SYSDATE, SYSDATE, 1, 1);

-- Insertar datos en la tabla usuario
INSERT INTO usuario (id_usuario, nombre, apellido, correo, telefono, direccion, ciudad, estado, id_rol, id_cupon_descuento, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (1, 'Juan', 'Pérez', 'juan@example.com', '1234567890', 'Calle 1', 'Ciudad 1', 'Activo', 1, NULL, SYSDATE, SYSDATE, 1, 1);
INSERT INTO usuario (id_usuario, nombre, apellido, correo, telefono, direccion, ciudad, estado, id_rol, id_cupon_descuento, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (2, 'María', 'Gómez', 'maria@example.com', '0987654321', 'Calle 2', 'Ciudad 2', 'Activo', 2, NULL, SYSDATE, SYSDATE, 1, 1);
INSERT INTO usuario (id_usuario, nombre, apellido, correo, telefono, direccion, ciudad, estado, id_rol, id_cupon_descuento, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (3, 'Carlos', 'Rodríguez', 'carlos@example.com', '1122334455', 'Calle 3', 'Ciudad 3', 'Activo', 3, NULL, SYSDATE, SYSDATE, 1, 1);
INSERT INTO usuario (id_usuario, nombre, apellido, correo, telefono, direccion, ciudad, estado, id_rol, id_cupon_descuento, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (4, 'Ana', 'Martínez', 'ana@example.com', '5544332211', 'Calle 4', 'Ciudad 4', 'Activo', 4, NULL, SYSDATE, SYSDATE, 1, 1);
INSERT INTO usuario (id_usuario, nombre, apellido, correo, telefono, direccion, ciudad, estado, id_rol, id_cupon_descuento, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (5, 'Luis', 'Fernández', 'luis@example.com', '9988776655', 'Calle 5', 'Ciudad 5', 'Activo', 5, NULL, SYSDATE, SYSDATE, 1, 1);
INSERT INTO usuario (id_usuario, nombre, apellido, correo, telefono, direccion, ciudad, estado, id_rol, id_cupon_descuento, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (6, 'Laura', 'López', 'laura@example.com', '4455667788', 'Calle 6', 'Ciudad 6', 'Activo', 6, NULL, SYSDATE, SYSDATE, 1, 1);
INSERT INTO usuario (id_usuario, nombre, apellido, correo, telefono, direccion, ciudad, estado, id_rol, id_cupon_descuento, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (7, 'Miguel', 'García', 'miguel@example.com', '7788990011', 'Calle 7', 'Ciudad 7', 'Activo', 7, NULL, SYSDATE, SYSDATE, 1, 1);
INSERT INTO usuario (id_usuario, nombre, apellido, correo, telefono, direccion, ciudad, estado, id_rol, id_cupon_descuento, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (8, 'Sofía', 'Hernández', 'sofia@example.com', '2233445566', 'Calle 8', 'Ciudad 8', 'Activo', 8, NULL, SYSDATE, SYSDATE, 1, 1);
INSERT INTO usuario (id_usuario, nombre, apellido, correo, telefono, direccion, ciudad, estado, id_rol, id_cupon_descuento, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (9, 'Diego', 'Sánchez', 'diego@example.com', '6677889900', 'Calle 9', 'Ciudad 9', 'Activo', 9, NULL, SYSDATE, SYSDATE, 1, 1);
INSERT INTO usuario (id_usuario, nombre, apellido, correo, telefono, direccion, ciudad, estado, id_rol, id_cupon_descuento, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (10, 'Paula', 'Ramírez', 'paula@example.com', '1122334455', 'Calle 10', 'Ciudad 10', 'Activo', 10, NULL, SYSDATE, SYSDATE, 1, 1);
INSERT INTO usuario (id_usuario, nombre, apellido, correo, telefono, direccion, ciudad, estado, id_rol, id_cupon_descuento, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (11, 'Roberto', 'Torres', 'roberto@example.com', '5544332211', 'Calle 11', 'Ciudad 11', 'Activo', 11, NULL, SYSDATE, SYSDATE, 1, 1);
INSERT INTO usuario (id_usuario, nombre, apellido, correo, telefono, direccion, ciudad, estado, id_rol, id_cupon_descuento, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (12, 'Elena', 'Morales', 'elena@example.com', '9988776655', 'Calle 12', 'Ciudad 12', 'Activo', 12, NULL, SYSDATE, SYSDATE, 1, 1);
INSERT INTO usuario (id_usuario, nombre, apellido, correo, telefono, direccion, ciudad, estado, id_rol, id_cupon_descuento, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (13, 'Javier', 'Castro', 'javier@example.com', '4455667788', 'Calle 13', 'Ciudad 13', 'Activo', 13, NULL, SYSDATE, SYSDATE, 1, 1);
INSERT INTO usuario (id_usuario, nombre, apellido, correo, telefono, direccion, ciudad, estado, id_rol, id_cupon_descuento, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (14, 'Isabel', 'Ortega', 'isabel@example.com', '7788990011', 'Calle 14', 'Ciudad 14', 'Activo', 14, NULL, SYSDATE, SYSDATE, 1, 1);
INSERT INTO usuario (id_usuario, nombre, apellido, correo, telefono, direccion, ciudad, estado, id_rol, id_cupon_descuento, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (15, 'Fernando', 'Gutiérrez', 'fernando@example.com', '2233445566', 'Calle 15', 'Ciudad 15', 'Activo', 15, NULL, SYSDATE, SYSDATE, 1, 1);

-- Insertar datos en la tabla cupon_descuento
INSERT INTO cupon_descuento (id_cupon_descuento, id_usuario) VALUES (1, 1);
INSERT INTO cupon_descuento (id_cupon_descuento, id_usuario) VALUES (2, 2);
INSERT INTO cupon_descuento (id_cupon_descuento, id_usuario) VALUES (3, 3);
INSERT INTO cupon_descuento (id_cupon_descuento, id_usuario) VALUES (4, 4);
INSERT INTO cupon_descuento (id_cupon_descuento, id_usuario) VALUES (5, 5);
INSERT INTO cupon_descuento (id_cupon_descuento, id_usuario) VALUES (6, 6);
INSERT INTO cupon_descuento (id_cupon_descuento, id_usuario) VALUES (7, 7);
INSERT INTO cupon_descuento (id_cupon_descuento, id_usuario) VALUES (8, 8);
INSERT INTO cupon_descuento (id_cupon_descuento, id_usuario) VALUES (9, 9);
INSERT INTO cupon_descuento (id_cupon_descuento, id_usuario) VALUES (10, 10);
INSERT INTO cupon_descuento (id_cupon_descuento, id_usuario) VALUES (11, 11);
INSERT INTO cupon_descuento (id_cupon_descuento, id_usuario) VALUES (12, 12);
INSERT INTO cupon_descuento (id_cupon_descuento, id_usuario) VALUES (13, 13);
INSERT INTO cupon_descuento (id_cupon_descuento, id_usuario) VALUES (14, 14);
INSERT INTO cupon_descuento (id_cupon_descuento, id_usuario) VALUES (15, 15);

-- Insertar datos en la tabla producto
INSERT INTO producto (id_producto, id_categoria, stock, nombre_producto, descripcion, precio, imagen, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (1, 1, 100, 'Laptop', 'Laptop de alta gama', 999.99, 'laptop.jpg', SYSDATE, SYSDATE, 1, 1);
INSERT INTO producto (id_producto, id_categoria, stock, nombre_producto, descripcion, precio, imagen, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (2, 2, 200, 'Camiseta', 'Camiseta de algodón', 19.99, 'camiseta.jpg', SYSDATE, SYSDATE, 1, 1);
INSERT INTO producto (id_producto, id_categoria, stock, nombre_producto, descripcion, precio, imagen, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (3, 3, 150, 'Sofá', 'Sofá de cuero', 499.99, 'sofa.jpg', SYSDATE, SYSDATE, 1, 1);
INSERT INTO producto (id_producto, id_categoria, stock, nombre_producto, descripcion, precio, imagen, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (4, 4, 50, 'Balón de fútbol', 'Balón de fútbol oficial', 29.99, 'balon.jpg', SYSDATE, SYSDATE, 1, 1);
INSERT INTO producto (id_producto, id_categoria, stock, nombre_producto, descripcion, precio, imagen, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (5, 5, 100, 'Perfume', 'Perfume de marca', 49.99, 'perfume.jpg', SYSDATE, SYSDATE, 1, 1);
INSERT INTO producto (id_producto, id_categoria, stock, nombre_producto, descripcion, precio, imagen, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (6, 6, 200, 'Pelota', 'Pelota de juguete', 9.99, 'pelota.jpg', SYSDATE, SYSDATE, 1, 1);
INSERT INTO producto (id_producto, id_categoria, stock, nombre_producto, descripcion, precio, imagen, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (7, 7, 150, 'Libro', 'Libro de misterio', 14.99, 'libro.jpg', SYSDATE, SYSDATE, 1, 1);
INSERT INTO producto (id_producto, id_categoria, stock, nombre_producto, descripcion, precio, imagen, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (8, 8, 50, 'Vitaminas', 'Vitaminas multivitamínicas', 19.99, 'vitaminas.jpg', SYSDATE, SYSDATE, 1, 1);
INSERT INTO producto (id_producto, id_categoria, stock, nombre_producto, descripcion, precio, imagen, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (9, 9, 100, 'Aceite de motor', 'Aceite de motor sintético', 29.99, 'aceite.jpg', SYSDATE, SYSDATE, 1, 1);
INSERT INTO producto (id_producto, id_categoria, stock, nombre_producto, descripcion, precio, imagen, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (10, 10, 200, 'Planta', 'Planta de interior', 14.99, 'planta.jpg', SYSDATE, SYSDATE, 1, 1);
INSERT INTO producto (id_producto, id_categoria, stock, nombre_producto, descripcion, precio, imagen, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (11, 11, 150, 'Comida para perros', 'Comida para perros premium', 29.99, 'comida_perros.jpg', SYSDATE, SYSDATE, 1, 1);
INSERT INTO producto (id_producto, id_categoria, stock, nombre_producto, descripcion, precio, imagen, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (12, 12, 50, 'Smartphone', 'Smartphone de última generación', 799.99, 'smartphone.jpg', SYSDATE, SYSDATE, 1, 1);
INSERT INTO producto (id_producto, id_categoria, stock, nombre_producto, descripcion, precio, imagen, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (13, 13, 100, 'Zapatos', 'Zapatos de cuero', 99.99, 'zapatos.jpg', SYSDATE, SYSDATE, 1, 1);
INSERT INTO producto (id_producto, id_categoria, stock, nombre_producto, descripcion, precio, imagen, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (14, 14, 200, 'Lámpara', 'Lámpara de mesa', 29.99, 'lampara.jpg', SYSDATE, SYSDATE, 1, 1);
INSERT INTO producto (id_producto, id_categoria, stock, nombre_producto, descripcion, precio, imagen, fecha_creacion, fecha_actualizacion, usuario_creacion, usuario_actualizacion) VALUES (15, 15, 150, 'Chocolate', 'Chocolate de alta calidad', 9.99, 'chocolate.jpg', SYSDATE, SYSDATE, 1, 1);

-- Insertar datos en la tabla pedido
INSERT INTO pedido (id_pedido, id_usuario, fecha_pedido, estado) VALUES (1, 1, SYSDATE, 'En proceso');
INSERT INTO pedido (id_pedido, id_usuario, fecha_pedido, estado) VALUES (2, 2, SYSDATE, 'En proceso');
INSERT INTO pedido (id_pedido, id_usuario, fecha_pedido, estado) VALUES (3, 3, SYSDATE, 'En proceso');
INSERT INTO pedido (id_pedido, id_usuario, fecha_pedido, estado) VALUES (4, 4, SYSDATE, 'En proceso');
INSERT INTO pedido (id_pedido, id_usuario, fecha_pedido, estado) VALUES (5, 5, SYSDATE, 'En proceso');
INSERT INTO pedido (id_pedido, id_usuario, fecha_pedido, estado) VALUES (6, 6, SYSDATE, 'En proceso');
INSERT INTO pedido (id_pedido, id_usuario, fecha_pedido, estado) VALUES (7, 7, SYSDATE, 'En proceso');
INSERT INTO pedido (id_pedido, id_usuario, fecha_pedido, estado) VALUES (8, 8, SYSDATE, 'En proceso');
INSERT INTO pedido (id_pedido, id_usuario, fecha_pedido, estado) VALUES (9, 9, SYSDATE, 'En proceso');
INSERT INTO pedido (id_pedido, id_usuario, fecha_pedido, estado) VALUES (10, 10, SYSDATE, 'En proceso');
INSERT INTO pedido (id_pedido, id_usuario, fecha_pedido, estado) VALUES (11, 11, SYSDATE, 'En proceso');
INSERT INTO pedido (id_pedido, id_usuario, fecha_pedido, estado) VALUES (12, 12, SYSDATE, 'En proceso');
INSERT INTO pedido (id_pedido, id_usuario, fecha_pedido, estado) VALUES (13, 13, SYSDATE, 'En proceso');
INSERT INTO pedido (id_pedido, id_usuario, fecha_pedido, estado) VALUES (14, 14, SYSDATE, 'En proceso');
INSERT INTO pedido (id_pedido, id_usuario, fecha_pedido, estado) VALUES (15, 15, SYSDATE, 'En proceso');

-- Insertar datos en la tabla detalle_pedido
INSERT INTO detalle_pedido (id_detalle_pedido, id_producto, id_pedido, id_usuario, cantidad, precio_unitario, subtotal, estado) VALUES (1, 1, 1, 1, 2, 999.99, 1999.98, 'En proceso');
INSERT INTO detalle_pedido (id_detalle_pedido, id_producto, id_pedido, id_usuario, cantidad, precio_unitario, subtotal, estado) VALUES (2, 2, 2, 2, 3, 19.99, 59.97, 'En proceso');
INSERT INTO detalle_pedido (id_detalle_pedido, id_producto, id_pedido, id_usuario, cantidad, precio_unitario, subtotal, estado) VALUES (3, 3, 3, 3, 1, 499.99, 499.99, 'En proceso');
INSERT INTO detalle_pedido (id_detalle_pedido, id_producto, id_pedido, id_usuario, cantidad, precio_unitario, subtotal, estado) VALUES (4, 4, 4, 4, 2, 29.99, 59.98, 'En proceso');
INSERT INTO detalle_pedido (id_detalle_pedido, id_producto, id_pedido, id_usuario, cantidad, precio_unitario, subtotal, estado) VALUES (5, 5, 5, 5, 1, 49.99, 49.99, 'En proceso');
INSERT INTO detalle_pedido (id_detalle_pedido, id_producto, id_pedido, id_usuario, cantidad, precio_unitario, subtotal, estado) VALUES (6, 6, 6, 6, 3, 9.99, 29.97, 'En proceso');
INSERT INTO detalle_pedido (id_detalle_pedido, id_producto, id_pedido, id_usuario, cantidad, precio_unitario, subtotal, estado) VALUES (7, 7, 7, 7, 2, 14.99, 29.98, 'En proceso');
INSERT INTO detalle_pedido (id_detalle_pedido, id_producto, id_pedido, id_usuario, cantidad, precio_unitario, subtotal, estado) VALUES (8, 8, 8, 8, 1, 19.99, 19.99, 'En proceso');
INSERT INTO detalle_pedido (id_detalle_pedido, id_producto, id_pedido, id_usuario, cantidad, precio_unitario, subtotal, estado) VALUES (9, 9, 9, 9, 2, 29.99, 59.98, 'En proceso');
INSERT INTO detalle_pedido (id_detalle_pedido, id_producto, id_pedido, id_usuario, cantidad, precio_unitario, subtotal, estado) VALUES (10, 10, 10, 10, 1, 14.99, 14.99, 'En proceso');
INSERT INTO detalle_pedido (id_detalle_pedido, id_producto, id_pedido, id_usuario, cantidad, precio_unitario, subtotal, estado) VALUES (11, 11, 11, 11, 2, 29.99, 59.98, 'En proceso');
INSERT INTO detalle_pedido (id_detalle_pedido, id_producto, id_pedido, id_usuario, cantidad, precio_unitario, subtotal, estado) VALUES (12, 12, 12, 12, 1, 799.99, 799.99, 'En proceso');
INSERT INTO detalle_pedido (id_detalle_pedido, id_producto, id_pedido, id_usuario, cantidad, precio_unitario, subtotal, estado) VALUES (13, 13, 13, 13, 2, 99.99, 199.98, 'En proceso');
INSERT INTO detalle_pedido (id_detalle_pedido, id_producto, id_pedido, id_usuario, cantidad, precio_unitario, subtotal, estado) VALUES (14, 14, 14, 14, 1, 29.99, 29.99, 'En proceso');
INSERT INTO detalle_pedido (id_detalle_pedido, id_producto, id_pedido, id_usuario, cantidad, precio_unitario, subtotal, estado) VALUES (15, 15, 15, 15, 3, 9.99, 29.97, 'En proceso');

-- Insertar datos en la tabla notificacion
INSERT INTO notificacion (id_notificacion, id_pedido, mensaje, leido) VALUES (1, 1, 'Su pedido ha sido recibido', 0);
INSERT INTO notificacion (id_notificacion, id_pedido, mensaje, leido) VALUES (2, 2, 'Su pedido ha sido enviado', 0);
INSERT INTO notificacion (id_notificacion, id_pedido, mensaje, leido) VALUES (3, 3, 'Su pedido ha sido entregado', 0);
INSERT INTO notificacion (id_notificacion, id_pedido, mensaje, leido) VALUES (4, 4, 'Su pedido ha sido recibido', 0);
INSERT INTO notificacion (id_notificacion, id_pedido, mensaje, leido) VALUES (5, 5, 'Su pedido ha sido enviado', 0);
INSERT INTO notificacion (id_notificacion, id_pedido, mensaje, leido) VALUES (6, 6, 'Su pedido ha sido entregado', 0);
INSERT INTO notificacion (id_notificacion, id_pedido, mensaje, leido) VALUES (7, 7, 'Su pedido ha sido recibido', 0);
INSERT INTO notificacion (id_notificacion, id_pedido, mensaje, leido) VALUES (8, 8, 'Su pedido ha sido enviado', 0);
INSERT INTO notificacion (id_notificacion, id_pedido, mensaje, leido) VALUES (9, 9, 'Su pedido ha sido entregado', 0);
INSERT INTO notificacion (id_notificacion, id_pedido, mensaje, leido) VALUES (10, 10, 'Su pedido ha sido recibido', 0);
INSERT INTO notificacion (id_notificacion, id_pedido, mensaje, leido) VALUES (11, 11, 'Su pedido ha sido enviado', 0);
INSERT INTO notificacion (id_notificacion, id_pedido, mensaje, leido) VALUES (12, 12, 'Su pedido ha sido entregado', 0);
INSERT INTO notificacion (id_notificacion, id_pedido, mensaje, leido) VALUES (13, 13, 'Su pedido ha sido recibido', 0);
INSERT INTO notificacion (id_notificacion, id_pedido, mensaje, leido) VALUES (14, 14, 'Su pedido ha sido enviado', 0);
INSERT INTO notificacion (id_notificacion, id_pedido, mensaje, leido) VALUES (15, 15, 'Su pedido ha sido entregado', 0);

-- Insertar datos en la tabla devolucion
INSERT INTO devolucion (id_devolucion, id_pedido, id_detalle_pedido, motivo_devolucion, fecha_devolucion, estado) VALUES (1, 1, 1, 'Producto defectuoso', SYSTIMESTAMP, 'En proceso');
INSERT INTO devolucion (id_devolucion, id_pedido, id_detalle_pedido, motivo_devolucion, fecha_devolucion, estado) VALUES (2, 2, 2, 'Producto incorrecto', SYSTIMESTAMP, 'En proceso');
INSERT INTO devolucion (id_devolucion, id_pedido, id_detalle_pedido, motivo_devolucion, fecha_devolucion, estado) VALUES (3, 3, 3, 'Producto dañado', SYSTIMESTAMP, 'En proceso');
INSERT INTO devolucion (id_devolucion, id_pedido, id_detalle_pedido, motivo_devolucion, fecha_devolucion, estado) VALUES (4, 4, 4, 'Producto defectuoso', SYSTIMESTAMP, 'En proceso');
INSERT INTO devolucion (id_devolucion, id_pedido, id_detalle_pedido, motivo_devolucion, fecha_devolucion, estado) VALUES (5, 5, 5, 'Producto incorrecto', SYSTIMESTAMP, 'En proceso');
INSERT INTO devolucion (id_devolucion, id_pedido, id_detalle_pedido, motivo_devolucion, fecha_devolucion, estado) VALUES (6, 6, 6, 'Producto dañado', SYSTIMESTAMP, 'En proceso');
INSERT INTO devolucion (id_devolucion, id_pedido, id_detalle_pedido, motivo_devolucion, fecha_devolucion, estado) VALUES (7, 7, 7, 'Producto defectuoso', SYSTIMESTAMP, 'En proceso');
INSERT INTO devolucion (id_devolucion, id_pedido, id_detalle_pedido, motivo_devolucion, fecha_devolucion, estado) VALUES (8, 8, 8, 'Producto incorrecto', SYSTIMESTAMP, 'En proceso');
INSERT INTO devolucion (id_devolucion, id_pedido, id_detalle_pedido, motivo_devolucion, fecha_devolucion, estado) VALUES (9, 9, 9, 'Producto dañado', SYSTIMESTAMP, 'En proceso');
INSERT INTO devolucion (id_devolucion, id_pedido, id_detalle_pedido, motivo_devolucion, fecha_devolucion, estado) VALUES (10, 10, 10, 'Producto defectuoso', SYSTIMESTAMP, 'En proceso');
INSERT INTO devolucion (id_devolucion, id_pedido, id_detalle_pedido, motivo_devolucion, fecha_devolucion, estado) VALUES (11, 11, 11, 'Producto incorrecto', SYSTIMESTAMP, 'En proceso');
INSERT INTO devolucion (id_devolucion, id_pedido, id_detalle_pedido, motivo_devolucion, fecha_devolucion, estado) VALUES (12, 12, 12, 'Producto dañado', SYSTIMESTAMP, 'En proceso');
INSERT INTO devolucion (id_devolucion, id_pedido, id_detalle_pedido, motivo_devolucion, fecha_devolucion, estado) VALUES (13, 13, 13, 'Producto defectuoso', SYSTIMESTAMP, 'En proceso');
INSERT INTO devolucion (id_devolucion, id_pedido, id_detalle_pedido, motivo_devolucion, fecha_devolucion, estado) VALUES (14, 14, 14, 'Producto incorrecto', SYSTIMESTAMP, 'En proceso');
INSERT INTO devolucion (id_devolucion, id_pedido, id_detalle_pedido, motivo_devolucion, fecha_devolucion, estado) VALUES (15, 15, 15, 'Producto dañado', SYSTIMESTAMP, 'En proceso');

-- Insertar datos en la tabla ofertas_especiales
INSERT INTO ofertas_especiales (id_ofertas_especiales, id_producto, ofertas_descripcion, fecha_inicio, fecha_final) VALUES (1, 1, 'Oferta de lanzamiento', SYSDATE, SYSDATE + 30);
INSERT INTO ofertas_especiales (id_ofertas_especiales, id_producto, ofertas_descripcion, fecha_inicio, fecha_final) VALUES (2, 2, 'Oferta de temporada', SYSDATE, SYSDATE + 30);
INSERT INTO ofertas_especiales (id_ofertas_especiales, id_producto, ofertas_descripcion, fecha_inicio, fecha_final) VALUES (3, 3, 'Oferta de liquidación', SYSDATE, SYSDATE + 30);
INSERT INTO ofertas_especiales (id_ofertas_especiales, id_producto, ofertas_descripcion, fecha_inicio, fecha_final) VALUES (4, 4, 'Oferta de lanzamiento', SYSDATE, SYSDATE + 30);
INSERT INTO ofertas_especiales (id_ofertas_especiales, id_producto, ofertas_descripcion, fecha_inicio, fecha_final) VALUES (5, 5, 'Oferta de temporada', SYSDATE, SYSDATE + 30);
INSERT INTO ofertas_especiales (id_ofertas_especiales, id_producto, ofertas_descripcion, fecha_inicio, fecha_final) VALUES (6, 6, 'Oferta de liquidación', SYSDATE, SYSDATE + 30);
INSERT INTO ofertas_especiales (id_ofertas_especiales, id_producto, ofertas_descripcion, fecha_inicio, fecha_final) VALUES (7, 7, 'Oferta de lanzamiento', SYSDATE, SYSDATE + 30);
INSERT INTO ofertas_especiales (id_ofertas_especiales, id_producto, ofertas_descripcion, fecha_inicio, fecha_final) VALUES (8, 8, 'Oferta de temporada', SYSDATE, SYSDATE + 30);
INSERT INTO ofertas_especiales (id_ofertas_especiales, id_producto, ofertas_descripcion, fecha_inicio, fecha_final) VALUES (9, 9, 'Oferta de liquidación', SYSDATE, SYSDATE + 30);
INSERT INTO ofertas_especiales (id_ofertas_especiales, id_producto, ofertas_descripcion, fecha_inicio, fecha_final) VALUES (10, 10, 'Oferta de lanzamiento', SYSDATE, SYSDATE + 30);
INSERT INTO ofertas_especiales (id_ofertas_especiales, id_producto, ofertas_descripcion, fecha_inicio, fecha_final) VALUES (11, 11, 'Oferta de temporada', SYSDATE, SYSDATE + 30);
INSERT INTO ofertas_especiales (id_ofertas_especiales, id_producto, ofertas_descripcion, fecha_inicio, fecha_final) VALUES (12, 12, 'Oferta de liquidación', SYSDATE, SYSDATE + 30);
INSERT INTO ofertas_especiales (id_ofertas_especiales, id_producto, ofertas_descripcion, fecha_inicio, fecha_final) VALUES (13, 13, 'Oferta de lanzamiento', SYSDATE, SYSDATE + 30);
INSERT INTO ofertas_especiales (id_ofertas_especiales, id_producto, ofertas_descripcion, fecha_inicio, fecha_final) VALUES (14, 14, 'Oferta de temporada', SYSDATE, SYSDATE + 30);
INSERT INTO ofertas_especiales (id_ofertas_especiales, id_producto, ofertas_descripcion, fecha_inicio, fecha_final) VALUES (15, 15, 'Oferta de liquidación', SYSDATE, SYSDATE + 30);


SELECT * FROM ofertas_especiales;

-- Insertar datos en la tabla direccion_envio
INSERT INTO direccion_envio (id_direccion_envio, id_pedido, direccion, lugar_referencia) VALUES (1, 1, 'Calle 1, Ciudad 1', 'Cerca del parque');
INSERT INTO direccion_envio (id_direccion_envio, id_pedido, direccion, lugar_referencia) VALUES (2, 2, 'Calle 2, Ciudad 2', 'Cerca del supermercado');
INSERT INTO direccion_envio (id_direccion_envio, id_pedido, direccion, lugar_referencia) VALUES (3, 3, 'Calle 3, Ciudad 3', 'Cerca de la escuela');
INSERT INTO direccion_envio (id_direccion_envio, id_pedido, direccion, lugar_referencia) VALUES (4, 4, 'Calle 4, Ciudad 4', 'Cerca del parque');
INSERT INTO direccion_envio (id_direccion_envio, id_pedido, direccion, lugar_referencia) VALUES (5, 5, 'Calle 5, Ciudad 5', 'Cerca del supermercado');
INSERT INTO direccion_envio (id_direccion_envio, id_pedido, direccion, lugar_referencia) VALUES (6, 6, 'Calle 6, Ciudad 6', 'Cerca de la escuela');
INSERT INTO direccion_envio (id_direccion_envio, id_pedido, direccion, lugar_referencia) VALUES (7, 7, 'Calle 7, Ciudad 7', 'Cerca del parque');
INSERT INTO direccion_envio (id_direccion_envio, id_pedido, direccion, lugar_referencia) VALUES (8, 8, 'Calle 8, Ciudad 8', 'Cerca del supermercado');
INSERT INTO direccion_envio (id_direccion_envio, id_pedido, direccion, lugar_referencia) VALUES (9, 9, 'Calle 9, Ciudad 9', 'Cerca de la escuela');
INSERT INTO direccion_envio (id_direccion_envio, id_pedido, direccion, lugar_referencia) VALUES (10, 10, 'Calle 10, Ciudad 10', 'Cerca del parque');
INSERT INTO direccion_envio (id_direccion_envio, id_pedido, direccion, lugar_referencia) VALUES (11, 11, 'Calle 11, Ciudad 11', 'Cerca del supermercado');
INSERT INTO direccion_envio (id_direccion_envio, id_pedido, direccion, lugar_referencia) VALUES (12, 12, 'Calle 12, Ciudad 12', 'Cerca de la escuela');
INSERT INTO direccion_envio (id_direccion_envio, id_pedido, direccion, lugar_referencia) VALUES (13, 13, 'Calle 13, Ciudad 13', 'Cerca del parque');
INSERT INTO direccion_envio (id_direccion_envio, id_pedido, direccion, lugar_referencia) VALUES (14, 14, 'Calle 14, Ciudad 14', 'Cerca del supermercado');
INSERT INTO direccion_envio (id_direccion_envio, id_pedido, direccion, lugar_referencia) VALUES (15, 15, 'Calle 15, Ciudad 15', 'Cerca de la escuela');

-- Insertar datos en la tabla detalle_envio
INSERT INTO detalle_envio (id_detalle_envio, id_direccion_envio, id_pedido, transportista, estado) VALUES (1, 1, 1, 'DHL', 'En proceso');
INSERT INTO detalle_envio (id_detalle_envio, id_direccion_envio, id_pedido, transportista, estado) VALUES (2, 2, 2, 'FedEx', 'En proceso');
INSERT INTO detalle_envio (id_detalle_envio, id_direccion_envio, id_pedido, transportista, estado) VALUES (3, 3, 3, 'UPS', 'En proceso');
INSERT INTO detalle_envio (id_detalle_envio, id_direccion_envio, id_pedido, transportista, estado) VALUES (4, 4, 4, 'DHL', 'En proceso');
INSERT INTO detalle_envio (id_detalle_envio, id_direccion_envio, id_pedido, transportista, estado) VALUES (5, 5, 5, 'FedEx', 'En proceso');
INSERT INTO detalle_envio (id_detalle_envio, id_direccion_envio, id_pedido, transportista, estado) VALUES (6, 6, 6, 'UPS', 'En proceso');
INSERT INTO detalle_envio (id_detalle_envio, id_direccion_envio, id_pedido, transportista, estado) VALUES (7, 7, 7, 'DHL', 'En proceso');
INSERT INTO detalle_envio (id_detalle_envio, id_direccion_envio, id_pedido, transportista, estado) VALUES (8, 8, 8, 'FedEx', 'En proceso');
INSERT INTO detalle_envio (id_detalle_envio, id_direccion_envio, id_pedido, transportista, estado) VALUES (9, 9, 9, 'UPS', 'En proceso');
INSERT INTO detalle_envio (id_detalle_envio, id_direccion_envio, id_pedido, transportista, estado) VALUES (10, 10, 10, 'DHL', 'En proceso');
INSERT INTO detalle_envio (id_detalle_envio, id_direccion_envio, id_pedido, transportista, estado) VALUES (11, 11, 11, 'FedEx', 'En proceso');
INSERT INTO detalle_envio (id_detalle_envio, id_direccion_envio, id_pedido, transportista, estado) VALUES (12, 12, 12, 'UPS', 'En proceso');
INSERT INTO detalle_envio (id_detalle_envio, id_direccion_envio, id_pedido, transportista, estado) VALUES (13, 13, 13, 'DHL', 'En proceso');
INSERT INTO detalle_envio (id_detalle_envio, id_direccion_envio, id_pedido, transportista, estado) VALUES (14, 14, 14, 'FedEx', 'En proceso');
INSERT INTO detalle_envio (id_detalle_envio, id_direccion_envio, id_pedido, transportista, estado) VALUES (15, 15, 15, 'UPS', 'En proceso');

-- Insertar datos en la tabla pago
INSERT INTO pago (id_pago, id_pedido, id_metodo_pago, monto, fechas_pago) VALUES (1, 1, 1, 1999.98, SYSTIMESTAMP);
INSERT INTO pago (id_pago, id_pedido, id_metodo_pago, monto, fechas_pago) VALUES (2, 2, 2, 59.97, SYSTIMESTAMP);
INSERT INTO pago (id_pago, id_pedido, id_metodo_pago, monto, fechas_pago) VALUES (3, 3, 3, 499.99, SYSTIMESTAMP);
INSERT INTO pago (id_pago, id_pedido, id_metodo_pago, monto, fechas_pago) VALUES (4, 4, 4, 59.98, SYSTIMESTAMP);
INSERT INTO pago (id_pago, id_pedido, id_metodo_pago, monto, fechas_pago) VALUES (5, 5, 5, 49.99, SYSTIMESTAMP);
INSERT INTO pago (id_pago, id_pedido, id_metodo_pago, monto, fechas_pago) VALUES (6, 6, 6, 29.97, SYSTIMESTAMP);
INSERT INTO pago (id_pago, id_pedido, id_metodo_pago, monto, fechas_pago) VALUES (7, 7, 7, 29.98, SYSTIMESTAMP);
INSERT INTO pago (id_pago, id_pedido, id_metodo_pago, monto, fechas_pago) VALUES (8, 8, 8, 19.99, SYSTIMESTAMP);
INSERT INTO pago (id_pago, id_pedido, id_metodo_pago, monto, fechas_pago) VALUES (9, 9, 9, 59.98, SYSTIMESTAMP);
INSERT INTO pago (id_pago, id_pedido, id_metodo_pago, monto, fechas_pago) VALUES (10, 10, 10, 14.99, SYSTIMESTAMP);
INSERT INTO pago (id_pago, id_pedido, id_metodo_pago, monto, fechas_pago) VALUES (11, 11, 11, 59.98, SYSTIMESTAMP);
INSERT INTO pago (id_pago, id_pedido, id_metodo_pago, monto, fechas_pago) VALUES (12, 12, 12, 799.99, SYSTIMESTAMP);
INSERT INTO pago (id_pago, id_pedido, id_metodo_pago, monto, fechas_pago) VALUES (13, 13, 13, 199.98, SYSTIMESTAMP);
INSERT INTO pago (id_pago, id_pedido, id_metodo_pago, monto, fechas_pago) VALUES (14, 14, 14, 29.99, SYSTIMESTAMP);
INSERT INTO pago (id_pago, id_pedido, id_metodo_pago, monto, fechas_pago) VALUES (15, 15, 15, 29.97, SYSTIMESTAMP);

--INSERTANDO TRIGGERS A MIS TABLAS:
    
   -- Crear secuencias necesarias
CREATE SEQUENCE notificacion_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE pago_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE reseña_producto_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE descuento_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE detalle_envio_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE devolucion_seq START WITH 1 INCREMENT BY 1;

-- Trigger para actualizar la fecha de actualización en la tabla `usuario`
CREATE OR REPLACE TRIGGER trg_actualizar_fecha_usuario
BEFORE UPDATE ON usuario
FOR EACH ROW
BEGIN
    :NEW.fecha_actualizacion := SYSDATE;
END;
/

-- Trigger para insertar un registro en la tabla `notificacion` cuando se crea un nuevo pedido
CREATE OR REPLACE TRIGGER trg_insertar_notificacion_pedido
AFTER INSERT ON pedido
FOR EACH ROW
BEGIN
    INSERT INTO notificacion (id_notificacion, id_pedido, mensaje, leido)
    VALUES (notificacion_seq.NEXTVAL, :NEW.id_pedido, 'Su pedido ha sido recibido', 0);
END;
/

-- Trigger para validar que el estado del pedido sea uno de los valores permitidos
CREATE OR REPLACE TRIGGER trg_validar_estado_pedido
BEFORE INSERT OR UPDATE ON pedido
FOR EACH ROW
BEGIN
    IF :NEW.estado NOT IN ('En proceso', 'Enviado', 'Entregado', 'Cancelado') THEN
        RAISE_APPLICATION_ERROR(-20001, 'Estado de pedido no válido');
    END IF;
END;
/

-- Trigger para actualizar la fecha de actualización en la tabla `producto`
CREATE OR REPLACE TRIGGER trg_actualizar_fecha_producto
BEFORE UPDATE ON producto
FOR EACH ROW
BEGIN
    :NEW.fecha_actualizacion := SYSDATE;
END;
/

-- Trigger para insertar un registro en la tabla `pago` cuando se crea un nuevo pedido
CREATE OR REPLACE TRIGGER trg_insertar_pago_pedido
AFTER INSERT ON pedido
FOR EACH ROW
BEGIN
    INSERT INTO pago (id_pago, id_pedido, id_metodo_pago, monto, fechas_pago)
    VALUES (pago_seq.NEXTVAL, :NEW.id_pedido, 1, 0, SYSTIMESTAMP);
END;
/

-- Trigger para validar que el precio del producto no sea negativo
CREATE OR REPLACE TRIGGER trg_validar_precio_producto
BEFORE INSERT OR UPDATE ON producto
FOR EACH ROW
BEGIN
    IF :NEW.precio < 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'El precio del producto no puede ser negativo');
    END IF;
END;
/

-- Trigger para actualizar la fecha de actualización en la tabla `categorias`
CREATE OR REPLACE TRIGGER trg_actualizar_fecha_categorias
BEFORE UPDATE ON categorias
FOR EACH ROW
BEGIN
    :NEW.fecha_actualizacion := SYSDATE;
END;
/

-- Trigger para insertar un registro en la tabla `reseña_producto` cuando se crea un nuevo pedido
CREATE OR REPLACE TRIGGER trg_insertar_reseña_pedido
AFTER INSERT ON pedido
FOR EACH ROW
BEGIN
    INSERT INTO reseña_producto (id_reseña_producto, id_usuario, id_producto, calificacion, comentario)
    VALUES (reseña_producto_seq.NEXTVAL, :NEW.id_usuario, 1, 5, 'Reseña automática');
END;
/

-- Trigger para validar que la calificación de la reseña esté en el rango permitido
CREATE OR REPLACE TRIGGER trg_validar_calificacion_reseña
BEFORE INSERT OR UPDATE ON reseña_producto
FOR EACH ROW
BEGIN
    IF :NEW.calificacion NOT BETWEEN 1 AND 5 THEN
        RAISE_APPLICATION_ERROR(-20003, 'La calificación debe estar entre 1 y 5');
    END IF;
END;
/

-- Trigger para actualizar la fecha de actualización en la tabla `ofertas_especiales`
CREATE OR REPLACE TRIGGER trg_actualizar_fecha_ofertas_especiales
BEFORE UPDATE ON ofertas_especiales
FOR EACH ROW
BEGIN
    :NEW.fecha_final := SYSDATE;
END;
/

-- Trigger para insertar un registro en la tabla `descuento` cuando se crea una nueva oferta especial
CREATE OR REPLACE TRIGGER trg_insertar_descuento_oferta
AFTER INSERT ON ofertas_especiales
FOR EACH ROW
BEGIN
    INSERT INTO descuento (id_descuento, id_ofertas_especiales, id_cupon_descuento, descripcion, descuento_porcentaje)
    VALUES (descuento_seq.NEXTVAL, :NEW.id_ofertas_especiales, 1, 'Descuento automático', 10.00);
END;
/

-- Trigger para validar que el descuento porcentaje esté en el rango permitido
CREATE OR REPLACE TRIGGER trg_validar_descuento_porcentaje
BEFORE INSERT OR UPDATE ON descuento
FOR EACH ROW
BEGIN
    IF :NEW.descuento_porcentaje NOT BETWEEN 0 AND 100 THEN
        RAISE_APPLICATION_ERROR(-20004, 'El descuento porcentaje debe estar entre 0 y 100');
    END IF;
END;
/

-- Trigger para actualizar la fecha de actualización en la tabla `metodo_pago`
CREATE OR REPLACE TRIGGER trg_actualizar_fecha_metodo_pago
BEFORE UPDATE ON metodo_pago
FOR EACH ROW
BEGIN
    :NEW.fecha_actualizacion := SYSDATE;
END;
/

-- Trigger para insertar un registro en la tabla `detalle_envio` cuando se crea una nueva dirección de envío
CREATE OR REPLACE TRIGGER trg_insertar_detalle_envio
AFTER INSERT ON direccion_envio
FOR EACH ROW
BEGIN
    INSERT INTO detalle_envio (id_detalle_envio, id_direccion_envio, id_pedido, transportista, estado)
    VALUES (detalle_envio_seq.NEXTVAL, :NEW.id_direccion_envio, :NEW.id_pedido, 'DHL', 'En proceso');
END;
/

-- Trigger para validar que el estado del detalle de envío sea uno de los valores permitidos
CREATE OR REPLACE TRIGGER trg_validar_estado_detalle_envio
BEFORE INSERT OR UPDATE ON detalle_envio
FOR EACH ROW
BEGIN
    IF :NEW.estado NOT IN ('En proceso', 'Enviado', 'Entregado', 'Cancelado') THEN
        RAISE_APPLICATION_ERROR(-20005, 'Estado del detalle de envío no válido');
    END IF;
END;
/

-- Trigger para actualizar la fecha de actualización en la tabla `cupon_descuento`
CREATE OR REPLACE TRIGGER trg_actualizar_fecha_cupon_descuento
BEFORE UPDATE ON cupon_descuento
FOR EACH ROW
BEGIN
    :NEW.fecha_actualizacion := SYSDATE;
END;
/

-- Trigger para insertar un registro en la tabla `devolucion` cuando se crea un nuevo detalle de pedido
CREATE OR REPLACE TRIGGER trg_insertar_devolucion_detalle_pedido
AFTER INSERT ON detalle_pedido
FOR EACH ROW
BEGIN
    INSERT INTO devolucion (id_devolucion, id_pedido, id_detalle_pedido, motivo_devolucion, fecha_devolucion, estado)
    VALUES (devolucion_seq.NEXTVAL, :NEW.id_pedido, :NEW.id_detalle_pedido, 'Producto defectuoso', SYSTIMESTAMP, 'En proceso');
END;
/

-- Trigger para validar que el estado de la devolución sea uno de los valores permitidos
CREATE OR REPLACE TRIGGER trg_validar_estado_devolucion
BEFORE INSERT OR UPDATE ON devolucion
FOR EACH ROW
BEGIN
    IF :NEW.estado NOT IN ('En proceso', 'Aceptado', 'Rechazado') THEN
        RAISE_APPLICATION_ERROR(-20006, 'Estado de la devolución no válido');
    END IF;
END;
/