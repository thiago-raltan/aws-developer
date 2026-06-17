# AWS CodePipeline

> Foco DVA-C02 – Domínio 3: Deployment

---

## O que é

Serviço de **CI/CD totalmente gerenciado** que orquestra pipelines de entrega de software.

---

## Estrutura de um Pipeline

```
[Source]  →  [Build]  →  [Test]  →  [Deploy]
  ↓              ↓           ↓           ↓
CodeCommit   CodeBuild   CodeBuild   CodeDeploy
  GitHub                             Beanstalk
   S3                                 ECS
                                   CloudFormation
```

### Estágios (Stages) e Ações (Actions)
- Pipeline = N estágios sequenciais.
- Estágio = N ações paralelas ou sequenciais.
- Tipos de ação: Source, Build, Test, Deploy, Approval, Invoke (Lambda).

---

## Tipos de ação por categoria

| Categoria | Providers |
|---|---|
| **Source** | CodeCommit, GitHub, Bitbucket, ECR, S3 |
| **Build** | CodeBuild, Jenkins |
| **Test** | CodeBuild, DeviceFarm |
| **Deploy** | CodeDeploy, Beanstalk, ECS, CloudFormation, S3, AppConfig |
| **Approval** | SNS (notificação para aprovação manual) |
| **Invoke** | Lambda, Step Functions |

---

## Triggers e integração

- **Push para branch**: CodeCommit/GitHub → EventBridge rule → Pipeline execução.
- **S3 changes**: mudança no bucket de artefatos.
- **Manual**: via console ou CLI.
- `aws codepipeline start-pipeline-execution --name MeuPipeline`

---

## Artefatos

- Cada ação pode consumir e produzir **artefatos** (arquivos ZIP no S3).
- Bucket S3 de artefatos: criado automaticamente pelo CodePipeline.
- Criptografia: KMS.

---

## Aprovação manual

```
Stage: Aprovacao-Producao
  Action: Manual Approval
    NotificationArn: arn:aws:sns:...:aprovadores
    ExternalEntityLink: https://meu-sistema/review
```

---

## Conceitos críticos para a prova ⚠️

- CodePipeline **orquestra** — não compila nem testa diretamente (usa CodeBuild para isso).
- Falha em qualquer estágio: pipeline para; estágios posteriores não executam.
- `Invoke` com Lambda: útil para validações customizadas ou tarefas intermediárias.
- Variáveis de namespace: passar saídas entre estágios.
- **EventBridge** monitora mudanças de estado do pipeline.

---

## Pegadinhas da prova 🎯

- CodePipeline não tem capacidade computacional — não executa código diretamente.
- Rollback: CodePipeline não tem rollback automático — configure no CodeDeploy.
- Pipeline não pode ter 2 execuções simultâneas (por padrão, fila a segunda).

---

## Referências oficiais

- [AWS CodePipeline](https://docs.aws.amazon.com/codepipeline/latest/userguide/welcome.html)
- [Pipeline structure](https://docs.aws.amazon.com/codepipeline/latest/userguide/pipeline-structure.html)
- [CodePipeline actions](https://docs.aws.amazon.com/codepipeline/latest/userguide/integrations-action-type.html)
