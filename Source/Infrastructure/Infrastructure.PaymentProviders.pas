unit Infrastructure.PaymentProviders;

interface

uses
  Core.Interfaces, Core.Entities, System.SysUtils;

type
  { Principio Aberto/Fechado (OCP):
    O sistema está aberto para extensão (novos provedores de pagamento)
    mas fechado para modificação (TOrderService não precisa ser alterado).

    Principio da Substituição de Liskov (LSP):
    Qualquer implementação de IPaymentProvider (TCreditCardProvider, TPixProvider)
    pode ser substituída uma pela outra sem quebrar a lógica de TOrderService. }

  // Implementação para pagamento com Cartão de Crédito
  TCreditCardProvider = class(TInterfacedObject, IPaymentProvider)
  public
    function ProcessPayment(const AOrder: TOrder): Boolean;
    function GetName: string;
  end;

  // Implementação para pagamento com PIX
  TPixProvider = class(TInterfacedObject, IPaymentProvider)
  public
    function ProcessPayment(const AOrder: TOrder): Boolean;
    function GetName: string;
  end;

implementation

{ TCreditCardProvider }

function TCreditCardProvider.GetName: string;
begin
  Result := 'Cartão de Crédito';
end;

function TCreditCardProvider.ProcessPayment(const AOrder: TOrder): Boolean;
begin
  Writeln(Format('Processando R$ %.2f com %s...', [AOrder.Total, GetName]));
  // Lógica de pagamento com cartão...
  Result := True; // Simula sucesso
end;

{ TPixProvider }

function TPixProvider.GetName: string;
begin
  Result := 'PIX';
end;

function TPixProvider.ProcessPayment(const AOrder: TOrder): Boolean;
begin
  Writeln(Format('Gerando QR Code PIX no valor de R$ %.2f...', [AOrder.Total]));
  // Lógica de pagamento com PIX...
  Result := True; // Simula sucesso
end;

end.