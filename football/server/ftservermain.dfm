object Form2: TForm2
  Left = 175
  Top = 127
  Width = 696
  Height = 480
  Caption = 'Form2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 64
    Top = 400
    Width = 75
    Height = 25
    Caption = 'start'
    TabOrder = 0
    OnClick = Button1Click
  end
  object manualsave: TButton
    Left = 152
    Top = 400
    Width = 75
    Height = 25
    Caption = 'manual save'
    TabOrder = 1
  end
  object blankworld: TCheckBox
    Left = 8
    Top = 424
    Width = 97
    Height = 17
    Caption = 'Blank world'
    TabOrder = 2
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 673
    Height = 385
    ActivePage = countries
    TabOrder = 3
    object main: TTabSheet
      Caption = 'main'
    end
    object countries: TTabSheet
      Caption = 'countries'
      ImageIndex = 1
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 99
        Height = 13
        Caption = 'Total countries = n/a'
      end
      object Label2: TLabel
        Left = 144
        Top = 8
        Width = 60
        Height = 13
        Caption = 'New country'
      end
      object Label3: TLabel
        Left = 8
        Top = 40
        Width = 106
        Height = 13
        Caption = 'Team selected = none'
      end
      object Label4: TLabel
        Left = 144
        Top = 64
        Width = 43
        Height = 13
        Caption = 'divisions:'
      end
      object newcountry: TEdit
        Left = 216
        Top = 8
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'newcountry'
      end
      object newcountryadd: TButton
        Left = 344
        Top = 8
        Width = 75
        Height = 25
        Caption = 'add'
        TabOrder = 1
        OnClick = newcountryaddClick
      end
      object countrylist: TListBox
        Left = 8
        Top = 56
        Width = 121
        Height = 137
        ItemHeight = 13
        Items.Strings = (
          'none'
          'here '
          'yet')
        TabOrder = 2
        OnClick = countrylistClick
      end
    end
  end
end
