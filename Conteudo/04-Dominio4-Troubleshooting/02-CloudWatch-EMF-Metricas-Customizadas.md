# CloudWatch EMF e Métricas Customizadas

> Foco DVA-C02 – Domínio 4: Troubleshooting and Optimization

---

## PutMetricData (métricas customizadas clássicas)

```python
import boto3

cloudwatch = boto3.client('cloudwatch')
cloudwatch.put_metric_data(
    Namespace='MeuApp/Pagamentos',
    MetricData=[{
        'MetricName': 'TransacoesProcessadas',
        'Value': 42,
        'Unit': 'Count',
        'Dimensions': [
            {'Name': 'Environment', 'Value': 'prod'},
            {'Name': 'Region', 'Value': 'us-east-1'}
        ]
    }]
)
```

- Custo: $0.30 por métrica por mês.
- Resolução padrão: 60s; alta resolução: 1s (custo maior).

---

## CloudWatch EMF (Embedded Metric Format)

Formato que permite emitir métricas **dentro dos logs** sem chamada API adicional.

### Como funciona
1. Lambda escreve log JSON especial (formato EMF).
2. CloudWatch Logs processa e extrai métricas automaticamente.
3. Métricas aparecem no CloudWatch Metrics.

### Formato EMF
```json
{
  "_aws": {
    "Timestamp": 1702000000000,
    "CloudWatchMetrics": [{
      "Namespace": "MeuApp/Pagamentos",
      "Dimensions": [["Environment"]],
      "Metrics": [
        {"Name": "TransacoesProcessadas", "Unit": "Count"},
        {"Name": "LatenciaMedia", "Unit": "Milliseconds"}
      ]
    }]
  },
  "Environment": "prod",
  "TransacoesProcessadas": 42,
  "LatenciaMedia": 125.5,
  "RequestId": "abc-123"
}
```

### Com biblioteca `aws_embedded_metrics` (Python)
```python
from aws_embedded_metrics import metric_scope

@metric_scope
async def lambda_handler(event, context, metrics):
    metrics.set_namespace('MeuApp/Pagamentos')
    metrics.put_dimensions({'Environment': 'prod'})
    metrics.put_metric('TransacoesProcessadas', 1, 'Count')
    metrics.put_metric('LatenciaMedia', 125.5, 'Milliseconds')
    metrics.set_property('RequestId', context.aws_request_id)
    # processa a lógica...
```

---

## Comparativo

| | PutMetricData | EMF |
|---|---|---|
| API call separada | Sim | Não (via logs) |
| Latência adicional | Sim | Mínima |
| Custo | $0.30/métrica/mês | Mesmo de CloudWatch Logs + Metrics |
| Dados contextuais nos logs | Não diretamente | Sim (mesma linha) |
| Ideal para | Poucas métricas críticas | Alta frequência, contexto rico |

---

## Conceitos críticos para a prova ⚠️

- EMF = métricas **dentro de logs** — sem chamada API separada.
- Dimensões no EMF: máximo 9 dimensões por namespace de métricas.
- EMF é mais eficiente para Lambda com alta invocação (sem throttle em PutMetricData).
- `StorageResolution=1` = **high resolution** = 1 segundo; custo maior, mais granularidade.

---

## Pegadinhas da prova 🎯

- EMF não é uma API — é um **formato de log** que CloudWatch entende.
- PutMetricData tem limite de 150 TPS por conta — EMF contorna isso.
- Métricas customizadas via EMF aparecem em CloudWatch Metrics normalmente após processamento.

---

## Referências oficiais

- [CloudWatch custom metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/publishingMetrics.html)
- [CloudWatch EMF](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Embedded_Metric_Format.html)
- [EMF specification](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Embedded_Metric_Format_Specification.html)
