program ProjectVisor3D;

uses
  Vcl.Forms,
  Visor3D in 'Visor3D.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
