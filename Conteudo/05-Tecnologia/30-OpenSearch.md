# Amazon OpenSearch Service — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Serviço gerenciado de busca e análise baseado no OpenSearch (fork do Elasticsearch). Permite indexar grandes volumes de dados e executar buscas full-text, agregações analíticas e correlações complexas em tempo quase real.

**Para que usamos:** Busca full-text em catálogos de produtos e documentos, análise e correlação de logs (stack equivalente ao ELK: OpenSearch + Logstash + Kibana/OpenSearch Dashboards), detecção de anomalias de segurança, buscas geoespaciais.

**Exemplo de prova:** Uma aplicação e-commerce precisa que todos os produtos inseridos ou atualizados no DynamoDB sejam automaticamente disponibilizados para busca full-text por nome, descrição e categoria no OpenSearch. Qual arquitetura implementar, considerando que não há integração nativa direta entre DynamoDB e OpenSearch?
→ Habilitar **DynamoDB Streams** na tabela. Criar uma **Lambda** acionada pelo Stream que captura eventos `INSERT` e `MODIFY`, transforma o item para o formato de documento OpenSearch e faz `PUT` via HTTP para o endpoint do OpenSearch Service. A Lambda atua como **conector** entre os dois serviços. Para DELETE, capturar o evento e remover o documento correspondente.

---

## O que é

Serviço gerenciado para busca full-text e análise de logs.
Baseado em OpenSearch (fork do Elasticsearch). UI: OpenSearch Dashboards (ex-Kibana).

---

## Casos de uso

- Busca full-text (catálogos, documentos).
- Log analytics (CloudWatch Logs → OpenSearch).
- Monitoramento e alertas.
- Busca sobre dados do DynamoDB.

---

## Ingestão de dados

| Fonte | Método |
|---|---|
| CloudWatch Logs | Subscription Filter → Lambda → OpenSearch |
| DynamoDB Streams | Lambda → OpenSearch |
| Kinesis Firehose | Firehose → OpenSearch (direto) |
| S3 | Lambda ou Firehose |
| Aplicação | SDK via REST API |

---

## Arquitetura com DynamoDB

```
[DynamoDB] → [Streams] → [Lambda] → [OpenSearch]
[Cliente]  → [API GW]  → [Lambda] → [OpenSearch Query]
```

DynamoDB = fonte da verdade; OpenSearch = índice de busca.

---

## Segurança

- VPC ou endpoint público com access policy.
- Fine-grained access control (usuários por índice/campo).
- Encryption at rest (KMS) + node-to-node encryption.
- SAML para autenticação no Dashboards.

---

## Conceitos

| Conceito | Equivalente relacional |
|---|---|
| Index | Tabela |
| Document | Linha |
| Field | Coluna |
| Shard | Partição |

---

## Referências oficiais

- [Amazon OpenSearch Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/what-is.html)
