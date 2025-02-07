with Ada.Text_IO;
use Ada.Text_IO;

--Los paquetes nos permiten definir un tipo de dato para un manejo mas personalizado
--En este caso para hacer conversion a texto (es necesario usarlo)
--El uso nos permite implementar la funcion put() y nos ahorra el uso de "image"
--image se usa para un casting a string
--En los decimales con "Aft" determinamos los decimales y con "Exp" aplicamos o no la notacion cientifica
procedure paquetes is
package ES_int is new Ada.Text_IO.Integer_IO(Integer);
package ES_float is new Ada.Text_IO.Float_IO(FLoat); 
numero:Integer:=10;
flotante:FLoat:=5.5;
use ES_float , ES_int;
begin
put_line("Es un numero: " & Integer'image(numero));
put(flotante, Aft => 2, Exp=>0);
put(numero);
end paquetes;