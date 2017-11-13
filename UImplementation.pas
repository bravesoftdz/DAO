unit UImplementation;

interface


type

  TDataElement = class;

  TDataElement = class(TMyObjectList)
  private
    fIdelement: integer;
    fDescription: string;
    fPrice: integer;
    fComponent: string;
  public
    function AddNew(idelement: integer; description: string; price: integer;
      component: string): TDataElement; override;
  end;


implementation

{ TDataElement }

function TDataElement.AddNew(idelement: integer; description: string;
  price: integer; component: string): TDataElement;
begin
  result := TDataElement.Create;
  result.fIdelement := idelement;
  result.fDescription := description;
  result.fPrice := price;
  result.fComponent := component;
  add(result);
end;

end.
