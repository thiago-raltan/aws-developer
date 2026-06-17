# AWS SAM — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Framework open-source construído sobre CloudFormation que simplifica a definição e implantação de aplicações serverless. Usa tipos de recursos simplificados (`AWS::Serverless::Function`, `AWS::Serverless::Api`) que se expandem para templates CloudFormation completos.

**Para que usamos:** Definir Lambda + API Gateway + DynamoDB com muito menos código que CloudFormation puro, testar funções localmente com `sam local`, criar pipelines CI/CD serverless com `sam pipeline`.

**Exemplo de prova:** Um desenvolvedor quer depurar localmente uma função Lambda que é acionada por eventos SQS antes de fazer o deploy na AWS. Quais são os pré-requisitos e o comando correto?
→ Pré-requisito: **Docker** instalado e rodando (SAM usa containers para simular o ambiente Lambda). Comando: `sam local invoke NomeDaFuncao --event evento.json`, onde `evento.json` contém o payload simulando o formato de evento do SQS. Alternativamente, `sam local start-lambda` expõe um endpoint local para invocações programáticas.

---

## Transform obrigatório

```yaml
Transform: AWS::Serverless-2016-10-31
```

---

## Recursos SAM

| Recurso | O que cria |
|---|---|
| `AWS::Serverless::Function` | Lambda + Role + Events |
| `AWS::Serverless::Api` | API Gateway REST |
| `AWS::Serverless::HttpApi` | API Gateway HTTP |
| `AWS::Serverless::SimpleTable` | DynamoDB Table |
| `AWS::Serverless::StateMachine` | Step Functions |
| `AWS::Serverless::LayerVersion` | Lambda Layer |
| `AWS::Serverless::Application` | App do SAR |

---

## Globals

```yaml
Globals:
  Function:
    Runtime: python3.12
    Timeout: 30
    MemorySize: 256
    Tracing: Active
    Environment:
      Variables:
        ENV: prod
```

---

## Policy Templates comuns

`DynamoDBCrudPolicy`, `S3CrudPolicy`, `SQSPollerPolicy`, `SNSPublishMessagePolicy`, `KMSDecryptPolicy`, `SSMParameterReadPolicy`, `SecretsManagerReadWrite`, `VPCAccessPolicy`.

---

## Comandos CLI

```bash
sam build          # Compila + instala dependências
sam local invoke   # Invoca localmente com evento JSON
sam local start-api # API local em :3000
sam deploy --guided # Deploy interativo
sam logs -n FunctionName --tail # Logs em tempo real
```

---

## Referências oficiais

- [AWS SAM](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html)
