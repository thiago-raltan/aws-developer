# Amazon DynamoDB — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Banco de dados NoSQL totalmente gerenciado com latência de milissegundos em qualquer escala. Suporta modelos chave-valor e documento, com escalabilidade automática de throughput e armazenamento.

**Para que usamos:** Sessões de usuário, carrinhos de compra, contadores em tempo real, tabelas de configuração com alta leitura, catálogos de produtos e workloads que exigem escala sem gestão de banco.

**Exemplo de prova:** Uma tabela DynamoDB tem `clienteId` como Partition Key e `orderId` como Sort Key. A aplicação precisa listar todos os pedidos de um cliente ordenados por data de criação (`createdAt`), mas `createdAt` não faz parte da chave primária. Qual a abordagem correta sem fazer Scan?
→ Criar um **GSI (Global Secondary Index)** com `clienteId` como Partition Key e `createdAt` como Sort Key. Isso permite `Query` eficiente por cliente com ordenação por data, sem varredura completa da tabela.

---

## Limites essenciais

| Item | Valor |
|---|---|
| Tamanho máximo de item | 400 KB |
| Partition Key | 2 KB máximo |
| Sort Key | 1 KB máximo |
| GSIs por tabela | 20 |
| LSIs por tabela | 5 (criados com a tabela) |
| Tabelas por conta | 2.500 (padrão) |

---

## Cálculo de RCU/WCU

| Operação | Cálculo |
|---|---|
| Leitura eventually consistent | ceil(itemKB / 4) × 0.5 RCU |
| Leitura strongly consistent | ceil(itemKB / 4) × 1 RCU |
| Leitura transacional | ceil(itemKB / 4) × 2 RCU |
| Escrita padrão | ceil(itemKB / 1) WCU |
| Escrita transacional | ceil(itemKB / 1) × 2 WCU |

---

## GSI vs. LSI

| | GSI | LSI |
|---|---|---|
| Partition Key | Qualquer | Mesmo da tabela |
| Sort Key | Qualquer | Diferente da tabela |
| Consistência | Eventual apenas | Strong e eventual |
| Criação | A qualquer momento | Apenas na criação da tabela |
| Capacidade | Própria | Compartilha com a tabela |

---

## Operações principais

`PutItem`, `GetItem`, `UpdateItem`, `DeleteItem`, `Query`, `Scan`, `BatchGetItem` (100 items), `BatchWriteItem` (25 ops), `TransactGetItems` (100 items, 2x RCU), `TransactWriteItems` (100 items, 2x WCU).

---

## Expressões importantes

- `KeyConditionExpression`: filtro na Query (chave obrigatório).
- `FilterExpression`: pós-leitura (consome RCU antes de filtrar).
- `ConditionExpression`: condicional na escrita (optimistic locking).
- `ProjectionExpression`: retornar apenas atributos selecionados.

---

## Streams & TTL

- **Streams**: captura mudanças em itens; tipos: KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES.
- **TTL**: atributo numérico (epoch); deleção automática em ~48h após expiração.

---

## Referências oficiais

- [DynamoDB Developer Guide](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Introduction.html)
