with Ada.Text_IO;
with genericos;
use genericos;
use Ada.Text_IO;
procedure main is
X:Integer:=10;
Y:Integer:=9;
procedure intercambiar_integer is new intercambiar(Integer);
begin
intercambiar_integer(X,Y);
Put_Line ("X:" & Integer'Image(X) & "Y:" & Integer'Image(Y));
end main;