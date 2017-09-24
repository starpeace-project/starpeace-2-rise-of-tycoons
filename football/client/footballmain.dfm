object Form1: TForm1
  Left = 202
  Top = 172
  Width = 696
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 128
    Top = 168
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object mainpanel: TPanel
    Left = 88
    Top = 8
    Width = 121
    Height = 409
    Caption = 'mainpanel'
    TabOrder = 2
  end
  object Button1: TButton
    Left = 184
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object splash: TPanel
    Left = 144
    Top = 80
    Width = 393
    Height = 281
    TabOrder = 1
    object logon: TPanel
      Left = 40
      Top = 32
      Width = 305
      Height = 209
      TabOrder = 0
      object Label2: TLabel
        Left = 80
        Top = 64
        Width = 48
        Height = 13
        Caption = 'Username'
      end
      object Label3: TLabel
        Left = 80
        Top = 96
        Width = 46
        Height = 13
        Caption = 'Password'
      end
      object logonerror: TLabel
        Left = 56
        Top = 24
        Width = 3
        Height = 13
      end
      object uname: TEdit
        Left = 152
        Top = 56
        Width = 121
        Height = 21
        OEMConvert = True
        TabOrder = 0
        Text = 'uname'
      end
      object password: TEdit
        Left = 152
        Top = 88
        Width = 121
        Height = 21
        TabOrder = 1
        Text = 'password'
      end
      object logonbut: TButton
        Left = 192
        Top = 144
        Width = 75
        Height = 25
        Caption = 'Log On'
        TabOrder = 2
        OnClick = logonbutClick
      end
      object newuserpanel: TButton
        Left = 48
        Top = 144
        Width = 75
        Height = 25
        Caption = 'New User'
        TabOrder = 3
        OnClick = newuserpanelClick
      end
    end
    object newuser: TPanel
      Left = 8
      Top = 24
      Width = 353
      Height = 241
      TabOrder = 1
      object newusererror: TLabel
        Left = 32
        Top = 24
        Width = 3
        Height = 13
      end
      object newusername: TEdit
        Left = 128
        Top = 72
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'newusername'
      end
      object newuserpass: TEdit
        Left = 128
        Top = 104
        Width = 121
        Height = 21
        TabOrder = 1
        Text = 'newuserpass'
      end
      object newuseremail: TEdit
        Left = 128
        Top = 136
        Width = 121
        Height = 21
        TabOrder = 2
        Text = 'newuseremail'
      end
      object newusercountry: TComboBox
        Left = 128
        Top = 168
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 3
        Text = 'England'
        Items.Strings = (
          'England'
          'Scotland'
          'Whales'
          'Northern Ireland'
          'Republic of Ireland'
          'Canada'
          'USA'
          'Austrialia')
      end
      object newusersubmit: TButton
        Left = 200
        Top = 200
        Width = 75
        Height = 25
        Caption = 'Create'
        TabOrder = 4
        OnClick = newusersubmitClick
      end
      object newusercancel: TButton
        Left = 88
        Top = 200
        Width = 75
        Height = 25
        Caption = 'Cancel'
        TabOrder = 5
        OnClick = newusercancelClick
      end
    end
  end
end
