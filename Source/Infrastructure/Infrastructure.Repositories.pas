unit Infrastructure.Repositories;

interface

uses
  Core.Interfaces, Core.Entities, System.SysUtils;

type
  // Implementação concreta de um repositório (simulado em memória)
  TInMemoryOrderRepository = class(TInterfacedObject, IOrderRepository)
  public
    procedure Save(const AOrder: TOrder);
  end;

implementation

{ TInMemoryOrderRepository }

procedure TInMemoryOrderRepository.Save(const AOrder: TOrder);
begin
  // Nesta implementação simples, apenas "simulamos" salvar o pedido
  // exibindo uma mensagem no console ou log.
  // Em um projeto real, aqui estaria o código para salvar no banco de dados.
  Writeln(Format('Pedido #%d para %s salvo com sucesso no repositório em memória.', [AOrder.Id, AOrder.CustomerEmail]));
end;

end.