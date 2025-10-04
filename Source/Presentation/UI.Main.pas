unit UI.MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Core.Interfaces;

type
  TFormMain = class(TForm)
    btnProcessCreditCard: TButton;
    btnProcessPix: TButton;
    MemoLog: TMemo;
    procedure btnProcessCreditCardClick(Sender: TObject);
    procedure btnProcessPixClick(Sender: TObject);
  private
    procedure ProcessOrder(const APaymentProvider: IPaymentProvider);
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses
  Core.Entities,
  Application.Services,
  Application.Validators,
  Infrastructure.Repositories,
  Infrastructure.Notifications,
  Infrastructure.PaymentProviders;

procedure TFormMain.ProcessOrder(const APaymentProvider: IPaymentProvider);
var
  // Injeção de Dependência manual (Composition Root)
  // O ponto principal da aplicação monta as dependências.
  Validator: IOrderValidator;
  Repository: IOrderRepository;
  Notifier: INotificationService;
  OrderService: TOrderService;
  Order: TOrder;
begin
  MemoLog.Clear;
  MemoLog.Lines.Add('Iniciando processamento do pedido...');

  // 1. Instanciando as dependências concretas
  Validator := TOrderValidator.Create;
  Repository := TInMemoryOrderRepository.Create;
  Notifier := TEmailNotificationService.Create;

  // 2. Injetando as dependências no serviço principal
  OrderService := TOrderService.Create(Validator, Repository, Notifier, APaymentProvider);
  try
    // 3. Criando o objeto de negócio (pedido)
    // Uso de inferência de tipo
    var CustomerEmail := 'cliente@email.com';
    Order := TOrder.Create(CustomerEmail);
    try
      Order.AddItem('Produto A', 2, 50.00);  // 100.00
      Order.AddItem('Produto B', 1, 75.50);  //  75.50
                                            // Total: 175.50

      MemoLog.Lines.Add(Format('Pedido criado para %s com total de R$ %.2f', [CustomerEmail, Order.Total]));

      // 4. Executando a ação
      if OrderService.ProcessOrder(Order) then
      begin
        MemoLog.Lines.Add('SUCESSO: Pedido processado e finalizado.');
      end
      else
      begin
        MemoLog.Lines.Add('FALHA: Pedido não pôde ser processado.');
      end;

    finally
      Order.Free;
    end;
  finally
    OrderService.Free;
  end;

  MemoLog.Lines.Add('Processamento finalizado.');
end;

procedure TFormMain.btnProcessCreditCardClick(Sender: TObject);
begin
  // Usa o provedor de Cartão de Crédito
  ProcessOrder(TCreditCardProvider.Create);
end;

procedure TFormMain.btnProcessPixClick(Sender: TObject);
begin
  // Usa o provedor de PIX
  ProcessOrder(TPixProvider.Create);
end;

end.