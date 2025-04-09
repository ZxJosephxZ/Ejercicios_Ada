with Horno;

package body Calefactor is
   -- Procedimiento para escribir la potencia al calefactor
   procedure Escribir (P: Potencias) is
   begin
      -- Llama al procedimiento de Horno para establecer la potencia
      Horno.Escribir(Horno.Potencias(P));
   end Escribir;
end Calefactor;

