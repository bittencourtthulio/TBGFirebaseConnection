unit TBGFirebaseConnection.Model.Post;

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
  TFirebaseConnectionModelPost = class(TInterfacedObject, iFirebasePost)
  private
    FParent : iFirebaseConnection;
    FResource : String;
    FJson : TJsonObject;
    FJson2 : String;
    FJsonArray : TJsonArray;
  public
    constructor Create(Parent : iFirebaseConnection);
    destructor Destroy; override;
    class function New(Parent : iFirebaseConnection): iFirebasePost;
    function Resource(Value: String): iFirebasePost; overload;
    function Resource: String; overload;
    function Json ( Value : String) : iFirebasePost; overload;
    function Json ( Value : TJsonObject) : iFirebasePost; overload;
    function Json ( Value : TJsonArray ) : iFirebasePost; overload;
    function Json : String; overload;
    function &End: iFirebaseConnection;
  end;

implementation

uses
  System.SysUtils, System.Classes;

{ TFirebaseConnectionModelPost }

function TFirebaseConnectionModelPost.&End: iFirebaseConnection;
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
    lIdHTTP.Post(lUrl, lJsonStream, AResponseContent);
  except
    raise Exception.Create('Não foi possivel realizar o Put na Base de Dados');
  end;

end;

constructor TFirebaseConnectionModelPost.Create(Parent : iFirebaseConnection);
begin
  FParent := Parent;
end;

destructor TFirebaseConnectionModelPost.Destroy;
begin

  inherited;
end;

function TFirebaseConnectionModelPost.Json: String;
begin
  Result := FJson.ToString;
end;

function TFirebaseConnectionModelPost.Json(Value: TJsonArray): iFirebasePost;
begin
  Result := Self;
  FJsonArray := Value;
end;

function TFirebaseConnectionModelPost.Json(Value: TJsonObject): iFirebasePost;
begin
  Result := Self;
  FJson := Value;
end;

function TFirebaseConnectionModelPost.Json(Value: String): iFirebasePost;
begin
  Result := Self;
  FJson := TJSONObject.ParseJSONValue(Value) as TJSONObject;
end;

class function TFirebaseConnectionModelPost.New(Parent : iFirebaseConnection): iFirebasePost;
begin
  Result := Self.Create(Parent);
end;

function TFirebaseConnectionModelPost.Resource: String;
begin
  Result := FResource;
end;

function TFirebaseConnectionModelPost.Resource(Value: String): iFirebasePost;
begin
  Result := Self;
  FResource := '/' + Value + '.json';
end;

end.
