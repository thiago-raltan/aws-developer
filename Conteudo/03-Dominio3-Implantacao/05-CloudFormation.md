# AWS CloudFormation

> Foco DVA-C02 – Domínio 3: Deployment

---

## O que é

Serviço de **Infrastructure as Code (IaC)** para provisionar recursos AWS via templates YAML/JSON.

---

## Estrutura do template

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: 'Descrição do stack'

Parameters:
  Env:
    Type: String
    Default: dev
    AllowedValues: [dev, prod]

Mappings:
  EnvToInstanceType:
    dev:
      InstanceType: t3.micro
    prod:
      InstanceType: m5.large

Conditions:
  IsProd: !Equals [!Ref Env, prod]

Resources:
  MyBucket:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: !Sub 'meu-bucket-${Env}'

  MyLambda:
    Type: AWS::Lambda::Function
    Properties:
      FunctionName: !Sub 'minha-funcao-${Env}'
      Runtime: python3.12
      Handler: index.handler
      Role: !GetAtt LambdaRole.Arn

Outputs:
  BucketName:
    Value: !Ref MyBucket
    Export:
      Name: !Sub '${AWS::StackName}-BucketName'
```

---

## Funções intrínsecas

| Função | Uso |
|---|---|
| `!Ref` | Referencia recurso ou parâmetro |
| `!GetAtt` | Retorna atributo de recurso |
| `!Sub` | Substitui variáveis em string |
| `!Join` | Concatena strings |
| `!Select` | Seleciona item de lista |
| `!If` | Condicional |
| `!ImportValue` | Importa Export de outro stack |
| `!FindInMap` | Busca valor em Mappings |

---

## Stack operations

| Operação | Descrição |
|---|---|
| `create-stack` | Cria novo stack |
| `update-stack` | Atualiza stack existente |
| `delete-stack` | Deleta stack e recursos |
| `describe-stacks` | Lista stacks e status |
| `validate-template` | Valida syntax do template |

### Change Sets
```bash
aws cloudformation create-change-set --stack-name MeuStack --change-set-name preview
aws cloudformation describe-change-set --change-set-name preview
aws cloudformation execute-change-set --change-set-name preview
```
- Visualize mudanças **antes** de aplicar.

---

## DeletionPolicy

```yaml
Resources:
  MyDB:
    Type: AWS::RDS::DBInstance
    DeletionPolicy: Retain     # Retain | Delete | Snapshot
```

| Valor | Comportamento |
|---|---|
| `Delete` | Padrão; deleta o recurso |
| `Retain` | Mantém o recurso ao deletar o stack |
| `Snapshot` | Cria snapshot antes de deletar (RDS, EC2) |

---

## StackSets

- Deploy do **mesmo template** em múltiplas contas e/ou regiões.
- Requer confiança entre conta administradora e contas-alvo.

---

## Conceitos críticos para a prova ⚠️

- `!Ref` em um recurso retorna o **ID lógico** ou nome; para atributos use `!GetAtt`.
- Exports/Imports: `!ImportValue` referencia exports de **outros stacks** na mesma região/conta.
- `DependsOn`: define dependências explícitas entre recursos.
- **Rollback**: CloudFormation desfaz automaticamente em caso de falha.
- `cfn-signal`: instâncias EC2 sinalizam CloudFormation quando estão prontas.

---

## Pegadinhas da prova 🎯

- Template pode ser armazenado no S3 para stacks maiores (limite: 51.200 bytes direto, 460.800 bytes via S3).
- `DeletionPolicy: Retain` — recurso persiste mas é **desassociado** do stack.
- `UPDATE_ROLLBACK_FAILED`: stack preso; precisa de intervenção manual ou `continue-update-rollback`.

---

## Referências oficiais

- [AWS CloudFormation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html)
- [CloudFormation template reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-reference.html)
- [CloudFormation intrinsic functions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference.html)
