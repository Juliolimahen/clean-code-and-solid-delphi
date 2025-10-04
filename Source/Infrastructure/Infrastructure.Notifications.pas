unit Infrastructure.Notifications;

interface

uses
  Core.Interfaces, System.SysUtils;

type
  // Implementação concreta de um serviço de notificação (simulado)
  TEmailNotificationService = class(TInterfacedObject, INotificationService)
  public
    procedure Send(const ACustomerEmail, AMessage: string);
  end;

implementation

{ TEmailNotificationService }

procedure TEmailNotificationService.Send(const ACustomerEmail, AMessage: string);
begin
  // Simula o envio de um e-mail
  Writeln(Format('--- EMAIL ENVIADO PARA: %s ---', [ACustomerEmail]));
  Writeln(Format('Mensagem: %s', [AMessage]));
  Writeln('-----------------------------------');
end;

end.