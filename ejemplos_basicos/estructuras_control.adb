with Ada.Text_IO;
use Ada.Text_IO;
with GNAT.Table;
--Se vera el uso de if,elsif,else, case(switch)
procedure estructuras_control is
I:Integer:=10;
begin
if I < 5 then
   Put_Line ( Integer'Image(I) &" es menor que 5");
elsif I > 5 then
   Put_Line ( Integer'Image(I) &" es mayor que 5");
else
   Put_Line (Integer'Image(I));
end if;

case I is
   when 8 => Put_Line ("El numero es 8");
   when 9 => Put_Line ("El numero es 9");
   when 10 => Put_Line ("El numero es 10");
   when others => Put_Line ("default");
end case;


end estructuras_control;