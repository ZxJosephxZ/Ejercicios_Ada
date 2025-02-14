package estados1 is
type Cuenta is private;--No se pueden ingresar a sus datos internos
function devolver(C: out Cuenta) return Integer;
private
type Cuenta is record
Saldo:Integer;
end record;
end estados1;