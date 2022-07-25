object fMain: TfMain
  Left = 0
  Top = 0
  Caption = 'Cadastro de Clientes'
  ClientHeight = 732
  ClientWidth = 981
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI Light'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 981
    Height = 89
    Align = alTop
    BevelInner = bvLowered
    Caption = 'Panel1'
    Color = 498667
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 0
    Top = 89
    Width = 981
    Height = 643
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel2'
    Color = 311551
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 153
      Height = 643
      Align = alLeft
      BevelInner = bvLowered
      Caption = 'Panel3'
      Color = 498667
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3811363
      Font.Height = -16
      Font.Name = 'Segoe UI Light'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      ShowCaption = False
      TabOrder = 0
      object Button1: TButton
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 143
        Height = 44
        Action = ActionCadCliente
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI Light'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object PanelWorkArea: TPanel
      Left = 153
      Top = 0
      Width = 828
      Height = 643
      Align = alClient
      BevelOuter = bvNone
      Caption = 'PanelWorkArea'
      Color = clGray
      ParentBackground = False
      ShowCaption = False
      TabOrder = 1
      object StatusBar1: TStatusBar
        Left = 0
        Top = 624
        Width = 828
        Height = 19
        Panels = <
          item
            Width = 150
          end
          item
            Width = 150
          end>
      end
    end
  end
  object ActionList1: TActionList
    Left = 297
    Top = 17
    object ActionCadCliente: TAction
      Caption = 'Cadastro de Cliente'
      OnExecute = ActionCadClienteExecute
    end
  end
  object ImageList1: TImageList
    Left = 336
    Top = 16
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 376
    Top = 16
  end
end
