# AWS SAM e Testes Unitários

> Foco DVA-C02 – Domínio 1: Development with AWS Services

---

## AWS SAM (Serverless Application Model)

Framework open-source que estende o CloudFormation para simplificar a definição de aplicações serverless.

### Tipos de recursos SAM

| Recurso SAM | Equivalente |
|---|---|
| `AWS::Serverless::Function` | Lambda + IAM Role |
| `AWS::Serverless::Api` | API Gateway REST API |
| `AWS::Serverless::SimpleTable` | DynamoDB Table |
| `AWS::Serverless::StateMachine` | Step Functions |

### Estrutura mínima `template.yaml`

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31

Globals:
  Function:
    Runtime: python3.12
    Timeout: 30

Resources:
  MeuFunction:
    Type: AWS::Serverless::Function
    Properties:
      Handler: app.handler
      Events:
        ApiEvent:
          Type: Api
          Properties:
            Path: /hello
            Method: get
```

### Comandos CLI SAM

```bash
sam build          # Compila a aplicação
sam local invoke   # Invoca função localmente
sam local start-api  # Inicia API Gateway local (porta 3000)
sam deploy --guided  # Deploy interativo
sam logs           # Exibe logs do CloudWatch
```

---

## Testes com SAM Local

- `sam local invoke`: testa função com evento JSON.
- `sam local start-api`: sobe API Gateway local para testes de integração.
- `sam local start-lambda`: endpoint local para chamar via SDK.
- Usa **Docker** internamente para simular o runtime Lambda.

## Testes Unitários Lambda (sem SAM)

```python
# handler.py
def lambda_handler(event, context):
    name = event.get('name', 'World')
    return {'statusCode': 200, 'body': f'Hello {name}'}

# test_handler.py
from handler import lambda_handler

def test_hello():
    event = {'name': 'AWS'}
    result = lambda_handler(event, None)
    assert result['statusCode'] == 200
```

---

## Conceitos críticos para a prova ⚠️

- SAM usa `Transform: AWS::Serverless-2016-10-31` — sem isso não é SAM.
- `Globals` aplica configurações padrão a todos os recursos do mesmo tipo.
- `sam build` gera `.aws-sam/` com artefatos; `sam deploy` usa esse diretório.
- Políticas SAM predefinidas: `DynamoDBCrudPolicy`, `S3ReadPolicy`, `SQSPollerPolicy` etc.
- `sam local` requer Docker instalado.

---

## Pegadinhas da prova 🎯

- SAM transforma para CloudFormation — é uma **extensão**, não substituto.
- `sam deploy` sem `--guided` usa configurações do `samconfig.toml`.
- Eventos locais (`sam local invoke -e event.json`) facilitam testes sem deploy.

---

## Referências oficiais

- [AWS SAM Developer Guide](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html)
- [SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-command-reference.html)
- [SAM policy templates](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-policy-templates.html)
