# AWS CDK — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Framework de Infrastructure as Code que permite definir recursos AWS usando linguagens de programação reais (TypeScript, Python, Java, C#, Go). O CDK compila o código em templates CloudFormation via `cdk synth`.

**Para que usamos:** Criar infraestrutura com lógica de programação (loops, condicionais, herança), reutilizar componentes via Constructs customizados, testar infraestrutura com frameworks de unit test, integrar IaC no mesmo repositório do código da aplicação.

**Exemplo de prova:** Uma empresa quer que todas as equipes usem o mesmo padrão de Lambda + API Gateway + DynamoDB com configurações de segurança corporativas (timeout, VPC, logs habilitados). Como garantir reutilização e padronização via CDK?
→ Criar um **CDK Construct de nível L3 (pattern)** que encapsula os 3 recursos com as configurações padrão pré-configuradas e parâmetros configuráveis expostos. Publicar o Construct como **pacote npm/pip privado no CodeArtifact**. As equipes instalam o pacote e instanciam o Construct, herdando automaticamente todos os padrões corporativos.

---

## Conceitos

| Conceito | Descrição |
|---|---|
| App | Raiz; contém stacks |
| Stack | Equivale a CloudFormation stack |
| Construct | Bloco de construção (L1/L2/L3) |
| Synthesize | Gera CloudFormation template |

---

## Níveis de constructs

| Nível | Prefixo | Descrição |
|---|---|---|
| L1 | `Cfn*` | Mapeamento 1:1 com CloudFormation |
| L2 | (sem prefixo) | Abstrações com defaults |
| L3 | Patterns | Combinações de serviços |

---

## Comandos CLI

```bash
cdk init app --language python
cdk bootstrap   # Primeira vez por conta/região
cdk synth       # Gerar template CloudFormation
cdk diff        # Comparar com estado atual
cdk deploy      # Implantar
cdk destroy     # Remover stack
```

---

## `grant_*` methods (L2)

```python
tabela.grant_read_write_data(funcao)      # DynamoDB
bucket.grant_read_write(funcao)            # S3
fila.grant_send_messages(funcao)           # SQS
topico.grant_publish(funcao)               # SNS
```
Adiciona permissões IAM automaticamente.

---

## CDK Pipelines

- Biblioteca para CI/CD com CodePipeline usando CDK.
- Self-mutating: pipeline atualiza a si mesma ao mudar o código.

---

## Referências oficiais

- [AWS CDK v2](https://docs.aws.amazon.com/cdk/v2/guide/home.html)
