# Tolerância a Falhas e Resiliência

> Foco DVA-C02 – Domínio 1: Development with AWS Services

---

## Princípios fundamentais

| Princípio | Descrição |
|---|---|
| **Retry + Backoff** | Tente novamente com espera crescente |
| **Idempotência** | Mesmo resultado se executado N vezes |
| **Circuit Breaker** | Para de chamar serviço com falha |
| **Bulkhead** | Isola falhas para não propagar |
| **DLQ** | Captura mensagens/eventos com falha |
| **Timeout** | Evita espera infinita |

---

## Exponential Backoff com Jitter

```
Tempo de espera = min(cap, base * 2^attempt) + random_jitter
```

- **Por que jitter?** Evita que múltiplos clientes reintentem simultaneamente (thundering herd).
- AWS SDK implementa automaticamente para a maioria dos serviços.
- Erros 5xx e ThrottlingException → sempre usar exponential backoff.

---

## Dead Letter Queue (DLQ)

| Serviço | Configuração DLQ |
|---|---|
| **SQS** | `RedrivePolicy` na fila (maxReceiveCount + DLQ ARN) |
| **Lambda assíncrona** | `DeadLetterConfig` na função |
| **SNS** | Subscription DLQ na assinatura |
| **EventBridge** | Dead-letter queue na regra |

---

## Resiliência em serviços AWS

### SQS
- `VisibilityTimeout`: mensagem fica invisível enquanto processada.
- `MessageRetentionPeriod`: até 14 dias.
- `ReceiveMessageWaitTimeSeconds`: long polling reduz chamadas vazias.

### Lambda
- Concorrência reservada: garante que função sempre tenha capacidade.
- Concorrência provisionada: elimina cold start.
- Retry automático em invocações assíncronas (2 tentativas).

### API Gateway
- Throttling: 10.000 req/s padrão (ajustável); 429 Too Many Requests.
- Cache de respostas: TTL configurável, reduz chamadas ao backend.

---

## Conceitos críticos para a prova ⚠️

- **SQS maxReceiveCount**: número de vezes que uma mensagem pode ser recebida antes de ir para a DLQ.
- **Lambda reserved concurrency = 0**: desativa a função (útil para throttle manual).
- **Step Functions** implementa retry/catch nativamente nos estados.
- Multi-AZ = alta disponibilidade; Multi-Region = disaster recovery.

---

## Pegadinhas da prova 🎯

- DLQ do SQS e DLQ da Lambda são configurações **separadas**.
- Aumentar o `VisibilityTimeout` do SQS não é a solução para processamento lento — ajuste o timeout da Lambda também.
- `ProvisionedConcurrency` elimina cold start mas **custa mais**.

---

## Referências oficiais

- [Exponential Backoff and Jitter](https://aws.amazon.com/blogs/architecture/exponential-backoff-and-jitter/)
- [SQS Dead Letter Queues](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-dead-letter-queues.html)
- [Lambda error handling](https://docs.aws.amazon.com/lambda/latest/dg/invocation-retries.html)
