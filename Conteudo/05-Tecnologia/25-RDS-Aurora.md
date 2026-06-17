# RDS e Aurora — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** **RDS** é o serviço de banco de dados relacional gerenciado da AWS (MySQL, PostgreSQL, Oracle, SQL Server, MariaDB). **Aurora** é a variante cloud-native da AWS com performance até 5x maior que MySQL e 3x maior que PostgreSQL, com replicação automática em 3 AZs.

**Para que usamos:** Aplicações que precisam de SQL com transações ACID, Aurora para alta disponibilidade com failover automático em <30 segundos, Aurora Serverless para workloads com tráfego imprevisível, RDS Proxy para ambientes serverless.

**Exemplo de prova:** Uma aplicação Lambda abre uma nova conexão com o RDS a cada invocação. Com alto tráfego, o banco começa a rejeitar conexões com erro `too many connections`. A equipe não quer aumentar `max_connections` no banco. Qual a solução recomendada para este cenário serverless?
→ Inserir o **RDS Proxy** entre a Lambda e o RDS. O Proxy mantém um pool de conexões persistentes com o banco e as multiplexia entre as invocações Lambda. A Lambda conecta ao Proxy (que aceita muitas conexões) enquanto o Proxy mantém poucas conexões reais com o RDS — resolvendo o problema sem alterar o banco.

---

## Multi-AZ vs. Read Replica

| | Multi-AZ | Read Replica |
|---|---|---|
| Objetivo | Alta disponibilidade | Escala de leitura |
| Replicação | Síncrona | Assíncrona |
| Failover | Automático (~1-2 min) | Manual (promote) |
| Aceita leitura? | Não (standby) | Sim |
| Cross-region? | Sim | Sim |

---

## Aurora

- 6 cópias em 3 AZs; quorum 4/6 escrita, 3/6 leitura.
- Storage: auto-escala 10 GB → 128 TB.
- Até 15 réplicas de leitura.
- Failover < 30 segundos.
- **Global Database**: lag < 1s; failover < 1 min.
- **Serverless v2**: 0.5–128 ACUs; não escala a zero.

---

## RDS Proxy

- Pool de conexões para Lambda + RDS.
- Suporta: MySQL, PostgreSQL, MariaDB, SQL Server, Aurora.
- Suporte a **IAM Authentication**.
- **Obrigatório** para Lambda de alta concorrência + RDS.

---

## Criptografia

- Habilitada na criação apenas.
- Para criptografar DB existente: snapshot → copy (with encryption) → restore.
- Read replicas herdam configuração de criptografia do source.

---

## Backup

- Automático: 1–35 dias de retenção.
- Manual (snapshot): indefinido.
- `rds:CreateDBSnapshot` vs backup automático são independentes.

---

## Referências oficiais

- [Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html)
- [Amazon Aurora](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html)
