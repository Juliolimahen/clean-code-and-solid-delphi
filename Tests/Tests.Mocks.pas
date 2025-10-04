unit Tests.Mocks;

interface

uses
  Core.Interfaces, Core.Entities, System.SysUtils;

type
  TOrderValidatorMock = class(TInterfacedObject, IOrderValidator)
    function Validate(const AOrder: TOrder): Boolean;
  end;

  TOrderRepositoryMock = class(TInterfacedObject, IOrderRepository)
    procedure Save(const AOrder: TOrder);
  end;

  TNotificationServiceMock = class(TInterfacedObject, INotificationService)
    procedure Send(const ACustomerEmail, AMessage: string);
  end;

  TPaymentProviderMock = class(TInterfacedObject, IPaymentProvider)
    function ProcessPayment(const AOrder: TOrder): Boolean;
    function GetName: string;
  end;

implementation

{ TOrderValidatorMock }
function TOrderValidatorMock.Validate(const AOrder: TOrder): Boolean;
begin
  if AOrder.Items.Count = 0 then
    raise EAssertionFailed.Create('Pedido vazio não é válido');
  Result := True;
end;

{ TOrderRepositoryMock }
procedure TOrderRepositoryMock.Save(const AOrder: TOrder);
begin
  // No mock, não faz nada
end;

{ TNotificationServiceMock }
procedure TNotificationServiceMock.Send(const ACustomerEmail, AMessage: string);
begin
  // No mock, não faz nada
end;

{ TPaymentProviderMock }
function TPaymentProviderMock.GetName: string;
begin
  Result := 'Mock Provider';
end;

function TPaymentProviderMock.ProcessPayment(const AOrder: TOrder): Boolean;
begin
  Result := True; // Simula sucesso sempre
end;

end.