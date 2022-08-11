unit memoriaSecundaria;

{$mode ObjFPC}{$H+}

interface
uses
  tipos,crt;


Const
Ruta = 'C:\Users\Usuario\OneDrive\UTN\Cursadas\Paradigmas\Evaluacion inicial\proyecto-grupal\Desktop2\eventos 2022\archivo\archivo.dat'; // editar esto pora que funcione en local.

Type

//t_lista = file of tdato;

claseLista = object
    arch: file of tdato;

    procedure insertar(elemento:tdato);
    function fin():byte;
    function devolver_elemento(pos:byte):tdato;
    procedure modificar (pos:byte; x:tdato);
    PROCEDURE abrir();
    FUNCTION  baja (buscado:byte):boolean;
    PROCEDURE buscar_por_tipo(buscado:string;var elemento:tdato;var control:boolean;var pos:byte);
    PROCEDURE coincideSiguiente(buscado:String;var elementoActual:tdato;var control:boolean;var pos:byte);
    procedure cerrar();
end;

// Manejo de lista implementada en archivo
//Procedure abrir(var arch:t_lista);
//Procedure cerrar(var arch:t_lista);
//procedure insertar(var arch:t_lista; x:tdato);
//procedure modificar (var arch:t_lista; pos:byte; x:tdato);
//procedure devolver_elemento(var arch:t_lista; pos:byte; var x:tdato);
//function  fin(var arch:t_lista):byte;
//function  tamanio(var arch:t_lista):byte;
//
//// Operaciones del dominio del problema
//function baja (var arch:t_lista; id_buscado:byte):boolean;
//FUNCTION  devolver_elemento_alta_true(var arch:t_lista; pos:byte):tdato;
//PROCEDURE buscar_por_tipo(var arch:t_lista;tipo_evento_buscado:string;var evento:tdato;var control:boolean;var pos:byte);
//procedure coincideSiguiente(var arch:t_lista;tipo_evento_buscado:String;var elementoActual:tdato;var control:boolean;var pos:byte);


implementation

Procedure claseLista.abrir();
 begin
   assign(arch,ruta);
{$I-}
reset(arch);
{$I+}
if IOResult  <> 0 then
  rewrite(arch);
 end;

Procedure claseLista.cerrar();
 begin
  close(arch);
 end;

procedure claseLista.insertar(x:tdato);
begin
     seek(arch, filesize(arch)); // inserta al final del archivo.
     write(arch, x);
end;

procedure claseLista.modificar (pos:byte; x:tdato);
begin
     seek(arch,pos);
     write(arch,x);
end;

procedure claseLista.devolver_elemento(pos:byte; var x:tdato);
begin
     seek(arch, pos);
     read(arch, x);
end;

FUNCTION claseLista.devolver_elemento_alta_true(pos:byte):tdato;
var x:tdato;
begin
     seek(arch, pos);
     read(arch, x);
     if x.alta = true then
       devolver_elemento_alta_true := x;
end;

function claseLista.baja (id_buscado:byte):boolean;  // La eliminacion es por id, entonces byte
var
i:byte;
x:tdato;
flag:boolean;
begin
   flag := false; // se usa como bandera para saber si se dio de baja algun elemento o no.
   for i:=1 to filesize(arch)-1 do
   begin
      devolver_elemento(i,x);
      if x.ID = id_buscado then
        begin
          x.alta := false;
          modificar(i,x);
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

PROCEDURE claseLista.buscar_por_tipo(tipo_evento_buscado:string;var evento:tdato;var control:boolean;var pos:byte);
var
flag:boolean;
i:byte;
x:tdato;
begin
   flag := false;
   i := 1;
   while ((i<tamanio()) and (flag <> true)) do
   begin
      devolver_elemento(i,x);
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

procedure claseLista.coincideSiguiente(tipo_evento_buscado:String;var elementoActual:tdato;var control:boolean;var pos:byte);
var i:byte;
x:tdato;
flag:boolean;
begin
   flag := false;
   if pos < tamanio() then
   begin
   i:=pos;
   while ((i<tamanio()) and (flag <> true)) do
     begin
        devolver_elemento(i,x);
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

function  claseLista.fin():byte;
begin
     fin_lista:= filesize(arch)-1;
end;

function claseLista.tamanio():byte;
begin
     tamanio:=filesize(arch);
end;

end.

