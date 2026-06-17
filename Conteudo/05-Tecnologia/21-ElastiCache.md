# Amazon ElastiCache — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Serviço de cache in-memory totalmente gerenciado compatível com Redis e Memcached. Oferece latência de microssegundos para leitura e escrita, com suporte a replicação, Multi-AZ e estruturas de dados avançadas (Redis).

**Para que usamos:** Cache de resultados de queries custosas no RDS/DynamoDB, armazenamento de sessões de usuário, leaderboards e rankings em tempo real com Redis Sorted Sets, rate limiting, pub/sub interno entre serviços.

**Exemplo de prova:** Uma aplicação armazena sessões de usuário no ElastiCache Redis. Em caso de falha do nó primário, a equipe exige que os usuários não percam suas sessões. O que configurar?
→ Criar um **Redis Replication Group** com Multi-AZ habilitado e **failover automático**. Os dados de sessão são replicados para o nó réplica em tempo real. Em caso de falha do primário, o ElastiCache promove automaticamente a réplica para primário em segundos. Sem Multi-AZ, a falha resulta em perda das sessões em memória.

---

## Redis vs. Memcached

| Feature | Redis | Memcached |
|---|---|---|
| Estruturas de dados | Strings, Lists, Sets, Hashes, Sorted Sets, Streams | Somente Strings |
| Persistência | Sim (RDB + AOF) | Não |
| Replicação | Sim | Não |
| Multi-AZ | Sim | Não |
| Pub/Sub | Sim | Não |
| Cluster | Sim (até 500 shards) | Sim (particionamento simples) |

---

## Padrões de cache

| Padrão | Descrição |
|---|---|
| Cache-Aside | Busca no cache; miss → DB → preenche cache |
| Write-Through | Escrita no DB e cache simultaneamente |
| Write-Behind | Escrita no cache; cache grava no DB assíncrono |

---

## Casos de uso

| Uso | Engine |
|---|---|
| Sessões de usuário | Redis |
| Leaderboard/ranking | Redis Sorted Set |
| Rate limiting | Redis (INCR + EXPIRE) |
| Cache de queries | Redis ou Memcached |
| Pub/Sub | Redis |

---

## Rede

- Sempre em **VPC** — sem IP público.
- Lambda + ElastiCache: ambos na mesma VPC (mesma subnet/SG).
- Para Lambda na VPC: adicionar NAT Gateway para acesso à internet.

---

## Referências oficiais

- [ElastiCache for Redis](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/WhatIs.html)
- [ElastiCache for Memcached](https://docs.aws.amazon.com/AmazonElastiCache/latest/mem-ug/WhatIs.html)
