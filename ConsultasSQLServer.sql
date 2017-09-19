CREATE DATABASE consultasSQLServer;
USE consultasSQLServer;

CREATE TABLE libros  
(
	codigo int identity,
	titulo varchar(40),
	autor varchar(40),
	editorial varchar(15),
	precio float
);

CREATE TABLE visitantes
(
	cantidad int identity,
	ciudad varchar(40),
	sexo varchar(40)
);

DROP TABLE libros,visitantes;


/*ALTERAR COLUMNAS*/

/*Agregar LLAVES PRIMARIA*/
/*TABLA LIBROS*/
ALTER TABLE libros
ADD PRIMARY KEY(codigo); 

/*TABLA VISITANTES*/
ALTER TABLE visitantes
ADD PRIMARY KEY(cantidad);


/*AGREGAR un campo a tabla*/
ALTER TABLE visitantes
ADD prueba varchar(20);

/*BORRAR campo a tabla*/
ALTER TABLE visitantes DROP COLUMN prueba; 

/*Cambiar el tipo de dato de la columna*/
ALTER TABLE visitantes ALTER COLUMN prueba varchar(10);  

/*Alterar FK(si la hubiera) */
ALTER TABLE VENTAS
ADD FOREIGN KEY (id_Cliente)/*LLAVE DE VENTAS*/ REFERENCES CLIENTES(id_Cliente)/*LLAVE DE CLIENTES*/;

/*Llenado de visitantes*/
INSERT INTO visitantes(ciudad,sexo) values('tepic','m');
INSERT INTO visitantes(ciudad,sexo) values('gdl','m');
INSERT INTO visitantes(ciudad,sexo) values('gua','f');



/*Llenado de datos libros*/
INSERT INTO libros (titulo,autor,editorial,precio) values('la vuelta al mundo','julio verne','planeta',45.5);
INSERT INTO libros (titulo,autor,editorial,precio) values('pulgarcito','simon','alfa',45.5);
INSERT INTO libros (titulo,autor,editorial,precio) values('it','steve','Viking Press',288.5);
INSERT INTO libros (titulo,autor,editorial,precio) values('historias macabras','lovecraft','lob',320.20);
INSERT INTO libros (titulo,autor,editorial,precio) values('pulpo','lovecraft','lob',320.20);

/*Operadores LOGICOS*/
SELECT *FROM libros where autor='simon' OR editorial='lob';
SELECT *FROM libros where autor='steve' AND editorial='Viking Press';

/*Operadores Relaciónales*/
SELECT * FROM libros WHERE precio<>45.5 AND precio>320;
SELECT * FROM libros WHERE precio BETWEEN 40 AND 288.5 ;

/*IN (se utiliza para averiguar si el valor de un campo esta incluido en una lsita de valores espesifica)*/

/*CON OPERADORES LOGICOS*/
SELECT * FROM libros WHERE autor='simon' OR autor='steve';

/*CON IN*/
SELECT *FROM libros WHERE autor IN('simon','steve');

/*NOT IN
OJO LOS VALORES NULL NO SE CONSIDERAN
*/
SELECT *FROM libros WHERE autor NOT IN('simon','steve');

/*TOP cantidad limitada de registros*/
SELECT TOP 2 * from libros;

/*LIKE (Son operadores de comparación que señalan igualdad o diferencia*/
/*El % reemplaza cualquier cantidad de caracteres */
SELECT * FROM libros WHERE autor LIKE '%Simon%';

/*Like%*/
/*Indica que el titulo debe tener como primera letra la L, luego cualquier cantidad de caracteres*/
/*Todo los libros que SI COMIENZAN CON L*/
SELECT * FROM libros WHERE autor LIKE 'L%';
/*Todos los libros que NO COMIENZAN CON L*/
SELECT * FROM libros WHERE autor NOT LIKE 'L%';

/*Like, autocompletado de busqueda*/
/* el "_" actua como comodin busca coincidencia que le siga despues de: */
SELECT * FROM libros WHERE autor LIKE '%lovecraf_';

/*Libros cuya editorial comienza con las letras "v" e "i"*/
SELECT titulo,autor,editorial FROM libros WHERE editorial LIKE '[p-l]%';

/*Count()-CONTAR REGISTROS */
/*Count(*)->Cuenta Registros incluyendo los nulos*/
/*Count(campo)->Cuenta registros sin contar los nulos*/

/*Cuenta la cantidad de registros en tabla INCLUYENDO NULL*/
SELECT count(*) FROM libros;
/*Cantidad de libros de la editorial "Lob"*/
SELECT count(*) FROM libros WHERE editorial='lob';
/*Retorna la cantidad de registrosque tiene ese precio */
SELECT precio, count(precio) as 'numero de precios' FROM libros GROUP BY precio;

/*FUNCIONES DE AGRUPAMIENTO*/
/*suma de precios de todos los libros*/
SELECT sum(precio) from libros;
/*EL libro con mayor precio*/
SELECT max(precio) from libros;
/*Promedio del precio del libro pulpo*/
SELECT avg(precio) from libros WHERE titulo like '%pulpo%';

