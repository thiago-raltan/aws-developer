# Lambda — Debugging e Dead Letter Queue

> Foco DVA-C02 – Domínio 4: Troubleshooting and Optimization

---

## Tipos de falha em Lambda

| Tipo | Causa | Comportamento |
|---|---|---|
| **Function error** | Exceção no código | Erro retornado ao invocador |
| **Timeout** | Execução > timeout | `Task timed out after Xs` |
| **OOM** | Memória insuficiente | `Runtime exited with error: signal: killed` |
| **Throttle** | Concorrência excedida | 429 para síncrona; retry para assíncrona |
| **Init error** | Erro no código fora do handler | Execution environment falha |

---

## Debugging com CloudWatch Logs

### Campos automáticos Lambda
```
START RequestId: abc-123 Version: $LATEST
... seu log aqui ...
END RequestId: abc-123
REPORT RequestId: abc-123 Duration: 152.34 ms Billed Duration: 153 ms
  Memory Size: 256 MB Max Memory Used: 89 MB Init Duration: 312.45 ms
```

- `Init Duration`: presente apenas em cold starts.
- `Max Memory Used`: ajuda a dimensionar memória.
- `Billed Duration`: arredondado para cima ao ms mais próximo.

### Erros comuns e diagnóstico

| Erro | Causa | Solução |
|---|---|---|
| `Task timed out` | Código mais lento que timeout | Aumentar timeout ou otimizar código |
| `Unable to import module` | Dependência faltando | Verificar requirements.txt e build |
| `AccessDeniedException` | Falta permissão IAM | Adicionar permissão na execution role |
| `ResourceNotFoundException` | Recurso não existe ou nome errado | Verificar ARN/nome e variáveis de ambiente |
| `TooManyRequestsException` | Throttling | Aumentar concorrência ou usar SQS como buffer |

---

## Dead Letter Queue (DLQ)

Destino para eventos que **falharam após todas as tentativas** de retry.

### Lambda assíncrona (EventBridge, S3, SNS)
```json
{
  "FunctionName": "MinhaFuncao",
  "DeadLetterConfig": {
    "TargetArn": "arn:aws:sqs:us-east-1:123:minha-dlq"
  }
}
```

- Retry automático: **2 vezes** (total 3 tentativas).
- Após 3 falhas → mensagem vai para DLQ.
- DLQ pode ser: **SQS** ou **SNS**.

### Destinations (alternativa moderna à DLQ)
```json
{
  "EventInvokeConfig": {
    "DestinationConfig": {
      "OnSuccess": {
        "Destination": "arn:aws:sqs:us-east-1:123:sucesso-queue"
      },
      "OnFailure": {
        "Destination": "arn:aws:sqs:us-east-1:123:falha-queue"
      }
    }
  }
}
```

### DLQ vs. Destinations

| | DLQ | Destinations |
|---|---|---|
| Configuração | `DeadLetterConfig` | `EventInvokeConfig.DestinationConfig` |
| Tipos suportados | SQS, SNS | SQS, SNS, Lambda, EventBridge |
| Payload | Apenas evento original | Evento + metadados de execução |
| Sucesso | Não captura | Captura |
| Preferência | Legado | Recomendado |

---

## Lambda com SQS — Partial Batch Failure

```python
def lambda_handler(event, context):
    failed_items = []
    for record in event['Records']:
        try:
            process(record)
        except Exception as e:
            failed_items.append({'itemIdentifier': record['messageId']})

    # Retornar IDs de falha (apenas esses voltam para a fila)
    return {'batchItemFailures': failed_items}
```

- Requer `FunctionResponseTypes: [ReportBatchItemFailures]` no Event Source Mapping.
- Evita reprocessar mensagens que já tiveram sucesso no batch.

---

## Conceitos críticos para a prova ⚠️

- DLQ é configurado **na função** (invocação assíncrona), não no serviço de origem.
- Para SQS Event Source Mapping: DLQ é configurado **na fila SQS** (redrive policy).
- `MaximumRetryAttempts` e `MaximumRecordAgeInSeconds`: configuráveis no Event Source Mapping.
- Destinations são mais informativas que DLQ — recebem contexto completo da falha.

---

## Pegadinhas da prova 🎯

- Lambda síncrona (API Gateway): **não tem** retry automático — erro vai direto ao cliente.
- Lambda assíncrona: retry **2 vezes** automaticamente antes do DLQ.
- Destination para falha captura: evento original + causa da falha + requestId.

---

## Referências oficiais

- [Lambda error handling](https://docs.aws.amazon.com/lambda/latest/dg/invocation-retries.html)
- [Lambda DLQ](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async.html#invocation-async-errors)
- [Lambda destinations](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async.html#invocation-async-destinations)
- [SQS batch item failures](https://docs.aws.amazon.com/lambda/latest/dg/with-sqs.html#services-sqs-batchfailurereporting)
