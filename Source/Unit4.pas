unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ADODB, DB,dec;

type
  TForm4 = class(TForm)
    Label4: TLabel;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox2: TComboBox;
    GroupBox2: TGroupBox;
    BitBtn5: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn6: TBitBtn;
    muQuery: TADOQuery;
    muupdate: TADOCommand;
    PaintBox1: TPaintBox;
    Muquery2: TADOQuery;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    PaintBox2: TPaintBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormPaint(Sender: TObject);
    procedure grid;
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel51MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel1Click(Sender: TObject);
    procedure Panel17Click(Sender: TObject);
    procedure iniciar;
    procedure desenhar;
    procedure charactermostrar;
    procedure criar;
  private
    { Private declarations }
  public
    Drawing: Boolean;
  end;

var
  Form4: TForm4;
  cor: tcolor;
  agrid: array[1..8,1..8] of tcolor;

implementation

uses Unit1, Unit2;

{$R *.dfm}

procedure tform4.criar;
var x,y:integer;
marksql:string;
begin
  marksql:='';
  for y := 1 to 8 do
    for x := 1 to 8 do
      begin
        if agrid[x,y]=$666666 then marksql:=marksql+'0';
        if agrid[x,y]=$000000 then marksql:=marksql+'1';
        if agrid[x,y]=$8c8a8d then marksql:=marksql+'2';
        if agrid[x,y]=$ffffff then marksql:=marksql+'3';
        if agrid[x,y]=$0000fe then marksql:=marksql+'4';
        if agrid[x,y]=$008aff then marksql:=marksql+'5';
        if agrid[x,y]=$ffff00 then marksql:=marksql+'6';
        if agrid[x,y]=$01FF8D then marksql:=marksql+'7';
        if agrid[x,y]=$00ff00 then marksql:=marksql+'8';
        if agrid[x,y]=$8CFF01 then marksql:=marksql+'9';
        if agrid[x,y]=$00ffff then marksql:=marksql+'A';
        if agrid[x,y]=$ff8a00 then marksql:=marksql+'B';
        if agrid[x,y]=$fe0000 then marksql:=marksql+'C';
        if agrid[x,y]=$FF008C then marksql:=marksql+'D';
        if agrid[x,y]=$ff00fe then marksql:=marksql+'E';
        if agrid[x,y]=$8C00FF then marksql:=marksql+'F';
      end;
  muupdate.CommandText:='INSERT INTO '+guild+' ('+G_Name+','+G_Master+')  VALUES ('''+edit1.text+''','''+combobox2.text+''')';
  muupdate.Execute;
  muupdate.CommandText:='Update '+guild+' set '+g_mark+'=0x'+marksql+' where '+G_Name+'='''+edit1.text+'''';
  muupdate.Execute;
  if vs<>'CMT' then
    muupdate.CommandText:='INSERT INTO '+guildmember+' ('+G_Name2+','+Nome2+')  VALUES ('''+edit1.text+''','''+combobox2.text+''')'
      else muupdate.CommandText:='INSERT INTO '+guildmember+' ('+G_Name2+','+Nome2+','+G_Level2+','+G_status+')  VALUES ('''+edit1.text+''','''+combobox2.text+''',0,128)';
  muupdate.Execute;
end;
procedure TForm4.BitBtn1Click(Sender: TObject);
begin
if (combobox2.text<>'') and (edit1.Text<>'') then
  begin
    criar;
    guildsave:=edit1.Text;
    form2.show;
    form2.caption:=EditGuildForm+' '+guildsave+'';
    form2.iniciar;
    form4.Hide;
  end
    else   application.MessageBox(pchar(error18),pchar(errorcaption),mb_iconwarning)
end;

procedure TForm4.BitBtn5Click(Sender: TObject);
begin
if (combobox2.text<>'') and (edit1.Text<>'') then
  begin
    criar;
    form1.lerguilds;
    form1.update;
    form1.combobox1.ItemIndex:=0;
    form1.infor;
    form1.Enabled:=true;
    form4.Hide;
  end
    else   application.MessageBox(pchar(error18),pchar(errorcaption),mb_iconwarning)
end;

procedure TForm4.BitBtn6Click(Sender: TObject);
begin

form1.Enabled:=true;
form4.hide;
end;

procedure Tform4.CharacterMostrar; {Mostra Lista de Characters}
var i:byte;
j:integer;
accountsave:string;
begin
  Combobox2.Items.Clear;
  AccountSave:=Combobox1.Text;
  muquery.SQL.Clear;
  if combobox1.Text<>all then
    begin
      muquery.SQL.Add('select '+GameID1+','+GameID2+','+GameID3+','+GameID4+','+GameID5+' from '+AccountCharacter+' where '+Id+'='''+AccountSave+'''');
      muquery.Open;
      for i:=0 to 4 do
        begin
          if muquery.Fields[i].asstring<>'' then
            begin
              muquery2.SQL.Clear;
              muquery2.SQL.Add('select '+G_name2+' from '+GuildMember+' where '+nome2+'='''+muquery.Fields[i].asstring+'''');
              muquery2.Open;
              if (muquery2.Eof) and (muquery2.Bof) then
              Combobox2.Items.Add(muquery.Fields[i].asstring);
              muquery2.close;
            end;
        end;
      muquery.Close;
    end
      else
        begin
          muquery.SQL.Add('select '+GameID1+','+GameID2+','+GameID3+','+GameID4+','+GameID5+' from '+AccountCharacter+'');
          muquery.Open;
          for j := 0 to muquery.RecordCount-1 do
            begin
              for i:=0 to 4 do
                begin
                  if muquery.Fields[i].asstring<>'' then
                    begin
                      muquery2.SQL.Clear;
                      muquery2.SQL.Add('select '+G_name2+' from '+GuildMember+' where '+nome2+'='''+muquery.Fields[i].asstring+'''');
                      muquery2.Open;
                      if (muquery2.Eof) and (muquery2.Bof) then
                      Combobox2.Items.Add(muquery.Fields[i].asstring);
                      muquery2.close;
                    end;
                end;
              muquery.Next;
            end;
          muquery.Close;
        end;
end;
procedure Tform4.iniciar;
var x,y,i:integer;
begin
  for x := 1 to 8 do
    for y := 1 to 8 do
      agrid[x,y]:=$00666666;
  cor:=$00666666;
  paintbox1.canvas.Pen.Color:=$00666666;
  paintbox1.canvas.Pen.width:=144;
  paintbox1.canvas.moveto(72,0);
  paintbox1.Canvas.LineTo(72,144);
  paintbox1.canvas.Pen.width:=1;
  paintbox1.canvas.Pen.Color:=clblack;
  form4.grid;
  edit1.Text:='';
  combobox1.Items.clear;
  combobox1.Items.Add('(todas)');
  combobox2.Items.clear;
  muquery.SQL.clear;
  muquery.SQL.Add('select '+ID+' from '+AccountCharacter+'');
  muquery.Open;
  if (muquery.Eof) and (muquery.Bof) then
     application.MessageBox(pchar(error10),pchar(errorcaption),mb_iconwarning)
    else
      begin
        for i:=0 to muquery.RecordCount-1 do
          begin
            combobox1.Items.Add(muquery.Fields[0].asstring);
            muquery.Next;
          end;
      end;
  combobox1.Text:='';
  form4.Update;
  
end;
procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
form1.Enabled:=true;
end;
procedure TForm4.FormPaint(Sender: TObject);
begin
 paintbox1.canvas.Pen.Color:=clblack;
 grid;
 desenhar;
end;
procedure TForm4.ComboBox1Change(Sender: TObject);
begin
charactermostrar;
end;
procedure tform4.desenhar;
var x,y,z:integer;
begin
  for y:= 1 to 8 do
    for x := 1 to 8  do
      begin
        paintbox1.canvas.Pen.Color:=agrid[x,y];
        for z:=1 to 17 do
          begin
            paintbox1.Canvas.MoveTo(18*(x-1)+1, 18*(y-1)+z);
      	    paintbox1.Canvas.LineTo(18*(x-1)+18, 18*(y-1)+z);
          end;
        if agrid[x,y]=$00666666 then
          begin
            paintbox1.canvas.Pen.Color:=clwhite;
            paintbox1.canvas.Pen.width:=2;
            paintbox1.Canvas.MoveTo(18*(x-1)+2, 18*(y-1)+2);
      	    paintbox1.Canvas.LineTo(18*(x-1)+16, 18*(y-1)+16);
            paintbox1.Canvas.MoveTo(18*(x-1)+2, 18*(y-1)+16);
      	    paintbox1.Canvas.LineTo(18*(x-1)+16, 18*(y-1)+2);
            paintbox1.canvas.Pen.width:=1;
          end;
      end;
end;
procedure tform4.grid;
begin

  paintbox1.canvas.Pen.width:=1;
  paintbox1.canvas.moveto(0,0);
  paintbox1.Canvas.LineTo(0,144);
  paintbox1.canvas.moveto(18,0);
  paintbox1.Canvas.LineTo(18,144);
  paintbox1.canvas.moveto(36,0);
  paintbox1.Canvas.LineTo(36,144);
  paintbox1.canvas.moveto(54,0);
  paintbox1.Canvas.LineTo(54,144);
  paintbox1.canvas.moveto(72,0);
  paintbox1.Canvas.LineTo(72,144);
  paintbox1.canvas.moveto(90,0);
  paintbox1.Canvas.LineTo(90,144);
  paintbox1.canvas.moveto(108,0);
  paintbox1.Canvas.LineTo(108,144);
  paintbox1.canvas.moveto(126,0);
  paintbox1.Canvas.LineTo(126,144);
  paintbox1.canvas.moveto(144,0);
  paintbox1.Canvas.LineTo(144,144);
//horizontal
  paintbox1.canvas.moveto(0,0);
  paintbox1.Canvas.LineTo(144,0);
  paintbox1.canvas.moveto(0,18);
  paintbox1.Canvas.LineTo(144,18);
  paintbox1.canvas.moveto(0,36);
  paintbox1.Canvas.LineTo(144,36);
  paintbox1.canvas.moveto(0,54);
  paintbox1.Canvas.LineTo(144,54);
  paintbox1.canvas.moveto(0,72);
  paintbox1.Canvas.LineTo(144,72);
  paintbox1.canvas.moveto(0,90);
  paintbox1.Canvas.LineTo(144,90);
  paintbox1.canvas.moveto(0,108);
  paintbox1.Canvas.LineTo(144,108);
  paintbox1.canvas.moveto(0,126);
  paintbox1.Canvas.LineTo(144,126);
  paintbox1.canvas.moveto(0,144);
  paintbox1.Canvas.LineTo(144,144);
    paintbox2.canvas.Pen.width:=2;
  paintbox2.Canvas.MoveTo(0,0);
  paintbox2.Canvas.LineTo(16,16);
  paintbox2.Canvas.MoveTo(0,16);
  paintbox2.Canvas.LineTo(16,0);
  form4.Update;
end;
procedure TForm4.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var y2,x2,z:integer;
begin
Drawing := True;
for y2:=0 to 7 do
      for x2:=0 to 7 do
        if (x>=(x2*18)) and (x<((x2*18)+18)) and (y>=(y2*18)) and (y<((y2*18)+18)) then
          begin
            agrid[x2+1,y2+1]:=cor;
            for z:=1 to 17 do
              begin
                paintbox1.canvas.Pen.Color:=cor;
                paintbox1.Canvas.MoveTo(18*(x2)+1, 18*(y2)+z);
      	      	paintbox1.Canvas.LineTo(18*(x2)+18, 18*(y2)+z);
              end;
            if agrid[x2+1,y2+1]=$00666666 then
              begin
                paintbox1.canvas.Pen.Color:=clwhite;
                paintbox1.canvas.Pen.width:=2;
                paintbox1.Canvas.MoveTo(18*(x2)+2, 18*(y2)+2);
           	    paintbox1.Canvas.LineTo(18*(x2)+16, 18*(y2)+16);
                paintbox1.Canvas.MoveTo(18*(x2)+2, 18*(y2)+16);
      	        paintbox1.Canvas.LineTo(18*(x2)+16, 18*(y2)+2);
                paintbox1.canvas.Pen.width:=1;
              end;
        //    label1.caption:=inttostr(x2+1)+','+inttostr(y2+1);
          end;
end;
procedure TForm4.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var y2,x2,z:integer;
begin
  if Drawing then
  begin
   // label1.Caption:=inttostr(x)+','+inttostr(y)   ;
  //  z:=0;
    for y2:=0 to 7 do
      for x2:=0 to 7 do
        if (x>=(x2*18)) and (x<((x2*18)+18)) and (y>=(y2*18)) and (y<((y2*18)+18)) then
          begin
            agrid[x2+1,y2+1]:=cor;
            for z:=1 to 17 do
              begin
                paintbox1.canvas.Pen.Color:=cor;
                paintbox1.Canvas.MoveTo(18*(x2)+1, 18*(y2)+z);
      	      	paintbox1.Canvas.LineTo(18*(x2)+18, 18*(y2)+z);
              end;
            if agrid[x2+1,y2+1]=$00666666 then
              begin
                paintbox1.canvas.Pen.Color:=clwhite;
                paintbox1.canvas.Pen.width:=2;
                paintbox1.Canvas.MoveTo(18*(x2)+2, 18*(y2)+2);
           	    paintbox1.Canvas.LineTo(18*(x2)+16, 18*(y2)+16);
                paintbox1.Canvas.MoveTo(18*(x2)+2, 18*(y2)+16);
      	        paintbox1.Canvas.LineTo(18*(x2)+16, 18*(y2)+2);
                paintbox1.canvas.Pen.width:=1;
              end;
        //    label1.caption:=inttostr(x2+1)+','+inttostr(y2+1);
          end;

    form4.Update;

  end;
end;
procedure TForm4.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Drawing then
  begin
    Drawing := False;
  end;
end;
procedure TForm4.Panel17Click(Sender: TObject);
begin
 cor:=(sender as tpanel).Color
end;
procedure TForm4.Panel1Click(Sender: TObject);
begin
  cor:=(sender as tpanel).color;
end;
procedure TForm4.Panel51MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  (sender as tpanel).Color:=cor;
end;

end.                                                 
