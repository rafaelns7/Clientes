object fCadCliente: TfCadCliente
  Left = 0
  Top = 0
  Caption = 'fCadCliente'
  ClientHeight = 499
  ClientWidth = 635
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
    Left = 8
    Top = 56
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object Label2: TLabel
    Left = 8
    Top = 101
    Width = 81
    Height = 13
    Caption = 'Data Nascimento'
  end
  object Label3: TLabel
    Left = 148
    Top = 104
    Width = 42
    Height = 13
    Caption = 'Telefone'
  end
  object Label4: TLabel
    Left = 305
    Top = 101
    Width = 28
    Height = 13
    Caption = 'E-Mail'
  end
  object Label12: TLabel
    Left = 8
    Top = 10
    Width = 46
    Height = 13
    Caption = 'Id Cliente'
  end
  object Label14: TLabel
    Left = 305
    Top = 152
    Width = 72
    Height = 13
    Caption = 'Inscri'#231#227'o Fiscal'
  end
  object Panel1: TPanel
    Left = 0
    Top = 458
    Width = 635
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 7
    ExplicitLeft = 8
    object Button1: TButton
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 75
      Height = 31
      Align = alLeft
      Caption = 'Novo'
      TabOrder = 0
      OnClick = Button1Click
      ExplicitLeft = 8
      ExplicitTop = 0
      ExplicitHeight = 25
    end
    object Button2: TButton
      AlignWithMargins = True
      Left = 555
      Top = 5
      Width = 75
      Height = 31
      Align = alRight
      Caption = 'Cancelar'
      TabOrder = 1
      ExplicitLeft = 550
      ExplicitTop = 8
      ExplicitHeight = 25
    end
    object Button3: TButton
      AlignWithMargins = True
      Left = 474
      Top = 5
      Width = 75
      Height = 31
      Align = alRight
      Caption = 'Gravar'
      TabOrder = 2
      OnClick = Button3Click
      ExplicitLeft = 469
      ExplicitTop = 8
      ExplicitHeight = 25
    end
  end
  object GroupBox1: TGroupBox
    Left = 10
    Top = 224
    Width = 617
    Height = 228
    Caption = 'Endere'#231'o'
    TabOrder = 8
    object Label5: TLabel
      Left = 154
      Top = 17
      Width = 78
      Height = 13
      Caption = 'Tipo Logradouro'
    end
    object Label6: TLabel
      Left = 15
      Top = 84
      Width = 55
      Height = 13
      Caption = 'Logradouro'
    end
    object Label7: TLabel
      Left = 520
      Top = 84
      Width = 37
      Height = 13
      Caption = 'N'#250'mero'
    end
    object Label8: TLabel
      Left = 15
      Top = 122
      Width = 65
      Height = 13
      Caption = 'Complemento'
    end
    object Label9: TLabel
      Left = 15
      Top = 167
      Width = 33
      Height = 13
      Caption = 'Cidade'
    end
    object Label10: TLabel
      Left = 295
      Top = 168
      Width = 13
      Height = 13
      Caption = 'UF'
    end
    object Label13: TLabel
      Left = 295
      Top = 121
      Width = 28
      Height = 13
      Caption = 'Bairro'
    end
    object Label15: TLabel
      Left = 15
      Top = 17
      Width = 125
      Height = 13
      Caption = 'Informe o CEP para Busca'
    end
    object lblLoadCep: TLabel
      Left = 15
      Top = 60
      Width = 183
      Height = 19
      Caption = 'Aguarde Validando CEP...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Visible = False
      WordWrap = True
    end
    object edtTipoLogradouro: TEdit
      Left = 146
      Top = 36
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object edtlogradouro: TEdit
      Left = 16
      Top = 98
      Width = 498
      Height = 21
      TabOrder = 2
    end
    object edtNumero: TEdit
      Left = 520
      Top = 99
      Width = 92
      Height = 21
      TabOrder = 3
    end
    object edtComplemento: TEdit
      Left = 15
      Top = 140
      Width = 251
      Height = 21
      TabOrder = 4
    end
    object edtBairro: TEdit
      Left = 295
      Top = 141
      Width = 218
      Height = 21
      TabOrder = 5
    end
    object edtCidade: TEdit
      Left = 15
      Top = 186
      Width = 251
      Height = 21
      TabOrder = 6
    end
    object edtUF: TEdit
      Left = 295
      Top = 187
      Width = 42
      Height = 21
      TabOrder = 7
    end
    object edtCep: TEdit
      Left = 15
      Top = 36
      Width = 125
      Height = 21
      TabOrder = 0
      OnExit = edtCepExit
    end
  end
  object edtIdCliente: TEdit
    Left = 8
    Top = 29
    Width = 58
    Height = 21
    Enabled = False
    TabOrder = 0
  end
  object edtNome: TEdit
    Left = 10
    Top = 74
    Width = 617
    Height = 21
    TabOrder = 1
  end
  object dtDataNascimento: TDateTimePicker
    Left = 8
    Top = 120
    Width = 117
    Height = 21
    Date = 44742.000000000000000000
    Time = 0.894878738428815300
    TabOrder = 2
  end
  object edtTelefone: TEdit
    Left = 148
    Top = 120
    Width = 132
    Height = 21
    TabOrder = 3
    OnExit = edtTelefoneExit
  end
  object edtEmail: TEdit
    Left = 305
    Top = 120
    Width = 322
    Height = 21
    TabOrder = 4
  end
  object edtInscricaoFiscal: TEdit
    Left = 305
    Top = 171
    Width = 192
    Height = 21
    TabOrder = 6
    OnEnter = edtInscricaoFiscalEnter
    OnExit = edtInscricaoFiscalExit
  end
  object rdTipoPessoa: TRadioGroup
    Left = 8
    Top = 147
    Width = 272
    Height = 54
    Caption = 'Tipo Pessoa'
    Columns = 2
    Items.Strings = (
      'Fis'#237'ca'
      'Jur'#237'dica')
    TabOrder = 5
  end
end
