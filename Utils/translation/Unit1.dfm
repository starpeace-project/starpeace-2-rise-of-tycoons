object Form1: TForm1
  Left = 192
  Top = 114
  Caption = 'translate sp'
  ClientHeight = 444
  ClientWidth = 680
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 0
    Width = 673
    Height = 441
    TabOrder = 0
    object Label6: TLabel
      Left = 96
      Top = 8
      Width = 492
      Height = 20
      Caption = 'Translation tool created  for starpeace : www.starpeace2.com'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 8
      Top = 32
      Width = 642
      Height = 13
      Caption = 
        'If you like this tool then please  come play the game it was cre' +
        'ated for, donations in the form of a months time code to the gam' +
        'e welcome'
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 56
      Width = 649
      Height = 137
      Caption = 'input folder'
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 24
        Width = 26
        Height = 13
        Caption = 'folder'
      end
      object Label2: TLabel
        Left = 16
        Top = 64
        Width = 20
        Height = 13
        Caption = 'total'
      end
      object Label3: TLabel
        Left = 240
        Top = 32
        Width = 59
        Height = 13
        Caption = 'output folder'
      end
      object Label5: TLabel
        Left = 248
        Top = 72
        Width = 45
        Height = 13
        Caption = 'extension'
      end
      object Edit1: TEdit
        Left = 56
        Top = 24
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'C:\Program Files\sp\Cache\Translations\0\'
      end
      object Edit2: TEdit
        Left = 48
        Top = 64
        Width = 121
        Height = 21
        TabOrder = 1
        Text = '1'
      end
      object Button1: TButton
        Left = 80
        Top = 104
        Width = 75
        Height = 25
        Caption = 'start'
        TabOrder = 2
        OnClick = Button1Click
      end
      object Edit3: TEdit
        Left = 312
        Top = 32
        Width = 121
        Height = 21
        TabOrder = 3
        Text = 'C:\starpeace\Source\Utils\translation\test\'
      end
      object Edit4: TEdit
        Left = 312
        Top = 64
        Width = 121
        Height = 21
        TabOrder = 4
        Text = 'tln'
      end
      object CheckBox1: TCheckBox
        Left = 320
        Top = 112
        Width = 97
        Height = 17
        Caption = 'webbased'
        TabOrder = 5
      end
      object CheckBox2: TCheckBox
        Left = 456
        Top = 112
        Width = 97
        Height = 17
        Caption = 'quoates'
        TabOrder = 6
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 200
      Width = 641
      Height = 233
      Caption = 'output'
      TabOrder = 1
      object Label4: TLabel
        Left = 8
        Top = 32
        Width = 84
        Height = 13
        Caption = 'output - 0 out of 0'
      end
      object Button2: TButton
        Left = 16
        Top = 72
        Width = 75
        Height = 25
        Caption = 'start'
        Enabled = False
        TabOrder = 0
        OnClick = Button2Click
      end
      object Memo1: TMemo
        Left = 144
        Top = 16
        Width = 473
        Height = 209
        Lines.Strings = (
          
            'This is an easy (hopefully) to use translation program for games' +
            ' (and other utlities).'
          
            'Set the input folder, output folder (must have a trailing \ at t' +
            'he end), total lang'#39's excluding the '
          'primary and file extension.'
          
            'Run the first part to create the 0.txt file, translate this usin' +
            'g the webbased translations tools, like '
          'googles.'
          
            'Save the translations as 1.txt, 2.txt etc etc in the output fold' +
            'er.'
          
            'Run the second part to create the duplicate files made in sepera' +
            'te folders in the output folder.'
          ''
          'Lines must be:'
          
            'name=value, eg button1=start for english, would translate to but' +
            'ton1=d'#233'but in french')
        TabOrder = 1
      end
    end
  end
end
