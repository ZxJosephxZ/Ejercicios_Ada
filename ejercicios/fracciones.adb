with Ada.Text_IO; --Libreria para entrada y salida estandar
with Ada.Integer_Text_IO; --Libreria para manejo de enteros en entrada/salida
with fracciones; --Inclusion del paquete fracciones
use Ada.Text_IO;
use Ada.Integer_Text_IO;

--Implementacion del paquete fracciones
package body fracciones is
--Funcion para calcular el maximo comun divisor de dos numeros enteros
   function MCD(A, B: Integer) return Integer is
      X: Integer := abs(A); --Se toman valores absolutos
      Y: Integer := abs(B);
      Temp : Integer;
      begin
         while Y/= 0 loop --Algoritmo de euclides para calcular el maximo comun divisor
            Temp := Y;
            Y := X mod Y;
            X := Temp;
         end loop;
         return X;
   end MCD;
-- Funcion para simplificar una fraccion utilizando el MCD
   function Simplificar(F: fraccion_t) return fraccion_t is
      M: Integer := MCD(F.Num, F.Den);
   begin
      return (Num => F.Num / M, Den => F.Den / M);
   end Simplificar;

--SObrecarga de los operadores +,-,*,/
   function "+" (X,Y: fraccion_t) return fraccion_t is
      Num : Integer := X.Num * Y.Den + Y.Num * X.Den; --Se obtiene el numerador de la suma
      Den : Positive := X.Den * Y.Den; --Se obtiene el denominador de la suma
   begin
      return Simplificar ((Num, Den));
   end "+";

--Se obtiene el opuesto de una fraccion
   function "-" (X: fraccion_t) return fraccion_t is
   begin
      return (Num => -X.Num, Den => X.Den); --Se invierte el signo del numerador
   end "-";

   function "-" (X,Y:fraccion_t) return fraccion_t is
   begin
      return X + (-Y); --Se convierte la resta en una suma con el opuesto de Y
   end "-";

function "/" (X, Y: fraccion_t) return fraccion_t is
    Resultado: fraccion_t;
begin

   --En caso de que el numerador sea negativo se hace su ajuste
    if Y.Num < 0 then
        Resultado := (Num => (-X.Num) * Y.Den, Den => X.Den * (-Y.Num));
    else
        Resultado := (Num => X.Num * Y.Den, Den => X.Den * Y.Num); --Division normal de fracciones (multiplicacion cruzada)
    end if;

    return Simplificar(Resultado);
    exception --Control de la indeterminacion en fracciones
    when Constraint_Error =>
        Put_Line("Indeterminación: No se puede simplificar una fracción con denominador 0.");
        return (Num => 0, Den => 1);  -- Devuelve 0/1 para continuar la ejecución
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
      return (SX.Num = SY.Num) and (SX.Den = SY.Den); --Se compraran los valores simplificados
   end "=";

--Procedimiento para leer una fraccion desde la entrada estandar
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

--Procedimiento para imprimir una fraccion en la salida estandar
   procedure Escribir(F: fraccion_t) is
   begin
      Put(Integer'Image(F.Num) & "/" & Integer'Image(F.Den));
      New_Line;
   end Escribir;

--Obtener el numerador
   function Numerador (F: fraccion_t) return Integer is
   begin
      return F.Num;
   end Numerador;

--Obtener el denominador
   function Denominador(F:fraccion_t) return Positive is
   begin
      return F.Den;
   end Denominador;


end fracciones;