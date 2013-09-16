object Form2: TForm2
  Left = 179
  Top = 69
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Adicionar Guild'
  ClientHeight = 316
  ClientWidth = 460
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 32
    Width = 37
    Height = 13
    Caption = 'Pontos:'
  end
  object Label4: TLabel
    Left = 8
    Top = 8
    Width = 19
    Height = 13
    Caption = 'GM:'
  end
  object Label5: TLabel
    Left = 33
    Top = 4
    Width = 5
    Height = 19
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGradientActiveCaption
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 8
    Top = 258
    Width = 36
    Height = 13
    Caption = 'Noticia:'
  end
  object PaintBox1: TPaintBox
    Left = 8
    Top = 56
    Width = 145
    Height = 145
    Color = clCaptionText
    ParentColor = False
    OnMouseDown = PaintBox1MouseDown
    OnMouseMove = PaintBox1MouseMove
    OnMouseUp = PaintBox1MouseUp
  end
  object GroupBox1: TGroupBox
    Left = 159
    Top = 8
    Width = 291
    Height = 244
    Caption = 'Membros'
    TabOrder = 0
    object Label7: TLabel
      Left = 8
      Top = 228
      Width = 59
      Height = 13
      Caption = 'Guild Master'
      Color = 16747008
      ParentColor = False
    end
    object Label8: TLabel
      Left = 73
      Top = 228
      Width = 50
      Height = 13
      Caption = 'Assistente'
      Color = 9240321
      ParentColor = False
      Visible = False
    end
    object Label9: TLabel
      Left = 129
      Top = 228
      Width = 64
      Height = 13
      Caption = 'Battle Master'
      Color = clYellow
      ParentColor = False
      Visible = False
    end
    object Label10: TLabel
      Left = 199
      Top = 228
      Width = 33
      Height = 13
      Caption = 'Normal'
      Color = clSilver
      ParentColor = False
      Visible = False
    end
    object GroupBox2: TGroupBox
      Left = 151
      Top = 78
      Width = 133
      Height = 121
      Caption = 'Adicionar'
      TabOrder = 2
      Visible = False
      object Label2: TLabel
        Left = 8
        Top = 13
        Width = 43
        Height = 13
        Caption = 'Account:'
      end
      object Label3: TLabel
        Left = 8
        Top = 56
        Width = 48
        Height = 13
        Caption = 'Character'
      end
      object ComboBox2: TComboBox
        Left = 8
        Top = 32
        Width = 118
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        OnChange = ComboBox2Change
      end
      object ComboBox3: TComboBox
        Left = 8
        Top = 72
        Width = 118
        Height = 21
        ItemHeight = 13
        TabOrder = 1
      end
      object BitBtn3: TBitBtn
        Left = 7
        Top = 93
        Width = 56
        Height = 20
        Caption = 'OK'
        TabOrder = 2
        OnClick = BitBtn3Click
      end
      object BitBtn4: TBitBtn
        Left = 69
        Top = 96
        Width = 56
        Height = 20
        Caption = 'Cancelar'
        TabOrder = 3
        OnClick = BitBtn4Click
      end
    end
    object BitBtn1: TBitBtn
      Left = 151
      Top = 16
      Width = 133
      Height = 25
      Caption = 'Remover'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 151
      Top = 47
      Width = 133
      Height = 25
      Caption = 'Adicionar'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn9: TBitBtn
      Left = 151
      Top = 78
      Width = 133
      Height = 25
      Caption = 'Setar Guild Master'
      TabOrder = 3
      OnClick = BitBtn9Click
    end
    object ListBox1: TListBox
      Left = 8
      Top = 16
      Width = 137
      Height = 209
      Style = lbOwnerDrawVariable
      ItemHeight = 13
      TabOrder = 4
      OnClick = ListBox1Click
      OnDrawItem = ListBox1DrawItem
    end
    object BitBtn8: TBitBtn
      Left = 151
      Top = 140
      Width = 133
      Height = 25
      Caption = 'Setar Mestre de Batalha'
      TabOrder = 5
      Visible = False
      OnClick = BitBtn8Click
    end
    object BitBtn7: TBitBtn
      Left = 151
      Top = 109
      Width = 133
      Height = 25
      Caption = 'Setar Assistente'
      TabOrder = 6
      Visible = False
      OnClick = BitBtn7Click
    end
  end
  object Edit2: TEdit
    Left = 55
    Top = 29
    Width = 97
    Height = 21
    TabOrder = 1
  end
  object BitBtn5: TBitBtn
    Left = 8
    Top = 285
    Width = 90
    Height = 21
    Caption = 'Ok'
    TabOrder = 2
    OnClick = BitBtn5Click
  end
  object BitBtn6: TBitBtn
    Left = 104
    Top = 285
    Width = 90
    Height = 21
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = BitBtn6Click
  end
  object Edit1: TEdit
    Left = 50
    Top = 256
    Width = 399
    Height = 21
    TabOrder = 4
  end
  object Panel1: TPanel
    Left = 8
    Top = 216
    Width = 18
    Height = 18
    Color = 6710886
    TabOrder = 5
    OnClick = Panel1Click
    object PaintBox2: TPaintBox
      Left = 1
      Top = 1
      Width = 16
      Height = 16
      Align = alClient
      Color = clCaptionText
      ParentColor = False
      OnClick = PaintBox2Click
    end
  end
  object Panel2: TPanel
    Left = 26
    Top = 216
    Width = 18
    Height = 18
    Color = clBlack
    TabOrder = 6
    OnClick = Panel1Click
  end
  object Panel3: TPanel
    Left = 44
    Top = 216
    Width = 18
    Height = 18
    Color = 9210509
    TabOrder = 7
    OnClick = Panel1Click
  end
  object Panel4: TPanel
    Left = 62
    Top = 216
    Width = 18
    Height = 18
    Color = clWhite
    TabOrder = 8
    OnClick = Panel1Click
  end
  object Panel5: TPanel
    Left = 26
    Top = 234
    Width = 18
    Height = 18
    Color = 9240321
    TabOrder = 9
    OnClick = Panel1Click
  end
  object Panel6: TPanel
    Left = 44
    Top = 234
    Width = 18
    Height = 18
    Color = clAqua
    TabOrder = 10
    OnClick = Panel1Click
  end
  object Panel7: TPanel
    Left = 62
    Top = 234
    Width = 18
    Height = 18
    Color = 16747008
    TabOrder = 11
    OnClick = Panel1Click
  end
  object Panel8: TPanel
    Left = 80
    Top = 234
    Width = 18
    Height = 18
    Color = 16646144
    TabOrder = 12
    OnClick = Panel1Click
  end
  object Panel9: TPanel
    Left = 98
    Top = 234
    Width = 18
    Height = 18
    Color = 16711820
    TabOrder = 13
    OnClick = Panel1Click
  end
  object Panel10: TPanel
    Left = 116
    Top = 234
    Width = 18
    Height = 18
    Color = 16711934
    TabOrder = 14
    OnClick = Panel1Click
  end
  object Panel11: TPanel
    Left = 134
    Top = 234
    Width = 18
    Height = 18
    Color = 9175295
    TabOrder = 15
    OnClick = Panel1Click
  end
  object Panel12: TPanel
    Left = 80
    Top = 216
    Width = 18
    Height = 18
    Color = 254
    TabOrder = 16
    OnClick = Panel1Click
  end
  object Panel13: TPanel
    Left = 98
    Top = 216
    Width = 18
    Height = 18
    Color = 35583
    TabOrder = 17
    OnClick = Panel1Click
  end
  object Panel14: TPanel
    Left = 116
    Top = 216
    Width = 18
    Height = 18
    Color = clYellow
    TabOrder = 18
    OnClick = Panel1Click
  end
  object Panel15: TPanel
    Left = 134
    Top = 216
    Width = 18
    Height = 18
    Color = 130957
    TabOrder = 19
    OnClick = Panel1Click
  end
  object Panel16: TPanel
    Left = 8
    Top = 234
    Width = 18
    Height = 18
    Color = clLime
    TabOrder = 20
    OnClick = Panel1Click
  end
  object muQuery: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    Left = 168
    Top = 24
  end
  object muupdate: TADOCommand
    Parameters = <>
    Left = 232
    Top = 24
  end
  object Muquery2: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    Left = 200
    Top = 24
  end
end
