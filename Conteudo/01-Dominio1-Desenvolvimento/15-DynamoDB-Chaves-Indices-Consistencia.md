# DynamoDB — Chaves, Índices e Consistência

> Foco DVA-C02 – Domínio 1: Development with AWS Services

---

## Modelo de dados DynamoDB

### Terminologia
| DynamoDB | Relacional equivalente |
|---|---|
| Table | Tabela |
| Item | Linha/Registro |
| Attribute | Coluna |
| Partition Key | Chave primária (hash) |
| Sort Key | Chave de ordenação (range) |

### Tipos de chave primária
| Tipo | Composição | Unicidade |
|---|---|---|
| **Simple PK** | Partition Key apenas | Partition Key deve ser única |
| **Composite PK** | Partition Key + Sort Key | Combinação deve ser única |

---

## Índices Secundários

### GSI (Global Secondary Index)
- Partition Key e/ou Sort Key **diferentes** da tabela base.
- Tem capacidade de leitura/escrita **própria** (ou on-demand).
- Consistência: **eventual** apenas.
- Até **20 GSIs** por tabela.
- Pode ser criado e deletado **após** a criação da tabela.

### LSI (Local Secondary Index)
- **Mesma Partition Key** da tabela, mas **Sort Key diferente**.
- Compartilha capacidade com a tabela base.
- Suporta **consistência forte**.
- Máximo **5 LSIs** por tabela.
- Deve ser criado **no momento** da criação da tabela (imutável).

---

## Consistência de leitura

| Tipo | Latência | Custo RCU | Uso |
|---|---|---|---|
| **Eventually Consistent** | Menor | 0.5 RCU por 4KB | Padrão; aceita dados levemente desatualizados |
| **Strongly Consistent** | Maior | 1 RCU por 4KB | Dados sempre mais recentes |
| **Transactional** | Maior | 2 RCU por 4KB | Múltiplos itens, ACID |

---

## Capacidade (RCU/WCU)

### Cálculo RCU
- Eventually consistent: **0.5 RCU** por item de até 4 KB.
- Strongly consistent: **1 RCU** por item de até 4 KB.
- Ex: item de 10 KB strongly consistent = ceil(10/4) × 1 = 3 RCU.

### Cálculo WCU
- **1 WCU** por item de até 1 KB.
- Ex: item de 3.5 KB = 4 WCU.

### Modos de capacidade
| | Provisioned | On-Demand |
|---|---|---|
| Custo | Paga por RCU/WCU provisionado | Paga por request |
| Auto-scaling | Manual (+ Auto Scaling) | Automático |
| Throttling | `ProvisionedThroughputExceededException` | Sem throttle (com burst) |
| Ideal | Tráfego previsível | Tráfego imprevisível |

---

## Conceitos críticos para a prova ⚠️

- GSI: chave de partição distribui dados — evite chaves quentes.
- LSI: criado apenas na criação da tabela, compartilha throughput, suporta strong consistency.
- **DynamoDB Streams**: captura mudanças em itens em ordem. Tipos: KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES.
- **TTL (Time to Live)**: atributo numérico (epoch) — DynamoDB deleta automaticamente.

---

## Pegadinhas da prova 🎯

- GSI **não** suporta strongly consistent reads.
- LSI usa capacidade da **tabela base** — não tem capacidade própria.
- Tamanho máximo de um item: **400 KB**.
- Chave primária (PK + SK) tem tamanho máximo de **1.024 bytes** para cada atributo.
- DynamoDB **não** é relacional — não faça joins.

---

## Referências oficiais

- [DynamoDB core components](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.CoreComponents.html)
- [Global Secondary Indexes](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GSI.html)
- [Local Secondary Indexes](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LSI.html)
- [Read consistency](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.ReadConsistency.html)
