with Ada.Text_IO;
use Ada.Text_IO;
package body matematicas is
   function Cuadrado(X:Integer) return Integer is
   begin
      return X * X;
   end Cuadrado;

   procedure MostrarCuadrado(X:Integer) is
   begin
      put_line("El cuadrado de " & Integer'Image(X) & " es: " & Integer'Image(Cuadrado(X)));
   end MostrarCuadrado;
end matematicas;