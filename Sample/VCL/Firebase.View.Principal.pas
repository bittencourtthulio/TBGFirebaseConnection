unit Firebase.View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, TBGFirebaseConnection.View.Connection,
  Vcl.StdCtrls, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls;

type
  TForm6 = class(TForm)
    DBGrid1: TDBGrid;
    Memo1: TMemo;
    FDMemTable1: TFDMemTable;
    Button1: TButton;
    TBGFirebaseConnection1: TTBGFirebaseConnection;
    Button2: TButton;
    DataSource1: TDataSource;
    edtBaseURL: TLabeledEdit;
    edtAuth: TLabeledEdit;
    edtUID: TLabeledEdit;
    edtResource: TLabeledEdit;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

uses
  System.JSON;

{$R *.dfm}

procedure TForm6.Button1Click(Sender: TObject);
var
  Json : TJsonArray;
begin
  TBGFirebaseConnection1
  .Connect
    .BaseURL(edtBaseURL.Text)
    .Auth(edtAuth.Text)
    .uId(edtUID.Text)
  .&End
  .Get
    .Resource(edtResource.Text)           //Recurso "Tabela" que será consumida
    .DataSet(FDMemTable1)                 //Pode setar o DataSet que vai receber o retorno da Consulta
    .ResponseContent(Json)                //Pode setar um (JsonObject/JsonArray/String) que irá receber o retorno da Consulta
  .&End
  .Exec;

  FDMemTable1.Fields[0].DisplayWidth := 20;
  FDMemTable1.Fields[1].DisplayWidth := 20;
  FDMemTable1.Fields[2].DisplayWidth := 60;

  Memo1.Lines.Clear;
  Memo1.Lines.Add(Json.ToJSON);
end;

procedure TForm6.Button2Click(Sender: TObject);
var
  JsonArray : TJsonArray;
  JsonObject : TJsonObject;
begin
  //A Forma mais correta e fácil para armazenar e recuperar dados no Firebase
  //é salvando JsonObjects dentro de um JsonArray Pai, assim os dados ficam
  //Sempre Organizados na leitura e conversão para o DataSet


  JsonArray := TJsonArray.Create;
  try
    //Adicionando o Primeiro Registro ao Array "Tabela" de Clientes
    JsonArray.AddElement(
      TJsonObject.Create
        .AddPair('ID', TJSONNumber.Create(1))
        .AddPair('NOME', 'José da Silva')
        .AddPair('IDADE', TJSONNumber.Create(57))
    );

    //Adicionando o Segundo Registro ao Array "Tabela" de Clientes
    JsonArray.Add(
      TJsonObject.Create
        .AddPair('ID', TJSONNumber.Create(2))
        .AddPair('NOME', 'Maria Chiquinha')
        .AddPair('IDADE', TJSONNumber.Create(42))
    );

    //Executando o Put para Salva o Objeto no Firebase
    TBGFirebaseConnection1
    .Connect
      .BaseURL(edtBaseURL.Text)
      .Auth(edtAuth.Text)
      .uId(edtUID.Text)
    .&End
    .Put
      .Resource(edtResource.Text)
      .Json(JsonArray)                  //Aqui você pode passar String/JsonObject/JsonArray
    .&End;

  finally
    JsonArray.Free;
  end;

end;

procedure TForm6.Button3Click(Sender: TObject);
begin
  {* A Operação de Patch é responsável por dar um Update em um Registro no Firebase
     para ele você pode passar um Json apenas com os campos que você deseja alterar,
     caso o campo exista ele será atualizado, caso não exista ele será criado, porém
     os campos que você não informar, eles NÃO serão deletados *}

  TBGFirebaseConnection1
    .Connect
      .BaseURL(edtBaseURL.Text)
      .Auth(edtAuth.Text)
      .uId(edtUID.Text)
    .&End
    .Patch
      .RegisterID(FDMemTable1.RecNo -1)  //Número do Registro no Array de Dados no Firebase
      .Resource(edtResource.Text)
      .Json(TJsonObject.Create.AddPair('ENDERECO', 'Rua do Debug'))
    .&End;
end;

procedure TForm6.Button4Click(Sender: TObject);
begin
  {* A Operação de Delete é responsável por deletar um Registro no Firebase
     basta informar a posição do Array que será deletado *}

  TBGFirebaseConnection1
    .Connect
      .BaseURL(edtBaseURL.Text)
      .Auth(edtAuth.Text)
      .uId(edtUID.Text)
    .&End
    .Delete
      .Resource(edtResource.Text)
      .RegisterID(FDMemTable1.RecNo -1)  //Número do Registro no Array de Dados no Firebase
    .&End;
end;

end.
