# AWS X-Ray — Rastreamento Distribuído

> Foco DVA-C02 – Domínio 4: Troubleshooting and Optimization

---

## O que é

Serviço de **rastreamento distribuído** para analisar e depurar aplicações em produção.
Visualiza o caminho de uma request através de múltiplos serviços.

---

## Conceitos fundamentais

| Conceito | Descrição |
|---|---|
| **Trace** | Representação completa de uma request do início ao fim |
| **Segment** | Dados de um serviço individual dentro do trace |
| **Subsegment** | Subunidade dentro de um segment (ex: chamada a DynamoDB) |
| **Annotation** | Par chave-valor **indexado** para filtrar traces |
| **Metadata** | Par chave-valor **não indexado** (dados contextuais) |
| **Sampling** | Porcentagem de requests a rastrear |

---

## Service Map

Mapa visual dos serviços interconectados:
```
[API Gateway] → [Lambda] → [DynamoDB]
                         → [S3]
                         → [External HTTP API]
```
- Mostra latência e taxa de erros por conexão.
- Identifica gargalos.

---

## Integração com Lambda

### Habilitando X-Ray no Lambda
- Console: Configuration → Monitoring → Active tracing = Enable.
- SAM/CloudFormation: `Tracing: Active`.

```yaml
# SAM
MinhaFuncao:
  Type: AWS::Serverless::Function
  Properties:
    Tracing: Active
```

### SDK no código
```python
from aws_xray_sdk.core import xray_recorder, patch_all

# Patcha todos os clientes boto3 automaticamente
patch_all()

@xray_recorder.capture('processar_pagamento')
def processar_pagamento(dados):
    # Adiciona anotação (indexada)
    xray_recorder.current_segment().put_annotation('PaymentMethod', dados['method'])
    # Adiciona metadata (não indexada)
    xray_recorder.current_segment().put_metadata('PaymentDetails', dados)
    # código...
```

---

## Sampling Rules

- Padrão: 1 request/s + 5% das requests adicionais.
- Regras customizadas: por service, URL, método HTTP.
- Reduz custo evitando rastrear 100% do tráfego.

---

## X-Ray com outros serviços

| Serviço | Integração |
|---|---|
| API Gateway | Habilitar X-Ray tracing no stage |
| ECS | Daemon como sidecar container |
| EC2 | Instalar X-Ray Daemon |
| Elastic Beanstalk | X-Ray Daemon incluído |
| AppSync | Habilitar no serviço |

---

## X-Ray Daemon

- Processo que coleta dados de trace e envia para o serviço X-Ray.
- Roda como sidecar em ECS, processo em EC2/Beanstalk.
- Lambda: daemon gerenciado automaticamente pela AWS.
- Porta UDP 2000 para receber dados do SDK.

---

## Conceitos críticos para a prova ⚠️

- **Annotation vs. Metadata**: annotation é indexada (filtros no console); metadata não.
- X-Ray **não** registra dados completos de request/response por padrão — apenas metadados.
- Grupo de rastreamento: filtra traces por expressão para criar service maps parciais.
- Lambda com X-Ray: precisa de permissão `xray:PutTraceSegments` e `xray:PutTelemetryRecords` na execution role.

---

## Pegadinhas da prova 🎯

- `patch_all()` instrumeta todos os clientes AWS SDK (boto3); `patch(['boto3'])` instrumeta seletivamente.
- X-Ray SDK precisa do daemon para funcionar (exceto em Lambda onde é gerenciado).
- Trace ID propagado via header `X-Amzn-Trace-Id` entre serviços.
- Sampling = trace **parcial** — pode não capturar todos os erros raros.

---

## Referências oficiais

- [AWS X-Ray](https://docs.aws.amazon.com/xray/latest/devguide/aws-xray.html)
- [X-Ray SDK for Python](https://docs.aws.amazon.com/xray/latest/devguide/xray-sdk-python.html)
- [Lambda with X-Ray](https://docs.aws.amazon.com/lambda/latest/dg/services-xray.html)
- [X-Ray sampling rules](https://docs.aws.amazon.com/xray/latest/devguide/xray-console-sampling.html)
