--Type nos permite dentro de un tipo de dato limitar sus caracteristicas
--En caso de querer crear un nuevo tipo de dato se debe usar la palabra "new"
--Ejemplo type nuevo is new float; Ada en este caso por mas que el tipo de dato es float, lo tomara como un dato diferente a los otros float.
with Ada.Text_IO;
use Ada.Text_IO;

procedure tipos is
--En este caso no se crea un nuevo tipo sino se da un alias limitando un tipo de dato
type Rango is range 0 .. 150;--sera un entro de 0 a 150
type Color is (rojo, verde, azul);--puedes asignarle solo esos 3 colores
subtype Entero is Integer range 1 .. 10;-- al usar subtype creo el tipo de dato entero de tipo integer pero limitado (alias)
edad: Rango:=25;
reales:Entero:=2;
colores:Color:=rojo;
begin
put_line( Integer'Image(reales) & Color'Image(colores) & Rango'Image(edad));
end tipos;