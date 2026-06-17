# Amazon RDS e Aurora

> Foco DVA-C02 – Domínio 1: Development with AWS Services

---

## Amazon RDS

Serviço de banco de dados relacional gerenciado.

### Engines suportados
MySQL, PostgreSQL, MariaDB, Oracle, SQL Server, **Aurora** (MySQL/PostgreSQL compatible).

### Funcionalidades chave

| Feature | Descrição |
|---|---|
| **Multi-AZ** | Réplica síncrona em AZ diferente; failover automático (~1-2 min) |
| **Read Replica** | Réplica assíncrona para escalar leituras; pode ser cross-region |
| **Automated Backup** | Snapshots diários + transaction logs; retenção 1-35 dias |
| **Encryption at Rest** | KMS; deve ser habilitado na criação |
| **RDS Proxy** | Pool de conexões; ideal para Lambda |

### Multi-AZ vs. Read Replica
| | Multi-AZ | Read Replica |
|---|---|---|
| Objetivo | Alta disponibilidade / DR | Escala de leitura |
| Replicação | Síncrona | Assíncrona |
| Failover | Automático | Manual (promote) |
| Aceita escritas | Não (standby) | Não (read-only) |
| Cross-region | Sim (RDS Multi-AZ) | Sim |

---

## Amazon Aurora

- Compatível com MySQL 5.7/8.0 e PostgreSQL 12/13/14/15.
- Storage: auto-escala de 10 GB até 128 TB.
- **6 cópias** em 3 AZs; quorum: 4/6 para escrita, 3/6 para leitura.
- Até **15 Aurora Replicas** (vs. 5 do RDS).
- Failover < **30 segundos**.

### Aurora Serverless v2
- Auto-escala de 0.5 a 128 ACUs (Aurora Capacity Units).
- Ideal para workloads variáveis.
- **Não** escala a zero (v2); apenas v1 escala a zero.

### Aurora Global Database
- Réplica cross-region com lag < 1 segundo.
- Até 5 regiões secundárias; failover em < 1 minuto.
- Ideal para disaster recovery global.

---

## RDS Proxy

- Pool de conexões entre Lambda (ou EC2) e RDS.
- Reduz o número de conexões abertas no banco.
- **Obrigatório em arquiteturas com alta concorrência Lambda + RDS**.
- Suporta IAM Authentication.
- Disponível para MySQL, PostgreSQL, MariaDB, SQL Server, Aurora.

---

## Conceitos críticos para a prova ⚠️

- Multi-AZ ≠ Read Replica: Multi-AZ = disponibilidade; Read Replica = performance de leitura.
- Aurora replica para 3 AZs automaticamente — não precisa configurar Multi-AZ separado.
- `rds:CreateDBSnapshot` é diferente de backup automático.
- Encryption: só pode ser habilitado na criação; para criptografar DB existente, snapshot → copy with encryption → restore.

---

## Pegadinhas da prova 🎯

- Read Replica **pode** ser promovida a instância standalone.
- Multi-AZ standby **não** serve requisições de leitura (diferente do Aurora Replica).
- Lambda + RDS sem RDS Proxy = risco de `too many connections`.
- Aurora Serverless v2 **não escala a zero** (pagar mínimo sempre).

---

## Referências oficiais

- [Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html)
- [Amazon Aurora](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html)
- [RDS Multi-AZ](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.MultiAZ.html)
- [RDS Proxy](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-proxy.html)
