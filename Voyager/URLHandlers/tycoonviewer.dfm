object tycoonview: Ttycoonview
  Left = 0
  Top = 0
  Caption = 'tycoonview'
  ClientHeight = 500
  ClientWidth = 179
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 25
    Height = 33
    Picture.Data = {
      0954474946496D61676547494638396117002000B300006EA192608D80679789
      59837752796D4B6E6445645B3046403E5A523750492638321B2824141E1B0D14
      1206090900000021F9040908000F002C0000000017002000836EA192608D8067
      978959837752796D4B6E6445645B3046403E5A523750492638321B2824141E1B
      0D1412060909000000046FF0C949ABBD38EBCDBBFF93B32464B2780D02AC2C90
      704ED0B60497CC73B315788B6C841EABA6090A01BFE211B9512D159A866059D8
      30A63D418721ACC2842FCE00273B6C16465A47714C2A855A2BB607DD380C7047
      67C1C3853B0D06732B3A200A7D000620210A82858B90919292110021F9040908
      000F002C0000000017002000836EA192608D8067978959837752796D4B6E6445
      645B3046403E5A523750492638321B2824141E1B0D1412060909000000046FF0
      C949ABBD38EBCDBBFF93B32464B2780D02AC2C90704ED0B60497CC73B315788B
      6C841EABA6090A01BFE211B9512D159A866059D830A63D418721ACC2842FCE00
      273B6C16465A47714C2A855A2BB607DD380C704767C1C3853B0D06732B3A200A
      7D000620210A82858B90919292110021F9040908000F002C0000000017002000
      836EA192608D8067978959837752796D4B6E6445645B3046403E5A5237504926
      38321B2824141E1B0D1412060909000000046FF0C949ABBD38EBCDBBFF93B324
      64B2780D02AC2C90704ED0B60497CC73B315788B6C841EABA6090A01BFE211B9
      512D159A866059D830A63D418721ACC2842FCE00273B6C16465A47714C2A855A
      2BB607DD380C704767C1C3853B0D06732B3A200A7D000620210A82858B909192
      92110021F9040908000F002C0000000017002000836EA192608D806797895983
      7752796D4B6E6445645B3046403E5A523750492638321B2824141E1B0D141206
      0909000000046FF0C949ABBD38EBCDBBFF93B32464B2780D02AC2C90704ED0B6
      0497CC73B315788B6C841EABA6090A01BFE211B9512D159A866059D830A63D41
      8721ACC2842FCE00273B6C16465A47714C2A855A2BB607DD380C704767C1C385
      3B0D06732B3A200A7D000620210A82858B9091929211003B}
  end
  object uname: TFramedButton
    Left = 31
    Top = 16
    Width = 137
    Height = 17
    Cursor = crHandPoint
    TextColor = clBlack
    FrameColor = clBlack
    SelTextColor = 9829363
    DisableColor = clBlack
    SelFrameColor = clBlack
    FrameMargin = 0
    TextMargin = 0
    Align = fbaLeft
    Framed = True
    HilFramed = True
    NorGrpColor = clBlack
    SelGrpColor = clWhite
    GrpBkColor = clBlack
    GroupIndex = 0
    Selected = False
    Text = 'uname'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 9829363
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object cimg: TFramedButton
    Left = 21
    Top = 245
    Width = 100
    Height = 17
    Cursor = crHandPoint
    TextColor = clBlack
    FrameColor = clBlack
    SelTextColor = 9829363
    DisableColor = clBlack
    SelFrameColor = clBlack
    FrameMargin = 0
    TextMargin = 0
    Align = fbaLeft
    Framed = True
    HilFramed = True
    NorGrpColor = clBlack
    SelGrpColor = clWhite
    GrpBkColor = clBlack
    GroupIndex = 0
    Selected = False
    Text = 'change'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 9829363
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
    OnClick = cimgClick
  end
  object bcur: TFramedButton
    Left = 21
    Top = 268
    Width = 137
    Height = 25
    Cursor = crHandPoint
    TextColor = clBlack
    FrameColor = 5541207
    SelTextColor = 9829363
    DisableColor = clBlack
    SelFrameColor = 5541207
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
    Text = 'Curriculum'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = bcurClick
  end
  object bbank: TFramedButton
    Left = 21
    Top = 297
    Width = 137
    Height = 25
    Cursor = crHandPoint
    TextColor = clBlack
    FrameColor = 5541207
    SelTextColor = 9829363
    DisableColor = clBlack
    SelFrameColor = 5541207
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
    Text = 'Bank Account'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = bbankClick
  end
  object bpl: TFramedButton
    Left = 21
    Top = 328
    Width = 137
    Height = 25
    Cursor = crHandPoint
    TextColor = clBlack
    FrameColor = 5541207
    SelTextColor = 9829363
    DisableColor = clBlack
    SelFrameColor = 5541207
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
    Text = 'Profit and Loss'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = bplClick
  end
  object bis: TFramedButton
    Left = 21
    Top = 359
    Width = 137
    Height = 25
    Cursor = crHandPoint
    TextColor = clBlack
    FrameColor = 5541207
    SelTextColor = 9829363
    DisableColor = clBlack
    SelFrameColor = 5541207
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
    Text = 'Initial Suppliers'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = bisClick
  end
  object bcomp: TFramedButton
    Left = 21
    Top = 390
    Width = 137
    Height = 25
    Cursor = crHandPoint
    TextColor = clBlack
    FrameColor = 5541207
    SelTextColor = 9829363
    DisableColor = clBlack
    SelFrameColor = 5541207
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
    Text = 'Companies'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = bcompClick
  end
  object bstrat: TFramedButton
    Left = 21
    Top = 421
    Width = 137
    Height = 25
    Cursor = crHandPoint
    TextColor = clBlack
    FrameColor = 5541207
    SelTextColor = 9829363
    DisableColor = clBlack
    SelFrameColor = 5541207
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
    Text = 'Startegy'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = bstratClick
  end
  object Image2: TImage
    Left = 16
    Top = 39
    Width = 155
    Height = 203
    AutoSize = True
    OnClick = cimgClick
  end
  object Memo1: TMemo
    Left = 140
    Top = 39
    Width = 561
    Height = 89
    Lines.Strings = (
      '<html>'
      '<script language="JScript">'
      ''
      'function Func1()'
      '{'
      'if (!document.all.picture.complete)'
      #9#9#9
      
        'document.all.picture.src = "http://www.starpeacelive.com/five/Vi' +
        'sual/Voyager/NewTycoon/images/nopicture.jpg"'
      '}'
      ''
      'function onPageLoad()'
      '{'
      'setTimeout("Func1()", 3000);'#9#9
      '}'
      ''
      ''
      '</script>'
      ''
      
        '<body style="margin-top: 0px; margin-left: 0px;overflow:hidden" ' +
        'onLoad="onPageLoad()" scrolling="no" '
      'frameborder="0">'
      #9
      
        #9'<img id=picture src="[treplace1]" border="0" width=150 height=2' +
        '00 alt="">'
      #9
      ''
      '</body>'
      ''
      '</html>')
    TabOrder = 0
    Visible = False
  end
  object Memo2: TMemo
    Left = 140
    Top = 126
    Width = 493
    Height = 89
    Lines.Strings = (
      'Memo2')
    TabOrder = 1
    Visible = False
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = False
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 40
    Top = 24
  end
end
