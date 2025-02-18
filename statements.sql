/* Relación tipo 1:1 */
-- PASO 1
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    edad INT
);

INSERT INTO usuarios (nombre, apellido, email, edad) VALUES
('Juan', 'Gomez', 'juan.gomez@example.com', 28),
('Maria', 'Lopez', 'maria.lopez@example.com', 32),
('Carlos', 'Rodriguez', 'carlos.rodriguez@example.com', 25),
('Laura', 'Fernandez', 'laura.fernandez@example.com', 30),
('Pedro', 'Martinez', 'pedro.martinez@example.com', 22),
('Ana', 'Hernandez', 'ana.hernandez@example.com', 35),
('Miguel', 'Perez', 'miguel.perez@example.com', 28),
('Sofia', 'Garcia', 'sofia.garcia@example.com', 26),
('Javier', 'Diaz', 'javier.diaz@example.com', 31),
('Luis', 'Sanchez', 'luis.sanchez@example.com', 27);


-- PASO 2
CREATE TABLE roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL
);

INSERT INTO roles (nombre_rol) VALUES
('Bronce'),
('Plata'),
('Oro'),
('Platino');

ALTER TABLE usuarios ADD COLUMN id_rol INT;
ALTER TABLE usuarios ADD FOREIGN KEY (id_rol) REFERENCES roles(id_rol);


-- PASO 3

UPDATE usuarios SET id_rol = 1 WHERE id_usuario IN (1, 2);
UPDATE usuarios SET id_rol = 2 WHERE id_usuario IN (3, 4);
UPDATE usuarios SET id_rol = 3 WHERE id_usuario IN (5, 6);
UPDATE usuarios SET id_rol = 4 WHERE id_usuario IN (7, 8, 9, 10);

-- PASO 4
SELECT usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email, usuarios.edad, roles.nombre_rol FROM usuarios JOIN roles ON usuarios.id_rol = roles.id_rol;

/* Relación tipo 1:N */
-- PASO 1
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);

INSERT INTO categorias (nombre_categoria) VALUES
('Electrónicos'),
('Ropa y Accesorios'),
('Libros'),
('Hogar y Cocina'),
('Deportes y aire libre'),
('Salud y cuidado personal'),
('Herramientas y mejoras para el hogar'),
('Juguetes y juegos'),
('Automotriz'),
('Música y Películas');

-- PASO 2
ALTER TABLE usuarios ADD COLUMN id_categoria INT;
ALTER TABLE usuarios ADD FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria);


-- PASO 3
UPDATE usuarios SET id_categoria = 1 WHERE id_usuario IN (1, 5, 9);
UPDATE usuarios SET id_categoria = 2 WHERE id_usuario IN (2, 6, 10);
UPDATE usuarios SET id_categoria = 3 WHERE id_usuario IN (3, 7);
UPDATE usuarios SET id_categoria = 4 WHERE id_usuario IN (4, 8);


-- PASO 4
SELECT usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email, usuarios.edad, roles.nombre_rol, categorias.nombre_categoria FROM usuarios JOIN roles ON usuarios.id_rol = roles.id_rol JOIN categorias ON usuarios.id_categoria = categorias.id_categoria;

/* Relación tipo N:M */
-- PASO 1
CREATE TABLE usuarios_categorias (
    id_usuario_categoria INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_categoria INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);


-- PASO 2
INSERT INTO usuarios_categorias (id_usuario, id_categoria) VALUES
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 5),
(3, 6), (3, 7),
(4, 8), (4, 9), (4, 10);


-- PASO 3
SELECT usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email, usuarios.edad, roles.nombre_rol, categorias.nombre_categoria 
FROM usuarios
JOIN roles ON usuarios.id_rol = roles.id_rol
JOIN usuarios_categorias ON usuarios.id_usuario = usuarios_categorias.id_usuario
JOIN categorias ON usuarios_categorias.id_categoria = categorias.id_categoria;
