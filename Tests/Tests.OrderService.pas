unit Tests.OrderService;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TOrderServiceTests = class
  public
    [Test]
    procedure Should_Fail_When_Processing_Empty_Order;
  end;

implementation

uses
  System.SysUtils,
  Core.Interfaces,
  Core.Entities,
  Application.Services,
  // Mocks/Stubs para testes
  Tests.Mocks;

procedure TOrderServiceTests.Should_Fail_When_Processing_Empty_Order;
var
  OrderService: TOrderService;
  Order: TOrder;
  Validator: IOrderValidator;
  Repository: IOrderRepository;
  Notifier: INotificationService;
  PaymentProvider: IPaymentProvider;
begin
  // Arrange: Configurar o ambiente do teste
  Validator       := TOrderValidatorMock.Create;
  Repository      := TOrderRepositoryMock.Create;
  Notifier        := TNotificationServiceMock.Create;
  PaymentProvider := TPaymentProviderMock.Create;

  OrderService := TOrderService.Create(Validator, Repository, Notifier, PaymentProvider);
  Order := TOrder.Create('test@test.com');
  try
    // Act & Assert: Executar e verificar
    // Espera-se que uma exceção seja levantada pelo validador
    Assert.WillRaise(
      procedure
      begin
        OrderService.ProcessOrder(Order);
      end,
      EAssertionFailed, // DUnitX usa EAssertionFailed para falhas de Assert
      'A validação de um pedido vazio deveria ter falhado'
    );
  finally
    Order.Free;
    OrderService.Free;
  end;
end;

end.