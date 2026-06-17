# Amazon OpenSearch Service

> Foco DVA-C02 – Domínio 1: Development with AWS Services

---

## O que é

Amazon OpenSearch Service é um serviço gerenciado para busca e análise de logs em tempo real. Baseado no OpenSearch (fork do Elasticsearch).

---

## Casos de uso

- **Busca full-text**: pesquisa em documentos, catálogos de produtos.
- **Log analytics**: análise de logs de aplicações (com Kibana/OpenSearch Dashboards).
- **Monitoramento**: métricas e alertas personalizados.
- **Integração com DynamoDB Streams**: busca sobre dados do DynamoDB.

---

## Ingestão de dados

| Fonte | Método |
|---|---|
| CloudWatch Logs | Subscription Filter → Lambda → OpenSearch |
| DynamoDB Streams | Lambda → OpenSearch |
| Kinesis Data Firehose | Firehose → OpenSearch (direto) |
| S3 | Lambda ou Firehose |
| Aplicação | SDK diretamente via REST API |

---

## Arquitetura típica com Lambda

```
[DynamoDB] → [Streams] → [Lambda] → [OpenSearch]
[API Gateway] ← [Lambda] ← [OpenSearch Query]
```

---

## Segurança

- **VPC** ou endpoint público com controle de acesso.
- **Fine-grained access control**: usuários internos do OpenSearch com permissões por índice/campo.
- **Encryption at rest**: KMS.
- **Node-to-node encryption**: TLS entre nós.
- **SAML** para autenticação federada no Dashboards.

---

## Conceitos críticos para a prova ⚠️

- OpenSearch **não é** um banco de dados principal — é um complemento para busca.
- Para busca sobre dados do DynamoDB: use DynamoDB Streams → Lambda → OpenSearch.
- Kibana foi renomeado para **OpenSearch Dashboards**.
- **Multi-AZ**: distribua instâncias em 2-3 AZs para alta disponibilidade.
- Índices são análogos a tabelas; documentos são análogos a itens.

---

## Pegadinhas da prova 🎯

- OpenSearch **não** substitui DynamoDB para operações CRUD.
- Acesso via endpoint público requer configuração de resource-based policy.
- CloudWatch Logs → OpenSearch via Subscription Filter **usa Lambda** como intermediário.

---

## Referências oficiais

- [Amazon OpenSearch Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/what-is.html)
- [Ingestion into OpenSearch](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/ingestion.html)
- [OpenSearch security](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/security.html)
