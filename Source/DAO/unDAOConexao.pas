unit unDAOConexao;

interface

uses
  System.IniFiles, System.SysUtils, Vcl.Dialogs,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait;

type
  TDAOConexao = class
  private
    class var FConnection: TFDConnection;
    class constructor Create;
  public
    class function GetConnection: TFDConnection;
  end;

implementation

{ TDAOConexao }

class constructor TDAOConexao.Create;
var
  PathIni: string;
  Ini: TIniFile;

begin
  try
    PathIni := ExtractFilePath(ParamStr(0)) + 'config\dbconfig.ini';
    if not FileExists(PathIni) then
      raise Exception.Create('Arquivo de configuração não encontrado: ' + PathIni);

    Ini := TIniFile.Create(PathIni);
    try
      FConnection := TFDConnection.Create(nil);
      FConnection.LoginPrompt := False;
      FConnection.Params.DriverID := 'MySQL';
      FConnection.Params.Database := Ini.ReadString('DB', 'Database', '');
      FConnection.Params.UserName := Ini.ReadString('DB', 'Username', '');
      FConnection.Params.Password := Ini.ReadString('DB', 'Password', '');
      FConnection.Params.Values['Server'] := Ini.ReadString('DB', 'Server', '');
      FConnection.Params.Values['Port'] := Ini.ReadString('DB', 'Port', '3306');
      FConnection.Params.Values['UseSSL'] := 'Disabled';
      FConnection.Connected := True;
    finally
      Ini.Free;
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Erro ao criar conexão: ' + sLineBreak + E.Message);
      Halt;
    end;
  end;
end;

class function TDAOConexao.GetConnection: TFDConnection;
begin
  Result := FConnection;
end;

end.

