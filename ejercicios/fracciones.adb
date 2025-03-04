with Ada.Text_IO;
with Ada.Integer_Text_IO;
with fracciones;
use Ada.Text_IO;
use Ada.Integer_Text_IO;


package body fracciones is

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

   function "+" (X,Y: fraccion_t) return fraccion_t is
      Num : Integer := X.Num * Y.Den + Y.Num * X.Den;
      Den : Positive := X.Den * Y.Den;
   begin
      return Simplificar ((Num, Den));
   end "+";

   function "-" (X: fraccion_t) return fraccion_t is
   begin
      return (Num => -X.Num, Den => X.Den);
   end "-";

   function "-" (X,Y:fraccion_t) return fraccion_t is
   begin
      return X + (-Y);
   end "-";

function "/" (X, Y: fraccion_t) return fraccion_t is
    Resultado: fraccion_t;
begin
    if Y.Num = 0 then
        raise Constraint_Error with "No se puede dividir entre cero";
    end if;

    if Y.Num < 0 then
        Resultado := (Num => (-X.Num) * Y.Den, Den => X.Den * (-Y.Num));
    else
        Resultado := (Num => X.Num * Y.Den, Den => X.Den * Y.Num);
    end if;

    return Simplificar(Resultado);
end "/";

   function "/" (X,Y: Integer) return fraccion_t is
      Num,Den : Integer;
   begin
      Num := X;
      Den := Y;
      if Den < 0 then
        Num := -Num;
        Den := -Den;  -- Hacemos que el denominador sea positivo y ajustamos el signo del numerador
      end if;
      return Simplificar((Num, Den));
   end "/";

   function "*" (X,Y:fraccion_t) return fraccion_t is
   begin
      return Simplificar ((Num => X.Num * Y.Num, Den => X.Den * Y.Den));
   end "*";

   function "=" (X,Y: fraccion_t) return Boolean is
      SX: fraccion_t := Simplificar (X);
      SY: fraccion_t := Simplificar (Y);
   begin
      return (SX.Num = SY.Num) and (SX.Den = SY.Den);
   end "=";

   procedure Leer(F:out fraccion_t) is
      Num, Den:Integer;
   begin
      Put("Ingrese el numerador:");
      Get(Num);
      loop
         Put("Ingrese el denominador (positivo): ");
         Get(Den);
         exit when Den > 0;
         Put_Line ("El denominador debe ser positivo");
      end loop;
      F := Simplificar((Num,Den));
   end Leer;

   procedure Escribir(F: fraccion_t) is
   begin
      Put(Integer'Image(F.Num) & "/" & Integer'Image(F.Den));
      New_Line;
   end Escribir;

   function Numerador (F: fraccion_t) return Integer is
   begin
      return F.Num;
   end Numerador;

   function Denominador(F:fraccion_t) return Positive is
   begin
      return F.Den;
   end Denominador;


end fracciones;