/*Ordenamiento de registros (Order By)
ordenados por algun campo en espesifico
Por defecto Ordena de manera ASCENDENTE(MENOR A MAYOR)
*/ 
SELECT * FROM libros Order by precio;
SELECT titulo,autor,precio FROM libros Order by 3;
/*Descendente*/
SELECT * FROM libros ORDER BY editorial DESC;
/*Ascendente*/
SELECT * FROM libros ORDER BY editorial ASC;
/*Ordenar por varios campos*/
SELECT * FROM libros ORDER BY titulo ASC, autor DESC;
SELECT * FROM libros ORDER BY titulo ASC, autor ASC, editorial ASC, precio DESC;
/*muestra nombre de editorial y cuenta la cantidad agrupada de los registros por el campo 'editorial'*/
SELECT editorial, count(*) FROM libros GROUP BY editorial;
/*Cantidad de libros agrupados por editorial SOLO grupos mayores a 2 */
SELECT editorial,count(*) FROM libros GROUP BY editorial HAVING count(*)>1;
/*Promedio de precios de libros agrupados por editorial
cuyo promedio suepre los 25 pesos.
*/
select editorial, avg(precio) FROM libros GROUP BY editorial HAVING avg(precio)>25; 

/*Cantidad de libros, sin considerar los que tienen precio nulo,
deben estar agrupados por editorial, sin considerar la editorial "planeta"*/
SELECT editorial, count(*) FROM libros
							WHERE precio IS NOT NULL
							GROUP BY editorial
							HAVING editorial<>'planeta';

/*Promedio de precios agrupados por editorial, de aquellas editoriales que tienen 
mas de dos libros*/
SELECT editorial, avg(precio) FROM libros
							GROUP BY editorial
							HAVING count(*)>2;
/*Mayor valor de libros agrupados y ordenados por editorial
  Seleccionar las filas que tengan un valor menor a 100 y mayor a 30*/

  SELECT editorial,max(precio) AS 'mayor'
				   FROM libros
				   GROUP BY editorial
				   HAVING min(precio)<100 AND
				   min(precio)>30
				   ORDER BY editorial;

/*ROLLUP (Agrega registros extras al resultado de una consulta)
Muestra totales de por ciudad y sexo y produce tantas filas extras como valores
existen del primer campo por el que se agrupo("ciudad" en este caso)
*/
SELECT ciudad,sexo,count(*) as Cantidad
							FROM visitantes
							GROUP BY ciudad,sexo
							WITH rollup;




/*MANEJO DE REGISTROS*/

/*Actualizar Registros*/
UPDATE libros SET autor='pintado' where editorial='alfa';  

/*Borra pero el identity sigue avanzando*/
DELETE FROM libros;
/*Borra y reinicia el identity*/
TRUNCATE TABLE libros;

SELECT * FROM libros;
SELECT * FROM visitantes;


/*BASE DE DATOS TIENDA
Esta base de datos contiene 4 TABLAS
	*Clientes
	*Productos
	*Ventas
	*Fechas

ADEMAS SE RELACIONARAN CON LLAVES FORANEAS 
DIAGRAMA ESTA EN: 
http://4.bp.blogspot.com/-NaOgnGNr1Dw/U-FHYhVM0gI/AAAAAAAAAMo/J7vUW4Nwe1g/s1600/ejemplo.JPG
http://somossistemas.blogspot.mx/2014/08/crear-tablas-con-llave-primaria-y.html
*/

/*Creacion de tablas*/
CREATE TABLE CLIENTES
( id_Cliente char(8) primary key,
NombreCliente varchar(max)
);

CREATE TABLE PRODUCTOS
( id_Producto char(8) primary key,
Rubro varchar(20),
Tipo varchar(20),
NombreProducto varchar(max)
);

CREATE TABLE FECHAS
( id_Fecha char(8) primary key,
Anio varchar(5),
Trimestre nvarchar(20),
Mes int,
Dia int
);


/*CREACION DE TABLA VENTAS */
CREATE TABLE VENTAS
( id_Cliente char(8) not null,
id_Producto char(8) not null,
id_Fecha char(8) not null,
importeTotal float,
Utilidad float
)




/*Crear LLAVES FORANEAS*/
ALTER TABLE VENTAS
ADD CONSTRAINT fk_Cliente FOREIGN KEY (id_Cliente) REFERENCES CLIENTES (id_Cliente);

ALTER TABLE VENTAS
ADD CONSTRAINT fk_Producto FOREIGN KEY (id_Producto) REFERENCES PRODUCTOS (id_Producto);

ALTER TABLE VENTAS 
ADD CONSTRAINT fk_Cliente2 FOREIGN KEY (id_Fecha) REFERENCES FECHAS (id_Fecha);

/*Borrar FK*/
ALTER TABLE Orders
DROP FOREIGN KEY FK_PersonOrder;

/*BORRAR TABLA*/
DROP TABLE CLIENTES,PRODUCTOS,FECHAS;






