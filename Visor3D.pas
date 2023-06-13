unit Visor3D;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Panel2: TPanel;
    Button11: TButton;
    Button12: TButton;
    OpenDialog1: TOpenDialog;
    procedure Button9Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type T3DPoint = record
  x : Real;
  y : Real;
  z : Real;
end;

type linea = record
  cords : Array [1..2] of T3Dpoint;
end;

type prisma = record
  cords : Array [1..10] of T3DPoint;
end;

var
  Form1: TForm1;
  ContMangueras : Integer;        //Contador para las mangueras.
  ContTubos : Integer;            //Contador para los tubos.
  ContCasas : Integer;            //Contador para las casas.
  ContEdificios : Integer;        //Contador para las edificios.
  ContValvulas : Integer;         //Contador para las valvulas.
  ContBombas : Integer;           //Contador para las bombas.
  ContMedidores : Integer;        //Contador para las medidores.
  ContDistri : Integer;           //Contador para las distribuidores.
  P, Q : TPoint;
  alfa, xAux, yAux, zAux, OjoAObjeto, D : Real;
  Xmax, Xmin, Ymax, Ymin, medianaX, medianaY : Integer;

  //Declaracion de arreglos globales.

  mangueras : Array [1..100] of linea;
  tubos : Array [1..100] of linea;
  casas : Array [1..100] of prisma;
  edificios : Array [1..100] of prisma;
  valvulas : Array [1..100] of prisma;
  bombas : Array [1..100] of prisma;
  medidores : Array [1..100] of prisma;
  distribuidores : Array [1..100] of prisma;

implementation

{$R *.dfm}

procedure TForm1.Button10Click(Sender: TObject);

  procedure ProyParalela(x, y, z: Real; var xP, yP : Integer);
  begin

    xP := Round( x ) + (300 - medianaX);
    yP := Round( y ) + (300 - medianaY);

  end;

  procedure Perspectiva( x, y, z: Real; var xP, yP : Integer );
  var
    xAux1, yAux1, zAux1 : Real;
  begin

    zAux1 := z + OjoAObjeto;
    xAux1 := ((x - medianaX) * D) / zAux1;
    xP := Round(xAux1) + 300;
    yAux1 := ((y - medianaY) * D) / zAux1;
    yP := Round(yAux1) + 300;

  end;

var
  i : Integer;
  j: Integer;


