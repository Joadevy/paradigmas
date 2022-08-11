unit interfaz;

{$mode ObjFPC}{$H+}
interface

uses
  crt,memPrincipal,tipos;

Type

interfaz_usuario = object
  lista: claseLista;

  procedure menu;
  procedure carga();
  procedure listar();
  Procedure dar_baja();
  Procedure consulta();
end;

//procedure menu;
//procedure carga(var lista:t_lista);
//procedure listar(var lista:t_lista);
//Procedure dar_baja(var lista:t_lista);
//Procedure consulta(var lista:t_lista);

implementation
Procedure interfaz_usuario.menu;
Var
   i,respuesta:integer;
BEGIN
  lista.abrir();  // abre el archivo en caso de que este en mem secundaria, sino inicializa el vector.
  respuesta:=1;
  while (respuesta <> 0) do
  begin
    clrscr;
    textcolor(white);
    for i:=8 to 21 do                                                {columnas de |}
        begin
          gotoxy(64,i); Write('|');
          gotoxy(95,i); Write('|');
        end;
    for i:=65 to 94 do                                                  {filas de _}
        begin
          gotoxy(i,7); Write('_');
          gotoxy(i,19);Write('_');
          gotoxy(i,9); Write('-');
          gotoxy(i,21); Write('_');
        end;
    textcolor(yellow);
    gotoxy(70,8);  Write(' *** MENÚ EVENTO ***');
    gotoxy(66,10); Write('1) Registrar datos');
    gotoxy(66,11); Write('2) Mostrar datos');
    gotoxy(66,12); Write('3) Dar baja evento');
    gotoxy(66,13); Write('4) Busqueda por tipo');

    gotoxy(66,16); Write('0) Salir');
    gotoxy(66,20); Write('Respuesta: ');
    gotoxy(76,20); Readln(respuesta);
    Case respuesta of
      1:Begin
        carga();
      end;
      2:Begin
        listar();
      end;
      3:begin
        dar_baja();
      end;
      4:begin
        consulta();
      end;
    end;
  end;
  lista.cerrar(); // cierra el archivo en caso de que este en mem secundaria, sino no hace nada.
END;

// Maneja la interfaz de carga y envia los datos cargados en un registro a la lista.
procedure interfaz_usuario.carga();
var
  elemento: tdato;
  control:byte;
begin
control:= 1;
   while(control <> 0) do
   begin
     clrscr;
     Writeln('ID del evento: ');
     Readln(elemento.ID);
     Writeln('Titulo: ');
     Readln(elemento.titulo);
     Writeln('Descripcion: ');
     Readln(elemento.descripcion);
     Writeln('Tipo de evento: ');
     Readln(elemento.tipo_evento);
     IF (elemento.tipo_evento = '') THEN
     REPEAT
       WRITELN ('Ingrese tipo evento valido: ');
       READLN(elemento.tipo_evento);
     UNTIL (elemento.tipo_evento <> '');
     Writeln('Dia de inicio: ');
     readln(elemento.fecha_inicio.dia);
     Writeln('Mes de inicio: ');
     readln(elemento.fecha_inicio.mes);
     Writeln('Anio de inicio: ');
     readln(elemento.fecha_inicio.ano);
     elemento.fecha_inicio.total:=((elemento.fecha_inicio.ano-1)*365)+((elemento.fecha_inicio.mes-1)*30)+elemento.fecha_inicio.dia;
     Writeln('Dia de cierre: ');
     readln(elemento.fecha_fin.dia);
     Writeln('Mes de cierre: ');
     readln(elemento.fecha_fin.mes);
     Writeln('Anio de cierre: ');
     readln(elemento.fecha_fin.ano);
     elemento.fecha_fin.total:=((elemento.fecha_fin.ano-1)*365)+((elemento.fecha_fin.mes-1)*30)+elemento.fecha_inicio.dia;
     Writeln('Hora de inicio: ');
     Readln(elemento.hora_inicio);
     Writeln('Hora de finalizacion: ');
     Readln(elemento.hora_fin);
     Writeln('Ubicacion: ');
     Readln(elemento.ubicacion);
     elemento.alta:=true;
     lista.insertar(elemento); // Se carga el elemento ingresado en la lista.
     Write('Continua cargando? 0 para salir: ');
     read(control);
   end;
end;

