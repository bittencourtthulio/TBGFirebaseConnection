unit TBGFirebaseConnection.Model.Patch;

interface

uses
  TBGFirebaseConnection.Interfaces,
  System.JSON,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  System.Net.HttpClient;

Type
  TFirebaseConnectionModelPatch = class(TInterfacedObject, iFirebasePatch)
  private
    FParent : iFirebaseConnection;
    FResource : String;
    FJson : TJsonObject;
    FJson2 : String;
    FJsonArray : TJsonArray;
    FRegisterID : Integer;
  public
    constructor Create(Parent : iFirebaseConnection);
    destructor Destroy; override;
    class function New(Parent : iFirebaseConnection): iFirebasePatch;
    function Resource(Value: String): iFirebasePatch; overload;
    function Resource: String; overload;
    function Json ( Value : String) : iFirebasePatch; overload;
    function Json ( Value : TJsonObject) : iFirebasePatch; overload;
    function Json ( Value : TJsonArray ) : iFirebasePatch; overload;
    function Json : String; overload;
    function RegisterID ( aValue : Integer ) : iFirebasePatch; overload;
    function &End: iFirebaseConnection;
  end;

implementation

uses
  System.SysUtils, System.Classes;

{ TFirebaseConnectionModelPatch }

function TFirebaseConnectionModelPatch.&End: iFirebaseConnection;
var
  lJsonStream: TStringStream;
  lIdHTTP: THTTPClient;
  lResponse: string;
  lUrl: string;
  AResponseContent : TStringStream;
begin
  Result := FParent;
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
    lIdHTTP.Patch(lUrl, lJsonStream, AResponseContent);
  except
    raise Exception.Create('Não foi possivel realizar o Patch na Base de Dados');
  end;

end;

constructor TFirebaseConnectionModelPatch.Create(Parent : iFirebaseConnection);
begin
  FParent := Parent;
end;

destructor TFirebaseConnectionModelPatch.Destroy;
begin

  inherited;
end;

function TFirebaseConnectionModelPatch.Json: String;
begin
  Result := FJson.ToString;
end;

function TFirebaseConnectionModelPatch.Json(Value: TJsonArray): iFirebasePatch;
begin
  Result := Self;
  FJsonArray := Value;
end;

function TFirebaseConnectionModelPatch.Json(Value: TJsonObject): iFirebasePatch;
begin
  Result := Self;
  FJson := Value;
end;

function TFirebaseConnectionModelPatch.Json(Value: String): iFirebasePatch;
begin
  Result := Self;
  FJson := TJSONObject.ParseJSONValue(Value) as TJSONObject;
end;

class function TFirebaseConnectionModelPatch.New(Parent : iFirebaseConnection): iFirebasePatch;
begin
  Result := Self.Create(Parent);
end;

function TFirebaseConnectionModelPatch.RegisterID(
  aValue: Integer): iFirebasePatch;
begin
  Result := Self;
  FRegisterID := aValue;
end;

function TFirebaseConnectionModelPatch.Resource: String;
begin
  Result := FResource;
end;

function TFirebaseConnectionModelPatch.Resource(Value: String): iFirebasePatch;
begin
  Result := Self;
  FResource := '/' + Value + '/' + IntToStr(FRegisterID) + '/.json';
end;

end.
