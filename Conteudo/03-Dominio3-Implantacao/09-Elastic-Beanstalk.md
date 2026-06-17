# AWS Elastic Beanstalk

> Foco DVA-C02 – Domínio 3: Deployment

---

## O que é

PaaS (Platform as a Service) que abstrai o provisionamento de infraestrutura para aplicações web.
- Gerencia: EC2, Auto Scaling, Load Balancer, RDS, CloudWatch, S3.
- Você fornece: código da aplicação.

---

## Plataformas suportadas

Node.js, Python, Java, .NET, PHP, Ruby, Go, Docker (Single/Multi-container).

---

## Componentes

| Componente | Descrição |
|---|---|
| **Application** | Container lógico (nome da app) |
| **Environment** | Instância em execução (prod, dev, staging) |
| **Application Version** | Bundle de código (ZIP no S3) |
| **Environment Tier** | Web Server ou Worker |

### Tiers
| | Web Server Tier | Worker Tier |
|---|---|---|
| Entrada | HTTP via ALB/ELB | SQS queue |
| Uso | APIs, web apps | Processamento assíncrono |
| Auto-scaling | Baseado em requests | Baseado em tamanho da fila |

---

## .ebextensions

Diretório `.ebextensions/` na raiz do projeto com arquivos YAML de configuração:

```yaml
# .ebextensions/options.config
option_settings:
  aws:autoscaling:launchconfiguration:
    InstanceType: t3.micro
  aws:elasticbeanstalk:application:environment:
    NODE_ENV: production

# .ebextensions/packages.config
packages:
  yum:
    git: []
    jq: []

# .ebextensions/commands.config
commands:
  01_migrate:
    command: "python manage.py migrate"
```

---

## Salvando configurações

- **Saved Configuration**: snapshot de configuração do ambiente (S3).
- `.ebextensions`: configuração como código no repositório.
- **Platform hooks** (`.platform/`): scripts de ciclo de vida.

---

## Deploy

```bash
eb init         # Configura app e região
eb create       # Cria ambiente
eb deploy       # Implanta nova versão
eb swap         # Troca URLs entre ambientes (Blue/Green)
eb config       # Configura opções do ambiente
eb terminate    # Termina ambiente
```

---

## Conceitos críticos para a prova ⚠️

- Beanstalk é **gratuito** — paga apenas pelos recursos provisionados (EC2, RDS, etc.).
- Rollback: reimplante versão anterior da application version.
- `.ebextensions` **faz parte do pacote de deploy** — não é separado.
- `eb swap`: para Blue/Green, muda as URLs CNAME entre dois ambientes.
- **Worker tier**: `daemon` processa mensagens SQS; `cron.yaml` agenda tarefas periódicas.

---

## Pegadinhas da prova 🎯

- Beanstalk não é serverless — usa EC2.
- `All at Once` tem downtime — não use em produção crítica.
- Para zero-downtime: use `Immutable` ou `Rolling with additional batch`.
- RDS dentro do ambiente Beanstalk: **perigoso** — deletar o ambiente deleta o RDS.
- Separe RDS do ambiente Beanstalk para produção.

---

## Referências oficiais

- [Elastic Beanstalk](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/Welcome.html)
- [Beanstalk deployment policies](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using-features.rolling-version-deploy.html)
- [.ebextensions](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/ebextensions.html)
