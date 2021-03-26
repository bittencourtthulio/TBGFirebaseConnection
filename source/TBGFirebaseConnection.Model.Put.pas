unit TBGFirebaseConnection.Model.Put;

interface

uses
  TBGFirebaseConnection.Interfaces,
  System.JSON,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  System.Net.URLClient,
  System.NetConsts,
  System.Net.HttpClient;

Type
  TFirebaseConnectionModelPut = class(TInterfacedObject, iFirebasePut)
  private
    FParent : iFirebaseConnection;
    FResource : String;
    FJson : TJsonObject;
    FJsonArray : TJsonArray;
  public
    constructor Create(Parent : iFirebaseConnection);
    destructor Destroy; override;
    class function New(Parent : iFirebaseConnection): iFirebasePut;
    function Resource(Value: String): iFirebasePut; overload;
    function Resource: String; overload;
    function Json(Value: String): iFirebasePut; overload;
    function Json(Value: TJsonObject): iFirebasePut; overload;
    function Json ( Value : TJsonArray ) : iFirebasePut; overload;
    function Json: String; overload;
    function &End: iFirebaseConnection;
  end;

implementation

uses
  System.SysUtils, System.Classes;

{ TFirebaseConnectionModelPut }

function TFirebaseConnectionModelPut.&End: iFirebaseConnection;
var
  lJsonStream: TStringStream;
  lIdHTTP: THTTPClient;
  lUrl: string;
  AResponseContent : TStringStream;
begin
  Result := FParent;
  lJsonStream := nil;
  try
    if Assigned(FJson) then
      lJsonStream := TStringStream.Create(Utf8Encode(FJson.ToJSON));

    if Assigned(FJsonArray) then
      lJsonStream := TStringStream.Create(Utf8Encode(FJsonArray.ToJSON));

    lIdHTTP := THTTPClient.Create;
    lIdHTTP.CustomHeaders['auth'] := FParent.Connect.Auth;
    lIdHTTP.CustomHeaders['uid'] := FParent.Connect.uId;
    lIdHTTP.ContentType := 'application/json';
    lUrl := FParent.Connect.BaseURL + FResource;
    AResponseContent := TStringStream.Create();
    lIdHTTP.Put(lUrl, lJsonStream, AResponseContent);
  except
    raise Exception.Create('N�o foi possivel realizar o Put na Base de Dados');
  end;

end;

constructor TFirebaseConnectionModelPut.Create(Parent : iFirebaseConnection);
begin
  FParent := Parent;
end;

destructor TFirebaseConnectionModelPut.Destroy;
begin

  inherited;
end;

function TFirebaseConnectionModelPut.Json: String;
begin
  Result := FJson.ToString;
end;

function TFirebaseConnectionModelPut.Json(Value: TJsonArray): iFirebasePut;
begin
  Result := Self;
  FJsonArray := Value;
end;

function TFirebaseConnectionModelPut.Json(Value: TJsonObject): iFirebasePut;
begin
  Result := Self;
  FJson := Value;
end;

function TFirebaseConnectionModelPut.Json(Value: String): iFirebasePut;
begin
  Result := Self;
  FJson := TJSONObject.ParseJSONValue(Value) as TJSONObject;
end;

class function TFirebaseConnectionModelPut.New(Parent : iFirebaseConnection): iFirebasePut;
begin
  Result := Self.Create(Parent);
end;

function TFirebaseConnectionModelPut.Resource: String;
begin
  Result := FResource;
end;

function TFirebaseConnectionModelPut.Resource(Value: String): iFirebasePut;
begin
  Result := Self;
  FResource := '/' + Value + '.json';
end;

end.
