# Acoplamento Rígido vs. Flexível

> Foco DVA-C02 – Domínio 1: Development with AWS Services

---

## Definições

| | Acoplamento Rígido (Tight Coupling) | Acoplamento Flexível (Loose Coupling) |
|---|---|---|
| Comunicação | Síncrona direta (HTTP/gRPC) | Assíncrona via mensagens |
| Dependência | Serviço A conhece e chama B diretamente | A envia mensagem; B consome quando puder |
| Falha em cascata | Alta probabilidade | Isolada |
| Escalabilidade independente | Não | Sim |

---

## Serviços AWS para desacoplamento

| Serviço | Uso |
|---|---|
| **SQS** | Fila entre produtor e consumidor; buffer de carga |
| **SNS** | Fan-out para múltiplos consumidores |
| **EventBridge** | Roteamento de eventos baseado em regras |
| **Kinesis** | Streaming de dados em tempo real |
| **Step Functions** | Orquestração de fluxos com estado |

---

## Padrão Produtor → Fila → Consumidor (SQS)

```
[Produtor] → [SQS Queue] → [Lambda / EC2 Consumer]
```

- Produtor e consumidor **nunca se chamam diretamente**.
- SQS **absorve picos** de tráfego (buffer).
- Consumidor processa na sua própria taxa.

## Padrão Fan-out (SNS + SQS)

```
[Produtor] → [SNS Topic] → [SQS Queue 1] → [Consumer 1]
                         → [SQS Queue 2] → [Consumer 2]
                         → [Lambda]
```

---

## Conceitos críticos para a prova ⚠️

- **SQS Visibility Timeout**: período em que a mensagem fica invisível após ser recebida. Se o processamento não completar, a mensagem volta à fila. Ajuste > tempo de processamento.
- **SNS + SQS Fan-out**: padrão clássico da prova para desacoplamento + durabilidade.
- **EventBridge** é preferido para eventos complexos com roteamento baseado em conteúdo.
- **Dead Letter Queue**: configure para capturar mensagens que falham repetidamente.

---

## Pegadinhas da prova 🎯

- Chamar Lambda diretamente de outra Lambda **não é** loose coupling — use SQS ou SNS.
- SNS não tem persistência de mensagem; para durabilidade, use SNS → SQS.
- EventBridge tem **retentativa automática** para destinos com falha (até 24h).

---

## Referências oficiais

- [Amazon SQS Developer Guide](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/welcome.html)
- [Amazon SNS Developer Guide](https://docs.aws.amazon.com/sns/latest/dg/welcome.html)
- [Amazon EventBridge](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-what-is.html)
