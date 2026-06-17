# Amazon EventBridge — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Barramento de eventos serverless que roteia eventos de serviços AWS, aplicações SaaS e fontes customizadas para múltiplos destinos com base em regras de filtragem. Substitui e expande o CloudWatch Events.

**Para que usamos:** Reagir a mudanças de estado de recursos AWS (EC2, RDS, CodePipeline), integrar com SaaS terceiros (Datadog, Zendesk, Shopify), criar arquiteturas event-driven desacopladas, agendar tarefas recorrentes (cron).

**Exemplo de prova:** Uma aplicação precisa acionar uma Lambda toda vez que um objeto com prefixo `relatorios/` é criado no S3, mas a política da empresa proíbe configurar notificações diretamente no bucket S3. Como implementar via EventBridge?
→ Habilitar **Amazon EventBridge notifications** no bucket S3 (configuração no próprio bucket, diferente de S3 Event Notifications). Criar uma **regra no EventBridge** com `source: aws.s3`, `detail-type: Object Created` e filtro `detail.object.key` com prefixo `relatorios/`. Destino: função Lambda.

---

## Componentes

| Componente | Descrição |
|---|---|
| **Event Bus** | Receptor: default (AWS services), custom, partner |
| **Rule** | Filtro + roteamento para targets |
| **Event Pattern** | JSON para filtrar eventos |
| **Schedule** | Cron ou rate expression |
| **Pipe** | Conexão point-to-point com filtering/enrichment |

---

## Event Pattern

```json
{
  "source": ["aws.s3"],
  "detail-type": ["Object Created"],
  "detail": {
    "bucket": {"name": ["meu-bucket"]},
    "object": {"size": [{"numeric": [">", 1000]}]}
  }
}
```

---

## Targets

Lambda, SQS, SNS, Step Functions, API Gateway, Kinesis, Firehose, CodePipeline, ECS Task, EC2, outros event buses.

---

## Schedule

```
rate(5 minutes)
rate(1 hour)
cron(0 12 * * ? *)    # todo dia ao meio-dia UTC
cron(15 10 ? * MON-FRI *)  # 10:15 UTC dias úteis
```

---

## Retry Policy

- Retry automático por até **24 horas** com exponential backoff.
- `MaximumRetryAttempts`: 0–185.
- `MaximumEventAgeInSeconds`: até 86.400 s (24h).

---

## Default Event Bus

- Recebe eventos de **todos** os serviços AWS automaticamente.
- CloudTrail integração: qualquer API call → evento no default bus.

---

## Referências oficiais

- [Amazon EventBridge](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-what-is.html)
