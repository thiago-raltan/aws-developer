# AWS CodeBuild — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Serviço de build e teste totalmente gerenciado que compila código-fonte, executa testes e produz artefatos prontos para deploy. Sem necessidade de provisionar ou gerenciar servidores de build — escala automaticamente.

**Para que usamos:** Compilar projetos Java/Python/Node.js/Go, executar testes unitários e de integração, construir e publicar imagens Docker no ECR, gerar pacotes SAM/CloudFormation para deploy, rodar análise de segurança de código (SAST).

**Exemplo de prova:** Um projeto CodeBuild precisa construir uma imagem Docker e publicá-la no ECR privado. O build falha com erro de autenticação no ECR. Quais permissões a Service Role do CodeBuild precisa e o que deve estar no `buildspec.yml`?
→ A **Service Role** precisa das permissões: `ecr:GetAuthorizationToken`, `ecr:BatchCheckLayerAvailability`, `ecr:PutImage`, `ecr:InitiateLayerUpload`, `ecr:UploadLayerPart`, `ecr:CompleteLayerUpload`. No `buildspec.yml`, fase `pre_build`: `aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_URI`.

---

## buildspec.yml — estrutura

```yaml
version: 0.2
env:
  variables: {}
  parameter-store: {}
  secrets-manager: {}
phases:
  install:
    runtime-versions:
      python: 3.11
    commands: []
  pre_build:
    commands: []
  build:
    commands: []
  post_build:
    commands: []
artifacts:
  files: ['**/*']
  base-directory: dist/
cache:
  paths: ['/root/.cache/pip/**/*']
```

---

## Fases de build (status)

`SUBMITTED → QUEUED → PROVISIONING → DOWNLOAD_SOURCE → INSTALL → PRE_BUILD → BUILD → POST_BUILD → UPLOAD_ARTIFACTS → FINALIZING → COMPLETED`

---

## Variáveis de ambiente automáticas

`CODEBUILD_BUILD_ID`, `CODEBUILD_BUILD_ARN`, `AWS_DEFAULT_REGION`, `AWS_ACCOUNT_ID`, `CODEBUILD_SOURCE_VERSION`.

---

## Docker no CodeBuild

- Requer **Privileged mode** habilitado no projeto.
- Faz login no ECR via `aws ecr get-login-password`.

---

## Cache

- S3: persistente entre builds.
- Local: apenas em builds no mesmo worker.
- Configurar `cache.paths` no buildspec.

---

## VPC

- CodeBuild pode rodar em VPC.
- Sem NAT Gateway em VPC = sem acesso à internet.
- Necessário para acessar RDS, ElastiCache na VPC.

---

## Referências oficiais

- [AWS CodeBuild](https://docs.aws.amazon.com/codebuild/latest/userguide/welcome.html)
