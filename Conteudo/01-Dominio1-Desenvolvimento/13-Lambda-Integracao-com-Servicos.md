# Lambda — Integração com Serviços AWS

> Foco DVA-C02 – Domínio 1: Development with AWS Services

---

## Integrações comuns Lambda

### Lambda ← API Gateway
- Integração mais comum para REST APIs.
- **Lambda Proxy Integration**: evento completo passado como JSON; Lambda formata resposta inteira.
- **Lambda Integration**: mapeamento customizado via VTL templates.
- Timeout API Gateway: máx. 29 s.

### Lambda ← S3
- Eventos: `s3:ObjectCreated:*`, `s3:ObjectRemoved:*`, etc.
- Invocação **assíncrona**.
- Configure notificação no bucket S3 → Lambda ARN.

### Lambda ← SQS (Event Source Mapping)
- Lambda faz polling automático.
- Processa mensagens em **batches** (até 10.000 por batch).
- `BatchSize`: 1–10.000 (padrão 10).
- Em caso de erro, batch inteiro retorna para fila (ou vai para DLQ se configurado).
- `FunctionResponseTypes: ReportBatchItemFailures`: retorna apenas os IDs que falharam.

### Lambda ← DynamoDB Streams
- Event Source Mapping; Lambda lê streams em ordem.
- `StartingPosition`: TRIM_HORIZON (início) ou LATEST.
- `BisectOnFunctionError`: divide batch para isolar problema.

### Lambda ← Kinesis Data Streams
- Polling automático por shard.
- `ParallelizationFactor`: 1–10 batches simultâneos por shard.

### Lambda → DynamoDB
- Use **IAM execution role** com `dynamodb:PutItem`, `dynamodb:GetItem` etc.
- Conexão DynamoDB é leve (HTTP) — sem necessidade de pool de conexão.

### Lambda → RDS
- Use **RDS Proxy** para pooling de conexões.
- Lambda precisa estar na mesma **VPC** que o RDS.
- Concorrência alta de Lambda pode esgotar conexões RDS — solução: RDS Proxy.

### Lambda → Secrets Manager / Parameter Store
- Inicialize conexão fora do handler (warm invocation reutiliza).
- Use **extensão Lambda** para refresh automático de secrets em cache.

---

## Lambda com VPC

```
Lambda (VPC) → NAT Gateway → Internet
Lambda (VPC) → VPC Endpoint → Serviços AWS (sem internet)
```

- Lambda em VPC: **não tem acesso à internet** por padrão.
- Para internet: precisa de NAT Gateway + Internet Gateway.
- Para serviços AWS: use **VPC Endpoints** (mais seguro e barato).

---

## Conceitos críticos para a prova ⚠️

- Lambda sem VPC tem acesso à internet automaticamente (via AWS networking).
- Lambda **em VPC** perde acesso à internet — adicione NAT Gateway se necessário.
- `ReportBatchItemFailures` é essencial para SQS: evita reprocessar mensagens que já tiveram sucesso.
- Lambda deve ter IAM role com permissões explícitas para cada serviço que acessar.

---

## Pegadinhas da prova 🎯

- SQS DLQ da Lambda (invocação assíncrona) ≠ DLQ da fila SQS (Event Source Mapping).
- Para SQS, configure DLQ **na fila**, não na função Lambda.
- `FunctionResponseTypes` só funciona com SQS (não com Kinesis ou DynamoDB Streams).
- RDS Proxy é a solução correta para Lambda + RDS com alta concorrência.

---

## Referências oficiais

- [Lambda event source mapping](https://docs.aws.amazon.com/lambda/latest/dg/invocation-eventsourcemapping.html)
- [Lambda with SQS](https://docs.aws.amazon.com/lambda/latest/dg/with-sqs.html)
- [Lambda VPC access](https://docs.aws.amazon.com/lambda/latest/dg/configuration-vpc.html)
- [RDS Proxy](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-proxy.html)
