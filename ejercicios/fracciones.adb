with Ada.Text_IO;
use Ada.Text_IO;

package body fraccion is
   function "+" (X,Y: fraccion_t) return fraccion_t is
      Num : Integer := X.Num * Y.Den + Y.Num * X.Den;
      Den : Positive := X.Den * Y.Den;
   begin
      return Simplificar ((Num, Den));
   end "+";

   function "-" (X:fraccion_t) return fraccion_t is
   begin
      return (Num => -X.Num, Den => X.Den);
   end "-";

   function "-" (X,Y:fraccion_t) return fraccion_t is
   begin
      return X + (-Y);
   end "-";

   function "/" (X,Y: fraccion_t) return fraccion_t is
   begin
      return Simplificar ((Num => X.Num * Y.Den, Den => X.Den * Y.Den));
   end "/";

   function "/" (X,Y: Integer) return fraccion_t is
   begin
      return Simplificar ((Num => X, Den => abs(Y)));
   end "/";

   function "*" (X,Y:fraccion_t) return fraccion_t is
   begin
   end "*";

   function "=" (X,Y: fraccion_t) return fraccion_t is
   begin
   end "=";

   procedure Leer(F:out fraccion_t) is
   begin
   end Leer;

   procedure Escribir(F: fraccion_t) is
   begin
   end Escribir;

   function Numerador (F: fraccion_t) return Integer is
   begin
   end Numerador;

   function Denominador(F:fraccion_t) return Positive is
   begin
   end Denominador;

   function MCD(A, B: Integer) return Integer is
      X: Integer := abs(A);
      Y: Integer := abs(B);
      Temp : Integer;
      begin
         while Y/= 0 loop
            Temp := Y;
            Y := X mod Y;
            X := Temp;
         end loop;
         return X;
   end MCD;

   function Simplificar(F: fraccion_t) return fraccion_t is
      M: Integer := MCD(F.Num, F.Den);
   begin
      return (Num => F.Num / M, Den => F.Den / M);
   end Simplificar;
end fraccion;