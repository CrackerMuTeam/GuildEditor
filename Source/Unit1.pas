unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls,strUtils, ValEdit, ExtCtrls, Buttons,dec,
  ComCtrls, Menus,  unit3,unit2,
  ToolWin;

type
  TForm1 = class(TForm)
    ComboBox1: TComboBox;
    Label9: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label4: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    BitBtn5: TBitBtn;
    StatusBar1: TStatusBar;
    muQuery: TADOQuery;
    BitBtn4: TBitBtn;
    PaintBox1: TPaintBox;
    muupdate: TADOCommand;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure lerguilds;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBox1Change(Sender: TObject);
    procedure iniciar;
    procedure BitBtn5Click(Sender: TObject);
    procedure infor;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit4, Unit5;



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




procedure FillHexguild(item:Tfield); {填充某个账户的仓库}
type Tcharset=set of char;
var A:tcharset;
    itemblock:array of byte;
    sWS,sItem,sUni:string;
    wsrow,wscol,i,panelcount:integer;
    j,k:integer;
begin
  a:=['0'..'7'];
  with item do begin
      setlength(itemblock,datasize);
      try
      getdata(itemblock);
      {截取仓库的16进制代码}
      i:=2;
      while i<=high(itemblock) do
      begin
        sws:=sws+uppercase(bytetohex(itemblock[i]));
        inc(i);
      end;

{      for i:=2 to high(itemblock) do
          sws:=sws+uppercase(bytetohex(itemblock[i]));
 }

      for wscol:=1 to 8 do
        for wsrow:=1 to 8 do
          begin
            sitem:=midstr(sws,8*((wscol)-1)+1*((wsrow)-1)+1,1);
           // form1.canvas.pen.Width:=8;
      //      form1.Canvas.Pen.Mode := pmnotXor;
      
            if (sitem='0') then
              form1.paintbox1.Canvas.Pen.Color:=clbtnface;
            if (sitem='1') then
              form1.paintbox1.Canvas.Pen.Color:=$000000;
            if (sitem='2') then
              form1.paintbox1.Canvas.Pen.Color:=$8c8a8d;
            if (sitem='3') then
              form1.paintbox1.Canvas.Pen.Color:=$ffffff;
            if (sitem='4') then
              form1.paintbox1.Canvas.Pen.Color:=$0000fe;
            if (sitem='5') then
              form1.paintbox1.Canvas.Pen.Color:=$008aff;
            if (sitem='6') then
              form1.paintbox1.Canvas.Pen.Color:=$ffff00;
            if (sitem='7') then
              form1.paintbox1.Canvas.Pen.Color:=$01FF8D;
            if (sitem='8') then
              form1.paintbox1.Canvas.Pen.Color:=$00ff00;
            if (sitem='9') then
              form1.paintbox1.Canvas.Pen.Color:=$8CFF01;
            if (sitem='A') then
              form1.paintbox1.Canvas.Pen.Color:=$00ffff;
            if (sitem='B') then
              form1.paintbox1.Canvas.Pen.Color:=$ff8a00;
            if (sitem='C') then
              form1.paintbox1.Canvas.Pen.Color:=$fe0000;
            if (sitem='D') then
              form1.paintbox1.Canvas.Pen.Color:=$FF008C;
            if (sitem='E') then
              form1.paintbox1.Canvas.Pen.Color:=$ff00fe;
            if (sitem='F') then
              form1.paintbox1.Canvas.Pen.Color:=$8C00FF;
           // form1.Canvas.Ellipse(139+8*(wsrow), 8*(wscol), 139+8*(wsrow)+8, 8*(wscol)+8);
            form1.paintbox1.Canvas.Rectangle(8*(wsrow)-8, 8*(wscol)-8, 8*(wsrow), 8*(wscol));
            for j := 1 to 7 do
              begin
                form1.paintbox1.Canvas.MoveTo(8*(wsrow)-8, 8*(wscol)+j-8);
				      	form1.paintbox1.Canvas.LineTo(8*(wsrow), 8*(wscol)+j-8);
              end;
          end;


      except
      on E:exception do application.MessageBox(pchar(e.Message),'Erro',mb_ok+mb_iconerror);


      end;
  end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
