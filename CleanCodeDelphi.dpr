program ProjectSOLID;

uses
  Vcl.Forms,
  UI.MainForm in 'UI.MainForm.pas' {FormMain},
  Core.Interfaces in 'Core.Interfaces.pas',
  Core.Entities in 'Core.Entities.pas',
  Application.Services in 'Application.Services.pas',
  Infrastructure.Repositories in 'Infrastructure.Repositories.pas',
  Infrastructure.Notifications in 'Infrastructure.Notifications.pas',
  Application.Validators in 'Application.Validators.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.