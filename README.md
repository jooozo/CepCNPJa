# uCepCNPJa

Unit para integração com a plataforma [CNPJa](https://cnpja.com/) para consulta de endereços a partir do CEP, utilizando Delphi XE6 ou superior.

## Sobre

Esta unit permite consultar endereços brasileiros usando o serviço de API do [CNPJa](https://cnpja.com/). Você pode criar rapidamente aplicações Delphi capazes de obter endereços completos apenas informando o CEP, ideal para automação de cadastros e validações.

- **Compatível com Delphi XE6 ou superior**
- Utiliza componentes padrão (Indy e System.JSON)
- Acesso via API gratuita (é necessário criar uma conta gratuita no site CNPJa para obter a chave)
- Totalmente independente: não depende de outros módulos ou registros externos

## Como usar

1. **Cadastre-se gratuitamente no site [CNPJa](https://cnpja.com/)**
2. Obtenha sua chave de API gratuita personalizada.
3. Substitua `<SUA API CNPJA>` no código pela sua chave de API.
4. Adicione o arquivo `uCepCNPJa.pas` ao seu projeto Delphi.

### Exemplo de uso

```delphi
uses
  uCepCNPJa;

var
  CepClient: TCepCNPJa;
  Endereco: TCEPAddress;
begin
  CepClient := TCepCNPJa.Create;
  try
    Endereco := CepClient.ObterEndereco('01001-000');
    ShowMessage('Rua: ' + Endereco.Endereco + sLineBreak +
                'Bairro: ' + Endereco.Bairro + sLineBreak +
                'Cidade: ' + Endereco.Cidade + sLineBreak +
                'Estado: ' + Endereco.Estado);
  finally
    CepClient.Free;
  end;
end;
```

## Estrutura do retorno

O tipo `TCEPAddress` contém os seguintes campos:

| Campo         | Descrição                 |
| ------------- | ------------------------ |
| Endereco      | Nome da rua/avenida      |
| Bairro        | Bairro                   |
| CodigoIBGE    | Código do IBGE           |
| Cidade        | Nome da cidade           |
| Estado        | UF                       |

## Requisitos

- **Delphi XE6** ou superior
- Componentes Indy instalados (IdHTTP, IdSSLIOHandlerSocketOpenSSL)
- Conexão com a internet
- Chave de API gratuita do CNPJa

## Observações

- Não esqueça de substituir a string `<SUA API CNPJA>` pela sua chave de autorização obtida no CNPJa.
- Para outros tipos de consultas, consulte a [documentação oficial da API CNPJa](https://docs.cnpja.com/).

---

**Licença:**  
Este projeto é open source. Fique à vontade para contribuir ou adaptar para suas necessidades!