// Muestra cada elemento luego de llamar para pedir el siguiente elemento.
Procedure interfaz_usuario.listar();
var
  i:byte;
  elemento:tdato;
  limite:byte;
Begin
    limite := lista.fin();
    for i:=1 to limite do
    begin
    clrscr;
      elemento.tipo_evento := ''; // Para controlar que el elemento este con alta true (ya que si o si tiene que tener algo en este campo)
      // Pide el siguiente elemento a donde sea que se guarde (en mem principal o secundaria)
      elemento := lista.devolver_elemento_alta_true(i);
      if elemento.tipo_evento <> '' then
      begin
        writeln('Elemento numero: ',i,' de la lista');
        Writeln('');
        Writeln('ID: ',elemento.ID);
        Writeln('Titulo: ',elemento.titulo);
        Writeln('Descripcion: ',elemento.descripcion);
        Writeln('Tipo de evento: ',elemento.tipo_evento);
        Writeln('Dia de inicio: ',elemento.fecha_inicio.dia);
        Writeln('Mes de inicio: ',elemento.fecha_inicio.mes);
        Writeln('Anio de inicio: ',elemento.fecha_inicio.ano);
        Writeln('Dia de cierre: ',elemento.fecha_fin.dia);
        Writeln('Mes de cierre: ',elemento.fecha_fin.mes);
        Writeln('Anio de cierre: ',elemento.fecha_fin.ano);
        Writeln('Hora de inicio: ',elemento.hora_inicio);
        Writeln('Hora de fin: ',elemento.hora_fin);
        Writeln('Ubicacion: ',elemento.ubicacion);
        Writeln('Alta ',elemento.alta);
        Writeln('');
        Write('Presione una tecla para mostrar el siguiente elemento ');
        readkey;
      end;
    end;
end;

Procedure interfaz_usuario.dar_baja();
var
  buscado:byte;
  resp:char;
  control:boolean;
begin
  clrscr;
  write('Ingrese ID a buscar: ');
  readln (buscado);
  write ('Desea eliminar este evento? s/n ');
  read(resp);
  if resp = 's' then
  begin
     control := lista.baja(buscado);
     if control = false then
        begin
         Writeln('No existe el elemento con ID: ',buscado);
        end
     else
     begin
        Writeln('Elemento con ID: ',buscado, ' ha sido dado de baja');
     end;
     readkey; // Dentro del if, si la persona dice 'n' vuelve al menu directamente.
  end;
end;

Procedure interfaz_usuario.consulta();
var
  buscado:string;
  elemento:tdato;
  control:boolean;
  pos:byte;
begin
  clrscr;
  write('Ingrese tipo de evento a buscar: ');
  readln (buscado);
  lista.buscar_por_tipo(buscado,elemento,control,pos); // pos recibe la posicion del primero de los elementos que coincide.
  if control = false then
        begin
         Writeln('No existe ningun evento de tipo: ',buscado);
         readkey;
        end
     else
     begin
       repeat     // Repite hasta que no encuentre mas elementos del tipo del evento (para mostrar todos)
            clrscr;
            Writeln('ID: ',elemento.ID);
            Writeln('Titulo: ',elemento.titulo);
            Writeln('Descripcion: ',elemento.descripcion);
            Writeln('Tipo de evento: ',elemento.tipo_evento);
            Writeln('Dia de inicio: ',elemento.fecha_inicio.dia);
            Writeln('Mes de inicio: ',elemento.fecha_inicio.mes);
            Writeln('Anio de inicio: ',elemento.fecha_inicio.ano);
            Writeln('Dia de cierre: ',elemento.fecha_fin.dia);
            Writeln('Mes de cierre: ',elemento.fecha_fin.mes);
            Writeln('Anio de cierre: ',elemento.fecha_fin.ano);
            Writeln('Hora de inicio: ',elemento.hora_inicio);
            Writeln('Hora de fin: ',elemento.hora_fin);
            Writeln('Ubicacion: ',elemento.ubicacion);
            Writeln('Alta ',elemento.alta);
            Writeln('');
            Write('Presione una tecla para mostrar el siguiente elemento ');
            readkey;
            lista.coincideSiguiente(buscado,elemento,control,pos); // DEMASIADOS PARAMETROS (pero funciona)
       until control = false;
       end;
end;

end.

