unit Core.Interfaces;

interface

uses
  Core.Entities;

type
  { Principio da Segregação de Interfaces (ISP):
    Interfaces pequenas e coesas são melhores que uma interface monolítica.
    Cada interface tem uma responsabilidade bem definida. }

  // Interface para validação de pedidos
  IOrderValidator = interface
    ['{1A5E8A9A-1B8C-4B7C-9E4B-2B2D31B7C95B}']
    function Validate(const AOrder: TOrder): Boolean;
  end;

  // Interface para persistência de dados de pedidos
  IOrderRepository = interface
    ['{F2C79E88-A46D-4A2E-8E49-7FF29E0B201A}']
    procedure Save(const AOrder: TOrder);
  end;

  // Interface para notificação sobre o status do pedido
  INotificationService = interface
    ['{E9A8E2E8-8B4E-4B0D-9571-0C7A9F5C5C0F}']
    procedure Send(const ACustomerEmail, AMessage: string);
  end;

  // Interface para processamento de pagamentos
  IPaymentProvider = interface
    ['{B9D9C3A3-4C3D-4A4B-8367-73B8D9E3B4F5}']
    function ProcessPayment(const AOrder: TOrder): Boolean;
    function GetName: string;
  end;

implementation

end.