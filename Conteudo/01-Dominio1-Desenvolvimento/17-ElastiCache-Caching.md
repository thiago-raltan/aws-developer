# Amazon ElastiCache — Caching

> Foco DVA-C02 – Domínio 1: Development with AWS Services

---

## Engines disponíveis

| | Redis | Memcached |
|---|---|---|
| Estruturas de dados | Strings, Lists, Sets, Sorted Sets, Hashes, Streams | Somente Strings |
| Persistência | Sim (RDB + AOF) | Não |
| Replicação | Sim (cluster mode) | Não |
| Multi-AZ | Sim | Não |
| Backup/Restore | Sim | Não |
| Pub/Sub | Sim | Não |
| Lua scripting | Sim | Não |
| Ideal | Sessions, leaderboards, pub/sub, filas | Cache simples, máxima performance |

---

## Padrões de caching

### Cache-Aside (Lazy Loading)
```
Aplicação → busca no cache
  ├─ HIT → retorna dado do cache
  └─ MISS → busca no DB → salva no cache → retorna
```
- Prós: só carrega o que é usado; falha no cache não quebra a aplicação.
- Contras: cache miss tem 3 operações; dados podem estar desatualizados (stale).

### Write-Through
```
Aplicação → escreve no DB → escreve no cache
```
- Prós: cache sempre atualizado.
- Contras: latência de escrita maior; cache polluted com dados não lidos.

### Write-Behind (Write-Back)
- Escreve no cache; aplicação confirma; cache grava no DB assincronamente.
- Risco de perda de dados se cache cair antes de gravar.

### TTL (Time-To-Live)
- Todos os padrões devem usar TTL para evitar dados stale infinitamente.
- Redis: `SET key value EX 3600`.

---

## Casos de uso na prova

| Caso de uso | Engine | Padrão |
|---|---|---|
| Sessões de usuário | Redis | Cache-Aside ou Write-Through |
| Leaderboard (ranking) | Redis Sorted Set | — |
| Rate limiting | Redis (INCR + EXPIRE) | — |
| Cache de queries RDS | Redis ou Memcached | Cache-Aside |
| Pub/Sub em tempo real | Redis | — |

---

## Conceitos críticos para a prova ⚠️

- ElastiCache está **sempre em VPC** — Lambda ou EC2 também precisam estar na mesma VPC.
- Redis com **cluster mode enabled**: dados particionados em múltiplos shards.
- Redis **Multi-AZ**: réplica de leitura em AZ diferente; failover automático.
- Memcached: sem persistência — dados perdidos em restart.

---

## Pegadinhas da prova 🎯

- ElastiCache **não** é acessível diretamente pela internet (sem IP público).
- Redis Cluster Mode Disabled = 1 shard + até 5 réplicas.
- Redis Cluster Mode Enabled = até 500 shards.
- Session store com Redis: armazene token de sessão como key, dados como value + TTL.

---

## Referências oficiais

- [ElastiCache for Redis](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/WhatIs.html)
- [ElastiCache for Memcached](https://docs.aws.amazon.com/AmazonElastiCache/latest/mem-ug/WhatIs.html)
- [Caching strategies](https://docs.aws.amazon.com/AmazonElastiCache/latest/mem-ug/Strategies.html)
