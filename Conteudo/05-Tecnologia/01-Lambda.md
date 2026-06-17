# AWS Lambda — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Serviço de computação serverless que executa código em resposta a eventos sem necessidade de provisionar ou gerenciar servidores. Você paga apenas pelo tempo de execução e número de invocações.

**Para que usamos:** Processar eventos de S3, SQS, DynamoDB Streams e API Gateway; automações periódicas via EventBridge; transformações de dados e integrações entre serviços sem infraestrutura dedicada.

**Exemplo de prova:** Uma Lambda consome mensagens de uma fila SQS. O processamento falha intermitentemente e as mensagens precisam ser retentadas até 3 vezes antes de serem descartadas para análise posterior — sem perda de dados. O que configurar?
→ Criar uma **Dead Letter Queue (DLQ)** SQS separada; configurar a **Redrive Policy** na fila de origem com `maxReceiveCount = 3`. Ajustar o `VisibilityTimeout` da fila para ser maior que o timeout da Lambda multiplicado pelo número de retries, evitando que a mensagem reapareça antes do processamento terminar.

---

## Limites essenciais

| Configuração | Valor |
|---|---|
| Timeout máximo | 15 minutos (900 s) |
| Timeout padrão | 3 segundos |
| Memória | 128 MB – 10.240 MB |
| /tmp storage | 512 MB – 10.240 MB |
| Package size (ZIP) | 50 MB (250 MB descompactado) |
| Container image | Até 10 GB |
| Layers por função | 5 |
| Env vars total | 4 KB |
| Concorrência padrão | 1.000 (por conta) |

---

## Tipos de invocação

| Tipo | Trigger | Retry automático |
|---|---|---|
| Síncrona | API Gateway, SDK `RequestResponse` | Não (erro vai ao cliente) |
| Assíncrona | S3, SNS, EventBridge | 2 retries (3 tentativas total) |
| Poll-based | SQS, Kinesis, DynamoDB Streams | Configurável |

---

## Runtimes suportados

Python 3.9/3.10/3.11/3.12, Node.js 18/20, Java 11/17/21, .NET 6/8, Ruby 3.2, Go (custom runtime).

---

## Ciclo de vida do container

```
Cold Start: [Extension Init] → [Runtime Init] → [Function Init] → [Handler]
Warm Start: [Handler] apenas
```

---

## Permissões

- **Execution Role**: o que Lambda pode fazer (chamar outros serviços).
- **Resource-based Policy**: quem pode invocar Lambda.

---

## Variáveis de ambiente automáticas

`AWS_REGION`, `AWS_LAMBDA_FUNCTION_NAME`, `AWS_LAMBDA_FUNCTION_MEMORY_SIZE`, `AWS_EXECUTION_ENV`.

---

## Referências oficiais

- [Lambda Developer Guide](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)
