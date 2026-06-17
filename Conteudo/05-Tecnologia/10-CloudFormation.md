# AWS CloudFormation — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Serviço de Infrastructure as Code (IaC) que provisiona e gerencia recursos AWS por meio de templates declarativos em JSON ou YAML. Trata infraestrutura como código versionável e reproduzível.

**Para que usamos:** Criar ambientes idênticos (dev/staging/prod), garantir rollback automático em falhas de deploy, stacks aninhadas para modularização, drift detection para detectar mudanças manuais não rastreadas.

**Exemplo de prova:** Durante um deploy de CloudFormation, a criação de um recurso no meio da stack falha. A equipe quer investigar o estado dos recursos criados até aquele ponto antes de qualquer limpeza. O que ocorre por padrão e como mudar esse comportamento?
→ Por padrão, o CloudFormation executa **rollback automático**, deletando todos os recursos criados naquele deploy. Para desabilitar, usar a flag `--disable-rollback` (CLI) ou `DisableRollback: true` (console). Isso mantém os recursos no estado atual para inspeção, mas requer limpeza manual antes de um novo deploy.

---

## Seções do template

`AWSTemplateFormatVersion`, `Description`, `Parameters`, `Mappings`, `Conditions`, `Transform`, `Resources` (obrigatória), `Outputs`.

---

## Funções intrínsecas

| Função | Uso |
|---|---|
| `!Ref` | ID do recurso ou valor do parâmetro |
| `!GetAtt` | Atributo de recurso |
| `!Sub` | Substituição de variáveis em string |
| `!Join` | Concatenar com delimitador |
| `!Select` | Elemento de lista |
| `!If` | Condicional |
| `!ImportValue` | Importar export de outro stack |
| `!FindInMap` | Buscar em Mappings |
| `!Split` | Dividir string em lista |

---

## DeletionPolicy

| Valor | Comportamento |
|---|---|
| `Delete` | Padrão — deleta o recurso |
| `Retain` | Mantém o recurso (desassociado) |
| `Snapshot` | Cria snapshot antes de deletar (RDS, EC2, ElastiCache) |

---

## Change Sets

Pré-visualiza mudanças antes de aplicar.
```bash
aws cloudformation create-change-set ...
aws cloudformation execute-change-set ...
```

---

## Outputs e Exports

```yaml
Outputs:
  BucketArn:
    Value: !GetAtt MeuBucket.Arn
    Export:
      Name: !Sub "${AWS::StackName}-BucketArn"
```
```yaml
# Outro stack
!ImportValue NomeDoStack-BucketArn
```

---

## Pseudo-parameters

`AWS::AccountId`, `AWS::Region`, `AWS::StackName`, `AWS::StackId`, `AWS::NoValue`, `AWS::URLSuffix`.

---

## Referências oficiais

- [CloudFormation User Guide](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html)
