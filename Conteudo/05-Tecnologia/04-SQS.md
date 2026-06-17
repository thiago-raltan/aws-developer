# Amazon SQS — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Serviço de filas de mensagens totalmente gerenciado para desacoplar e escalar microsserviços, sistemas distribuídos e aplicações serverless. Oferece filas Standard (alto throughput, entrega at-least-once) e FIFO (ordenação garantida, exactly-once).

**Para que usamos:** Desacoplar produtor e consumidor, buffer de escrita para suavizar picos de carga, retry automático com visibilidade, orquestração de tarefas assíncronas.

**Exemplo de prova:** Um sistema de pedidos usa SQS Standard. Às vezes a mesma mensagem é processada duas vezes, gerando pedidos duplicados. A equipe não pode migrar para FIFO imediatamente. Como mitigar a duplicidade no lado da aplicação?
→ Implementar **idempotência no consumidor**: antes de processar, verificar no DynamoDB (ou ElastiCache) se o `messageId` da mensagem já foi processado. Se sim, descartar silenciosamente. O `MessageDeduplicationId` é exclusivo do FIFO; em Standard, a responsabilidade é da aplicação.

---

## Standard vs. FIFO

| | Standard | FIFO |
|---|---|---|
| Ordem | Melhor esforço | Garantida |
| Entrega | Pelo menos 1x | Exatamente 1x |
| Throughput | Ilimitado | 300 TPS (3.000 com batch) |
| Deduplication | Não nativo | 5-min dedup window |
| Nome | Qualquer | Deve terminar em `.fifo` |

---

## Parâmetros críticos

| Parâmetro | Padrão | Máximo |
|---|---|---|
| VisibilityTimeout | 30 s | 12 h |
| MessageRetentionPeriod | 4 dias | 14 dias |
| ReceiveMessageWaitTime | 0 s (short) | 20 s (long) |
| MaximumMessageSize | — | 256 KB |
| DelaySeconds | 0 | 900 s (15 min) |

---

## Lambda + SQS

- Event Source Mapping: Lambda faz polling automático.
- `BatchSize`: 1–10.000 mensagens por invocação.
- `VisibilityTimeout` recomendado = 6× o timeout da Lambda.
- `ReportBatchItemFailures`: retorna apenas IDs com falha.
- DLQ: configurar **na fila** com `RedrivePolicy`.

---

## Long Polling vs. Short Polling

- **Short polling** (0 s): resposta imediata, pode ser vazia.
- **Long polling** (1–20 s): aguarda mensagem → recomendado.

---

## FIFO — identificadores

- `MessageGroupId`: grupo de ordenação (obrigatório).
- `MessageDeduplicationId`: dedup ID (ou ContentBasedDeduplication).

---

## Referências oficiais

- [Amazon SQS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/welcome.html)
