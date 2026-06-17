# Comunicação Síncrona vs. Assíncrona

> Foco DVA-C02 – Domínio 1: Development with AWS Services

---

## Comparação

| | Síncrona | Assíncrona |
|---|---|---|
| Espera resposta | Sim — bloqueia até responder | Não — continua sem aguardar |
| Acoplamento | Rígido (ambos precisam estar UP) | Flexível |
| Latência percebida | Alta se serviço demorar | Baixa para o produtor |
| Exemplos AWS | API Gateway → Lambda (invocação síncrona) | SQS, SNS, EventBridge, S3 Event |

---

## Tipos de invocação Lambda

| Tipo | Quando usar | Exemplo |
|---|---|---|
| **Synchronous** | Cliente aguarda resposta | API Gateway, CLI `invoke`, ALB |
| **Asynchronous** | Lambda enfileira e retorna 202 | S3 Events, SNS, EventBridge |
| **Poll-based** | Lambda puxa mensagens | SQS, Kinesis, DynamoDB Streams |

### Invocação Assíncrona Lambda
- Eventos ficam em fila interna; Lambda tenta 2 vezes automaticamente.
- Configure **DLQ** (SQS ou SNS) para eventos que falham.
- Configure **Destination** (sucesso ou falha) → SQS, SNS, EventBridge, outra Lambda.

### Poll-based (Event Source Mapping)
- Lambda cria e gerencia o **polling** automaticamente.
- **SQS**: processa em lotes (batch); erros → mensagem volta para fila ou vai para DLQ.
- **Kinesis**: lê shards; checkpointing automático.
- **DynamoDB Streams**: processa mudanças na tabela em ordem.

---

## Conceitos críticos para a prova ⚠️

- Invocação **síncrona**: erros chegam diretamente ao chamador → gerencie retry no cliente.
- Invocação **assíncrona**: Lambda faz retry automático 2x (total 3 tentativas); após isso, vai para DLQ/Destination.
- **SQS como trigger Lambda**: Lambda escala automaticamente — 1 invocação por batch de até 10.000 mensagens.
- Kinesis: Lambda processa **um shard por vez**; paralelismo = número de shards.

---

## Pegadinhas da prova 🎯

- S3 Event Notification invoca Lambda de forma **assíncrona** — não há resposta ao S3.
- DLQ em Lambda assíncrona: precisa ser configurada **na função** (não no serviço de origem).
- EventBridge → Lambda: invocação **assíncrona**; EventBridge retenta em caso de falha.
- API Gateway → Lambda: **síncrono**; timeout máximo do API Gateway = 29 segundos.

---

## Referências oficiais

- [Lambda invocation types](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async.html)
- [Lambda event source mapping](https://docs.aws.amazon.com/lambda/latest/dg/invocation-eventsourcemapping.html)
- [Lambda destinations](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async.html#invocation-async-destinations)
