object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 675
  ClientWidth = 773
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 434
    Height = 39
    Caption = 'VISOR 3D / AGUA DE PUEBLA '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -32
    Font.Name = 'Tahoma'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object Image1: TImage
    Left = 16
    Top = 64
    Width = 600
    Height = 600
  end
  object Panel1: TPanel
    Left = 638
    Top = 64
    Width = 123
    Height = 489
    TabOrder = 0
    object Button1: TButton
      Left = 24
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Rot x +'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 24
      Top = 65
      Width = 75
      Height = 25
      Caption = 'Rot x -'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 24
      Top = 112
      Width = 75
      Height = 25
      Caption = 'Rot y +'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 24
      Top = 160
      Width = 75
      Height = 25
      Caption = 'Rot y -'
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 24
      Top = 209
      Width = 75
      Height = 25
      Caption = 'Rot z +'
      TabOrder = 4
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 24
      Top = 256
      Width = 75
      Height = 25
      Caption = 'Rot z -'
      TabOrder = 5
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 24
      Top = 304
      Width = 75
      Height = 25
      Caption = 'Lejos'
      TabOrder = 6
      OnClick = Button7Click
    end
    object Button8: TButton
      Left = 24
      Top = 353
      Width = 75
      Height = 25
      Caption = 'Cerca'
      TabOrder = 7
      OnClick = Button8Click
    end
    object Button9: TButton
      Left = 24
      Top = 401
      Width = 75
      Height = 25
      Caption = 'Abrir'
      TabOrder = 8
      OnClick = Button9Click
    end
    object Button10: TButton
      Left = 25
      Top = 448
      Width = 75
      Height = 25
      Caption = 'Pinta Red'
      TabOrder = 9
      OnClick = Button10Click
    end
  end
  object Panel2: TPanel
    Left = 464
    Top = 8
    Width = 297
    Height = 41
    TabOrder = 1
    object Button11: TButton
      Left = 16
      Top = 8
      Width = 121
      Height = 25
      Caption = 'Autor'
      TabOrder = 0
      OnClick = Button11Click
    end
    object Button12: TButton
      Left = 160
      Top = 8
      Width = 121
      Height = 25
      Caption = 'Salir'
      TabOrder = 1
      OnClick = Button12Click
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 8
    Top = 8
  end
end
