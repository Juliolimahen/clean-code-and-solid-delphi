unit Core.Entities;

interface

uses
  System.Generics.Collections;

type
  // Uso de 'Managed Record' do Delphi moderno para simplificar o gerenciamento de memória.
  // O compilador gerencia automaticamente a inicialização e finalização do registro.
  TOrderItem = record
  private
    FProductName: string;
    FQuantity: Integer;
    FPrice: Currency;
  public
    class function New(const AProductName: string; AQuantity: Integer; APrice: Currency): TOrderItem;
    property ProductName: string read FProductName;
    property Quantity: Integer read FQuantity;
    property Price: Currency read FPrice;
  end;

  TOrder = class
  private
    FId: Integer;
    FCustomerEmail: string;
    FItems: TList<TOrderItem>;
    FTotal: Currency;
    function GetTotal: Currency;
  public
    constructor Create(const ACustomerEmail: string);
    destructor Destroy; override;
    procedure AddItem(const AProductName: string; AQuantity: Integer; APrice: Currency);
    property Id: Integer read FId write FId;
    property CustomerEmail: string read FCustomerEmail;
    property Items: TList<TOrderItem> read FItems;
    property Total: Currency read GetTotal;
  end;

implementation

uses
  System.SysUtils;

{ TOrderItem }

class function TOrderItem.New(const AProductName: string; AQuantity: Integer; APrice: Currency): TOrderItem;
begin
  Result.FProductName := AProductName;
  Result.FQuantity := AQuantity;
  Result.FPrice := APrice;
end;

{ TOrder }

constructor TOrder.Create(const ACustomerEmail: string);
begin
  inherited Create;
  FId := TInterlocked.Increment(TOrder); // Simples gerador de ID
  FCustomerEmail := ACustomerEmail;
  FItems := TList<TOrderItem>.Create;
  FTotal := 0;
end;

destructor TOrder.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TOrder.AddItem(const AProductName: string; AQuantity: Integer; APrice: Currency);
begin
  // Uso de variáveis inline e inferência de tipo
  var Item := TOrderItem.New(AProductName, AQuantity, APrice);
  FItems.Add(Item);
end;

function TOrder.GetTotal: Currency;
var
  Item: TOrderItem; // Variável de loop clássica para clareza
begin
  Result := 0;
  for Item in FItems do
  begin
    Result := Result + (Item.Price * Item.Quantity);
  end;
end;

end.