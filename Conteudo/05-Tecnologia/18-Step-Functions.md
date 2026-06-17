# AWS Step Functions — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Serviço de orquestração de workflows serverless baseado em máquinas de estado definidas com Amazon States Language (ASL). Gerencia o estado, os retries, os timeouts e o fluxo entre etapas sem necessidade de código de orquestração na aplicação.

**Para que usamos:** Coordenar múltiplas Lambdas em sequência ou paralelo, implementar retries com backoff exponencial, workflows de longa duração (até 1 ano no modo Standard), processos de aprovação humana com `waitForTaskToken`.

**Exemplo de prova:** Um workflow de processamento de pedidos executa validação, cobrança e envio em paralelo. Se qualquer etapa falhar, o sistema deve executar automaticamente um estorno sem intervenção manual. Como modelar isso no Step Functions?
→ Usar um estado **`Parallel`** para as 3 etapas simultâneas. No estado pai (ou no wrapper do `Parallel`), adicionar um bloco **`Catch`** que captura erros de qualquer branch e redireciona para um estado de compensação (Lambda de estorno). O `Catch` no Step Functions funciona como um try/catch distribuído.

---

## O que é

Serviço de **orquestração** de fluxos de trabalho serverless com estado.
Usa Amazon States Language (ASL) — JSON.

---

## Tipos de fluxo

| | Standard | Express |
|---|---|---|
| Duração máxima | 1 ano | 5 minutos |
| Execuções | Exatamente 1x | Pelo menos 1x |
| Throughput | Baixo | Alto (100.000/s) |
| Preço | Por state transition | Por execução e duração |
| Ideal | Fluxos longos, humanos | Processamento de eventos de alta frequência |

---

## Tipos de estado

| Estado | Uso |
|---|---|
| `Task` | Executa trabalho (Lambda, ECS, DynamoDB, etc.) |
| `Choice` | Ramificação condicional |
| `Wait` | Pausa por tempo ou timestamp |
| `Parallel` | Executa branches em paralelo |
| `Map` | Processa array de items em paralelo |
| `Pass` | Passa estado sem processamento |
| `Succeed` / `Fail` | Termina com sucesso ou falha |

---

## Retry e Catch

```json
"Retry": [{
  "ErrorEquals": ["Lambda.ServiceException"],
  "IntervalSeconds": 2,
  "MaxAttempts": 3,
  "BackoffRate": 2
}],
"Catch": [{
  "ErrorEquals": ["States.TaskFailed"],
  "Next": "HandleError"
}]
```

---

## Integrações de serviço

- Lambda, ECS, DynamoDB, SNS, SQS, Glue, SageMaker, etc.
- **Optimized integrations**: direto sem Lambda (ex: `dynamodb:PutItem`).

---

## Callback Pattern

- `waitForTaskToken`: pausa até receber callback com token.
- Use para aprovação humana, integração com sistemas externos.

---

## Referências oficiais

- [AWS Step Functions](https://docs.aws.amazon.com/step-functions/latest/dg/welcome.html)
