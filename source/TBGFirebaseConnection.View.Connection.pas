unit TBGFirebaseConnection.View.Connection;

interface

uses
  TBGFirebaseConnection.Interfaces, System.Classes;

Type
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidAndroid32Arm or pidAndroid64Arm)]
  TTBGFirebaseConnection = class(TComponent, iFirebaseConnection)
    private
      FConnect : iFirebaseConnect;
      FPut : iFirebasePut;
      FGet : iFirebaseGet;
      FPatch : iFirebasePatch;
      FDelete : iFirebaseDelete;
      FPost : iFirebasePost;
      FCloudMessage : iFirebaseCloudMessage;
    public
      constructor Create; reintroduce;
      destructor Destroy; override;
      class function New : iFirebaseConnection;
      function Connect : iFirebaseConnect;
      function Put : iFirebasePut;
      function Get : iFirebaseGet;
      function Patch : iFirebasePatch;
      function Delete : iFirebaseDelete;
      function Post : iFirebasePost;
      function CloudMessage : iFirebaseCloudMessage;
      procedure &Exec;
  end;

procedure Register;

implementation

{$R firebase.dcr}

uses
  TBGFirebaseConnection.Model.Connect, TBGFirebaseConnection.Model.Put,
  TBGFirebaseConnection.Model.Get, TBGFirebaseConnection.Model.Patch,
  TBGFirebaseConnection.Model.Delete, TBGFirebaseConnection.Model.CM.Send,
  TBGFirebaseConnection.Model.Post;

{ TTBGFirebaseConnection }

function TTBGFirebaseConnection.CloudMessage: iFirebaseCloudMessage;
begin
  if not Assigned(FCloudMessage) then
    FCloudMessage := TFirebaseCloudMessage.New;
  Result := FCloudMessage;
end;

function TTBGFirebaseConnection.Connect: iFirebaseConnect;
begin
  if not Assigned(FConnect) then
    FConnect := TFirebaseConnectionMoldeConnect.New(Self);

  Result := FConnect;
end;

constructor TTBGFirebaseConnection.Create;
begin

end;

function TTBGFirebaseConnection.Delete: iFirebaseDelete;
begin
   if not Assigned(FDelete) then
    FDelete := TFirebaseConnectionModelDelete.New(Self);

  Result := FDelete;
end;

destructor TTBGFirebaseConnection.Destroy;
begin

  inherited;
end;

procedure TTBGFirebaseConnection.Exec;
begin
  //Somente para Encerrar o Ciclo;
end;

function TTBGFirebaseConnection.Get: iFirebaseGet;
begin
  if not Assigned(FGet) then
    FGet := TFirebaseConnectionModelGet.New(Self);

  Result := FGet;
end;

class function TTBGFirebaseConnection.New: iFirebaseConnection;
begin
  Result := Self.Create;
end;

function TTBGFirebaseConnection.Patch: iFirebasePatch;
begin
  if not Assigned(FPatch) then
    FPatch := TFirebaseConnectionModelPatch.New(Self);

  Result := FPatch;
end;

function TTBGFirebaseConnection.Post: iFirebasePost;
begin
  if not Assigned(FPost) then
    FPost := TFirebaseConnectionModelPost.New(Self);
  Result := FPost;
end;

function TTBGFirebaseConnection.Put: iFirebasePut;
begin
  if not Assigned(FPut) then
    FPut := TFirebaseConnectionModelPut.New(Self);
  Result := FPut;
end;

procedure Register;
begin
  RegisterComponents('TBG Firebase', [TTBGFirebaseConnection]);
end;


end.
