# Observabilidade: Logs, Métricas e Monitoramento

> Foco DVA-C02 – Domínio 4: Troubleshooting and Optimization

---

## Os três pilares da Observabilidade

| Pilar | AWS Service | O que responde |
|---|---|---|
| **Métricas** | CloudWatch Metrics | "O que está acontecendo?" (números) |
| **Logs** | CloudWatch Logs | "Por que está acontecendo?" (contexto) |
| **Traces** | X-Ray | "Onde está o problema?" (caminho) |

---

## Estratégia de logging para Lambda

### Structured Logging (JSON)
```python
import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    logger.info(json.dumps({
        'requestId': context.aws_request_id,
        'operation': 'processarPedido',
        'orderId': event['orderId'],
        'status': 'iniciado'
    }))
```

- Use JSON para facilitar queries no CloudWatch Insights.
- Inclua sempre: `requestId`, operação, identidade do usuário, IDs de recurso.

---

## CloudWatch Logs Insights — Queries úteis

```sql
-- Encontrar erros Lambda
fields @timestamp, @message
| filter @message like /ERROR/
| sort @timestamp desc
| limit 50

-- Latência média por função
fields @duration
| stats avg(@duration), max(@duration), min(@duration) by bin(5m)

-- Requests lentos
fields @timestamp, @duration, @requestId
| filter @duration > 3000
| sort @duration desc
```

---

## CloudWatch Dashboard

- Painel centralizado com widgets: gráficos, alarmes, métricas, logs.
- Compartilhável entre contas.
- **Cross-account cross-region**: dashboard com métricas de múltiplas contas/regiões.

---

## AWS X-Ray Insights

- Detecta anomalias automaticamente no padrão de tráfego.
- Identifica grupos de traces com alta taxa de erro/latência.

---

## Alerta e Notificação

```
CloudWatch Alarm → SNS Topic → Email / Lambda / PagerDuty / Slack
                → Auto Scaling policy
                → SSM OpsCenter incident
```

---

## Synthetics (Canaries)

- Scripts **simulam requests de usuário** para monitorar APIs externamente.
- Detecta problemas antes que usuários reais sejam afetados.
- Suporte: API, URL, GUI (headless Chrome).

---

## Container Insights

- Métricas e logs para ECS, EKS, Kubernetes.
- CPU, memória, rede por task/pod/container.

---

## Conceitos críticos para a prova ⚠️

- Observabilidade completa = Métricas + Logs + Traces juntos.
- Lambda `@duration` = duração da execução; `@billedDuration` = quanto será cobrado.
- CloudWatch Contributor Insights: identifica os maiores contribuintes para problemas.
- **Log correlation**: inclua Trace ID do X-Ray nos logs para correlacionar.

---

## Pegadinhas da prova 🎯

- CloudWatch Logs Insights: **não é streaming** — análise ad-hoc sobre logs históricos.
- Para alertas em tempo real sobre padrões de log: use **Subscription Filter → Lambda**.
- X-Ray trace ≠ CloudWatch log — são sistemas separados (correlacione via RequestId).

---

## Referências oficiais

- [CloudWatch Logs Insights](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AnalyzingLogData.html)
- [CloudWatch Synthetics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries.html)
- [Container Insights](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/ContainerInsights.html)
