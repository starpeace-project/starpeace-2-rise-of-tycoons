object Form2: TForm2
  Left = 302
  Top = 114
  Width = 696
  Height = 624
  Caption = 'Form2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 112
    Top = 560
    Width = 75
    Height = 25
    Caption = 'start'
    TabOrder = 0
    OnClick = Button1Click
  end
  object manualsave: TButton
    Left = 184
    Top = 560
    Width = 75
    Height = 25
    Caption = 'manual save'
    TabOrder = 1
    OnClick = manualsaveClick
  end
  object blankworld: TCheckBox
    Left = 8
    Top = 568
    Width = 97
    Height = 17
    Caption = 'Blank world'
    TabOrder = 2
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 673
    Height = 545
    ActivePage = games
    TabOrder = 3
    object main: TTabSheet
      Caption = 'main'
    end
    object games: TTabSheet
      Caption = 'games'
      ImageIndex = 1
      object sgame: TListBox
        Left = 8
        Top = 40
        Width = 145
        Height = 473
        ItemHeight = 13
        TabOrder = 0
        OnClick = sgameClick
      end
      object refresh: TButton
        Left = 8
        Top = 8
        Width = 75
        Height = 25
        Caption = 'refresh'
        TabOrder = 1
        OnClick = refreshClick
      end
      object cgame: TGroupBox
        Left = 176
        Top = 8
        Width = 481
        Height = 417
        Caption = 'current game'
        TabOrder = 2
        object Label1: TLabel
          Left = 16
          Top = 24
          Width = 31
          Height = 13
          Caption = 'Name:'
        end
        object Label2: TLabel
          Left = 16
          Top = 48
          Width = 27
          Height = 13
          Caption = 'Price:'
        end
        object Label3: TLabel
          Left = 16
          Top = 72
          Width = 48
          Height = 13
          Caption = 'Purchase:'
        end
        object Label4: TLabel
          Left = 16
          Top = 96
          Width = 45
          Height = 13
          Caption = 'Category:'
        end
        object Label5: TLabel
          Left = 16
          Top = 120
          Width = 75
          Height = 13
          Caption = 'Time today: n/a'
        end
        object Label6: TLabel
          Left = 16
          Top = 136
          Width = 94
          Height = 13
          Caption = 'Time this week: n/a'
        end
        object Label7: TLabel
          Left = 16
          Top = 152
          Width = 94
          Height = 13
          Caption = 'Time last week: n/a'
        end
        object Label8: TLabel
          Left = 16
          Top = 168
          Width = 69
          Height = 13
          Caption = 'Total sold; n/a'
        end
        object Label9: TLabel
          Left = 16
          Top = 184
          Width = 92
          Height = 13
          Caption = 'Sold last week: n/a'
        end
        object Label10: TLabel
          Left = 16
          Top = 200
          Width = 90
          Height = 13
          Caption = 'sold this week: n/a'
        end
        object Label11: TLabel
          Left = 200
          Top = 16
          Width = 20
          Height = 13
          Caption = 'ID:='
        end
        object Label12: TLabel
          Left = 224
          Top = 16
          Width = 6
          Height = 13
          Caption = '0'
        end
        object Label13: TLabel
          Left = 192
          Top = 48
          Width = 31
          Height = 13
          Caption = 'Owner'
        end
        object Label14: TLabel
          Left = 192
          Top = 72
          Width = 34
          Height = 13
          Caption = 'version'
        end
        object Label15: TLabel
          Left = 192
          Top = 96
          Width = 54
          Height = 13
          Caption = 'percentage'
        end
        object Label16: TLabel
          Left = 192
          Top = 120
          Width = 19
          Height = 13
          Caption = 'kitty'
        end
        object Edit1: TEdit
          Left = 56
          Top = 16
          Width = 121
          Height = 21
          TabOrder = 0
          Text = 'Edit1'
        end
        object Edit2: TEdit
          Left = 56
          Top = 40
          Width = 121
          Height = 21
          TabOrder = 1
          Text = 'Edit2'
        end
        object Edit3: TEdit
          Left = 72
          Top = 64
          Width = 105
          Height = 21
          TabOrder = 2
          Text = 'Edit3'
        end
        object Edit4: TEdit
          Left = 72
          Top = 88
          Width = 105
          Height = 21
          TabOrder = 3
          Text = 'Edit4'
        end
        object Edit5: TEdit
          Left = 232
          Top = 40
          Width = 121
          Height = 21
          TabOrder = 4
          Text = 'Edit5'
        end
        object Edit6: TEdit
          Left = 232
          Top = 64
          Width = 121
          Height = 21
          TabOrder = 5
          Text = 'Edit6'
        end
        object Edit7: TEdit
          Left = 256
          Top = 88
          Width = 97
          Height = 21
          TabOrder = 6
          Text = 'Edit7'
        end
        object Edit8: TEdit
          Left = 224
          Top = 112
          Width = 121
          Height = 21
          TabOrder = 7
          Text = 'Edit8'
        end
        object gedit: TButton
          Left = 56
          Top = 264
          Width = 75
          Height = 25
          Caption = 'edit'
          TabOrder = 8
          OnClick = geditClick
        end
        object gadd: TButton
          Left = 144
          Top = 264
          Width = 75
          Height = 25
          Caption = 'add'
          TabOrder = 9
          OnClick = gaddClick
        end
      end
    end
    object users: TTabSheet
      Caption = 'users'
      ImageIndex = 2
    end
    object stats: TTabSheet
      Caption = 'stats'
      ImageIndex = 3
    end
  end
  object backup: TTimer
    Enabled = False
    Interval = 3600000
    OnTimer = backupTimer
    Left = 624
    Top = 560
  end
  object savegeneral: TTimer
    Enabled = False
    Interval = 300000
    OnTimer = savegeneralTimer
    Left = 656
    Top = 560
  end
end
