unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls,strUtils, ValEdit, ExtCtrls, Buttons,dec,
  ComCtrls, Menus,
  ToolWin, CheckLst;
type
  TForm2 = class(TForm)
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn9: TBitBtn;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    muQuery: TADOQuery;
    muupdate: TADOCommand;
    Label6: TLabel;
    Edit1: TEdit;
    Muquery2: TADOQuery;
    PaintBox1: TPaintBox;
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
    Edit2: TEdit;
    ListBox1: TListBox;
    PaintBox2: TPaintBox;
    BitBtn8: TBitBtn;
    BitBtn7: TBitBtn;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel1Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure iniciar;
    procedure lerguild;
    procedure desenhar;
    procedure grid;
    procedure leracc;
    procedure Charactermostrar;
    procedure editar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  agrid:array[1..8,1..8] of tcolor;
  cor: tcolor;
  sel:string;
  drawing:boolean;
  GMNum,AsNum,BMNum1,BMNum2,BMNum3:integer;
implementation

uses Unit1;

{$R *.dfm}
function bytetohex(src: byte): string;   {byte-->hex}
begin
  setlength(result, 2);
  asm
  mov edi, [result]
  mov edi, [edi]
  mov al, src
  mov ah, al // 保存至 ah
  shr al, 4 // 输出高4位
  add al, '0'
  cmp al, '9'
  jbe @@outcharlo
  add al, 'a'-'9'-1
@@outcharlo:
  and ah, $f
  add ah, '0'
  cmp ah, '9'
  jbe @@outchar
  add ah, 'a'-'9'-1
@@outchar:
  stosw
  end;
end;
{Function strByteSize(Value: Longint): String;

Const
KBYTE = Sizeof(Byte) shl 10;
MBYTE = KBYTE shl 10;
GBYTE = MBYTE shl 10;
begin
if Value > GBYTE then
begin
Result := FloatToStrF(Round(Value / GBYTE),ffNumber,6,0)+' GB';
end
else if Value > MBYTE then
begin
Result := FloatToStrF(Round(Value / MBYTE),ffNumber,6,0)+' MB';
end
else if Value > KBYTE then
begin
Result := FloatToStrF(Round(Value / KBYTE),ffNumber,6,0)+' KB';
end
else
begin
Result := FloatToStrF(Round(Value),ffNumber,6,0)+' Byte';
end;
end;    }
procedure FillHexguild(item:Tfield); {填充某个账户的仓库}
type Tcharset=set of char;
var A:tcharset;
    itemblock:array of byte;
    sWS,sItem:string;
    wsrow,wscol,i,panelcount:integer;
    j,k:integer;
begin
  a:=['0'..'7'];
  with item do
    begin
      setlength(itemblock,datasize);
      try
        getdata(itemblock);
        i:=2;
        while i<=high(itemblock) do
          begin
            sws:=sws+uppercase(bytetohex(itemblock[i]));
            inc(i);
          end;
        for wscol:=1 to 8 do
          for wsrow:=1 to 8 do
            begin
              sitem:=midstr(sws,8*((wscol)-1)+1*((wsrow)-1)+1,1);
              if (sitem='0') then agrid[wsrow,wscol]:=$666666;
              if (sitem='1') then agrid[wsrow,wscol]:=$000000;
              if (sitem='2') then agrid[wsrow,wscol]:=$8c8a8d;
              if (sitem='3') then agrid[wsrow,wscol]:=$ffffff;
              if (sitem='4') then agrid[wsrow,wscol]:=$0000fe;
              if (sitem='5') then agrid[wsrow,wscol]:=$008aff;
              if (sitem='6') then agrid[wsrow,wscol]:=$ffff00;
              if (sitem='7') then agrid[wsrow,wscol]:=$01FF8D;
              if (sitem='8') then agrid[wsrow,wscol]:=$00ff00;
              if (sitem='9') then agrid[wsrow,wscol]:=$8CFF01;
              if (sitem='A') then agrid[wsrow,wscol]:=$00ffff;
              if (sitem='B') then agrid[wsrow,wscol]:=$ff8a00;
              if (sitem='C') then agrid[wsrow,wscol]:=$fe0000;
              if (sitem='D') then agrid[wsrow,wscol]:=$FF008C;
              if (sitem='E') then agrid[wsrow,wscol]:=$ff00fe;
              if (sitem='F') then agrid[wsrow,wscol]:=$8C00FF;
            end;
        form2.desenhar;
      except
      on E:exception do application.MessageBox(pchar(e.Message),'Erro',mb_ok+mb_iconerror);

      end;
    end;
