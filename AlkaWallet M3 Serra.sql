

/*CONSIDERACIONES PREVIAS

Si bien los atributos exigidos para crear nuestra tabla usuarios son los siguientes:

user_id (clave primaria)
nombre
correo electrónico
contraseña
saldo.

En una de las consultas que debemos hacer se nos solicita lo siguiente:

"Consulta para obtener el nombre de la moneda elegida por un usuario específico"

Por lo tanto, tenemos que hacer una relación entre moneda y usuario.
Ante lo cual, yo decidi añadir la columna usermoneda_id a la tabla usuario en la que se 
especifique a través de una fk, cual es la moneda escogida por este.
*/

Create DATABASE AlkaWallet;

USE AlkaWallet;

CREATE TABLE MONEDA (
currency_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
currency_name VARCHAR (25),
currency_symbol VARCHAR (25)
);

Create table Usuario(
user_id INT Primary Key auto_increment, 
Nombre VARCHAR(255), 
CorreoElectronico VARCHAR(255), 
Clave VARCHAR(255), 
Saldo DECIMAL(10,2),
UserMoneda_id INT NOT NULL,
FOREIGN KEY (UserMoneda_id) REFERENCES Moneda(currency_id)
);

CREATE TABLE TRANSACCION (
transaction_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
sender_user_id INT NOT NULL,
receiver_user_id INT NOT NULL,
importe DECIMAL (10,2) CHECK (importe > 0),
transaction_date DATE,
FOREIGN KEY (sender_user_id) REFERENCES Usuario(user_id),
FOREIGN KEY (receiver_user_id) REFERENCES Usuario(user_id)
);

INSERT into MONEDA ( currency_name , currency_symbol) VALUES ("DOLLAR","US$");
INSERT into MONEDA ( currency_name , currency_symbol) VALUES ("PESO","CLP$");
INSERT into MONEDA ( currency_name , currency_symbol) VALUES ("EURO","€");


INSERT INTO USUARIO (Nombre, CorreoElectronico, Clave, Saldo, UserMoneda_id) VALUES ("John Perez","APACHAI@GMAIL.COM","1234", "1000000", "1");
INSERT INTO USUARIO (Nombre, CorreoElectronico, Clave, Saldo, UserMoneda_id) VALUES ("Leonardo Tellez","LEOT@GMAIL.COM","1234", "2000000", "2");
INSERT INTO USUARIO (Nombre, CorreoElectronico, Clave, Saldo, UserMoneda_id) VALUES ("Marlen Mena","ACAPACHAI@GMAIL.COM","1234", "3000000", "3");


INSERT INTO TRANSACCION (sender_user_id, receiver_user_id, importe, transaction_date) VALUES ("1","2","100000", "1995-01-29");
INSERT INTO TRANSACCION (sender_user_id, receiver_user_id, importe, transaction_date) VALUES ("1","1","200000", "1998-01-29");
INSERT INTO TRANSACCION (sender_user_id, receiver_user_id, importe, transaction_date) VALUES ("2","3","300000", "2015-01-29");


//Revisar inserciones
select * from usuario;
select * from TRANSACCION;
select * from MONEDA;

//Saber el nombre de la moneda escogida por un usuario
select currency_name from Moneda where currency_id in 
(select UserMoneda_id from Usuario where user_id=2);

//Mostrar todas las transacciones
Select * from  TRANSACCION;

//Mostrar las transacciones de un usuario expecifico
Select * from TRANSACCION Where sender_user_id ="1" or receiver_user_id = "1";

//Cambiar el correo electronico de un usuario
UPDATE USUARIO SET CorreoElectronico = "CAMBIO2@GMAIL.COM" WHERE user_id = '1';

//Revisar cambio de correo electronico
select * from usuario WHERE user_id = '1';

//Eliminar la fila completa de una transaccion
DELETE FROM TRANSACCION WHERE transaction_id = "1";

//Revisar la eliminación de una fila
select * from TRANSACCION;