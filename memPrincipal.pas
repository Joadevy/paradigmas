unit memPrincipal;
{$codepage utf8}
interface
uses
 crt,tipos;

Const
cantidad_elementos=50;

Type
  t_lista = array [1..cantidad_elementos] of tdato;

  // Rutinas basicas de lista
  procedure insertar(var lista:t_lista;elemento:tdato);
  function fin_lista(lista:t_lista):byte;
  FUNCTION devolver_elemento(lista:t_lista; pos:byte):tdato;

  // Rutinas especificas del dominio del problema (se podrian exportar a otra unit)
  PROCEDURE abrir(var lista:t_lista); // Inicializa el lista
  PROCEDURE BURBUJAID(VAR lista:t_lista);
  PROCEDURE BBINARIAID(lista:t_lista; BUSCADO:byte; VAR POS:BYTE);
  PROCEDURE BURBUJATIPO(VAR lista:t_lista);
  PROCEDURE BBINARIATIPO(lista:t_lista; BUSCADO:string; VAR POS:BYTE);
  FUNCTION  baja (VAR lista:t_lista;buscado:byte):boolean;
  FUNCTION devolver_elemento_alta_true(lista:t_lista; pos:byte):tdato;
  PROCEDURE buscar_por_tipo(lista:t_lista;buscado:string;var elemento:tdato;var control:boolean;var pos:byte);
  PROCEDURE coincideSiguiente(var lista:t_lista;buscado:String;var elementoActual:tdato;var control:boolean;var pos:byte);
  procedure cerrar(var lista:t_lista);

implementation

PROCEDURE abrir(var lista:t_lista);   // Inicializa el lista con '' en tipo_evento (campo requerido obligatoriamente)
var
i:byte;
begin
     for i:=1 to cantidad_elementos do
     begin
     lista[i].tipo_evento := '';
     end;
end;

procedure cerrar(var lista:t_lista);
begin
 // Es para que funcione al switchear con la unidad archivos.
end;

procedure insertar(var lista:t_lista;elemento:tdato);
VAR LIM:byte;
begin
     LIM := fin_lista(lista);
     INC(LIM);
     lista[LIM].ID := elemento.id;
     lista[LIM].titulo := elemento.titulo;
     lista[LIM].descripcion := elemento.descripcion;
     lista[LIM].tipo_evento := elemento.tipo_evento;
     lista[LIM].fecha_inicio.dia := elemento.fecha_inicio.dia;
     lista[LIM].fecha_inicio.mes := elemento.fecha_inicio.mes;
     lista[LIM].fecha_inicio.ano := elemento.fecha_inicio.ano;
     lista[LIM].fecha_inicio.total := elemento.fecha_inicio.total;
     lista[LIM].fecha_fin.dia := elemento.fecha_fin.dia;
     lista[LIM].fecha_fin.mes := elemento.fecha_fin.mes;
     lista[LIM].fecha_fin.ano := elemento.fecha_fin.ano;
     lista[LIM].fecha_fin.total := elemento.fecha_fin.total;
     lista[LIM].hora_inicio := elemento.hora_inicio;
     lista[LIM].hora_fin := elemento.hora_fin;
     lista[LIM].ubicacion := elemento.ubicacion;
     lista[LIM].alta := elemento.alta;
end;

function fin_lista(lista:t_lista):byte;
var i:byte;
begin
   fin_lista:=0;
   for i:=1 to cantidad_elementos do
   begin
       if lista[i].tipo_evento <> '' then // Si es '' significa que no se cargo esa celda porque si o si se debe asignar algo.
       fin_lista := fin_lista+1;
   end;
end;

function devolver_elemento_alta_true(lista:t_lista; pos:byte):tdato;
begin
   // Precondicion: pos debe ser < cantidad_elementos
     if (lista[pos].alta = true) and (lista[pos].tipo_evento <> '') then
     begin
       devolver_elemento_alta_true := lista[pos];
     end
end;

function devolver_elemento(lista:t_lista; pos:byte):tdato;
begin
  devolver_elemento := lista[pos];
end;

