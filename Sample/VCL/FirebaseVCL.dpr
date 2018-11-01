program FirebaseVCL;

uses
  Vcl.Forms,
  Firebase.View.Principal in 'Firebase.View.Principal.pas' {Form6};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm6, Form6);
  Application.Run;
end.
