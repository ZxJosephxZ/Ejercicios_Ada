package genericos is
--Se aplican tanto a datos como procedimientos
generic
type dato is private;
procedure intercambiar(A,B:in out dato);
end genericos;