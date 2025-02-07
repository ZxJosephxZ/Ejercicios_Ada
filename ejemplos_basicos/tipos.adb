--Como su nombre lo dice type nos permite declarar nuevos tipos de datos
with Ada.Text_IO;
use Ada.Text_IO;

procedure tipos is
type Rango is range 0 .. 150;--sera un entro de 0 a 150
type Color is (rojo, verde, azul);--puedes asignarle solo esos 3 colores
subtype Entero is Integer range 1 .. 10;-- al usar subtype creo el tipo de dato entero de tipo integer pero limitado
edad: Rango:=25;
reales:Entero:=2;
colores:Color:=rojo;
begin
put_line( Integer'Image(reales) & Color'Image(colores) & Rango'Image(edad));
end tipos;