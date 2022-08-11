  unit tipos;
interface

type
  fecha = record
    dia:integer;
    mes:integer;
    ano:integer;
    total:integer;
  end;

  tdato = record
        ID: byte;
        titulo: string[40];
        descripcion:string[200];
        tipo_evento:string[40];
        fecha_inicio:fecha;
        fecha_fin:fecha;
        hora_inicio:byte;
        hora_fin:byte;
        ubicacion:string[40];
        alta:boolean;
  end;

implementation
begin
end.
