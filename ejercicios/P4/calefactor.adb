-- Paquete Calefactor
with Horno;
package body Calefactor is
   procedure Escribir (la_Potencia: Potencias) is
   begin
      Horno.Escribir(Horno.Potencias(la_Potencia)); -- Conversión explícita
   end Escribir;
end Calefactor;
