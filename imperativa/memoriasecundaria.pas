unit memoriaSecundaria;

{$mode ObjFPC}{$H+}

interface
uses
  tipos,crt;


Const
Ruta = 'C:\Users\Usuario\OneDrive\UTN\Cursadas\Paradigmas\Evaluacion inicial\proyecto-grupal\Desktop2\eventos 2022\archivo\archivo.dat'; // editar esto pora que funcione en local.

Type

t_lista = file of tdato;

// Manejo de lista implementada en archivo
Procedure abrir(var arch:t_lista);
Procedure cerrar(var arch:t_lista);
procedure insertar(var arch:t_lista; x:tdato);
procedure modificar (var arch:t_lista; pos:byte; x:tdato);
procedure devolver_elemento(var arch:t_lista; pos:byte; var x:tdato);
function  fin_lista(var arch:t_lista):byte;
function  tamanio(var arch:t_lista):byte;

// Operaciones del dominio del problema
function baja (var arch:t_lista; id_buscado:byte):boolean;
FUNCTION  devolver_elemento_alta_true(var arch:t_lista; pos:byte):tdato;
PROCEDURE buscar_por_tipo(var arch:t_lista;tipo_evento_buscado:string;var evento:tdato;var control:boolean;var pos:byte);
procedure coincideSiguiente(var arch:t_lista;tipo_evento_buscado:String;var elementoActual:tdato;var control:boolean;var pos:byte);


implementation

Procedure abrir(var arch:t_lista);
 begin
   assign(arch,ruta);
{$I-}
reset(arch);
{$I+}
if IOResult  <> 0 then
  rewrite(arch);
 end;

Procedure cerrar(var arch:t_lista);
 begin
  close(arch);
 end;

procedure insertar(var arch:t_lista; x:tdato);
begin
     seek(arch, filesize(arch)); // inserta al final del archivo.
     write(arch, x);
end;

procedure modificar (var arch:t_lista; pos:byte; x:tdato);
begin
     seek(arch,pos);
     write(arch,x);
end;

procedure devolver_elemento(var arch:t_lista; pos:byte; var x:tdato);
begin
     seek(arch, pos);
     read(arch, x);
end;

FUNCTION devolver_elemento_alta_true(var arch:t_lista; pos:byte):tdato;
var x:tdato;
begin
     seek(arch, pos);
     read(arch, x);
     if x.alta = true then
       devolver_elemento_alta_true := x;
end;

function baja (var arch:t_lista; id_buscado:byte):boolean;  // La eliminacion es por id, entonces byte
var
i:byte;
x:tdato;
flag:boolean;
begin
   flag := false; // se usa como bandera para saber si se dio de baja algun elemento o no.
   for i:=1 to filesize(arch)-1 do
   begin
      devolver_elemento(arch,i,x);
      if x.ID = id_buscado then
        begin
          x.alta := false;
          modificar(arch,i,x);
          flag:=true;
        end;
   end;

   if flag = true then
     begin
     baja:=true; // se devuelve true a la rutina donde se llamo.
     end
   else
     baja:=false;
end;

PROCEDURE buscar_por_tipo(var arch:t_lista;tipo_evento_buscado:string;var evento:tdato;var control:boolean;var pos:byte);
var
flag:boolean;
i:byte;
x:tdato;
begin
   flag := false;
   i := 1;
   while ((i<tamanio(arch)) and (flag <> true)) do
   begin
      devolver_elemento(arch,i,x);
      if x.tipo_evento = tipo_evento_buscado then
        begin
          evento := x; // le pasa el elemento que encontro (seria el primero que encuentra);
          pos := i+1; // se guarda la posicion que sigue en el archivo (para seguir leyendo luego);
          flag:=true;
        end;
      inc(i);
   end;

   if flag = true then
   begin
     control:=true; // se devuelve true a la rutina donde se llamo.
   end
   else
     control:=false;
end;

procedure coincideSiguiente(var arch:t_lista;tipo_evento_buscado:String;var elementoActual:tdato;var control:boolean;var pos:byte);
var i:byte;
x:tdato;
flag:boolean;
begin
   flag := false;
   if pos < tamanio(arch) then
   begin
   i:=pos;
   while ((i<tamanio(arch)) and (flag <> true)) do
     begin
        devolver_elemento(arch,i,x);
        if x.tipo_evento = tipo_evento_buscado then
          begin
            elementoActual := x; // le pasa el elemento que encontro;
            pos := i+1; // se guarda la posicion que sigue en el archivo (para seguir leyendo luego);
            flag:=true;
          end;
        inc(i);
     end;
   end;

   if flag = true then
   begin
     control:=true; // se devuelve true a la rutina donde se llamo.
   end
   else
     control:=false;
end;

function  fin_lista(var arch:t_lista):byte;
begin
     fin_lista:= filesize(arch)-1;
end;

function tamanio(var arch:t_lista):byte;
begin
     tamanio:=filesize(arch);
end;

end.

