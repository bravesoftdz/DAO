unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Unit2, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;

    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    DBGrid1 : TDBGrid;
    Connection: TConnection;
    DataElementObjectList: TDataElementObjectList;
    DataElement2: TDataElement2;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  i: integer;
begin
  DBGrid1 := TDBGrid.Create(Form1);
  DBGrid1.Parent := Form1;
  DBGrid1.Left := 50;
  DBGrid1.Top := 50;
  DataElementObjectList := TDataElementObjectList.create;
  DataElement2 := TDataElement2.create;
  Connection := TConnection.create;
  Connection.SetDataSource('op');
  while not Connection.GetDataSet.Eof do
  begin
    DataElementObjectList.AddNew(Connection.GetDataSet.Fields.Fields[0]
      .AsInteger, Connection.GetDataSet.Fields.Fields[1].AsString,
      Connection.GetDataSet.Fields.Fields[2].AsInteger,
      Connection.GetDataSet.Fields.Fields[3].AsString);
    DataElement2.AddNew(Connection.GetDataSet.Fields.Fields[0]
      .AsInteger, Connection.GetDataSet.Fields.Fields[1].AsString,
      Connection.GetDataSet.Fields.Fields[2].AsInteger,
      Connection.GetDataSet.Fields.Fields[3].AsString);
    Connection.GetDataSet.next;
  end;
  Label1.Caption := inttostr(DataElement2.Count);
  DBGrid1.DataSource := Connection.GetDataSource;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  DataElementObjectList.Clear;
  //DataElementObjectList.Free;
  DBGrid1.Free;
  Connection.Free;
end;
end.
