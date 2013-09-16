program Project1;

uses
  Forms,
  Unit1 in '..\..\Entrada\Unit1.pas' {Form1},
  FlashForm in '..\..\Entrada\FlashForm.pas' {MUFlash};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TMUFlash, MUFlash);
  Application.Run;
end.
