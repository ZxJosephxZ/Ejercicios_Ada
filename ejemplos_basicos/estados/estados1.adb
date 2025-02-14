with Ada.Text_IO;
use Ada.Text_IO;
package body estados1 is
function devolver(C: out Cuenta) return Integer is
begin
C.Saldo:=10;
return C.Saldo;
end devolver;
end estados1;