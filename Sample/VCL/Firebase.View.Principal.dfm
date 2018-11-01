object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'Form6'
  ClientHeight = 435
  ClientWidth = 768
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 104
    Top = 95
    Width = 649
    Height = 177
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Memo1: TMemo
    Left = 104
    Top = 287
    Width = 649
    Height = 122
    TabOrder = 1
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 90
    Height = 25
    Caption = 'GET'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 39
    Width = 90
    Height = 25
    Caption = 'PUT'
    TabOrder = 3
    OnClick = Button2Click
  end
  object edtBaseURL: TLabeledEdit
    Left = 104
    Top = 20
    Width = 209
    Height = 21
    EditLabel.Width = 45
    EditLabel.Height = 13
    EditLabel.Caption = 'Base URL'
    TabOrder = 4
    Text = 'https://meuapp-e4931.firebaseio.com/'
  end
  object edtAuth: TLabeledEdit
    Left = 319
    Top = 20
    Width = 209
    Height = 21
    EditLabel.Width = 23
    EditLabel.Height = 13
    EditLabel.Caption = 'Auth'
    TabOrder = 5
    Text = 'Anonymous'
  end
  object edtUID: TLabeledEdit
    Left = 534
    Top = 20
    Width = 219
    Height = 21
    EditLabel.Width = 17
    EditLabel.Height = 13
    EditLabel.Caption = 'uID'
    TabOrder = 6
    Text = '76c7f3c2-f35a-4ea3-ac33-7dc3860465e1'
  end
  object edtResource: TLabeledEdit
    Left = 104
    Top = 68
    Width = 209
    Height = 21
    EditLabel.Width = 138
    EditLabel.Height = 13
    EditLabel.Caption = 'Resource (Tabela/Collection)'
    TabOrder = 7
    Text = 'CLIENTE'
  end
  object Button3: TButton
    Left = 8
    Top = 70
    Width = 90
    Height = 25
    Caption = 'PATH'
    TabOrder = 8
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 101
    Width = 90
    Height = 25
    Caption = 'DELETE'
    TabOrder = 9
    OnClick = Button4Click
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 480
    Top = 144
  end
  object TBGFirebaseConnection1: TTBGFirebaseConnection
    Left = 592
    Top = 144
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 696
    Top = 144
  end
end
