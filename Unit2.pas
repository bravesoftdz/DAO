unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ToolWin, ActnMan, ActnCtrls,
  ActnMenus, Menus, Data.DB, Data.Win.ADODB, Contnrs,
  Generics.Collections;

type

  TConnection = class
  private
    ADOConnection: TADOConnection;
    ADOQuery: TADOQuery;
    DataSource: TDataSource;
  public
    procedure SetDataSource(SQL: string);
    function GetDataSource: TDataSource;
    function GetDataSet: TDataSet;
    constructor create;
    destructor destroy; override;
  end;

  TDataElement2 = class(TObjectList)
  private
    fIdelement: integer;
    fDescription: string;
    fPrice: integer;
    fComponent: string;
  public
    function AddNew(idelement: integer; description: string; price: integer;
      component: string): TDataElement2;
  end;

  TDataElement = class
  private
    fIdelement: integer;
    fDescription: string;
    fPrice: integer;
    fComponent: string;
  end;

  TDataElementObjectList = class(TObjectList<TDataElement>)
  public
    function AddNew(idelement: integer; description: string; price: integer;
      component: string): TDataElement;
  end;

implementation

{ TDataElementObjectList }

function TDataElementObjectList.AddNew(idelement: integer; description: string;
  price: integer; component: string): TDataElement;
begin
  result := TDataElement.create;
  result.fIdelement := idelement;
  result.fDescription := description;
  result.fPrice := price;
  result.fComponent := component;
  add(result);
end;

{ TConnection }

constructor TConnection.create;
begin
  if not Assigned(ADOConnection) then
    ADOConnection := TADOConnection.create(nil);
  ADOConnection.ConnectionString :=
    'Provider=MSDASQL.1;Password=2307;Persist Security Info=True;User ID=root;Extended Properties="DRIVER={MySQL ODBC 5.3 Unicode Driver};UID=root;PWD=2307;SERVER=localhost;DATABASE=store;PORT=3306;COLUMN_SIZE_S32=1;";Initial Catalog=store';
  ADOConnection.LoginPrompt := false;
  ADOConnection.Connected := true;
end;

destructor TConnection.destroy;
begin
  inherited;
  ADOConnection.Free;
  ADOQuery.Free;
  DataSource.Free;
end;

function TConnection.GetDataSet: TDataSet;
begin
  result := DataSource.DataSet;
end;

function TConnection.GetDataSource: TDataSource;
begin
  result := DataSource;
end;

procedure TConnection.SetDataSource(SQL: string);
begin
  if not Assigned(ADOQuery) then
    ADOQuery := TADOQuery.create(nil);
  ADOQuery.Connection := ADOConnection;
  ADOQuery.Close;
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.add('SELECT * FROM store.element;');
  ADOQuery.Open;
  ADOQuery.Active := true;
  if not Assigned(DataSource) then
    DataSource := TDataSource.create(nil);
  DataSource.DataSet := ADOQuery;
end;

{ TDataElement2 }

function TDataElement2.AddNew(idelement: integer; description: string;
  price: integer; component: string): TDataElement2;
begin
  result := TDataElement2.create;
  result.fIdelement := idelement;
  result.fDescription := description;
  result.fPrice := price;
  result.fComponent := component;
  add(result);
end;

end.
