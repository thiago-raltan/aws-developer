# DynamoDB — Operações: Query vs. Scan

> Foco DVA-C02 – Domínio 1: Development with AWS Services

---

## Operações de leitura

### GetItem
- Lê um **único item** pela chave primária completa.
- Mais eficiente possível — O(1).
- Suporta strongly consistent.

### Query
- Lê itens com a **mesma Partition Key**.
- Filtra pela Sort Key com condições: `=`, `<`, `>`, `BETWEEN`, `begins_with`.
- **Eficiente**: acessa apenas uma partição.
- Usa índice (tabela, GSI, LSI).

```python
response = table.query(
    KeyConditionExpression=Key('userId').eq('123') & Key('createdAt').begins_with('2024')
)
```

### Scan
- Lê **todos os itens** da tabela.
- **Ineficiente** para tabelas grandes — O(n).
- Permite `FilterExpression`, mas o filtro ocorre **após** a leitura (consome RCU de todos os itens).
- Use apenas quando necessário buscar por atributos não-chave sem GSI.

---

## Operações de escrita

| Operação | Descrição |
|---|---|
| `PutItem` | Cria ou substitui item completo |
| `UpdateItem` | Atualiza atributos específicos (sem sobrescrever tudo) |
| `DeleteItem` | Remove item pela chave primária |
| `BatchWriteItem` | Até 25 PutItem/DeleteItem por chamada |
| `TransactWriteItems` | Até 100 operações atômicas (ACID) |

---

## Operações em batch e transação

### BatchGetItem
- Lê até **100 itens** de uma ou mais tabelas por chamada.
- Itens não encontrados = sem erro (apenas ausentes na resposta).
- `UnprocessedKeys`: itens que falharam — faça retry com backoff.

### BatchWriteItem
- Até **25 operações** (PutItem + DeleteItem) por chamada.
- Sem `UpdateItem` em batch.
- `UnprocessedItems`: itens que falharam — faça retry.

### TransactGetItems / TransactWriteItems
- **Transações ACID** entre múltiplas tabelas/itens.
- Custo: 2× o RCU/WCU normal.
- `TransactionConflictException`: outra transação competindo.

---

## Expressões DynamoDB

| Expressão | Uso |
|---|---|
| `KeyConditionExpression` | Filtra pela chave (Query) |
| `FilterExpression` | Filtra após leitura (Query/Scan) |
| `ProjectionExpression` | Seleciona apenas atributos específicos |
| `ConditionExpression` | Condição para Write (PutItem, UpdateItem, DeleteItem) |
| `UpdateExpression` | Define modificações (SET, REMOVE, ADD, DELETE) |

---

## Parallel Scan

```python
# Divida o scan em N segmentos processados em paralelo
response = table.scan(
    TotalSegments=4,
    Segment=0  # worker 0 de 4
)
```

---

## Conceitos críticos para a prova ⚠️

- `FilterExpression` **não reduz RCU** — consome capacidade de todos os itens lidos antes de filtrar.
- Para evitar Scan: crie GSI no atributo de filtro e use Query.
- `ConditionExpression` implementa **operações condicionais** (otimistic locking).
- Pagination: `LastEvaluatedKey` indica que há mais resultados; repasse como `ExclusiveStartKey`.

---

## Pegadinhas da prova 🎯

- Scan em tabela grande = alto custo em RCU e latência.
- Projections no GSI: se o atributo projetado não estiver no GSI, DynamoDB busca o item na tabela (fetch extra = mais custo).
- BatchWriteItem **não** suporta UpdateItem.
- Transações: até 100 itens únicos, custo 2×, não podem incluir o mesmo item mais de uma vez.

---

## Referências oficiais

- [DynamoDB Query](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Query.html)
- [DynamoDB Scan](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Scan.html)
- [DynamoDB Transactions](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/transactions.html)
- [Batch operations](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/WorkingWithItems.html)