form4.show;
form4.iniciar;
form1.Enabled:=false;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
if combobox1.text<>'' then
  begin
    if application.MessageBox(pchar(question8),'Guild Editor',mb_yesno+mb_iconinformation)=mrno then begin
      exit;
    end;
    muupdate.CommandText:=('delete from '+guildmember+' where '+G_name2+'='''+combobox1.Text+'''');
    muupdate.Execute;
    muupdate.CommandText:=('delete from '+guild+' where '+G_name+'='''+combobox1.Text+'''');
    muupdate.Execute;
    application.MessageBox(pchar(confirm3),'Guild Editor',mb_ok);
    lerguilds;
    combobox1.Itemindex:=0;
    infor;
  end
    else application.MessageBox(pchar(error19),pchar(errorcaption),mb_ok+mb_iconerror);
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
if combobox1.Text<>'' then
  begin
    guildsave:=combobox1.Text;
    form2.caption:=EditGuildForm+' '+guildsave+'';
    form2.show;
    form2.iniciar;
    form1.Enabled:=false;
  end
    else application.MessageBox(pchar(error19),pchar(errorcaption),mb_ok+mb_iconerror);
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
form5.show;
form5.iniciar;
form1.Enabled:=false;
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
form3.showmodal;
end;


procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  infor;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
application.Terminate;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  if combobox1.Text<>'' then
    begin
      muquery.SQL.clear;
      muquery.SQL.Add('select '+G_mark+','+G_Master+','+G_Score+' from '+guild+' where '+G_name+'='''+combobox1.text+'''');
      muquery.Open;
      label5.caption:=muquery.Fields[1].asstring;
      label1.caption:=score+muquery.fields[2].asstring;
      FillHexguild(muquery.fields[0]);
      muquery.Close;
    end;
end;

procedure tform1.infor;
var s:string;
i:integer;
begin
  muquery.SQL.clear;
  muquery.SQL.Add('select '+G_mark+','+G_Master+','+G_Score+' from '+guild+' where '+G_name+'='''+combobox1.text+'''');
  muquery.Open;
  label5.caption:=muquery.Fields[1].asstring;
  label1.caption:=score+muquery.fields[2].asstring;
  FillHexguild(muquery.fields[0]);
  muquery.Close;
  muquery.SQL.clear;
  if vs<>'CMT' then begin
    muquery.SQL.Add('select '+nome2+' from '+guildmember+' where '+G_name2+'='''+combobox1.text+'''');
    muquery.Open;
    label2.Caption:=members+inttostr(muquery.RecordCount);
    muquery.close;
  end else begin
    muquery.SQL.Add('select '+nome2+','+G_Status+' from '+guildmember+' where '+G_name2+'='''+combobox1.text+'''');
    muquery.Open;
    s:='';
    label6.caption:=assistent2;
    label7.caption:=battlemasters;
    for i := 0 to muquery.RecordCount - 1 do
      begin
        if muquery.Fields[1].AsInteger=64 then label6.Caption:=assistent2+' '+muquery.Fields[0].asstring;
        if muquery.Fields[1].AsInteger=32 then
          if s='' then s:=muquery.Fields[0].asstring
            else s:=s+' , '+muquery.Fields[0].asstring;
        muquery.Next;
      end;
    label7.caption:=battlemasters+' '+s;
    label2.Caption:=members+' '+inttostr(muquery.RecordCount);
    muquery.close;
  end;
end;

procedure tform1.iniciar;
var i:integer;
  filename : string;
  f : textfile;
  ch : char;
  esc: boolean;
  s:array[1..20] of string;
  g:string;
begin
  //initws;
  //editlock;
  muquery.ConnectionString:='Provider=MSDASQL.1;Password='+mupwd+';Persist Security Info=True;User ID='+muid+';Data Source='+mudsn+';Initial Catalog='+catalog;
  muupdate.ConnectionString:=muquery.ConnectionString;
  form2.muquery.ConnectionString:=muquery.ConnectionString;
  form2.muupdate.connectionstring:=muquery.ConnectionString;
  form2.muquery2.ConnectionString:=muquery.ConnectionString;
  form4.muquery.ConnectionString:=muquery.ConnectionString;
  form4.muquery2.ConnectionString:=muquery.ConnectionString;
  form4.muupdate.connectionstring:=muquery.ConnectionString;
  form5.muquery.ConnectionString:=muquery.ConnectionString;
  form5.muupdate.connectionstring:=muquery.ConnectionString;
  filename:=ExtractFilePath(Application.ExeName)+'SQLNames.txt';
  assignfile(F,filename);
  reset(F);
  i:=0;
  while not eof(F) do
    begin
      read(F,ch);
      Case ch of
        '"'  :  begin
                  if esc=false then esc:=true
                    else
                      begin
                        esc:=false;
                        inc(i);
                        s[i]:=g;
                        g:='';
                      end;
                end;
         else begin
                if esc=true then
                  begin
                    g:=g+ch;
                  end;
               end;
      end;
    end;
  closefile(F);
  //Guild
  G_name:=s[1];
  G_mark:=s[2];
  G_Master:=s[3];
  G_Count:=s[4];
  G_notice:=s[5];
  Guild:=s[6];
  //AccountCharacter
  GameID1:=s[7];
  GameID2:=s[8];
  GameID3:=s[9];
  GameID4:=s[10];
  GameID5:=s[11];
  AccountCharacter:=s[12];
  ID:=s[13];
  //GuildMember
  Nome2:=s[14];
  G_Level:=s[15];
  GuildMember:=s[16];
  G_Score:=s[17];
  g_name2:=s[18];
  G_level2:=s[19];
  G_status:=s[20];
  lerguilds;
  form1.Update;
  combobox1.ItemIndex:=0;
  //lang
  with form1 do
    begin
      label9.caption:=guildtext;
      bitbtn1.Hint:=Addhint;
      bitbtn2.Hint:=remhint;
      bitbtn3.Hint:=edithint;
      bitbtn4.Hint:=tophint;
      label4.caption:=gm;
      label1.caption:=score;
      label2.caption:=members;
      bitbtn5.Caption:=creditstext;
      label6.caption:=assistent2;
      label7.caption:=battlemasters;
    end;
  with form2 do
    begin
      label4.Caption:=gm;
      label1.caption:=score;
      label6.caption:=notice;
      groupbox1.Caption:=members;
      bitbtn1.caption:=rem;
      bitbtn2.caption:=add;
      bitbtn9.caption:=setgm;
      groupbox2.Caption:=addmember;
      label2.caption:=accounttext;
      label3.caption:=charactertext;
      bitbtn3.caption:=ok;
      bitbtn4.caption:=cancel;
      bitbtn5.caption:=ok;
      bitbtn6.caption:=cancel;
      caption:=EditGuildForm;
      bitbtn7.caption:=setassistent;
      bitbtn8.caption:=setbattlemaster;
      label7.Caption:=guildmaster;
      label8.caption:=assistent;
      label9.caption:=battlemaster;
      label10.Caption:=normalplayer;
    end;
  with form3 do
    begin
      label4.caption:=Translate;
      label2.caption:=otherfiles;
      caption:=creditstext;
    end;
  with form4 do
    begin
      label4.Caption:=guildtext;
      label1.caption:=accounttext;
      label2.caption:=charactertext;
      groupbox1.Caption:=selectgm;
      bitbtn5.caption:=NewGuild;
      bitbtn1.caption:=NewEditGuild;
      bitbtn6.caption:=Cancel;
      caption:=AddGuildForm;
    end;
  with form5 do
    begin
      groupbox1.Caption:=dec.info;
      label4.Caption:=gm;
      label1.caption:=score;
      label2.caption:=members;
      bitbtn2.Hint:=remhint;
      bitbtn3.Hint:=edithint;
      bitbtn1.caption:=RefreshList;
      bitbtn4.caption:=CloseTop;
      caption:=TopForm;
    end;
  //langend
  if (vs='WZ') or (vs='CMT') or (vs='DT') then
    begin
      vs:='CMT';
      label6.visible:=true;
      label7.visible:=true;
      form5.label6.visible:=true;
      form5.label7.visible:=true;
      form2.label8.visible:=true;
      form2.label9.visible:=true;
      form2.label10.visible:=true;
      form2.BitBtn7.Visible:=true;
      form2.BitBtn8.Visible:=true;
    end;
  infor;
  form1.Update;
end;

procedure tform1.lerguilds;
var i,j, wsrow,wscol:integer;
begin
  combobox1.Items.clear;
  muquery.SQL.clear;
  muquery.SQL.Add('select '+G_name+' from '+guild+'');
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
  muquery.Close;
  combobox1.text:='';
  combobox1.ItemIndex:=-1;
  label5.caption:='';
  LABEL1.Caption:=score;
  for wsrow:=1 to 8 do
    for wscol:=1 to 8 do
      begin
        form1.paintbox1.Canvas.Pen.Color:=clBtnFace;
        form1.paintbox1.Canvas.Rectangle(8*(wsrow)-8, 8*(wscol)-8, 8*(wsrow), 8*(wscol));
        for j := 1 to 7 do
          begin
            form1.paintbox1.Canvas.MoveTo(8*(wsrow)-8, 8*(wscol)+j-8);
      	  	form1.paintbox1.Canvas.LineTo(8*(wsrow), 8*(wscol)+j-8);
          end;
      end;

end;

end.
