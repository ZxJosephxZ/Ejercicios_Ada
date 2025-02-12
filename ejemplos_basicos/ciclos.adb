with Ada.Text_IO;
use Ada.Text_IO;
procedure ciclos is
I:Integer:=10;
begin
--Es un bucle que se mantiene en ejecucion mientras no se cumpla el exit
loop
Put_Line ("bucle infinito");
exit when I > 9;
end loop;
--while de toda la vida
while I < 12 loop
Put_Line (Integer'Image(I));
I:=I+1;
end loop;
--for se pasa una variable limitando un rango, tambien se puede usar para recorrer arreglos
for I in 1 .. 10 loop
   Put_Line (Integer'Image(I));
end loop;
end ciclos;