end;
procedure TForm2.ComboBox2Change(Sender: TObject);
begin
CharacterMostrar;
end;
procedure TForm2.BitBtn1Click(Sender: TObject);
begin
  if listbox1.items[listbox1.itemindex]<>label5.Caption then
    begin
      if application.MessageBox(pchar(question8),'Guild Editor',mb_yesno+mb_iconinformation)=mrno then begin
        exit;
      end;
      muupdate.CommandText:='delete from '+GuildMember+' where '+nome2+'='''+listbox1.items[listbox1.itemindex]+'''';
      muupdate.execute;
      ListBox1.Items.Delete(ListBox1.ItemIndex);
      application.MessageBox(pchar(confirm6),'Guild Editor',mb_ok);
    end
      else application.MessageBox(pchar(error22),pchar(errorcaption),mb_ok+mb_iconerror);
end;
procedure TForm2.BitBtn2Click(Sender: TObject);
begin
  leracc;
  groupbox2.visible:=true;
end;
procedure TForm2.BitBtn3Click(Sender: TObject);
begin
if combobox3.Text<>'' then
  begin
    muupdate.CommandText:='insert into '+GuildMember+' ('+G_Name2+','+Nome2+')  VALUES ('''+guildsave+''','''+combobox3.text+''')';
    muupdate.execute;
    ListBox1.Items.Add(ComboBox3.Text);
    //groupbox2.visible:=false;
    leracc;
    application.MessageBox(pchar(confirm5),'Guild Editor',mb_ok);
  end
    else application.MessageBox(pchar(error21),pchar(errorcaption),mb_ok+mb_iconerror);

end;
procedure TForm2.BitBtn4Click(Sender: TObject);
begin
groupbox2.visible:=false;
end;
procedure TForm2.BitBtn5Click(Sender: TObject);
begin
  editar;
  form1.lerguilds;
  form1.update;
  form1.combobox1.ItemIndex:=0;
  form1.infor;
  form1.Enabled:=true;
  form2.Hide;
end;

procedure TForm2.BitBtn6Click(Sender: TObject);
begin

form1.Enabled:=true;
form2.Hide;
end;

procedure TForm2.BitBtn7Click(Sender: TObject);
begin
  if bitbtn7.caption=SetAssistent then
    begin
      muquery.close;
      muquery.SQL.Clear;
      muquery.sql.add('Select '+Nome2+' from '+guildmember+' where '+G_status+'=64');
      muquery.Open;
      if muquery.Bof and muquery.Eof then
        begin
          muupdate.CommandText:='Update '+Guildmember+' set '+G_status+'=64 where '+nome2+'='''+listbox1.items[listbox1.itemindex]+'''';
          muupdate.execute;
          muquery.close;
          lerguild;
        end
          else
            begin
              application.MessageBox(pchar(error24),pchar(errorcaption),mb_ok+mb_iconerror) ;
              muquery.Close;
              exit;
            end;
    end else begin
      muupdate.CommandText:='Update '+Guildmember+' set '+G_status+'=0 where '+nome2+'='''+listbox1.items[listbox1.itemindex]+'''';
      muupdate.execute;
      muquery.close;
      lerguild;
    end;

end;

procedure TForm2.BitBtn8Click(Sender: TObject);
begin
if bitbtn8.caption=SetBattleMaster then
  begin
    muquery.close;
    muquery.SQL.Clear;
    muquery.sql.add('Select '+Nome2+' from '+guildmember+' where '+G_status+'=32');
    muquery.Open;
    if muquery.recordcount=3 then
      begin
        application.MessageBox(pchar(error23),pchar(errorcaption),mb_ok+mb_iconerror) ;
        muquery.Close;
        exit;
      end;
    muupdate.CommandText:='Update '+Guildmember+' set '+G_status+'=32 where '+nome2+'='''+listbox1.items[listbox1.itemindex]+'''';
    muupdate.execute;
    muquery.close;
    lerguild;
  end else begin
    muupdate.CommandText:='Update '+Guildmember+' set '+G_status+'=0 where '+nome2+'='''+listbox1.items[listbox1.itemindex]+'''';
    muupdate.execute;
    muquery.close;
    lerguild;
  end;
end;

procedure TForm2.BitBtn9Click(Sender: TObject);
begin
  if application.MessageBox(pchar(question10),'Guild Editor',mb_yesno+mb_iconinformation)=mrno then begin
    exit;
  end;
  if vs='CMT' then
    begin
      muupdate.CommandText:='Update '+Guildmember+' set '+G_status+'=128 where '+nome2+'='''+listbox1.items[listbox1.itemindex]+'''';
      muupdate.execute;
      muupdate.CommandText:='Update '+Guildmember+' set '+G_status+'=0 where '+nome2+'='''+label5.Caption+'''';
      muupdate.execute;
    end;
  muupdate.CommandText:='Update '+Guild+' set '+G_master+'='''+listbox1.items[listbox1.itemindex]+''' where '+G_name+'='''+guildsave+'''';
  muupdate.execute;
  label5.caption:=listbox1.items[listbox1.itemindex];
  //application.MessageBox(pchar(confirm4),'Guild Editor',mb_ok);
  lerguild;

end;





procedure tform2.editar;
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
  muupdate.CommandText:='Update '+guild+' set '+g_mark+'=0x'+marksql+', '+G_Score+'='''+edit2.text+''', '+G_notice+'='''+edit1.Text+''' where '+G_Name+'='''+guildsave+'''';
  muupdate.Execute;
end;
procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
form1.Enabled:=true;
end;

procedure TForm2.FormPaint(Sender: TObject);
begin
 paintbox1.canvas.Pen.Color:=clblack;
 grid;
 desenhar;
end;

procedure tform2.desenhar;
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
procedure tform2.lerguild;
var i:integer;
s:string;
begin
  muquery.SQL.clear;
  muquery.SQL.add('select '+G_mark+','+G_Score+','+G_Master+','+G_notice+' from '+Guild+' where '+G_Name+'='''+guildsave+'''') ;
  muquery.Open;
  edit2.Text:=muquery.Fields[1].AsString;
  label5.Caption:=muquery.Fields[2].AsString;
  edit1.Text:=muquery.Fields[3].AsString;
  FillHexguild(muquery.Fields[0]);
  gmnum:=-1;
  asnum:=-1;
  bmnum1:=-1;
  bmnum2:=-1;
  bmnum3:=-1;
  muquery.Close;
  muquery.SQL.clear;
  if vs='CMT' then
    muquery.sql.Add('select '+nome2+','+G_status+' from '+guildmember+' where '+G_name2+'='''+guildsave+'''')
      else  muquery.sql.Add('select '+nome2+' from '+guildmember+' where '+G_name2+'='''+guildsave+'''');
  muquery.Open;
  listbox1.Items.Clear;
  for I:=0 to muquery.RecordCount-1 do
    begin
      if muquery.Fields[0].asstring=label5.Caption then gmnum:=i;
      if vs='CMT' then begin
        if muquery.Fields[1].asinteger=64 then asnum:=i;
        if muquery.Fields[1].asinteger=32 then
          if bmnum1=-1 then
            bmnum1:=i
              else if bmnum2=-1 then
                bmnum2:=i
                  else if bmnum3=-1 then
                    bmnum3:=i;
      end;
      listbox1.Items.Add(muquery.Fields[0].asstring);
      muquery.Next;
    end;
  muquery.close;
  listbox1.ItemIndex:=0;
  if listbox1.itemindex=gmnum then
    begin
      bitbtn9.enabled:=false;
      bitbtn7.enabled:=false;
      bitbtn8.enabled:=false;
    end else if listbox1.itemindex=asnum then
      begin
        bitbtn9.enabled:=true;
        bitbtn7.enabled:=true;
        bitbtn8.enabled:=true;
        bitbtn7.Caption:=remassistent;
      end else if (listbox1.itemindex=bmnum1) or (listbox1.itemindex=bmnum2) or (listbox1.itemindex=bmnum3)  then
        begin
          bitbtn9.enabled:=true;
          bitbtn7.enabled:=true;
          bitbtn8.enabled:=true;
          bitbtn8.Caption:=rembattlemaster;
        end
          else
            begin
              bitbtn9.enabled:=true;
              bitbtn7.enabled:=true;
              bitbtn8.enabled:=true;
            end;
end;
procedure TForm2.ListBox1Click(Sender: TObject);
begin
  if listbox1.itemindex=gmnum then
    begin
      bitbtn9.enabled:=false;
      bitbtn7.enabled:=false;
      bitbtn8.enabled:=false;
      bitbtn1.Enabled:=false;
      bitbtn7.Caption:=setassistent;
      bitbtn8.Caption:=setbattlemaster;
    end else if listbox1.itemindex=asnum then
      begin
        bitbtn9.enabled:=true;
        bitbtn7.enabled:=true;
        bitbtn8.enabled:=true;
        bitbtn1.Enabled:=true;
        bitbtn7.Caption:=remassistent;
        bitbtn8.Caption:=setbattlemaster;
      end else if (listbox1.itemindex=bmnum1) or (listbox1.itemindex=bmnum2) or (listbox1.itemindex=bmnum3)  then
        begin
          bitbtn9.enabled:=true;
          bitbtn7.enabled:=true;
          bitbtn8.enabled:=true;
          bitbtn1.Enabled:=true;
          bitbtn7.Caption:=setassistent;
          bitbtn8.Caption:=rembattlemaster;
        end
          else
            begin
              bitbtn9.enabled:=true;
              bitbtn7.enabled:=true;
              bitbtn8.enabled:=true;
              bitbtn1.Enabled:=true;
              bitbtn7.Caption:=setassistent;
              bitbtn8.Caption:=setbattlemaster;
            end;
end;

procedure TForm2.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
myColor: TColor;
myBrush: TBrush;
begin
myBrush := TBrush.Create;
with (Control as TListBox).Canvas do
begin
if index=Gmnum then
  myColor := $00FF8A00
   else if index=Asnum then
     myColor := $008CFF01
        else if (index=BMnum1) or (index=BMnum2) or (index=BMnum3)  then
          myColor :=clYellow
            else mycolor :=clSilver;
myBrush.Style := bsSolid;
myBrush.Color := myColor;
Windows.FillRect(handle, Rect, myBrush.Handle);
Brush.Style := bsClear;
TextOut(Rect.Left, Rect.Top,(Control as TListBox).Items[Index]);
MyBrush.Free;
end;
end;


procedure TForm2.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
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
           // label1.caption:=inttostr(x2+1)+','+inttostr(y2+1);
          end;
end;

procedure TForm2.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
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
           // label1.caption:=inttostr(x2+1)+','+inttostr(y2+1);
          end;

    form2.Update;

  end;
end;

procedure TForm2.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Drawing then
  begin
    Drawing := False;
  end;
end;

procedure TForm2.Panel1Click(Sender: TObject);
begin
cor:=(sender as tpanel).color;
end;

procedure tform2.grid;
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
//
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

   paintbox2.canvas.Pen.Color:=clwhite;
    paintbox2.canvas.Pen.width:=2;
  paintbox2.Canvas.MoveTo(0,0);
  paintbox2.Canvas.LineTo(16,16);
  paintbox2.Canvas.MoveTo(0,16);
  paintbox2.Canvas.LineTo(16,0);
  form2.Update;
end;
procedure tform2.leracc;
var i:integer;
begin
  combobox2.Items.clear;
  combobox2.Items.Add(all);
  combobox3.Items.clear;
  muquery.SQL.clear;
  muquery.SQL.Add('select '+ID+' from '+AccountCharacter+'');
  muquery.Open;
  if (muquery.Eof) and (muquery.Bof) then
     application.MessageBox(pchar(error10),Pchar(errorcaption),mb_iconwarning)
    else
      for i:=0 to muquery.RecordCount-1 do
        begin
          combobox2.Items.Add(muquery.Fields[0].asstring);
          muquery.Next;
        end;
  muquery.close;
  combobox3.Text:='';
  combobox2.Text:='';
end;
procedure Tform2.CharacterMostrar;
var i:byte;
j:integer;
accountsave:string;
begin
  Combobox3.Items.Clear;
  AccountSave:=Combobox2.Text;
  muquery.SQL.Clear;
  if combobox2.Text<>all then
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
              Combobox3.Items.Add(muquery.Fields[i].asstring);
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
                      Combobox3.Items.Add(muquery.Fields[i].asstring);
                      muquery2.close;
                    end;
                end;
              muquery.Next;
            end;
          muquery.Close;
        end;
end;
procedure tform2.iniciar;
var x,y,i:integer;
begin
  paintbox1.canvas.Pen.width:=1;
  paintbox1.canvas.Pen.Color:=clblack;
  form2.grid;
  lerguild;
  leracc;

  cor:=$00666666;
  form2.Update;
end;

end.
