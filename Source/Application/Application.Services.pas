unit Application.Services;

interface

uses
  Core.Interfaces, Core.Entities;

type
  { Principio da Responsabilidade Única (SRP):
    Esta classe tem apenas uma razão para mudar: a alteração das regras de negócio
    ao processar um pedido. Ela não se preocupa com validação, persistência ou notificação.

    Principio da Inversão de Dependência (DIP):
    A classe TOrderService depende de abstrações (interfaces) e não de
    implementações concretas. As dependências são injetadas via construtor. }
  TOrderService = class
  private
    FValidator: IOrderValidator;
    FRepository: IOrderRepository;
    FNotifier: INotificationService;
    FPaymentProvider: IPaymentProvider;
  public
    constructor Create(
      const AValidator: IOrderValidator;
      const ARepository: IOrderRepository;
      const ANotifier: INotificationService;
      const APaymentProvider: IPaymentProvider);
    function ProcessOrder(AOrder: TOrder): Boolean;
  end;

implementation

uses System.SysUtils;

{ TOrderService }

constructor TOrderService.Create(
  const AValidator: IOrderValidator;
  const ARepository: IOrderRepository;
  const ANotifier: INotificationService;
  const APaymentProvider: IPaymentProvider);
begin
  inherited Create;
  // Injeção de Dependência manual via construtor
  FValidator := AValidator;
  FRepository := ARepository;
  FNotifier := ANotifier;
  FPaymentProvider := APaymentProvider;
end;

function TOrderService.ProcessOrder(AOrder: TOrder): Boolean;
begin
  Result := False;
  // 1. Validar o pedido
  if not FValidator.Validate(AOrder) then
    Exit;

  // 2. Processar o pagamento
  if not FPaymentProvider.ProcessPayment(AOrder) then
  begin
    FNotifier.Send(AOrder.CustomerEmail, 'Seu pagamento falhou.');
    Exit;
  end;

  // 3. Salvar o pedido no repositório
  FRepository.Save(AOrder);

  // 4. Notificar o cliente
  var SuccessMessage := Format('Pedido #%d confirmado! Pagamento via %s com sucesso.', [AOrder.Id, FPaymentProvider.GetName]);
  FNotifier.Send(AOrder.CustomerEmail, SuccessMessage);

  Result := True;
end;

end.