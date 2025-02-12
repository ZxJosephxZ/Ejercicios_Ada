with Ada.Text_IO;
use Ada.Text_IO;
procedure registros is
--colecciones (records) parecido a las estructuras en c
type Persona is record
   Nombre:String(1..20);
   Apellido:String(1..20);
end record;
begin
--Tambien se puede declarar todo entero
--Joseph:Persona:=(Nombre=>"",Edad=>"");
Joseph:Persona;
Joseph.Nombre:="01234567890123456789";
Put_Line (Joseph.Nombre);
Put_Line (Joseph.Apellido);
end registros;