# Amazon SNS — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Serviço de mensageria pub/sub totalmente gerenciado para envio de notificações em fanout a múltiplos destinos simultaneamente. Um publicador envia para um tópico SNS e todos os assinantes recebem a mensagem.

**Para que usamos:** Fanout para múltiplas filas SQS ou Lambdas, alertas operacionais para e-mail/SMS/HTTP, notificações push mobile (APNs, FCM), desacoplamento de eventos entre sistemas.

**Exemplo de prova:** Ao criar um novo pedido, o sistema precisa notificar simultaneamente o serviço de estoque, o de faturamento e enviar um e-mail de confirmação ao cliente. Como garantir que uma falha no serviço de faturamento não impeça as outras notificações?
→ Usar o padrão **Fanout SNS→SQS**: publicar no SNS Topic; cada serviço tem sua própria fila SQS assinante. Cada fila processa independentemente com seu próprio retry. O envio de e-mail usa uma assinatura SNS direto para Lambda/SES. Falha em um assinante não afeta os demais.

---

## Modelo Pub/Sub

```
[Publisher] → [SNS Topic] → [Subscriber 1: Lambda]
                          → [Subscriber 2: SQS]
                          → [Subscriber 3: HTTP/HTTPS]
                          → [Subscriber 4: Email]
                          → [Subscriber 5: SMS]
                          → [Subscriber 6: Mobile Push]
```

---

## Tipos de tópico

| | Standard | FIFO |
|---|---|---|
| Ordem | Sem garantia | Garantida |
| Deduplication | Não | Sim |
| Subscribers | Qualquer | Somente SQS FIFO |
| Throughput | Ilimitado | 300 TPS |

---

## Message Filtering

```json
{
  "store": ["minha-loja"],
  "event": [{"anything-but": "order_cancelled"}],
  "price": [{"numeric": [">=", 100]}]
}
```
- Cada subscription pode ter uma filter policy.
- Sem filter policy = recebe tudo.

---

## Fan-out Pattern

```
[Event] → [SNS Topic]
                ↓
          [SQS Queue 1] → [Consumer 1]
          [SQS Queue 2] → [Consumer 2]
          [Lambda Function]
```

- SNS → SQS para durabilidade (SNS não persiste mensagens).

---

## Limites

| Item | Valor |
|---|---|
| Tamanho da mensagem | 256 KB |
| Subscribers por tópico | 12.500.000 |
| Retenção | Sem persistência |

---

## Referências oficiais

- [Amazon SNS](https://docs.aws.amazon.com/sns/latest/dg/welcome.html)
