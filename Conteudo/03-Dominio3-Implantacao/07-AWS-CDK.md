# AWS CDK (Cloud Development Kit)

> Foco DVA-C02 – Domínio 3: Deployment

---

## O que é

Framework open-source para definir infraestrutura AWS em **linguagens de programação** (TypeScript, Python, Java, C#, Go).

CDK sintetiza código para **CloudFormation templates**.

---

## Conceitos fundamentais

| Conceito | Descrição |
|---|---|
| **App** | Unidade raiz do CDK; contém stacks |
| **Stack** | Equivale a um CloudFormation stack |
| **Construct** | Bloco de construção reutilizável |
| **Synth** | Gera o CloudFormation template (cdk synth) |
| **Deploy** | Implanta via CloudFormation (cdk deploy) |

### Níveis de constructs (L1, L2, L3)
| Nível | Nome | Descrição |
|---|---|---|
| **L1** | Cfn Resources | Mapeamento 1:1 com CloudFormation (`CfnBucket`) |
| **L2** | AWS Constructs | Abstrações com defaults inteligentes (`Bucket`) |
| **L3** | Patterns | Padrões de alto nível (`LambdaRestApi`) |

---

## Exemplo (Python)

```python
from aws_cdk import (
    Stack,
    aws_lambda as _lambda,
    aws_apigateway as apigw,
    aws_dynamodb as dynamodb,
)
from constructs import Construct

class MeuStack(Stack):
    def __init__(self, scope: Construct, id: str, **kwargs):
        super().__init__(scope, id, **kwargs)

        tabela = dynamodb.Table(
            self, 'MinhaTabelaDyn',
            partition_key=dynamodb.Attribute(
                name='id', type=dynamodb.AttributeType.STRING
            )
        )

        funcao = _lambda.Function(
            self, 'MinhaFuncao',
            runtime=_lambda.Runtime.PYTHON_3_12,
            handler='app.handler',
            code=_lambda.Code.from_asset('lambda/'),
            environment={'TABLE_NAME': tabela.table_name}
        )
        tabela.grant_read_write_data(funcao)

        apigw.LambdaRestApi(self, 'MinhaApi', handler=funcao)
```

---

## Comandos CDK

```bash
cdk init app --language python   # Inicializar projeto
cdk synth                        # Gerar CloudFormation template
cdk diff                         # Ver diferenças antes de deploy
cdk deploy                       # Implantar
cdk destroy                      # Remover stack
cdk bootstrap                    # Provisionar recursos CDK na conta/região
```

### cdk bootstrap
- Necessário na **primeira vez** por conta/região.
- Cria stack `CDKToolkit` com S3 bucket e ECR para artefatos.

---

## Conceitos críticos para a prova ⚠️

- CDK gera CloudFormation — todas as limitações do CloudFormation se aplicam.
- `grant_*` methods em L2 constructs adicionam permissões IAM automaticamente (ex: `grant_read_write_data`).
- `cdk bootstrap` é pré-requisito para deploy em nova conta/região.
- CDK Pipelines: biblioteca para CI/CD com CodePipeline usando CDK.

---

## Pegadinhas da prova 🎯

- CDK **não** é um substituto para CloudFormation — é uma abstração sobre ele.
- `cdk synth` não faz deploy — apenas gera o template.
- Constructs L1 (Cfn*) têm configuração idêntica ao CloudFormation YAML.

---

## Referências oficiais

- [AWS CDK](https://docs.aws.amazon.com/cdk/v2/guide/home.html)
- [CDK constructs](https://docs.aws.amazon.com/cdk/v2/guide/constructs.html)
- [CDK API reference](https://docs.aws.amazon.com/cdk/api/v2/)
