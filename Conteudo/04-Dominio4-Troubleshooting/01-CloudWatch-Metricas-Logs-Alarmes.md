# Amazon CloudWatch — Métricas, Logs e Alarmes

> Foco DVA-C02 – Domínio 4: Troubleshooting and Optimization

---

## CloudWatch Metrics

### Conceitos
| Conceito | Descrição |
|---|---|
| **Namespace** | Categoria de métricas (ex: `AWS/Lambda`, `AWS/EC2`) |
| **Metric** | Nome da medição (ex: `Duration`, `Errors`) |
| **Dimension** | Par chave-valor para filtrar (ex: FunctionName=MinhaFuncao) |
| **Period** | Intervalo de agregação (60s, 300s, etc.) |
| **Statistic** | Agregação: Sum, Average, Min, Max, SampleCount |
| **Resolution** | Standard (60s) ou High Resolution (1s) |

### Métricas Lambda importantes
| Métrica | Descrição |
|---|---|
| `Invocations` | Número de invocações |
| `Duration` | Tempo de execução (ms) |
| `Errors` | Exceções não tratadas |
| `Throttles` | Invocações throttled |
| `ConcurrentExecutions` | Execuções simultâneas |
| `UnreservedConcurrentExecutions` | Concorrência sem reserva |
| `DeadLetterErrors` | Falhas ao enviar para DLQ |

---

## CloudWatch Logs

### Estrutura
```
Log Group (/aws/lambda/MinhaFuncao)
    └── Log Stream (2024/01/15/[$LATEST]abc123)
            └── Log Events (linhas individuais)
```

- **Log Group**: agrupa logs de um serviço/aplicação.
- **Log Stream**: sequência de logs de uma instância/execução.
- **Retention**: configurável por Log Group (1 dia a 10 anos, ou infinito).

### Insights Query
```sql
fields @timestamp, @message
| filter @message like /ERROR/
| sort @timestamp desc
| limit 20
```

### Subscription Filters
- Transmite logs em tempo real para: Lambda, Kinesis, Firehose, OpenSearch.
- Use para análise em tempo real ou arquivamento.

---

## CloudWatch Alarms

### Estados
| Estado | Significado |
|---|---|
| `OK` | Métrica dentro do threshold |
| `ALARM` | Métrica fora do threshold |
| `INSUFFICIENT_DATA` | Dados insuficientes para avaliar |

### Ações
- SNS (notificação).
- Auto Scaling (escalar in/out).
- EC2 Actions (stop, terminate, reboot).
- Systems Manager OpsItem.

### Composite Alarms
- Combina múltiplos alarmes com lógica AND/OR.
- Reduz false alarms.

---

## Conceitos críticos para a prova ⚠️

- Lambda logs: escritos automaticamente no CloudWatch Logs (execution role precisa de `logs:CreateLogGroup`, `logs:CreateLogStream`, `logs:PutLogEvents`).
- `@duration`, `@billedDuration`, `@memorySize`: campos automáticos nos logs Lambda.
- CloudWatch Logs Insights: análise interativa de logs (não é streaming).
- **High Resolution metrics**: `PutMetricData` com `StorageResolution=1` para métricas de 1s.

---

## Pegadinhas da prova 🎯

- Métricas padrão da AWS são **gratuitas**; métricas customizadas têm custo.
- Log Group sem retenção configurada = **retém para sempre** (custo crescente).
- Alarme em `INSUFFICIENT_DATA` ≠ ALARM — estados são distintos.
- CloudWatch Events (legado) = agora é **EventBridge**.

---

## Referências oficiais

- [Amazon CloudWatch metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/working_with_metrics.html)
- [CloudWatch Logs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/WhatIsCloudWatchLogs.html)
- [CloudWatch Alarms](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html)
- [CloudWatch Logs Insights](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AnalyzingLogData.html)
