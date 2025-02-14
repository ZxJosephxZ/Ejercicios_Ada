package body genericos is
procedure intercambiar(A,B:in out dato) is
temp:dato;
begin
temp:=A;
A:=B;
B:=temp;
end intercambiar;

end genericos;