begin

  Image1.Canvas.Rectangle(0,0,600,600);

  if Xmax <> Xmin then
  begin
    medianaX := Round(Xmin + ((Xmax - Xmin) / 2));
  end
  else
  begin
    medianaX := Xmax;
  end;

  if Ymax <> Ymin then
  begin
    medianaY := Round(Ymin + ((Ymax - Ymin) / 2));
  end
  else
  begin
    medianaY := Ymax;
  end;

  if ContMangueras <> 0 then
  begin

    Image1.Canvas.Pen.Color := clBlack;
    Image1.Canvas.Pen.Width := 4;

    for j := 1 to ContMangueras do
    begin

      Perspectiva(mangueras[j].cords[1].x, mangueras[j].cords[1].y, mangueras[j].cords[1].z, P.x, P.y);
      Perspectiva(mangueras[j].cords[2].x, mangueras[j].cords[2].y, mangueras[j].cords[2].z, Q.x, Q.y);
      Image1.Canvas.MoveTo(P.X, P.Y);
      Image1.Canvas.LineTo(Q.X, Q.Y);
    
    end;

    Image1.Canvas.Pen.Color := clWhite;
    Image1.Canvas.Rectangle(P.x+1,P.y+1,P.x,P.y);
    Image1.Canvas.Pen.Width := 1;
    Image1.Canvas.Pen.Color := clBlack;

  end;

  if ContCasas <> 0 then
  begin

    Image1.Canvas.Pen.Color := clRed;
    Image1.Canvas.Pen.Width := 2;

    for j := 1 to ContCasas do
    begin

      //Pinta el piso de la casa.
      for i := 1 to 4 do
      begin
        Perspectiva(casas[j].cords[i].x, casas[j].cords[i].y, casas[j].cords[i].z, P.x, P.y);
        Perspectiva(casas[j].cords[i+1].x, casas[j].cords[i+1].y, casas[j].cords[i+1].z, Q.x, Q.y);
        Image1.Canvas.MoveTo(P.x, P.Y);
        Image1.Canvas.LineTo(Q.X, Q.Y);
      end;

      // Pinta el techo de la casa.
      for i := 6 to 9 do
      begin
        Perspectiva(casas[j].cords[i].x, casas[j].cords[i].y, casas[j].cords[i].z, P.x, P.y);
        Perspectiva(casas[j].cords[i+1].x, casas[j].cords[i+1].y, casas[j].cords[i+1].z, Q.x, Q.y);
        Image1.Canvas.MoveTo(P.x, P.y);
        Image1.Canvas.LineTo(Q.x, Q.y);
      end;

      // Pinta las paredes de la casa.
      for i := 1 to 4 do
      begin
        Perspectiva(casas[j].cords[i].x, casas[j].cords[i].y, casas[j].cords[i].z, P.x, P.y);
        Perspectiva(casas[j].cords[i+5].x, casas[j].cords[i+5].y, casas[j].cords[i+5].z, Q.x, Q.y);
        Image1.Canvas.MoveTo(P.x, P.y);
        Image1.Canvas.LineTo(Q.x, Q.y);
      end;

    end;

    Image1.Canvas.Pen.Color := clBlack;

  end;

  if ContTubos <> 0 then
  begin

    Image1.Canvas.Pen.Color := clWebOrangeRed;
    Image1.Canvas.Pen.Width := 6;

    for j := 1 to ContTubos do
    begin

      Perspectiva(tubos[j].cords[1].x, tubos[j].cords[1].y, tubos[j].cords[1].z, P.x, P.y);
      Perspectiva(tubos[j].cords[2].x, tubos[j].cords[2].y, tubos[j].cords[2].z, Q.x, Q.y);
      Image1.Canvas.MoveTo(P.X, P.Y);
      Image1.Canvas.LineTo(Q.X, Q.Y);

    end;

    Image1.Canvas.Pen.Color := clWhite;
    Image1.Canvas.Rectangle(P.x+1,P.y+1,P.x,P.y);
    Image1.Canvas.Pen.Width := 2;
    Image1.Canvas.Pen.Color := clBlack;

  end;

  if ContEdificios <> 0 then
  begin

    Image1.Canvas.Pen.Color := clGreen;

    for j := 1 to ContEdificios do
    begin

      //Pinta el piso del edificio.
      for i := 1 to 4 do
      begin
        Perspectiva(edificios[j].cords[i].x, edificios[j].cords[i].y, edificios[j].cords[i].z, P.x, P.y);
        Perspectiva(edificios[j].cords[i+1].x, edificios[j].cords[i+1].y, edificios[j].cords[i+1].z, Q.x, Q.y);
        Image1.Canvas.MoveTo(P.x, P.Y);
        Image1.Canvas.LineTo(Q.X, Q.Y);
      end;

      // Pinta el techo del edificio.
      for i := 6 to 9 do
      begin
        Perspectiva(edificios[j].cords[i].x, edificios[j].cords[i].y, edificios[j].cords[i].z, P.x, P.y);
        Perspectiva(edificios[j].cords[i+1].x, edificios[j].cords[i+1].y, edificios[j].cords[i+1].z, Q.x, Q.y);
        Image1.Canvas.MoveTo(P.x, P.y);
        Image1.Canvas.LineTo(Q.x, Q.y);
      end;

      // Pinta las paredes del edificio.
      for i := 1 to 4 do
      begin
        Perspectiva(edificios[j].cords[i].x, edificios[j].cords[i].y, edificios[j].cords[i].z, P.x, P.y);
        Perspectiva(edificios[j].cords[i+5].x, edificios[j].cords[i+5].y, edificios[j].cords[i+5].z, Q.x, Q.y);
        Image1.Canvas.MoveTo(P.x, P.y);
        Image1.Canvas.LineTo(Q.x, Q.y);
      end;

    end;

    Image1.Canvas.Pen.Color := clBlack;

  end;

  if ContValvulas <> 0 then
  begin

    Image1.Canvas.Pen.Color := clGray;

    for j := 1 to ContValvulas do
    begin

      //Pinta el piso de la valvula.
      for i := 1 to 4 do
      begin
        Perspectiva(valvulas[j].cords[i].x, valvulas[j].cords[i].y, valvulas[j].cords[i].z, P.x, P.y);
        Perspectiva(valvulas[j].cords[i+1].x, valvulas[j].cords[i+1].y, valvulas[j].cords[i+1].z, Q.x, Q.y);
        Image1.Canvas.MoveTo(P.x, P.Y);
        Image1.Canvas.LineTo(Q.X, Q.Y);
      end;

      // Pinta el techo de la valvula.
      for i := 6 to 9 do
      begin
        Perspectiva(valvulas[j].cords[i].x, valvulas[j].cords[i].y, valvulas[j].cords[i].z, P.x, P.y);
        Perspectiva(valvulas[j].cords[i+1].x, valvulas[j].cords[i+1].y, valvulas[j].cords[i+1].z, Q.x, Q.y);
        Image1.Canvas.MoveTo(P.x, P.y);
        Image1.Canvas.LineTo(Q.x, Q.y);
      end;

      // Pinta las paredes de la valvula.
      for i := 1 to 4 do
      begin
        Perspectiva(valvulas[j].cords[i].x, valvulas[j].cords[i].y, valvulas[j].cords[i].z, P.x, P.y);
        Perspectiva(valvulas[j].cords[i+5].x, valvulas[j].cords[i+5].y, valvulas[j].cords[i+5].z, Q.x, Q.y);
        Image1.Canvas.MoveTo(P.x, P.y);
        Image1.Canvas.LineTo(Q.x, Q.y);
      end;

    end;

    Image1.Canvas.Pen.Color := clBlack;

  end;

  if ContBombas <> 0 then
  begin

    Image1.Canvas.Pen.Color := clBlue;

    for j := 1 to ContBombas do
    begin

      //Pinta el piso de la bomba.
      for i := 1 to 4 do
      begin
        Perspectiva(bombas[j].cords[i].x, bombas[j].cords[i].y, bombas[j].cords[i].z, P.x, P.y);
        Perspectiva(bombas[j].cords[i+1].x, bombas[j].cords[i+1].y, bombas[j].cords[i+1].z, Q.x, Q.y);
        Image1.Canvas.MoveTo(P.x, P.Y);
        Image1.Canvas.LineTo(Q.X, Q.Y);
      end;

      // Pinta el techo de la bomba.
      for i := 6 to 9 do
      begin
        Perspectiva(bombas[j].cords[i].x, bombas[j].cords[i].y, bombas[j].cords[i].z, P.x, P.y);
        Perspectiva(bombas[j].cords[i+1].x, bombas[j].cords[i+1].y, bombas[j].cords[i+1].z, Q.x, Q.y);
        Image1.Canvas.MoveTo(P.x, P.y);
        Image1.Canvas.LineTo(Q.x, Q.y);
      end;

      // Pinta las paredes de la bomba.
      for i := 1 to 4 do
      begin
        Perspectiva(bombas[j].cords[i].x, bombas[j].cords[i].y, bombas[j].cords[i].z, P.x, P.y);
        Perspectiva(bombas[j].cords[i+5].x, bombas[j].cords[i+5].y, bombas[j].cords[i+5].z, Q.x, Q.y);
        Image1.Canvas.MoveTo(P.x, P.y);
        Image1.Canvas.LineTo(Q.x, Q.y);
      end;

    end;

    Image1.Canvas.Pen.Color := clBlack;

  end;

  if ContMedidores <> 0 then
  begin

    Image1.Canvas.Pen.Color := clWebPurple;

    for j := 1 to ContMedidores do
    begin

      //Pinta el piso del medidor.
      for i := 1 to 4 do
      begin
        Perspectiva(medidores[j].cords[i].x, medidores[j].cords[i].y, medidores[j].cords[i].z, P.x, P.y);
        Perspectiva(medidores[j].cords[i+1].x, medidores[j].cords[i+1].y, medidores[j].cords[i+1].z, Q.x, Q.y);
        Image1.Canvas.MoveTo(P.x, P.Y);
        Image1.Canvas.LineTo(Q.X, Q.Y);
      end;

      // Pinta el techo del medidor.
      for i := 6 to 9 do
      begin
        Perspectiva(medidores[j].cords[i].x, medidores[j].cords[i].y, medidores[j].cords[i].z, P.x, P.y);
        Perspectiva(medidores[j].cords[i+1].x, medidores[j].cords[i+1].y, medidores[j].cords[i+1].z, Q.x, Q.y);
        Image1.Canvas.MoveTo(P.x, P.y);
        Image1.Canvas.LineTo(Q.x, Q.y);
      end;

      // Pinta las paredes del medidor.
      for i := 1 to 4 do
      begin
        Perspectiva(medidores[j].cords[i].x, medidores[j].cords[i].y, medidores[j].cords[i].z, P.x, P.y);
        Perspectiva(medidores[j].cords[i+5].x, medidores[j].cords[i+5].y, medidores[j].cords[i+5].z, Q.x, Q.y);
        Image1.Canvas.MoveTo(P.x, P.y);
        Image1.Canvas.LineTo(Q.x, Q.y);
      end;

    end;

    Image1.Canvas.Pen.Color := clBlack;

  end;

  if ContDistri <> 0 then
  begin

    Image1.Canvas.Pen.Color := clWebSaddleBrown;

    for j := 1 to ContDistri do
    begin

      //Pinta el piso del distribuidor.
      for i := 1 to 4 do
      begin
        Perspectiva(distribuidores[j].cords[i].x, distribuidores[j].cords[i].y, distribuidores[j].cords[i].z, P.x, P.y);
        Perspectiva(distribuidores[j].cords[i+1].x, distribuidores[j].cords[i+1].y, distribuidores[j].cords[i+1].z, Q.x, Q.y);
        Image1.Canvas.MoveTo(P.x, P.Y);
        Image1.Canvas.LineTo(Q.X, Q.Y);
      end;

      // Pinta el techo del distribuidor.
      for i := 6 to 9 do
      begin
        Perspectiva(distribuidores[j].cords[i].x, distribuidores[j].cords[i].y, distribuidores[j].cords[i].z, P.x, P.y);
        Perspectiva(distribuidores[j].cords[i+1].x, distribuidores[j].cords[i+1].y, distribuidores[j].cords[i+1].z, Q.x, Q.y);
        Image1.Canvas.MoveTo(P.x, P.y);
        Image1.Canvas.LineTo(Q.x, Q.y);
      end;

      // Pinta las paredes del distribuidor.
      for i := 1 to 4 do
      begin
        Perspectiva(distribuidores[j].cords[i].x, distribuidores[j].cords[i].y, distribuidores[j].cords[i].z, P.x, P.y);
        Perspectiva(distribuidores[j].cords[i+5].x, distribuidores[j].cords[i+5].y, distribuidores[j].cords[i+5].z, Q.x, Q.y);
        Image1.Canvas.MoveTo(P.x, P.y);
        Image1.Canvas.LineTo(Q.x, Q.y);
      end;

    end;

    Image1.Canvas.Pen.Color := clBlack;

  end;

