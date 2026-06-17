# Amazon Kinesis — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Plataforma de streaming de dados em tempo real composta por: **Data Streams** (ingestão e processamento com baixa latência), **Data Firehose** (entrega gerenciada para S3/Redshift/OpenSearch) e **Data Analytics** (processamento com SQL/Apache Flink em tempo real).

**Para que usamos:** Ingestão de clickstream, logs de aplicação em tempo real, telemetria de IoT, processamento de eventos financeiros com ordenação garantida por partição, pipelines de dados com múltiplos consumidores.

**Exemplo de prova:** Uma aplicação publica eventos de transações financeiras no Kinesis Data Streams. É crítico que todas as transações de um mesmo cliente sejam processadas em ordem cronológica pela Lambda consumidora. Como garantir isso?
→ Usar o `clienteId` como **`PartitionKey`** ao publicar os registros. O Kinesis garante que registros com a mesma `PartitionKey` vão para o **mesmo shard** e são processados em ordem (FIFO por shard). A Lambda processa cada shard sequencialmente. Aumentar shards aumenta paralelismo, mas registros do mesmo cliente ainda ficam no mesmo shard.

---

## Família Kinesis

| Serviço | Uso | Gerenciamento |
|---|---|---|
| **Data Streams** | Processamento em tempo real com controle | Manual (shards) |
| **Data Firehose** | Entrega gerenciada para S3/Redshift/OpenSearch | Automático |
| **Data Analytics** | SQL/Flink sobre streams | Gerenciado |

---

## Kinesis Data Streams

### Capacidade de shard

| Métrica | Valor |
|---|---|
| Ingestão | 1 MB/s ou 1.000 records/s |
| Saída (standard) | 2 MB/s compartilhado |
| Saída (Enhanced Fan-Out) | 2 MB/s por consumer |
| Retenção padrão | 24 horas |
| Retenção máxima | 365 dias |

### Modos de capacidade

| | Provisioned | On-Demand |
|---|---|---|
| Shards | Manual | Automático |
| Custo | Por shard/hora | Por GB |

---

## Lambda + Kinesis

- Poll automático por shard.
- `ParallelizationFactor`: 1–10 batches simultâneos por shard.
- `BisectOnFunctionError`: divide batch ao meio em erro.
- `StartingPosition`: TRIM_HORIZON ou LATEST.

---

## Kinesis Firehose

- **Buffer**: tamanho (1–128 MB) ou tempo (60–900 s).
- Destinos: S3, Redshift, OpenSearch, HTTP Endpoint, Splunk.
- Transformação com Lambda inline.
- **Não é tempo real** < 60s — use KDS + Lambda para isso.

---

## Referências oficiais

- [Kinesis Data Streams](https://docs.aws.amazon.com/streams/latest/dev/introduction.html)
- [Kinesis Data Firehose](https://docs.aws.amazon.com/firehose/latest/dev/what-is-this-service.html)
