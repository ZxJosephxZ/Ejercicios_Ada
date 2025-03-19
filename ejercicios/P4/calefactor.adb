-- Paquete Calefactor
with Horno;
package body Calefactor is
   procedure Escribir (la_Potencia: Potencias) is
   begin
      Horno.Escribir(la_Potencia);
   end Escribir;
end Calefactor;