PROCEDURE BURBUJAID(VAR lista:t_lista);
VAR
I,J,limite: 1..cantidad_elementos;
AUX: TDATO;
BEGIN
limite:=fin_lista(lista);
 FOR I:=1 TO limite-1 DO
  FOR J:= 1 TO limite-I DO
  IF lista[J].id > lista[J+1].id THEN
  BEGIN
    AUX:= lista[J];
    lista[J]:= lista[J+1];
    lista[J+1]:= AUX;
  END;
END;

 PROCEDURE BBINARIAID(lista:t_lista; BUSCADO:byte; VAR POS:BYTE);
 VAR
 PRI,ULT,MEDIO,limite:BYTE;
 BEGIN
   PRI:=1;
   ULT:=fin_lista(lista);
   POS:=0;
   WHILE (PRI<=ULT) AND (POS =0) DO
   BEGIN
     MEDIO:=(PRI+ULT) DIV 2;

     IF lista[MEDIO].id = BUSCADO THEN
        POS:= MEDIO
     ELSE
         IF lista[MEDIO].id > BUSCADO THEN
            ULT:= MEDIO-1
         ELSE
            PRI:=MEDIO + 1;
         end;
 end;

 PROCEDURE BURBUJATIPO(VAR lista:t_lista);
 VAR
 I,J,limite: 1..cantidad_elementos;
 AUX: TDATO;
 BEGIN
 limite:=fin_lista(lista);
  FOR I:=1 TO limite-1 DO
   FOR J:= 1 TO limite-I DO
   IF lista[J].tipo_evento > lista[J+1].tipo_evento THEN
   BEGIN
     AUX:= lista[J];
     lista[J]:= lista[J+1];
     lista[J+1]:= AUX;
   END;
 END;


  PROCEDURE BBINARIATIPO(lista:t_lista; BUSCADO:string; VAR POS:BYTE);
  VAR
  PRI,ULT,MEDIO,limite:BYTE;
  BEGIN
    PRI:=1;
    ULT:=fin_lista(lista);
    POS:=0;
    WHILE (PRI<=ULT) AND (POS =0) DO
    BEGIN
      MEDIO:=(PRI+ULT) DIV 2;

      IF lista[MEDIO].tipo_evento = BUSCADO THEN
         POS:= MEDIO
      ELSE
          IF lista[MEDIO].tipo_evento > BUSCADO THEN
             ULT:= MEDIO-1
          ELSE
             PRI:=MEDIO + 1;
          end;
  end;

 function baja (VAR lista:t_lista;buscado:byte):boolean;
 var
 pos:byte;
 begin
   BURBUJAID(lista);
   BBINARIAID(lista,buscado,pos);
   if (pos <> 0) then
     begin
        lista[pos].alta:=false;
        baja:=true;
     end
   else
       baja:=false;
end;

procedure buscar_por_tipo(lista:t_lista;buscado:string;var elemento:tdato;var control:boolean;var pos:byte);
begin
  BURBUJATIPO(lista);
  BBINARIATIPO(lista,buscado,pos);
   if (pos <> 0) then
     begin
        IF POS>1 THEN   // Sino se rompe al comparar el primer elemento con vacio.
        BEGIN
        WHILE(lista[pos-1].tipo_evento = buscado) and (POS>1) DO
          BEGIN
             POS:=POS-1;
          END;
        END;
        elemento := lista[pos];  // Le pasa el primero que aparece en la lista con el tipo que se busco.
        control := true;
     end
   else
       control:=false;
end;

procedure coincideSiguiente(var lista:t_lista;buscado:String;var elementoActual:tdato;var control:boolean;var pos:byte);
begin
   BURBUJATIPO(lista); // Primero ordena para no perder la pos en caso de que se haya ordenado por otra cosa el array antes de llamar.
   if pos+1 <= cantidad_elementos then
   begin
     if (lista[pos+1].tipo_evento = buscado)then
     begin
       elementoActual := lista[pos+1];
       pos := pos+1;
       control := true;
     end
     else
       control := false;
   end;
end;

end.

