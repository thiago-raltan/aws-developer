# AWS SAM (Serverless Application Model)

> Foco DVA-C02 – Domínio 3: Deployment

---

## O que é

Extensão do CloudFormation que simplifica a definição de aplicações serverless.

**Transform**: `AWS::Serverless-2016-10-31` — converte recursos SAM para CloudFormation.

---

## Recursos SAM principais

| Recurso SAM | O que cria |
|---|---|
| `AWS::Serverless::Function` | Lambda + IAM Role + Event Sources |
| `AWS::Serverless::Api` | API Gateway REST API + Deployment + Stage |
| `AWS::Serverless::SimpleTable` | DynamoDB Table |
| `AWS::Serverless::StateMachine` | Step Functions State Machine |
| `AWS::Serverless::LayerVersion` | Lambda Layer |
| `AWS::Serverless::HttpApi` | API Gateway HTTP API |

---

## Template completo de exemplo

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31

Globals:
  Function:
    Runtime: python3.12
    Timeout: 30
    MemorySize: 256
    Environment:
      Variables:
        TABLE_NAME: !Ref MinhaTabelaDyn

Resources:
  MinhaApi:
    Type: AWS::Serverless::Api
    Properties:
      StageName: prod
      Auth:
        DefaultAuthorizer: MeuAutorizador
        Authorizers:
          MeuAutorizador:
            UserPoolArn: !GetAtt MeuUserPool.Arn

  MinhaFuncao:
    Type: AWS::Serverless::Function
    Properties:
      Handler: app.handler
      Events:
        ApiEvent:
          Type: Api
          Properties:
            RestApiId: !Ref MinhaApi
            Path: /items
            Method: get
      Policies:
        - DynamoDBCrudPolicy:
            TableName: !Ref MinhaTabelaDyn

  MinhaTabelaDyn:
    Type: AWS::Serverless::SimpleTable
    Properties:
      PrimaryKey:
        Name: id
        Type: String
```

---

## SAM Policy Templates

Templates predefinidos de policy para uso comum:

| Policy Template | Permissões |
|---|---|
| `DynamoDBCrudPolicy` | CRUD em tabela DynamoDB |
| `S3CrudPolicy` | CRUD em bucket S3 |
| `SQSPollerPolicy` | Ler mensagens do SQS |
| `SNSPublishMessagePolicy` | Publicar em SNS topic |
| `KMSDecryptPolicy` | Descriptografar com KMS |
| `SSMParameterReadPolicy` | Ler parâmetros do SSM |
| `SecretsManagerReadWrite` | Ler/escrever no Secrets Manager |

---

## Fluxo de deploy

```bash
sam build            # Compila dependências, gera .aws-sam/
sam local invoke     # Testa localmente
sam local start-api  # API local em localhost:3000
sam package          # Upload para S3 (equivale a aws cloudformation package)
sam deploy           # Deploy via CloudFormation
```

### samconfig.toml (configuração persistente)
```toml
[default.deploy.parameters]
stack_name = "minha-app"
s3_bucket = "meu-bucket-sam"
region = "us-east-1"
capabilities = "CAPABILITY_IAM"
```

---

## Conceitos críticos para a prova ⚠️

- `Globals` aplica defaults a todos os recursos do mesmo tipo na seção `Resources`.
- SAM ainda usa CloudFormation — todos os recursos podem ser misturados.
- `CAPABILITY_IAM` ou `CAPABILITY_NAMED_IAM`: necessário ao criar IAM resources.
- `sam local`: usa Docker; requer Docker instalado e rodando.
- **Nested applications**: `AWS::Serverless::Application` referencia apps do SAR.

---

## Pegadinhas da prova 🎯

- `sam build` é obrigatório antes de `sam deploy` para instalar dependências.
- `sam package` ≠ `sam build`: package faz upload; build compila.
- Policy templates são atalhos — geram políticas IAM inline na function role.
- `Transform: AWS::Serverless-2016-10-31` **deve** estar no template — sem isso, CloudFormation não reconhece recursos SAM.

---

## Referências oficiais

- [AWS SAM](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html)
- [SAM resource types](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-specification-resources-and-properties.html)
- [SAM policy templates](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-policy-templates.html)
