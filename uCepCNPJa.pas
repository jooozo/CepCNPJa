unit uCepCNPJa;

interface

type
  // Define o record genérico para endereço
  TCEPAddress = record
    Endereco: string;
    Bairro: string;
    CodigoIBGE: string;
    Cidade: string;
    Estado: string;
  end;

  TCepCNPJa = class
  public
    function ObterEndereco(const pCEP: String): TCEPAddress;
  end;

implementation

uses
  IdHTTP,
  IdSSLOpenSSL,
  System.Classes,
  System.JSON,
  System.SysUtils;

{ TCepCNPJa }

function TCepCNPJa.ObterEndereco(const pCEP: String): TCEPAddress;
var
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  Resp: string;
  lJson: TJSONObject;
begin
  // Inicializa campos do record vazio
  FillChar(Result, SizeOf(Result), 0);

  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    IdHTTP.IOHandler := SSL;
    IdHTTP.Request.CustomHeaders.Values['Authorization'] := '<SUA API CNPJA>';
    IdHTTP.Request.Accept := 'application/json';

    Resp := IdHTTP.Get('https://api.cnpja.com/zip/' + pCEP);

    lJson := TJSONObject.ParseJSONValue(Resp) as TJSONObject;
    try
      if Assigned(lJson) then
      begin
        Result.Endereco   := AnsiUpperCase(lJson.GetValue<string>('street'));
        Result.Bairro     := AnsiUpperCase(lJson.GetValue<string>('district'));
        Result.CodigoIBGE := lJson.GetValue<string>('municipality');
        Result.Cidade     := AnsiUpperCase(lJson.GetValue<string>('city'));
        Result.Estado     := AnsiUpperCase(lJson.GetValue<string>('state'));
      end;
    finally
      lJson.Free;
    end;
  finally
    IdHTTP.Free;
    SSL.Free;
  end;
end;

end.