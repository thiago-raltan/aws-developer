# AWS CodePipeline — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Serviço de entrega contínua (CD) totalmente gerenciado que orquestra os estágios de build, teste e deploy de forma automatizada. Integra fontes de código (CodeCommit, GitHub, S3) com ferramentas de build e deploy da AWS e terceiros.

**Para que usamos:** Automatizar o fluxo completo CI/CD — do commit ao deploy em produção — integrando CodeCommit/GitHub → CodeBuild → CodeDeploy/CloudFormation/Elastic Beanstalk, com aprovações manuais e parallelização de estágios.

**Exemplo de prova:** Um pipeline CodePipeline falhou no estágio de deploy. O desenvolvedor corrigiu o bug e quer reexecutar o pipeline para revalidar, mas não há código novo para commitar. O pipeline foi disparado por webhook no CodeCommit. Como reexecutar sem fazer um commit vazio?
→ Usar o botão **"Release change"** no console do CodePipeline, ou via CLI: `aws codepipeline start-pipeline-execution --name NomeDoPipeline`. Isso força uma nova execução com os artefatos já presentes no estágio de Source, sem necessidade de novo commit.

---

## Estrutura

```
Pipeline → Stage 1 (Source) → Stage 2 (Build) → Stage 3 (Deploy)
             ↓                   ↓                   ↓
           Actions             Actions             Actions
```

---

## Categorias de ação

| Categoria | Providers |
|---|---|
| Source | CodeCommit, GitHub, S3, ECR, Bitbucket |
| Build | CodeBuild, Jenkins |
| Test | CodeBuild, DeviceFarm |
| Deploy | CodeDeploy, Beanstalk, ECS, CloudFormation, S3 |
| Approval | Manual (via SNS) |
| Invoke | Lambda, Step Functions |

---

## Artefatos

- Passados entre estágios como ZIP no S3.
- Bucket criado automaticamente (criptografado com KMS).
- Input/Output artifacts por ação.

---

## Triggers

- Push para branch (via EventBridge + CodeCommit/GitHub).
- Mudança em bucket S3.
- Manual (`start-pipeline-execution` CLI).

---

## Execuções paralelas

- Por padrão: execuções paralelas são **enfileiradas**.
- Superseded mode: execução anterior é cancelada pela nova.

---

## Referências oficiais

- [AWS CodePipeline](https://docs.aws.amazon.com/codepipeline/latest/userguide/welcome.html)
