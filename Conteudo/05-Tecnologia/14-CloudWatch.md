# Amazon CloudWatch — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Plataforma de observabilidade da AWS que centraliza métricas, logs, alarmes, dashboards e eventos. Monitora recursos e aplicações em tempo real, com capacidade de criar métricas customizadas e acionar ações automáticas.

**Para que usamos:** Monitorar Lambda (Duration, Errors, Throttles, ConcurrentExecutions), criar alarmes de billing, centralizar logs de múltiplos serviços com Log Groups, criar métricas de negócio customizadas sem infraestrutura adicional.

**Exemplo de prova:** Uma Lambda precisa publicar métricas de negócio (ex: número de pedidos processados por invocação) no CloudWatch para que alarmes possam ser criados. A equipe quer evitar chamadas separadas à API `PutMetricData` por questões de custo e latência. Qual a abordagem recomendada?
→ Usar **CloudWatch Embedded Metric Format (EMF)**: escrever um JSON estruturado no `stdout` da Lambda com o namespace e dimensões especificados. O CloudWatch Logs Agent detecta o formato EMF e extrai as métricas automaticamente, sem chamada adicional à API e sem custo de invocação `PutMetricData`.

---

## Hierarquia de logs

```
Log Group (ex: /aws/lambda/MinhaFuncao)
  └── Log Stream (ex: 2024/01/15[$LATEST]abc123)
        └── Log Events (linhas individuais)
```

---

## Métricas Lambda automáticas

`Invocations`, `Duration`, `Errors`, `Throttles`, `ConcurrentExecutions`, `UnreservedConcurrentExecutions`, `DeadLetterErrors`, `IteratorAge` (Kinesis/DDB Streams).

---

## Logs Insights — sintaxe

```sql
fields @timestamp, @message
| filter @message like /ERROR/
| stats count(*) as erros by bin(1h)
| sort @timestamp desc
| limit 20
```

Comandos: `fields`, `filter`, `stats`, `sort`, `limit`, `parse`, `display`.

---

## Alarmes

| Estado | Significado |
|---|---|
| OK | Dentro do threshold |
| ALARM | Fora do threshold |
| INSUFFICIENT_DATA | Dados insuficientes |

Ações: SNS, Auto Scaling, EC2 action, SSM OpsItem.

---

## Subscription Filters

- Envia logs em tempo real para: Lambda, Kinesis, Firehose, OpenSearch.
- Máximo: 2 filters por Log Group.

---

## EMF (Embedded Metric Format)

- JSON especial nos logs → métricas extraídas automaticamente.
- Sem chamada API adicional; ideal para Lambda de alta frequência.

---

## Métricas customizadas

```python
cloudwatch.put_metric_data(
    Namespace='MeuApp',
    MetricData=[{'MetricName': 'Requests', 'Value': 1, 'Unit': 'Count'}]
)
```
Custo: $0.30/métrica/mês.

---

## Referências oficiais

- [Amazon CloudWatch](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/WhatIsCloudWatch.html)