end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  showMessage('Juan Carlos Maldonado Lozano');
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
  close();
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i, j : Integer;
begin

  if ContMangueras <> 0 then
  begin
  
    for j := 1 to ContMangueras do
    begin
    
      for i := 1 to 2 do
      begin
      
        yAux := ((mangueras[j].cords[i].y - medianaY) * COS( -alfa )) + (mangueras[j].cords[i].z * SIN( -alfa ));
        zAux := -((mangueras[j].cords[i].y - medianaY) * SIN( -alfa )) + (mangueras[j].cords[i].z * COS( -alfa ));
        mangueras[j].cords[i].y := yAux + medianaY;
        mangueras[j].cords[i].z := zAux;

      end;
        
    end;

  end;

  if ContTubos <> 0 then
  begin

    for j := 1 to ContTubos do
    begin

      for i := 1 to 2 do
      begin

        yAux := ((tubos[j].cords[i].y - medianaY) * COS( -alfa )) + (tubos[j].cords[i].z * SIN( -alfa ));
        zAux := -((tubos[j].cords[i].y - medianaY) * SIN( -alfa )) + (tubos[j].cords[i].z * COS( -alfa ));
        tubos[j].cords[i].y := yAux + medianaY;
        tubos[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContCasas <> 0 then
  begin

    for j := 1 to ContCasas do
    begin

      for i := 1 to 10 do
      begin
      
        yAux := ((casas[j].cords[i].y - medianaY) * COS( -alfa )) + (casas[j].cords[i].z * SIN( -alfa ));
        zAux := -((casas[j].cords[i].y - medianaY) * SIN( -alfa )) + (casas[j].cords[i].z * COS( -alfa ));
        casas[j].cords[i].y := yAux + medianaY;
        casas[j].cords[i].z := zAux;

      end;

    end;
  
  end;

  if ContEdificios <> 0 then
  begin

    for j := 1 to ContEdificios do
    begin

      for i := 1 to 10 do
      begin

        yAux := ((edificios[j].cords[i].y - medianaY) * COS( -alfa )) + (edificios[j].cords[i].z * SIN( -alfa ));
        zAux := -((edificios[j].cords[i].y - medianaY) * SIN( -alfa )) + (edificios[j].cords[i].z * COS( -alfa ));
        edificios[j].cords[i].y := yAux + medianaY;
        edificios[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContValvulas <> 0 then
  begin

    for j := 1 to ContValvulas do
    begin

      for i := 1 to 10 do
      begin

        yAux := ((valvulas[j].cords[i].y - medianaY) * COS( -alfa )) + (valvulas[j].cords[i].z * SIN( -alfa ));
        zAux := -((valvulas[j].cords[i].y - medianaY) * SIN( -alfa )) + (valvulas[j].cords[i].z * COS( -alfa ));
        valvulas[j].cords[i].y := yAux + medianaY;
        valvulas[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContBombas <> 0 then
  begin

    for j := 1 to ContBombas do
    begin

      for i := 1 to 10 do
      begin

        yAux := ((bombas[j].cords[i].y - medianaY) * COS( -alfa )) + (bombas[j].cords[i].z * SIN( -alfa ));
        zAux := -((bombas[j].cords[i].y - medianaY) * SIN( -alfa )) + (bombas[j].cords[i].z * COS( -alfa ));
        bombas[j].cords[i].y := yAux + medianaY;
        bombas[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContMedidores <> 0 then
  begin

    for j := 1 to ContMedidores do
    begin

      for i := 1 to 10 do
      begin

        yAux := ((medidores[j].cords[i].y - medianaY) * COS( -alfa )) + (medidores[j].cords[i].z * SIN( -alfa ));
        zAux := -((medidores[j].cords[i].y - medianaY) * SIN( -alfa )) + (medidores[j].cords[i].z * COS( -alfa ));
        medidores[j].cords[i].y := yAux + medianaY;
        medidores[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContDistri <> 0 then
  begin

    for j := 1 to ContDistri do
    begin

      for i := 1 to 10 do
      begin

        yAux := ((distribuidores[j].cords[i].y - medianaY) * COS( -alfa )) + (distribuidores[j].cords[i].z * SIN( -alfa ));
        zAux := -((distribuidores[j].cords[i].y - medianaY) * SIN( -alfa )) + (distribuidores[j].cords[i].z * COS( -alfa ));
        distribuidores[j].cords[i].y := yAux + medianaY;
        distribuidores[j].cords[i].z := zAux;

      end;

    end;

  end;
  
  Form1.Button10Click(Sender);

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  j, i: Integer;
begin

  if ContMangueras <> 0 then
  begin

    for j := 1 to ContMangueras do
    begin
    
      for i := 1 to 2 do
      begin
      
        yAux := ((mangueras[j].cords[i].y - medianaY) * COS( alfa )) + (mangueras[j].cords[i].z * SIN( alfa ));
        zAux := -((mangueras[j].cords[i].y - medianaY) * SIN( alfa )) + (mangueras[j].cords[i].z * COS( alfa ));
        mangueras[j].cords[i].y := yAux + medianaY;
        mangueras[j].cords[i].z := zAux;
      
      end;
        
    end;
  
  end;

  if ContTubos <> 0 then
  begin

    for j := 1 to ContTubos do
    begin

      for i := 1 to 2 do
      begin

        yAux := ((tubos[j].cords[i].y - medianaY) * COS( alfa )) + (tubos[j].cords[i].z * SIN( alfa ));
        zAux := -((tubos[j].cords[i].y - medianaY) * SIN( alfa )) + (tubos[j].cords[i].z * COS( alfa ));
        tubos[j].cords[i].y := yAux + medianaY;
        tubos[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContCasas <> 0 then
  begin
  
    for j := 1 to ContCasas do
    begin

      for i := 1 to 10 do
      begin
      
        yAux := ((casas[j].cords[i].y - medianaY) * COS( alfa )) + (casas[j].cords[i].z * SIN( alfa ));
        zAux := -((casas[j].cords[i].y - medianaY) * SIN( alfa )) + (casas[j].cords[i].z * COS( alfa ));
        casas[j].cords[i].y := yAux + medianaY;
        casas[j].cords[i].z := zAux;

      end;

    end;
  
  end;

  if ContEdificios <> 0 then
  begin

    for j := 1 to ContEdificios do
    begin

      for i := 1 to 10 do
      begin

        yAux := ((edificios[j].cords[i].y - medianaY) * COS( alfa )) + (edificios[j].cords[i].z * SIN( alfa ));
        zAux := -((edificios[j].cords[i].y - medianaY) * SIN( alfa )) + (edificios[j].cords[i].z * COS( alfa ));
        edificios[j].cords[i].y := yAux + medianaY;
        edificios[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContValvulas <> 0 then
  begin

    for j := 1 to ContValvulas do
    begin

      for i := 1 to 10 do
      begin

        yAux := ((valvulas[j].cords[i].y - medianaY) * COS( alfa )) + (valvulas[j].cords[i].z * SIN( alfa ));
        zAux := -((valvulas[j].cords[i].y - medianaY) * SIN( alfa )) + (valvulas[j].cords[i].z * COS( alfa ));
        valvulas[j].cords[i].y := yAux + medianaY;
        valvulas[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContBombas <> 0 then
  begin

    for j := 1 to ContBombas do
    begin

      for i := 1 to 10 do
      begin

        yAux := ((bombas[j].cords[i].y - medianaY) * COS( alfa )) + (bombas[j].cords[i].z * SIN( alfa ));
        zAux := -((bombas[j].cords[i].y - medianaY) * SIN( alfa )) + (bombas[j].cords[i].z * COS( alfa ));
        bombas[j].cords[i].y := yAux + medianaY;
        bombas[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContMedidores <> 0 then
  begin

    for j := 1 to ContMedidores do
    begin

      for i := 1 to 10 do
      begin

        yAux := ((medidores[j].cords[i].y - medianaY) * COS( alfa )) + (medidores[j].cords[i].z * SIN( alfa ));
        zAux := -((medidores[j].cords[i].y - medianaY) * SIN( alfa )) + (medidores[j].cords[i].z * COS( alfa ));
        medidores[j].cords[i].y := yAux + medianaY;
        medidores[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContDistri <> 0 then
  begin

    for j := 1 to ContDistri do
    begin

      for i := 1 to 10 do
      begin

        yAux := ((distribuidores[j].cords[i].y - medianaY) * COS( alfa )) + (distribuidores[j].cords[i].z * SIN( alfa ));
        zAux := -((distribuidores[j].cords[i].y - medianaY) * SIN( alfa )) + (distribuidores[j].cords[i].z * COS( alfa ));
        distribuidores[j].cords[i].y := yAux + medianaY;
        distribuidores[j].cords[i].z := zAux;

      end;

    end;

  end;

  Form1.Button10Click(Sender);

end;

procedure TForm1.Button3Click(Sender: TObject);
var
  i, j : Integer;

begin

  if ContMangueras <> 0 then
  begin

    for j := 1 to ContMangueras do
    begin

      for i := 1 to 2 do
      begin

        zAux := (mangueras[j].cords[i].z * COS( -alfa )) + ((mangueras[j].cords[i].x - medianaX) * SIN( -alfa ));
        xAux := -(mangueras[j].cords[i].z * SIN( -alfa )) + ((mangueras[j].cords[i].x - medianaX) * COS( -alfa ));
        mangueras[j].cords[i].x := xAux + medianaX;
        mangueras[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContTubos <> 0 then
  begin

    for j := 1 to ContTubos do
    begin

      for i := 1 to 2 do
      begin

        zAux := (tubos[j].cords[i].z * COS( -alfa )) + ((tubos[j].cords[i].x - medianaX) * SIN( -alfa ));
        xAux := -(tubos[j].cords[i].z * SIN( -alfa )) + ((tubos[j].cords[i].x - medianaX) * COS( -alfa ));
        tubos[j].cords[i].x := xAux + medianaX;
        tubos[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContCasas <> 0 then
  begin

    for j := 1 to ContCasas do
    begin

      for i := 1 to 10 do
      begin

        zAux := (casas[j].cords[i].z * COS( -alfa )) + ((casas[j].cords[i].x - medianaX) * SIN( -alfa ));
        xAux := -(casas[j].cords[i].z * SIN( -alfa )) + ((casas[j].cords[i].x - medianaX) * COS( -alfa ));
        casas[j].cords[i].x := xAux + medianaX;
        casas[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContEdificios <> 0 then
  begin

    for j := 1 to ContEdificios do
    begin

      for i := 1 to 10 do
      begin

        zAux := (edificios[j].cords[i].z * COS( -alfa )) + ((edificios[j].cords[i].x - medianaX) * SIN( -alfa ));
        xAux := -(edificios[j].cords[i].z * SIN( -alfa )) + ((edificios[j].cords[i].x - medianaX) * COS( -alfa ));
        edificios[j].cords[i].x := xAux + medianaX;
        edificios[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContValvulas <> 0 then
  begin

    for j := 1 to ContValvulas do
    begin

      for i := 1 to 10 do
      begin

        zAux := (valvulas[j].cords[i].z * COS( -alfa )) + ((valvulas[j].cords[i].x - medianaX) * SIN( -alfa ));
        xAux := -(valvulas[j].cords[i].z * SIN( -alfa )) + ((valvulas[j].cords[i].x - medianaX) * COS( -alfa ));
        valvulas[j].cords[i].x := xAux + medianaX;
        valvulas[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContBombas <> 0 then
  begin

    for j := 1 to ContBombas do
    begin

      for i := 1 to 10 do
      begin

        zAux := (bombas[j].cords[i].z * COS( -alfa )) + ((bombas[j].cords[i].x - medianaX) * SIN( -alfa ));
        xAux := -(bombas[j].cords[i].z * SIN( -alfa )) + ((bombas[j].cords[i].x - medianaX) * COS( -alfa ));
        bombas[j].cords[i].x := xAux + medianaX;
        bombas[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContMedidores <> 0 then
  begin

    for j := 1 to ContMedidores do
    begin

      for i := 1 to 10 do
      begin

        zAux := (medidores[j].cords[i].z * COS( -alfa )) + ((medidores[j].cords[i].x - medianaX) * SIN( -alfa ));
        xAux := -(medidores[j].cords[i].z * SIN( -alfa )) + ((medidores[j].cords[i].x - medianaX) * COS( -alfa ));
        medidores[j].cords[i].x := xAux + medianaX;
        medidores[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContDistri <> 0 then
  begin

    for j := 1 to ContDistri do
    begin

      for i := 1 to 10 do
      begin

        zAux := (distribuidores[j].cords[i].z * COS( -alfa )) + ((distribuidores[j].cords[i].x - medianaX) * SIN( -alfa ));
        xAux := -(distribuidores[j].cords[i].z * SIN( -alfa )) + ((distribuidores[j].cords[i].x - medianaX) * COS( -alfa ));
        distribuidores[j].cords[i].x := xAux + medianaX;
        distribuidores[j].cords[i].z := zAux;

      end;

    end;

  end;

  Form1.Button10Click(Sender);

end;

procedure TForm1.Button4Click(Sender: TObject);
var
  i, j: Integer;
begin

  if ContMangueras <> 0 then
  begin

    for j := 1 to ContMangueras do
    begin

      for i := 1 to 2 do
      begin

        zAux := (mangueras[j].cords[i].z * COS( alfa )) + ((mangueras[j].cords[i].x - medianaX) * SIN( alfa ));
        xAux := -(mangueras[j].cords[i].z * SIN( alfa )) + ((mangueras[j].cords[i].x - medianaX) * COS( alfa ));
        mangueras[j].cords[i].x := xAux + medianaX;
        mangueras[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContTubos <> 0 then
  begin

    for j := 1 to ContTubos do
    begin

      for i := 1 to 2 do
      begin

        zAux := (tubos[j].cords[i].z * COS( alfa )) + ((tubos[j].cords[i].x - medianaX) * SIN( alfa ));
        xAux := -(tubos[j].cords[i].z * SIN( alfa )) + ((tubos[j].cords[i].x - medianaX) * COS( alfa ));
        tubos[j].cords[i].x := xAux + medianaX;
        tubos[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContCasas <> 0 then
  begin

    for j := 1 to ContCasas do
    begin

      for i := 1 to 10 do
      begin

        zAux := (casas[j].cords[i].z * COS( alfa )) + ((casas[j].cords[i].x - medianaX) * SIN( alfa ));
        xAux := -(casas[j].cords[i].z * SIN( alfa )) + ((casas[j].cords[i].x - medianaX) * COS( alfa ));
        casas[j].cords[i].x := xAux + medianaX;
        casas[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContEdificios <> 0 then
  begin

    for j := 1 to ContEdificios do
    begin

      for i := 1 to 10 do
      begin

        zAux := (edificios[j].cords[i].z * COS( alfa )) + ((edificios[j].cords[i].x - medianaX) * SIN( alfa ));
        xAux := -(edificios[j].cords[i].z * SIN( alfa )) + ((edificios[j].cords[i].x - medianaX) * COS( alfa ));
        edificios[j].cords[i].x := xAux + medianaX;
        edificios[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContValvulas <> 0 then
  begin

    for j := 1 to ContValvulas do
    begin

      for i := 1 to 10 do
      begin

        zAux := (valvulas[j].cords[i].z * COS( alfa )) + ((valvulas[j].cords[i].x - medianaX) * SIN( alfa ));
        xAux := -(valvulas[j].cords[i].z * SIN( alfa )) + ((valvulas[j].cords[i].x - medianaX) * COS( alfa ));
        valvulas[j].cords[i].x := xAux + medianaX;
        valvulas[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContBombas <> 0 then
  begin

    for j := 1 to ContBombas do
    begin

      for i := 1 to 10 do
      begin

        zAux := (bombas[j].cords[i].z * COS( alfa )) + ((bombas[j].cords[i].x - medianaX) * SIN( alfa ));
        xAux := -(bombas[j].cords[i].z * SIN( alfa )) + ((bombas[j].cords[i].x - medianaX) * COS( alfa ));
        bombas[j].cords[i].x := xAux + medianaX;
        bombas[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContMedidores <> 0 then
  begin

    for j := 1 to ContMedidores do
    begin

      for i := 1 to 10 do
      begin

        zAux := (medidores[j].cords[i].z * COS( alfa )) + ((medidores[j].cords[i].x - medianaX) * SIN( alfa ));
        xAux := -(medidores[j].cords[i].z * SIN( alfa )) + ((medidores[j].cords[i].x - medianaX) * COS( alfa ));
        medidores[j].cords[i].x := xAux + medianaX;
        medidores[j].cords[i].z := zAux;

      end;

    end;

  end;

  if ContDistri <> 0 then
  begin

    for j := 1 to ContDistri do
    begin

      for i := 1 to 10 do
      begin

        zAux := (distribuidores[j].cords[i].z * COS( alfa )) + ((distribuidores[j].cords[i].x - medianaX) * SIN( alfa ));
        xAux := -(distribuidores[j].cords[i].z * SIN( alfa )) + ((distribuidores[j].cords[i].x - medianaX) * COS( alfa ));
        distribuidores[j].cords[i].x := xAux + medianaX;
        distribuidores[j].cords[i].z := zAux;

      end;

    end;

  end;

  Form1.Button10Click(Sender);

end;

procedure TForm1.Button5Click(Sender: TObject);
var
  i, j : Integer;

begin

  if ContMangueras <> 0 then
  begin

    for j := 1 to ContMangueras do
    begin

      for i := 1 to 2 do
      begin

        xAux := ((mangueras[j].cords[i].x - medianaX) * COS( alfa )) + ((mangueras[j].cords[i].y - medianaY) * SIN( alfa ));
        yAux := -((mangueras[j].cords[i].x - medianaX) * SIN( alfa )) + ((mangueras[j].cords[i].y - medianaY) * COS( alfa ));
        mangueras[j].cords[i].x := xAux + medianaX;
        mangueras[j].cords[i].y := yAux + medianaY;

      end;

    end;

  end;

  if ContTubos <> 0 then
  begin

    for j := 1 to ContTubos do
    begin

      for i := 1 to 2 do
      begin

        xAux := ((tubos[j].cords[i].x - medianaX) * COS( alfa )) + ((tubos[j].cords[i].y - medianaY) * SIN( alfa ));
        yAux := -((tubos[j].cords[i].x - medianaX) * SIN( alfa )) + ((tubos[j].cords[i].y - medianaY) * COS( alfa ));
        tubos[j].cords[i].x := xAux + medianaX;
        tubos[j].cords[i].y := yAux + medianaY;

      end;

    end;

  end;

  if ContCasas <> 0 then
  begin

    for j := 1 to ContCasas do
    begin

      for i := 1 to 10 do
      begin

        xAux := ((casas[j].cords[i].x - medianaX) * COS( alfa )) + ((casas[j].cords[i].y - medianaY) * SIN( alfa ));
        yAux := -((casas[j].cords[i].x - medianaX) * SIN( alfa )) + ((casas[j].cords[i].y - medianaY) * COS( alfa ));
        casas[j].cords[i].x := xAux + medianaX;
        casas[j].cords[i].y := yAux + medianaY;

      end;

    end;

  end;

  if ContEdificios <> 0 then
  begin

    for j := 1 to ContEdificios do
    begin

      for i := 1 to 10 do
      begin

        xAux := ((edificios[j].cords[i].x - medianaX) * COS( alfa )) + ((edificios[j].cords[i].y - medianaY) * SIN( alfa ));
        yAux := -((edificios[j].cords[i].x - medianaX) * SIN( alfa )) + ((edificios[j].cords[i].y - medianaY) * COS( alfa ));
        edificios[j].cords[i].x := xAux + medianaX;
        edificios[j].cords[i].y := yAux + medianaY;

      end;

    end;

  end;

  if ContValvulas <> 0 then
  begin

    for j := 1 to ContValvulas do
    begin

      for i := 1 to 10 do
      begin

        xAux := ((valvulas[j].cords[i].x - medianaX) * COS( alfa )) + ((valvulas[j].cords[i].y - medianaY) * SIN( alfa ));
        yAux := -((valvulas[j].cords[i].x - medianaX) * SIN( alfa )) + ((valvulas[j].cords[i].y - medianaY) * COS( alfa ));
        valvulas[j].cords[i].x := xAux + medianaX;
        valvulas[j].cords[i].y := yAux + medianaY;

      end;

    end;

  end;

  if ContBombas <> 0 then
  begin

    for j := 1 to ContBombas do
    begin

      for i := 1 to 10 do
      begin

        xAux := ((bombas[j].cords[i].x - medianaX) * COS( alfa )) + ((bombas[j].cords[i].y - medianaY) * SIN( alfa ));
        yAux := -((bombas[j].cords[i].x - medianaX) * SIN( alfa )) + ((bombas[j].cords[i].y - medianaY) * COS( alfa ));
        bombas[j].cords[i].x := xAux + medianaX;
        bombas[j].cords[i].y := yAux + medianaY;

      end;

    end;

  end;

  if ContMedidores <> 0 then
  begin

    for j := 1 to ContMedidores do
    begin

      for i := 1 to 10 do
      begin

        xAux := ((medidores[j].cords[i].x - medianaX) * COS( alfa )) + ((medidores[j].cords[i].y - medianaY) * SIN( alfa ));
        yAux := -((medidores[j].cords[i].x - medianaX) * SIN( alfa )) + ((medidores[j].cords[i].y - medianaY) * COS( alfa ));
        medidores[j].cords[i].x := xAux + medianaX;
        medidores[j].cords[i].y := yAux + medianaY;

      end;

    end;

  end;

  if ContDistri <> 0 then
  begin

    for j := 1 to ContDistri do
    begin

      for i := 1 to 10 do
      begin

        xAux := ((distribuidores[j].cords[i].x - medianaX) * COS( alfa )) + ((distribuidores[j].cords[i].y - medianaY) * SIN( alfa ));
        yAux := -((distribuidores[j].cords[i].x - medianaX) * SIN( alfa )) + ((distribuidores[j].cords[i].y - medianaY) * COS( alfa ));
        distribuidores[j].cords[i].x := xAux + medianaX;
        distribuidores[j].cords[i].y := yAux + medianaY;

      end;

    end;

  end;

  Form1.Button10Click(Sender);

end;

procedure TForm1.Button6Click(Sender: TObject);
var
  j: Integer;
  i: Integer;
begin

  if ContMangueras <> 0 then
  begin

    for j := 1 to ContMangueras do
    begin

      for i := 1 to 2 do
      begin

        xAux := ((mangueras[j].cords[i].x - medianaX) * COS( -alfa )) + ((mangueras[j].cords[i].y - medianaY) * SIN( -alfa ));
        yAux := -((mangueras[j].cords[i].x - medianaX) * SIN( -alfa )) + ((mangueras[j].cords[i].y - medianaY) * COS( -alfa ));
        mangueras[j].cords[i].x := xAux + medianaX;
        mangueras[j].cords[i].y := yAux + medianaY;

      end;

    end;

  end;

  if ContTubos <> 0 then
  begin

    for j := 1 to ContTubos do
    begin

      for i := 1 to 2 do
      begin

        xAux := ((tubos[j].cords[i].x - medianaX) * COS( -alfa )) + ((tubos[j].cords[i].y - medianaY) * SIN( -alfa ));
        yAux := -((tubos[j].cords[i].x - medianaX) * SIN( -alfa )) + ((tubos[j].cords[i].y - medianaY) * COS( -alfa ));
        tubos[j].cords[i].x := xAux + medianaX;
        tubos[j].cords[i].y := yAux + medianaY;

      end;

    end;

  end;

  if ContCasas <> 0 then
  begin

    for j := 1 to ContCasas do
    begin

      for i := 1 to 10 do
      begin

        xAux := ((casas[j].cords[i].x - medianaX) * COS( -alfa )) + ((casas[j].cords[i].y - medianaY) * SIN( -alfa ));
        yAux := -((casas[j].cords[i].x - medianaX) * SIN( -alfa )) + ((casas[j].cords[i].y - medianaY) * COS( -alfa ));
        casas[j].cords[i].x := xAux + medianaX;
        casas[j].cords[i].y := yAux + medianaY;

      end;

    end;

  end;

  if ContEdificios <> 0 then
  begin

    for j := 1 to ContEdificios do
    begin

      for i := 1 to 10 do
      begin

        xAux := ((edificios[j].cords[i].x - medianaX) * COS( -alfa )) + ((edificios[j].cords[i].y - medianaY) * SIN( -alfa ));
        yAux := -((edificios[j].cords[i].x - medianaX) * SIN( -alfa )) + ((edificios[j].cords[i].y - medianaY) * COS( -alfa ));
        edificios[j].cords[i].x := xAux + medianaX;
        edificios[j].cords[i].y := yAux + medianaY;

      end;

    end;

  end;

  if ContValvulas <> 0 then
  begin

    for j := 1 to ContValvulas do
    begin

      for i := 1 to 10 do
      begin

        xAux := ((valvulas[j].cords[i].x - medianaX) * COS( -alfa )) + ((valvulas[j].cords[i].y - medianaY) * SIN( -alfa ));
        yAux := -((valvulas[j].cords[i].x - medianaX) * SIN( -alfa )) + ((valvulas[j].cords[i].y - medianaY) * COS( -alfa ));
        valvulas[j].cords[i].x := xAux + medianaX;
        valvulas[j].cords[i].y := yAux + medianaY;

      end;

    end;

  end;

  if ContBombas <> 0 then
  begin

    for j := 1 to ContBombas do
    begin

      for i := 1 to 10 do
      begin

        xAux := ((bombas[j].cords[i].x - medianaX) * COS( -alfa )) + ((bombas[j].cords[i].y - medianaY) * SIN( -alfa ));
        yAux := -((bombas[j].cords[i].x - medianaX) * SIN( -alfa )) + ((bombas[j].cords[i].y - medianaY) * COS( -alfa ));
        bombas[j].cords[i].x := xAux + medianaX;
        bombas[j].cords[i].y := yAux + medianaY;

      end;

    end;

  end;

  if ContMedidores <> 0 then
  begin

    for j := 1 to ContMedidores do
    begin

      for i := 1 to 10 do
      begin

        xAux := ((medidores[j].cords[i].x - medianaX) * COS( -alfa )) + ((medidores[j].cords[i].y - medianaY) * SIN( -alfa ));
        yAux := -((medidores[j].cords[i].x - medianaX) * SIN( -alfa )) + ((medidores[j].cords[i].y - medianaY) * COS( -alfa ));
        medidores[j].cords[i].x := xAux + medianaX;
        medidores[j].cords[i].y := yAux + medianaY;

      end;

    end;

  end;

  if ContDistri <> 0 then
  begin

    for j := 1 to ContDistri do
    begin

      for i := 1 to 10 do
      begin

        xAux := ((distribuidores[j].cords[i].x - medianaX) * COS( -alfa )) + ((distribuidores[j].cords[i].y - medianaY) * SIN( -alfa ));
        yAux := -((distribuidores[j].cords[i].x - medianaX) * SIN( -alfa )) + ((distribuidores[j].cords[i].y - medianaY) * COS( -alfa ));
        distribuidores[j].cords[i].x := xAux + medianaX;
        distribuidores[j].cords[i].y := yAux + medianaY;

      end;

    end;

  end;

  Form1.Button10Click(Sender);

end;

procedure TForm1.Button7Click(Sender: TObject);
begin

  OjoAObjeto := OjoAObjeto * 1.10;
  Form1.Button10Click(Sender);

end;

procedure TForm1.Button8Click(Sender: TObject);
begin

  OjoAObjeto := OjoAObjeto * 0.90;
  Form1.Button10Click(Sender);

end;

procedure TForm1.Button9Click(Sender: TObject);
var
  f : TextFile;
  temp : String;
  angulo : Integer;

begin

  OpenDialog1.Execute();
  AssignFile(f,OpenDialog1.FileName);
  Reset(f);

  if OpenDialog1.Name <> '' then //Si el usuario da cancelar no ocurre absolutamente nada.
  begin

    Xmax := 0; Xmin := 2000; Ymax := 0; Ymin := 2000;

    //Inicializamos los contadores.
    ContMangueras := 0;
    ContTubos := 0;
    ContCasas := 0;
    ContEdificios := 0;
    ContValvulas := 0;
    ContBombas := 0;
    ContMedidores := 0;
    ContDistri := 0;

    while not EoF(f) do
    begin

      Readln(f, temp);

      if temp = 'a' then
      begin

        ContMangueras := ContMangueras + 1;

        Readln(f,mangueras[ContMangueras].cords[1].x);
        Readln(f,mangueras[ContMangueras].cords[1].y);
        Readln(f,mangueras[ContMangueras].cords[2].x);
        Readln(f,mangueras[ContMangueras].cords[2].y);
        mangueras[ContMangueras].cords[1].z := 0;
        mangueras[ContMangueras].cords[2].z := 0;

        if Xmin > mangueras[ContMangueras].cords[1].x then
          Xmin := Round(mangueras[ContMangueras].cords[1].x);
        if Xmin > mangueras[ContMangueras].cords[2].x then
          Xmin := Round(mangueras[ContMangueras].cords[2].x);

        if Xmax < mangueras[ContMangueras].cords[1].x then
          Xmax := Round(mangueras[ContMangueras].cords[1].x);
        if Xmax < mangueras[ContMangueras].cords[2].x then
          Xmax := Round(mangueras[ContMangueras].cords[2].x);

        if Ymin > mangueras[ContMangueras].cords[1].y then
          Ymin := Round(mangueras[ContMangueras].cords[1].y);
        if Ymin > mangueras[ContMangueras].cords[2].y then
          Ymin := Round(mangueras[ContMangueras].cords[2].y);

        if Ymax < mangueras[ContMangueras].cords[1].y then
          Ymax := Round(mangueras[ContMangueras].cords[1].y);
        if Ymax < mangueras[ContMangueras].cords[2].y then
          Ymax := Round(mangueras[ContMangueras].cords[2].y);

      end;

      if temp = 'b' then
      begin

        ContTubos := ContTubos + 1;

        Readln(f,tubos[ContTubos].cords[1].x);
        Readln(f,tubos[ContTubos].cords[1].y);
        Readln(f,tubos[ContTubos].cords[2].x);
        Readln(f,tubos[ContTubos].cords[2].y);
        tubos[ContTubos].cords[1].z := 0;
        tubos[ContTubos].cords[2].z := 0;

        if Xmin > tubos[ContTubos].cords[1].x then
          Xmin := Round(tubos[ContTubos].cords[1].x);
        if Xmin > tubos[ContTubos].cords[2].x then
          Xmin := Round(tubos[ContTubos].cords[2].x);

        if Xmax < tubos[ContTubos].cords[1].x then
          Xmax := Round(tubos[ContTubos].cords[1].x);
        if Xmax < tubos[ContTubos].cords[2].x then
          Xmax := Round(tubos[ContTubos].cords[2].x);

        if Ymin > tubos[ContTubos].cords[1].y then
          Ymin := Round(tubos[ContTubos].cords[1].y);
        if Ymin > tubos[ContTubos].cords[2].y then
          Ymin := Round(tubos[ContTubos].cords[2].y);

        if Ymax < tubos[ContTubos].cords[1].y then
          Ymax := Round(tubos[ContTubos].cords[1].y);
        if Ymax < tubos[ContTubos].cords[2].y then
          Ymax := Round(tubos[ContTubos].cords[2].y);

      end;

      if temp = 'c' then
      begin

        ContCasas := ContCasas + 1;

        Readln(f,casas[ContCasas].cords[1].x);
        Readln(f,casas[ContCasas].cords[1].y);
        Readln(f,angulo);
        casas[ContCasas].cords[1].z := 0;

        if Xmax < (casas[ContCasas].cords[1].x + 80) then
          Xmax := Round(casas[ContCasas].cords[1].x + 80);
        if Xmin > casas[ContCasas].cords[1].x then
          Xmin := Round(casas[ContCasas].cords[1].x);
        if Ymax < (casas[ContCasas].cords[1].y + 80) then
          Ymax := Round(casas[ContCasas].cords[1].y + 80);
        if Ymin > casas[ContCasas].cords[1].y then
          Ymin := Round(casas[ContCasas].cords[1].y);

        casas[ContCasas].cords[2].x := casas[ContCasas].cords[1].x + 80;
        casas[ContCasas].cords[2].y := casas[ContCasas].cords[1].y;
        casas[ContCasas].cords[2].z := 0;

        casas[ContCasas].cords[3].x := casas[ContCasas].cords[1].x + 80;
        casas[ContCasas].cords[3].y := casas[ContCasas].cords[1].y + 80;
        casas[ContCasas].cords[3].z := 0;

        casas[ContCasas].cords[4].x := casas[ContCasas].cords[1].x;
        casas[ContCasas].cords[4].y := casas[ContCasas].cords[1].y + 80;
        casas[ContCasas].cords[4].z := 0;

        casas[ContCasas].cords[5].x := casas[ContCasas].cords[1].x;
        casas[ContCasas].cords[5].y := casas[ContCasas].cords[1].y;
        casas[ContCasas].cords[5].z := 0;

        casas[ContCasas].cords[6].x := casas[ContCasas].cords[1].x;
        casas[ContCasas].cords[6].y := casas[ContCasas].cords[1].y;
        casas[ContCasas].cords[6].z := 80;

        casas[ContCasas].cords[7].x := casas[ContCasas].cords[1].x + 80;
        casas[ContCasas].cords[7].y := casas[ContCasas].cords[1].y;
        casas[ContCasas].cords[7].z := 80;

        casas[ContCasas].cords[8].x := casas[ContCasas].cords[1].x + 80;
        casas[ContCasas].cords[8].y := casas[ContCasas].cords[1].y + 80;
        casas[ContCasas].cords[8].z := 80;

        casas[ContCasas].cords[9].x := casas[ContCasas].cords[1].x;
        casas[ContCasas].cords[9].y := casas[ContCasas].cords[1].y + 80;
        casas[ContCasas].cords[9].z := 80;

        casas[ContCasas].cords[10].x := casas[ContCasas].cords[1].x;
        casas[ContCasas].cords[10].y := casas[ContCasas].cords[1].y;
        casas[ContCasas].cords[10].z := 80;

      end;

      if temp = 'd' then
      begin

        ContEdificios := ContEdificios + 1;

        Readln(f,edificios[ContEdificios].cords[1].x);
        Readln(f,edificios[ContEdificios].cords[1].y);
        Readln(f, angulo);
        edificios[ContEdificios].cords[1].z := 0;

        if Xmax < (edificios[ContEdificios].cords[1].x + 80) then
          Xmax := Round(edificios[ContEdificios].cords[1].x + 80);
        if Xmin > edificios[ContEdificios].cords[1].x then
          Xmin := Round(edificios[ContEdificios].cords[1].x);
        if Ymax < (edificios[ContEdificios].cords[1].y + 80) then
          Ymax := Round(edificios[ContEdificios].cords[1].y + 80);
        if Ymin > edificios[ContEdificios].cords[1].y then
          Ymin := Round(edificios[ContEdificios].cords[1].y);

        edificios[ContEdificios].cords[2].x := edificios[ContEdificios].cords[1].x + 80;
        edificios[ContEdificios].cords[2].y := edificios[ContEdificios].cords[1].y;
        edificios[ContEdificios].cords[2].z := 0;

        edificios[ContEdificios].cords[3].x := edificios[ContEdificios].cords[1].x + 80;
        edificios[ContEdificios].cords[3].y := edificios[ContEdificios].cords[1].y + 80;
        edificios[ContEdificios].cords[3].z := 0;

        edificios[ContEdificios].cords[4].x := edificios[ContEdificios].cords[1].x;
        edificios[ContEdificios].cords[4].y := edificios[ContEdificios].cords[1].y + 80;
        edificios[ContEdificios].cords[4].z := 0;

        edificios[ContEdificios].cords[5].x := edificios[ContEdificios].cords[1].x;
        edificios[ContEdificios].cords[5].y := edificios[ContEdificios].cords[1].y;
        edificios[ContEdificios].cords[5].z := 0;

        edificios[ContEdificios].cords[6].x := edificios[ContEdificios].cords[1].x;
        edificios[ContEdificios].cords[6].y := edificios[ContEdificios].cords[1].y;
        edificios[ContEdificios].cords[6].z := 160;

        edificios[ContEdificios].cords[7].x := edificios[ContEdificios].cords[1].x + 80;
        edificios[ContEdificios].cords[7].y := edificios[ContEdificios].cords[1].y;
        edificios[ContEdificios].cords[7].z := 160;

        edificios[ContEdificios].cords[8].x := edificios[ContEdificios].cords[1].x + 80;
        edificios[ContEdificios].cords[8].y := edificios[ContEdificios].cords[1].y + 80;
        edificios[ContEdificios].cords[8].z := 160;

        edificios[ContEdificios].cords[9].x := edificios[ContEdificios].cords[1].x;
        edificios[ContEdificios].cords[9].y := edificios[ContEdificios].cords[1].y + 80;
        edificios[ContEdificios].cords[9].z := 160;

        edificios[ContEdificios].cords[10].x := edificios[ContEdificios].cords[1].x;
        edificios[ContEdificios].cords[10].y := edificios[ContEdificios].cords[1].y;
        edificios[ContEdificios].cords[10].z := 160;

      end;

      if temp = 'e' then
      begin

        ContValvulas := ContValvulas + 1;

        Readln(f,valvulas[ContValvulas].cords[1].x);
        Readln(f,valvulas[ContValvulas].cords[1].y);
        valvulas[ContValvulas].cords[1].z := 0;

        if Xmax < (valvulas[ContValvulas].cords[1].x + 80) then
          Xmax := Round(valvulas[ContValvulas].cords[1].x + 80);
        if Xmin > valvulas[ContValvulas].cords[1].x then
          Xmin := Round(valvulas[ContValvulas].cords[1].x);
        if Ymax < (valvulas[ContValvulas].cords[1].y + 80) then
          Ymax := Round(valvulas[ContValvulas].cords[1].y + 80);
        if Ymin > valvulas[ContValvulas].cords[1].y then
          Ymin := Round(valvulas[ContValvulas].cords[1].y);

        valvulas[ContValvulas].cords[2].x := valvulas[ContValvulas].cords[1].x + 80;
        valvulas[ContValvulas].cords[2].y := valvulas[ContValvulas].cords[1].y;
        valvulas[ContValvulas].cords[2].z := 0;

        valvulas[ContValvulas].cords[3].x := valvulas[ContValvulas].cords[1].x + 80;
        valvulas[ContValvulas].cords[3].y := valvulas[ContValvulas].cords[1].y + 80;
        valvulas[ContValvulas].cords[3].z := 0;

        valvulas[ContValvulas].cords[4].x := valvulas[ContValvulas].cords[1].x;
        valvulas[ContValvulas].cords[4].y := valvulas[ContValvulas].cords[1].y + 80;
        valvulas[ContValvulas].cords[4].z := 0;

        valvulas[ContValvulas].cords[5].x := valvulas[ContValvulas].cords[1].x;
        valvulas[ContValvulas].cords[5].y := valvulas[ContValvulas].cords[1].y;
        valvulas[ContValvulas].cords[5].z := 0;

        valvulas[ContValvulas].cords[6].x := valvulas[ContValvulas].cords[1].x;
        valvulas[ContValvulas].cords[6].y := valvulas[ContValvulas].cords[1].y;
        valvulas[ContValvulas].cords[6].z := 10;

        valvulas[ContValvulas].cords[7].x := valvulas[ContValvulas].cords[1].x + 80;
        valvulas[ContValvulas].cords[7].y := valvulas[ContValvulas].cords[1].y;
        valvulas[ContValvulas].cords[7].z := 10;

        valvulas[ContValvulas].cords[8].x := valvulas[ContValvulas].cords[1].x + 80;
        valvulas[ContValvulas].cords[8].y := valvulas[ContValvulas].cords[1].y + 80;
        valvulas[ContValvulas].cords[8].z := 10;

        valvulas[ContValvulas].cords[9].x := valvulas[ContValvulas].cords[1].x;
        valvulas[ContValvulas].cords[9].y := valvulas[ContValvulas].cords[1].y + 80;
        valvulas[ContValvulas].cords[9].z := 10;

        valvulas[ContValvulas].cords[10].x := valvulas[ContValvulas].cords[1].x;
        valvulas[ContValvulas].cords[10].y := valvulas[ContValvulas].cords[1].y;
        valvulas[ContValvulas].cords[10].z := 10;

      end;

      if temp = 'f' then
      begin

        ContBombas := ContBombas + 1;

        Readln(f,bombas[ContBombas].cords[1].x);
        Readln(f,bombas[ContBombas].cords[1].y);
        bombas[ContBombas].cords[1].z := 0;

        if Xmax < (bombas[ContBombas].cords[1].x + 80) then
          Xmax := Round(bombas[ContBombas].cords[1].x + 80);
        if Xmin > bombas[ContBombas].cords[1].x then
          Xmin := Round(bombas[ContBombas].cords[1].x);
        if Ymax < (bombas[ContBombas].cords[1].y + 80) then
          Ymax := Round(bombas[ContBombas].cords[1].y + 80);
        if Ymin > bombas[ContBombas].cords[1].y then
          Ymin := Round(bombas[ContBombas].cords[1].y);

        bombas[ContBombas].cords[2].x := bombas[ContBombas].cords[1].x + 80;
        bombas[ContBombas].cords[2].y := bombas[ContBombas].cords[1].y;
        bombas[ContBombas].cords[2].z := 0;

        bombas[ContBombas].cords[3].x := bombas[ContBombas].cords[1].x + 80;
        bombas[ContBombas].cords[3].y := bombas[ContBombas].cords[1].y + 80;
        bombas[ContBombas].cords[3].z := 0;

        bombas[ContBombas].cords[4].x := bombas[ContBombas].cords[1].x;
        bombas[ContBombas].cords[4].y := bombas[ContBombas].cords[1].y + 80;
        bombas[ContBombas].cords[4].z := 0;

        bombas[ContBombas].cords[5].x := bombas[ContBombas].cords[1].x;
        bombas[ContBombas].cords[5].y := bombas[ContBombas].cords[1].y;
        bombas[ContBombas].cords[5].z := 0;

        bombas[ContBombas].cords[6].x := bombas[ContBombas].cords[1].x;
        bombas[ContBombas].cords[6].y := bombas[ContBombas].cords[1].y;
        bombas[ContBombas].cords[6].z := 40;

        bombas[ContBombas].cords[7].x := bombas[ContBombas].cords[1].x + 80;
        bombas[ContBombas].cords[7].y := bombas[ContBombas].cords[1].y;
        bombas[ContBombas].cords[7].z := 40;

        bombas[ContBombas].cords[8].x := bombas[ContBombas].cords[1].x + 80;
        bombas[ContBombas].cords[8].y := bombas[ContBombas].cords[1].y + 80;
        bombas[ContBombas].cords[8].z := 40;

        bombas[ContBombas].cords[9].x := bombas[ContBombas].cords[1].x;
        bombas[ContBombas].cords[9].y := bombas[ContBombas].cords[1].y + 80;
        bombas[ContBombas].cords[9].z := 40;

        bombas[ContBombas].cords[10].x := bombas[ContBombas].cords[1].x;
        bombas[ContBombas].cords[10].y := bombas[ContBombas].cords[1].y;
        bombas[ContBombas].cords[10].z := 40;

      end;

      if temp = 'g' then
      begin

        ContMedidores := ContMedidores + 1;

        Readln(f,medidores[ContMedidores].cords[1].x);
        Readln(f,medidores[ContMedidores].cords[1].y);
        medidores[ContMedidores].cords[1].z := 0;

        if Xmax < (medidores[ContMedidores].cords[1].x + 80) then
          Xmax := Round(medidores[ContMedidores].cords[1].x + 80);
        if Xmin > medidores[ContMedidores].cords[1].x then
          Xmin := Round(medidores[ContMedidores].cords[1].x);
        if Ymax < (medidores[ContMedidores].cords[1].y + 80) then
          Ymax := Round(medidores[ContMedidores].cords[1].y + 80);
        if Ymin > medidores[ContMedidores].cords[1].y then
          Ymin := Round(medidores[ContMedidores].cords[1].y);

        medidores[ContMedidores].cords[2].x := medidores[ContMedidores].cords[1].x + 80;
        medidores[ContMedidores].cords[2].y := medidores[ContMedidores].cords[1].y;
        medidores[ContMedidores].cords[2].z := 0;

        medidores[ContMedidores].cords[3].x := medidores[ContMedidores].cords[1].x + 80;
        medidores[ContMedidores].cords[3].y := medidores[ContMedidores].cords[1].y + 80;
        medidores[ContMedidores].cords[3].z := 0;

        medidores[ContMedidores].cords[4].x := medidores[ContMedidores].cords[1].x;
        medidores[ContMedidores].cords[4].y := medidores[ContMedidores].cords[1].y + 80;
        medidores[ContMedidores].cords[4].z := 0;

        medidores[ContMedidores].cords[5].x := medidores[ContMedidores].cords[1].x;
        medidores[ContMedidores].cords[5].y := medidores[ContMedidores].cords[1].y;
        medidores[ContMedidores].cords[5].z := 0;

        medidores[ContMedidores].cords[6].x := medidores[ContMedidores].cords[1].x;
        medidores[ContMedidores].cords[6].y := medidores[ContMedidores].cords[1].y;
        medidores[ContMedidores].cords[6].z := 10;

        medidores[ContMedidores].cords[7].x := medidores[ContMedidores].cords[1].x + 80;
        medidores[ContMedidores].cords[7].y := medidores[ContMedidores].cords[1].y;
        medidores[ContMedidores].cords[7].z := 10;

        medidores[ContMedidores].cords[8].x := medidores[ContMedidores].cords[1].x + 80;
        medidores[ContMedidores].cords[8].y := medidores[ContMedidores].cords[1].y + 80;
        medidores[ContMedidores].cords[8].z := 10;

        medidores[ContMedidores].cords[9].x := medidores[ContMedidores].cords[1].x;
        medidores[ContMedidores].cords[9].y := medidores[ContMedidores].cords[1].y + 80;
        medidores[ContMedidores].cords[9].z := 10;

        medidores[ContMedidores].cords[10].x := medidores[ContMedidores].cords[1].x;
        medidores[ContMedidores].cords[10].y := medidores[ContMedidores].cords[1].y;
        medidores[ContMedidores].cords[10].z := 10;

      end;

      if temp = 'h' then
      begin

        ContDistri := ContDistri + 1;

        Readln(f,distribuidores[ContDistri].cords[1].x);
        Readln(f,distribuidores[ContDistri].cords[1].y);
        distribuidores[ContDistri].cords[1].z := 0;

        if Xmax < (distribuidores[ContDistri].cords[1].x + 80) then
          Xmax := Round(distribuidores[ContDistri].cords[1].x + 80);
        if Xmin > distribuidores[ContDistri].cords[1].x then
          Xmin := Round(distribuidores[ContDistri].cords[1].x);
        if Ymax < (distribuidores[ContDistri].cords[1].y + 80) then
          Ymax := Round(distribuidores[ContDistri].cords[1].y + 80);
        if Ymin > distribuidores[ContDistri].cords[1].y then
          Ymin := Round(distribuidores[ContDistri].cords[1].y);

        distribuidores[ContDistri].cords[2].x := distribuidores[ContDistri].cords[1].x + 80;
        distribuidores[ContDistri].cords[2].y := distribuidores[ContDistri].cords[1].y;
        distribuidores[ContDistri].cords[2].z := 0;

        distribuidores[ContDistri].cords[3].x := distribuidores[ContDistri].cords[1].x + 80;
        distribuidores[ContDistri].cords[3].y := distribuidores[ContDistri].cords[1].y + 80;
        distribuidores[ContDistri].cords[3].z := 0;

        distribuidores[ContDistri].cords[4].x := distribuidores[ContDistri].cords[1].x;
        distribuidores[ContDistri].cords[4].y := distribuidores[ContDistri].cords[1].y + 80;
        distribuidores[ContDistri].cords[4].z := 0;

        distribuidores[ContDistri].cords[5].x := distribuidores[ContDistri].cords[1].x;
        distribuidores[ContDistri].cords[5].y := distribuidores[ContDistri].cords[1].y;
        distribuidores[ContDistri].cords[5].z := 0;

        distribuidores[ContDistri].cords[6].x := distribuidores[ContDistri].cords[1].x;
        distribuidores[ContDistri].cords[6].y := distribuidores[ContDistri].cords[1].y;
        distribuidores[ContDistri].cords[6].z := 20;

        distribuidores[ContDistri].cords[7].x := distribuidores[ContDistri].cords[1].x + 80;
        distribuidores[ContDistri].cords[7].y := distribuidores[ContDistri].cords[1].y;
        distribuidores[ContDistri].cords[7].z := 20;

        distribuidores[ContDistri].cords[8].x := distribuidores[ContDistri].cords[1].x + 80;
        distribuidores[ContDistri].cords[8].y := distribuidores[ContDistri].cords[1].y + 80;
        distribuidores[ContDistri].cords[8].z := 20;

        distribuidores[ContDistri].cords[9].x := distribuidores[ContDistri].cords[1].x;
        distribuidores[ContDistri].cords[9].y := distribuidores[ContDistri].cords[1].y + 80;
        distribuidores[ContDistri].cords[9].z := 20;

        distribuidores[ContDistri].cords[10].x := distribuidores[ContDistri].cords[1].x;
        distribuidores[ContDistri].cords[10].y := distribuidores[ContDistri].cords[1].y;
        distribuidores[ContDistri].cords[10].z := 20;

      end;

    end;
    CloseFile(f);

  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  Image1.Canvas.Rectangle(0,0,600,600);

  OjoAObjeto := 900;
  D := 700;

  alfa := (15*Pi) / 180;

end;

end.
