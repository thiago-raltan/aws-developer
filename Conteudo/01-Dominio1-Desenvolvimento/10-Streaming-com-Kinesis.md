# Streaming com Amazon Kinesis

> Foco DVA-C02 – Domínio 1: Development with AWS Services

---

## Família Kinesis

| Serviço | Uso |
|---|---|
| **Kinesis Data Streams (KDS)** | Ingestão e processamento em tempo real com controle total |
| **Kinesis Data Firehose** | Entrega gerenciada para S3, Redshift, OpenSearch |
| **Kinesis Data Analytics** | SQL ou Apache Flink sobre streams |

---

## Kinesis Data Streams (KDS)

### Conceitos fundamentais
- **Shard**: unidade de capacidade. 1 shard = 1 MB/s entrada, 2 MB/s saída, 1.000 PUT/s.
- **Partition Key**: determina qual shard recebe o registro (use chave distribuída).
- **Sequence Number**: ordem dentro do shard (gerado pela AWS).
- **Retenção**: padrão 24h, ajustável até 7 dias (365 dias com extended retention).

### Modos de capacidade
| | On-Demand | Provisioned |
|---|---|---|
| Gerenciamento de shards | Automático | Manual |
| Custo | Pelo uso | Por shard/hora |
| Ideal | Tráfego imprevisível | Tráfego previsível |

### Consumidores
- **Standard (pull)**: `GetRecords`, compartilha 2 MB/s por shard entre todos.
- **Enhanced Fan-Out (push)**: 2 MB/s **dedicados por consumidor** por shard; usa `SubscribeToShard`.

---

## Kinesis Data Firehose

- **Totalmente gerenciado**: sem shards, sem escalonamento manual.
- Destinos: **S3** (principal), Redshift, OpenSearch, HTTP Endpoint, Splunk.
- Buffer: por tempo (60–900 s) ou por tamanho (1–128 MB) — o que ocorrer primeiro.
- Transformação inline com Lambda antes de entregar ao destino.

---

## Lambda + Kinesis (Event Source Mapping)

- Lambda cria polling automático.
- Processa **um shard por vez** por padrão.
- `BisectOnFunctionError`: divide o batch ao meio em caso de erro (isola mensagem problemática).
- `MaximumRetryAttempts`, `MaximumRecordAgeInSeconds`: controle de retry.
- Paralelismo por shard: até 10 batches simultâneos por shard (`ParallelizationFactor`).

---

## Conceitos críticos para a prova ⚠️

- `ProvisionedThroughputExceededException`: use exponential backoff ou aumente shards.
- **Partition key quente**: se muitos registros usam a mesma partition key, um shard fica sobrecarregado.
- Firehose **não é** para processamento em tempo real < 60 s — use KDS + Lambda.
- KDS retém dados mesmo após consumo (diferente do SQS que apaga após leitura).

---

## Pegadinhas da prova 🎯

- KDS padrão: 24h retenção; extended: 7 dias; long-term: 365 dias.
- Enhanced Fan-Out tem custo adicional por GB entregue.
- Firehose **não precisa de consumidor explícito** — é gerenciado.
- Aumentar shards no KDS = **resharding** (split shard).

---

## Referências oficiais

- [Kinesis Data Streams](https://docs.aws.amazon.com/streams/latest/dev/introduction.html)
- [Kinesis Data Firehose](https://docs.aws.amazon.com/firehose/latest/dev/what-is-this-service.html)
- [Lambda with Kinesis](https://docs.aws.amazon.com/lambda/latest/dg/with-kinesis.html)
