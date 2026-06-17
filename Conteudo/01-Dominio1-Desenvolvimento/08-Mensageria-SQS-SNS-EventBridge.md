# Mensageria: SQS, SNS e EventBridge

> Foco DVA-C02 – Domínio 1: Development with AWS Services

---

## Amazon SQS (Simple Queue Service)

### Tipos de fila
| | Standard | FIFO |
|---|---|---|
| Ordem | Melhor esforço | Garantida |
| Throughput | Ilimitado | 300 TPS (3.000 c/ batching) |
| Entrega | Pelo menos 1x | Exatamente 1x |
| Deduplication | Não nativo | Deduplication ID (5 min janela) |
| Sufixo | - | `.fifo` obrigatório |

### Parâmetros críticos SQS
| Parâmetro | Padrão | Máximo | Uso |
|---|---|---|---|
| `VisibilityTimeout` | 30 s | 12 h | Tempo invisível ao ser recebida |
| `MessageRetentionPeriod` | 4 dias | 14 dias | Tempo na fila |
| `ReceiveMessageWaitTime` | 0 s | 20 s | Long polling (>0) |
| `MaxReceiveCount` | — | — | Antes de ir para DLQ |
| `DelaySeconds` | 0 | 900 s | Atraso na entrega |

### Long Polling vs. Short Polling
- **Short polling**: resposta imediata, pode retornar vazia; mais custoso.
- **Long polling**: aguarda até mensagem chegar (até 20 s); **recomendado**.

---

## Amazon SNS (Simple Notification Service)

- **Pub/Sub**: publisher envia para Topic; subscribers recebem.
- **Push-based**: SNS empurra para os subscribers.
- Subscribers: SQS, Lambda, HTTP/HTTPS, Email, SMS, Mobile Push, Firehose.
- **Sem persistência**: se subscriber não receber, mensagem é perdida (use SQS para durabilidade).

### Message Filtering
```json
{
  "store": ["example_corp"],
  "event": [{"anything-but": "order_cancelled"}]
}
```
- Cada subscriber pode ter uma **filter policy** para receber apenas mensagens relevantes.

---

## Amazon EventBridge

- Barramento de eventos gerenciado com **roteamento baseado em regras**.
- Sources: serviços AWS, aplicações customizadas, SaaS partners.
- Targets: Lambda, SQS, SNS, Step Functions, API Gateway, etc.

### Componentes
| Componente | Descrição |
|---|---|
| **Event Bus** | Receptor de eventos (default, custom, partner) |
| **Rule** | Filtro + roteamento para targets |
| **Event Pattern** | JSON para filtrar eventos |
| **Schedule** | Cron ou rate para eventos periódicos |
| **Pipes** | Conexão ponto-a-ponto com enriquecimento |

---

## Comparativo rápido

| | SQS | SNS | EventBridge |
|---|---|---|---|
| Modelo | Queue (pull) | Topic (push) | Bus (rules) |
| Persistência | Sim (até 14 dias) | Não | Não |
| Filtro | Básico | Message Filter | Event Pattern rico |
| Fan-out | Não direto | Sim | Sim |
| Ideal para | Desacoplamento, buffer | Notificações, fan-out | Roteamento complexo, SaaS |

---

## Conceitos críticos para a prova ⚠️

- Fan-out padrão: **SNS → múltiplas SQS** (durabilidade + desacoplamento).
- FIFO SQS + FIFO SNS para preservar ordem end-to-end.
- EventBridge **default bus**: recebe eventos de todos os serviços AWS automaticamente.
- **Retry policy** do EventBridge: tenta por até 24h com backoff exponencial.

---

## Pegadinhas da prova 🎯

- SQS FIFO precisa de `MessageGroupId` para ordem; `MessageDeduplicationId` para deduplicação.
- SNS não tem DLQ nativa para o topic — configure DLQ por **subscription**.
- Lambda com SQS: ajuste `VisibilityTimeout` = 6× o timeout da Lambda.
- EventBridge rules têm `State: ENABLED/DISABLED`.

---

## Referências oficiais

- [Amazon SQS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/welcome.html)
- [Amazon SNS](https://docs.aws.amazon.com/sns/latest/dg/welcome.html)
- [Amazon EventBridge](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-what-is.html)
- [SQS FIFO queues](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html)
