package Horno is
   -- Tipos de datos para representar temperaturas y potencias
   type Temperaturas is digits 6;
   type Potencias is digits 6;

   -- Procedimiento para establecer la potencia aplicada al calefactor
   procedure Escribir(P: Potencias);
   
   -- Procedimiento para leer la temperatura interna del horno
   procedure Leer(T: out Temperaturas);
end Horno;
