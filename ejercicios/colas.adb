with Ada.Text_IO;
with Ada.Unchecked_Deallocation;
package body Colas is

   procedure Free_Node is new Ada.Unchecked_Deallocation(Nodo, ref_Nodo);

   -- Verifica si la cola está vacía
   function Esta_Vacia (La_Cola: cola_t) return Boolean is
   begin
      return La_Cola.ptr_primero = null;
   end Esta_Vacia;

   -- La cola dinámica no tiene un límite predefinido, por lo que siempre retorna False.
   function Esta_Llena (La_Cola: cola_t) return Boolean is
   begin
      return False;
   end Esta_Llena;

   -- Agregar un elemento a la cola (Poner)
   procedure Poner (el_Elemento: elemento_t; en_la_Cola: in out cola_t) is
      Nuevo_Nodo: ref_Nodo := new Nodo'(Datos => el_Elemento, ptr_Siguiente => null);
   begin
      if Esta_Vacia(en_la_Cola) then
         en_la_Cola.ptr_primero := Nuevo_Nodo;
         en_la_Cola.ptr_ultimo := Nuevo_Nodo;
      else
         en_la_Cola.ptr_ultimo.ptr_Siguiente := Nuevo_Nodo;
         en_la_Cola.ptr_ultimo := Nuevo_Nodo;
      end if;
   end Poner;

   -- Quitar un elemento de la cola
   procedure Quitar (un_Elemento: out elemento_t; de_la_Cola: in out cola_t) is
      Nodo_A_Eliminar: ref_Nodo;
   begin
      if Esta_Vacia(de_la_Cola) then
         raise Program_Error;
      else
         un_Elemento := de_la_Cola.ptr_primero.Datos;
         Nodo_A_Eliminar := de_la_Cola.ptr_primero;
         de_la_Cola.ptr_primero := de_la_Cola.ptr_primero.ptr_Siguiente;
         Free_Node(Nodo_A_Eliminar);
      end if;
   end Quitar;

   -- Mostrar todos los elementos de la cola
   procedure MostrarCola (La_Cola: cola_t) is
      Aux: ref_Nodo := La_Cola.ptr_primero;
   begin
      while Aux /= null loop
         Ada.Text_IO.Put_Line(ToString(Aux.Datos));
         Aux := Aux.ptr_Siguiente;
      end loop;
   end MostrarCola;

   -- Copiar una cola en otra
   procedure Copiar (Origen: cola_t; Destino: in out cola_t) is
      Aux: ref_Nodo := Origen.ptr_primero;
   begin
      while not Esta_Vacia(Destino) loop
         declare
            Elemento: elemento_t;
         begin
            Quitar(Elemento, Destino);
         end;
      end loop;

      while Aux /= null loop
         Poner(Aux.Datos, Destino);
         Aux := Aux.ptr_Siguiente;
      end loop;
   end Copiar;

   -- Comparar dos colas
   function "=" (La_Cola, Con_La_Cola: cola_t) return Boolean is
      Aux1: ref_Nodo := La_Cola.ptr_primero;
      Aux2: ref_Nodo := Con_La_Cola.ptr_primero;
   begin
      while (Aux1 /= null and Aux2 /= null) loop
         if Aux1.Datos /= Aux2.Datos then
            return False;
         end if;
         Aux1 := Aux1.ptr_Siguiente;
         Aux2 := Aux2.ptr_Siguiente;
      end loop;

      return Aux1 = null and Aux2 = null;
   end "=";

   -- Liberar toda la memoria de la cola
   procedure Liberar (La_Cola: in out cola_t) is
      Aux: ref_Nodo;
   begin
      while La_Cola.ptr_primero /= null loop
         Aux := La_Cola.ptr_primero;
         La_Cola.ptr_primero := La_Cola.ptr_primero.ptr_Siguiente;
         Free_Node(Aux);
      end loop;
      La_Cola.ptr_ultimo := null;
   end Liberar;

end Colas;
