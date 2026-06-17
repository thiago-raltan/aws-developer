# AWS CodeBuild

> Foco DVA-C02 – Domínio 3: Deployment

---

## O que é

Serviço de build totalmente gerenciado que **compila, testa e gera artefatos** de deploy.

---

## buildspec.yml

Arquivo na raiz do repositório que define o processo de build.

```yaml
version: 0.2

env:
  variables:
    MY_VAR: "valor"
  parameter-store:
    DB_HOST: "/minha-app/prod/db-host"
  secrets-manager:
    DB_PASS: "arn:aws:secretsmanager:us-east-1:123:secret:db-pass"

phases:
  install:
    runtime-versions:
      python: 3.11
    commands:
      - pip install -r requirements.txt
  pre_build:
    commands:
      - echo "Fazendo login no ECR"
      - aws ecr get-login-password | docker login --username AWS --password-stdin $ECR_REGISTRY
  build:
    commands:
      - echo "Executando testes"
      - pytest tests/
      - docker build -t $IMAGE_TAG .
      - docker push $IMAGE_TAG
  post_build:
    commands:
      - echo "Build concluído"

artifacts:
  files:
    - '**/*'
  base-directory: dist/

cache:
  paths:
    - '/root/.cache/pip/**/*'
```

---

## Fases do build

| Fase | Descrição |
|---|---|
| `SUBMITTED` | Build enviado |
| `QUEUED` | Aguardando executor |
| `PROVISIONING` | Preparando ambiente |
| `DOWNLOAD_SOURCE` | Baixando código-fonte |
| `INSTALL` | Fase install do buildspec |
| `PRE_BUILD` | Fase pre_build |
| `BUILD` | Fase build |
| `POST_BUILD` | Fase post_build |
| `UPLOAD_ARTIFACTS` | Enviando artefatos para S3 |
| `FINALIZING` | Limpando ambiente |
| `COMPLETED` | Concluído |

---

## Cache

- **S3**: cache de dependências (npm, pip, maven).
- **Local**: no executor (apenas para builds sequenciais no mesmo executor).
- Configurar `cache.paths` no buildspec.

---

## VPC e Segurança

- CodeBuild pode rodar dentro de uma VPC para acessar recursos privados.
- Service role: permissões para S3, ECR, Secrets Manager, etc.
- Logs: CloudWatch Logs e/ou S3.

---

## Variáveis de ambiente

1. Definidas no projeto CodeBuild.
2. `env.variables` no buildspec (não sensíveis).
3. `env.parameter-store` e `env.secrets-manager` (sensíveis).
4. Passadas pelo CodePipeline (namespace de ações anteriores).

---

## Conceitos críticos para a prova ⚠️

- `buildspec.yml` deve estar na **raiz** do repositório (ou especificado no projeto).
- Artefatos vão para o bucket S3 do CodePipeline (ou S3 customizado).
- CodeBuild usa **containers efêmeros** — nenhum estado persiste entre builds.
- `docker` disponível apenas em ambientes com Docker habilitado.
- `CODEBUILD_BUILD_ID`: variável de ambiente disponível automaticamente.

---

## Pegadinhas da prova 🎯

- Se o `buildspec.yml` não existe na raiz, build falha com erro de configuração.
- Cache não é garantido — builds devem funcionar sem cache.
- Para builds Docker: habilite "Privileged mode" no projeto CodeBuild.
- CodeBuild **não** tem acesso à internet por padrão em VPC — precisa de NAT Gateway.

---

## Referências oficiais

- [AWS CodeBuild](https://docs.aws.amazon.com/codebuild/latest/userguide/welcome.html)
- [buildspec reference](https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html)
- [CodeBuild environment variables](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-env-vars.html)
