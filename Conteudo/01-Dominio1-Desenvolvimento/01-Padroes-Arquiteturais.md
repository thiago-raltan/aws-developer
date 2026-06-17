# Padrões Arquiteturais na AWS

> Foco DVA-C02 – Domínio 1: Development with AWS Services

---

## O que é

Padrões arquiteturais são soluções reutilizáveis para problemas recorrentes de design de software. No contexto AWS, os mais cobrados são:
**Event-Driven**, **Microservices**, **Serverless** e **Monolítico** (para comparação).

---

## Padrões principais para a prova

### 1. Event-Driven Architecture
- Componentes se comunicam via **eventos** (mensagens assíncronas).
- Serviços AWS: **EventBridge**, **SNS**, **SQS**, **Kinesis**.
- Benefícios: desacoplamento, escalabilidade, tolerância a falhas.
- Padrão **Fan-out**: SNS → múltiplas filas SQS.

### 2. Microservices
- Cada serviço tem responsabilidade única, pode ser implantado/escalado de forma independente.
- Na AWS: **Lambda** (funções), **ECS/EKS** (containers), **API Gateway** (entrada).
- Comunicação: REST (síncrona) ou SQS/SNS/EventBridge (assíncrona).

### 3. Serverless
- Sem gerenciamento de servidores; pagamento por execução.
- Stack típica: **API Gateway → Lambda → DynamoDB / S3**.
- Limitações importantes: timeout máximo Lambda = **15 min**, cold start, limites de concorrência.

### 4. Monolítico vs. Distribuído
| Aspecto | Monolítico | Microservices |
|---|---|---|
| Implantação | Tudo junto | Independente |
| Escalabilidade | Toda a aplicação | Por serviço |
| Complexidade operacional | Baixa | Alta |
| Acoplamento | Alto | Baixo |

---

## Conceitos críticos para a prova ⚠️

- **Idempotência**: processar a mesma mensagem múltiplas vezes sem efeitos colaterais. Implementar com IDs únicos + DynamoDB/Redis.
- **Retry com Exponential Backoff + Jitter**: estratégia padrão AWS para lidar com throttling.
- **Dead Letter Queue (DLQ)**: destino de mensagens que falharam após N tentativas (SQS, SNS, Lambda, EventBridge).
- **Circuit Breaker**: evita chamadas repetidas a serviços com falha (implementado via Step Functions ou SDKs).
- **Saga Pattern**: gerenciamento de transações distribuídas via Step Functions.

---

## Pegadinhas da prova 🎯

- EventBridge usa **event buses** (default, custom, partner); SNS usa **topics**.
- SQS Standard garante entrega **pelo menos uma vez** — sempre implementar idempotência.
- Lambda com SQS: se a função falhar, a mensagem **volta para a fila** e é reprocessada.
- SNS **não retém mensagens**; SQS **retém** por até 14 dias.

---

## Referências oficiais

- [AWS Architecture Center](https://aws.amazon.com/architecture/)
- [Serverless Application Patterns](https://aws.amazon.com/serverless/patterns/)
- [Event-Driven Architecture](https://aws.amazon.com/event-driven-architecture/)
- [AWS Well-Architected Framework](https://docs.aws.amazon.com/wellarchitected/latest/framework/welcome.html)
