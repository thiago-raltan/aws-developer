# Stateful vs. Stateless

> Foco DVA-C02 – Domínio 1: Development with AWS Services

---

## Definições

| | Stateful | Stateless |
|---|---|---|
| Estado da sessão | Mantido no servidor | Não existe estado no servidor |
| Escalabilidade | Difícil (sessão presa a instância) | Fácil (qualquer instância atende) |
| Exemplos | WebSockets com estado, banco de dados | REST API, Lambda |
| AWS Fit | RDS com sessões, EC2 tradicional | Lambda, API Gateway, S3 |

---

## Por que Stateless é preferido na nuvem

- **Lambda é inerentemente stateless**: cada invocação é independente.
- Facilita **auto-scaling** (qualquer instância pode processar qualquer request).
- Facilita **fault tolerance** (substituição de instâncias é transparente).

---

## Como gerenciar estado em arquiteturas AWS

| Tipo de estado | Serviço recomendado |
|---|---|
| Sessão de usuário | **ElastiCache (Redis)**, DynamoDB |
| Estado de fluxo de trabalho | **AWS Step Functions** |
| Dados temporários de alta performance | **ElastiCache Memcached/Redis** |
| Estado de longa duração | **DynamoDB** |
| Arquivos e objetos | **S3** |

---

## Conceitos críticos para a prova ⚠️

- Lambda **pode reutilizar o execution context** (container warm): variáveis globais persistem entre invocações no mesmo container, mas **não é garantido**.
- Use variáveis de ambiente para configuração; **nunca** armazene estado em memória esperando persistência.
- **ElastiCache Redis** suporta estruturas de dados complexas e persistência; **Memcached** é simples e sem persistência.
- Step Functions é a solução correta quando um fluxo de trabalho precisa de estado entre múltiplas funções Lambda.

---

## Pegadinhas da prova 🎯

- A reutilização do execution context do Lambda é um **detalhe de otimização**, não uma garantia de estado.
- Conexões de banco de dados iniciadas fora do handler Lambda persistem entre invocações quentes — use **RDS Proxy** para pooling.
- ElastiCache em VPC: Lambda também deve estar na mesma VPC para acessar.

---

## Referências oficiais

- [AWS Lambda execution environment](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtime-environment.html)
- [Amazon ElastiCache](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/WhatIs.html)
- [AWS Step Functions](https://docs.aws.amazon.com/step-functions/latest/dg/welcome.html)
