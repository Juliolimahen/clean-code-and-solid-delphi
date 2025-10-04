unit Application.Validators;

interface

uses
  Core.Interfaces, Core.Entities, System.SysUtils;

type
  // Implementação concreta de um validador de pedidos
  TOrderValidator = class(TInterfacedObject, IOrderValidator)
  public
    function Validate(const AOrder: TOrder): Boolean;
  end;

implementation

{ TOrderValidator }

function TOrderValidator.Validate(const AOrder: TOrder): Boolean;
begin
  // Regra de negócio simples: um pedido deve ter pelo menos um item.
  Result := AOrder.Items.Count > 0;
  if not Result then
    raise Exception.Create('O pedido não pode estar vazio.');

  // Outra regra: o e-mail do cliente não pode ser nulo.
  if AOrder.CustomerEmail.IsEmpty then
  begin
    Result := False;
    raise Exception.Create('O e-mail do cliente é obrigatório.');
  end;
end;

end.