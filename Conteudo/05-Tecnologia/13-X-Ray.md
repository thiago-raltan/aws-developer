# AWS X-Ray — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Serviço de rastreamento distribuído que coleta dados sobre as requisições que a aplicação processa e fornece ferramentas para visualizar, filtrar e analisar esses dados. Gera um mapa de serviço com latências e taxas de erro.

**Para que usamos:** Identificar gargalos de latência em aplicações serverless e microsserviços, rastrear chamadas encadeadas entre Lambda → API Gateway → DynamoDB → RDS, depurar erros intermitentes em produção sem reproduzir localmente.

**Exemplo de prova:** Uma aplicação com 5 Lambdas encadeadas apresenta latência alta e intermitente. O time quer identificar exatamente qual função e qual chamada downstream (DynamoDB ou HTTP externo) está causando o atraso. O que habilitar e onde analisar?
→ Habilitar **Active Tracing** em cada Lambda (variável `AWS_XRAY_CONTEXT_MISSING` + layer X-Ray SDK) e no API Gateway. No console X-Ray: analisar o **Service Map** para visualizar o fluxo; abrir **Traces** individuais para ver os **Segments** (por serviço) e **Subsegments** (por chamada AWS SDK ou HTTP), identificando qual subsegmento tem maior `responseTime`.

---

## Conceitos

| Conceito | Descrição | Pesquisável |
|---|---|---|
| Trace | Request completa de ponta a ponta | Sim (por ID) |
| Segment | Dados de um serviço | — |
| Subsegment | Sub-operação (DB call, HTTP call) | — |
| Annotation | Key-value indexado | Sim (filtros) |
| Metadata | Key-value não indexado | Não |

---

## Sampling padrão

- 1 request/s + 5% do restante.
- Customizável com regras por serviço/URL/método.

---

## Habilitar no Lambda

```yaml
# SAM/CloudFormation
Properties:
  Tracing: Active
```
- Execution role precisa: `xray:PutTraceSegments`, `xray:PutTelemetryRecords`.

---

## SDK Python

```python
from aws_xray_sdk.core import xray_recorder, patch_all
patch_all()  # Instrumenta todo boto3

@xray_recorder.capture('minha_operacao')
def minha_funcao():
    xray_recorder.current_segment().put_annotation('key', 'value')
    xray_recorder.current_segment().put_metadata('key', {'data': 'value'})
```

---

## Daemon

- Coleta dados do SDK e envia para X-Ray service.
- Lambda: daemon gerenciado automaticamente.
- ECS: sidecar container.
- EC2/Beanstalk: instalar o daemon separadamente.
- Porta: **UDP 2000**.

---

## Trace ID Header

`X-Amzn-Trace-Id` propagado entre serviços para correlação.

---

## Referências oficiais

- [AWS X-Ray](https://docs.aws.amazon.com/xray/latest/devguide/aws-xray.html)
