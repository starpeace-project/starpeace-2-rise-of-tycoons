object Frame2: TFrame2
  Left = 0
  Top = 0
  Width = 590
  Height = 27
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 590
    Height = 27
    Align = alClient
    BevelOuter = bvNone
    Color = 8236034
    ParentBackground = False
    TabOrder = 0
    ExplicitTop = -3
    object bname: TLabel
      Left = 8
      Top = 7
      Width = 32
      Height = 13
      Caption = 'bname'
    end
    object bdate: TLabel
      Left = 96
      Top = 7
      Width = 28
      Height = 13
      Caption = 'bdate'
    end
    object bamount: TLabel
      Left = 192
      Top = 7
      Width = 42
      Height = 13
      Caption = 'bamount'
    end
    object brate: TLabel
      Left = 296
      Top = 7
      Width = 26
      Height = 13
      Caption = 'brate'
    end
    object bterm: TLabel
      Left = 344
      Top = 7
      Width = 28
      Height = 13
      Caption = 'bterm'
    end
    object bnext: TLabel
      Left = 408
      Top = 7
      Width = 28
      Height = 13
      Caption = 'bnext'
    end
    object brepay: TFramedButton
      Left = 514
      Top = 7
      Width = 63
      Height = 17
      Cursor = crHandPoint
      TextColor = clBlack
      FrameColor = clBlack
      SelTextColor = clBlack
      DisableColor = clBlack
      SelFrameColor = clBlack
      FrameMargin = 0
      TextMargin = 0
      Align = fbaCenter
      Framed = True
      HilFramed = True
      NorGrpColor = clBlack
      SelGrpColor = clWhite
      GrpBkColor = clBlack
      GroupIndex = 0
      Selected = False
      Text = 'Repay'
      OnClick = brepayClick
    end
  end
end
