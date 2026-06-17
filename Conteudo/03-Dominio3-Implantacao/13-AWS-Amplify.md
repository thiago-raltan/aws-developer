# AWS Amplify

> Foco DVA-C02 – Domínio 3: Deployment

---

## O que é

Plataforma de desenvolvimento para criar e implantar aplicações **web e mobile full-stack**.

Componentes:
- **Amplify Hosting**: CI/CD + CDN para frontend (React, Vue, Angular, Next.js).
- **Amplify Studio**: interface visual para construir UI e backend.
- **Amplify Libraries**: SDKs para integração com serviços AWS (Auth, Storage, API, etc.).
- **Amplify CLI**: configuração de backend via linha de comando.

---

## Amplify Hosting

### Fluxo de deploy
```
[Git Push] → [Amplify Hosting] → [Build] → [Deploy no CDN (CloudFront)]
```

- Conecta a: GitHub, GitLab, Bitbucket, CodeCommit.
- Branch-based deploys: cada branch = ambiente separado.
- PR previews: cada pull request = ambiente temporário.
- Build settings via `amplify.yml`.

### amplify.yml
```yaml
version: 1
frontend:
  phases:
    preBuild:
      commands:
        - npm install
    build:
      commands:
        - npm run build
  artifacts:
    baseDirectory: build
    files:
      - '**/*'
  cache:
    paths:
      - node_modules/**/*
```

---

## Amplify Libraries (Auth)

```javascript
import { Amplify } from 'aws-amplify';
import { signIn, signOut, getCurrentUser } from 'aws-amplify/auth';

Amplify.configure({
  Auth: {
    Cognito: {
      userPoolId: 'us-east-1_xxx',
      userPoolClientId: 'yyy',
    }
  }
});

// Login
await signIn({ username: 'usuario', password: 'senha' });

// Obter usuário atual
const user = await getCurrentUser();
```

---

## Backend com Amplify

- Provisiona automaticamente: Cognito, AppSync (GraphQL), DynamoDB, S3, Lambda.
- `amplify add auth` → configura Cognito User Pool.
- `amplify add api` → configura AppSync ou API Gateway.
- `amplify push` → deploy do backend via CloudFormation.

---

## Conceitos críticos para a prova ⚠️

- Amplify Hosting usa **CloudFront** para servir o frontend.
- Custom domain: configure CNAME/Alias para o domínio Amplify + ACM cert.
- Amplify = plataforma completa (frontend + backend); Elastic Beanstalk = apenas backend.
- `amplify.yml` define o build; similar ao `buildspec.yml` do CodeBuild.

---

## Pegadinhas da prova 🎯

- Amplify Hosting ≠ S3 static website (Amplify inclui CI/CD e CDN automaticamente).
- Para Next.js SSR: Amplify Hosting tem suporte nativo com Lambda@Edge.
- Branch feature → ambiente de preview automático: útil para QA.

---

## Referências oficiais

- [AWS Amplify](https://docs.aws.amazon.com/amplify/latest/userguide/welcome.html)
- [Amplify Hosting](https://docs.aws.amazon.com/amplify/latest/userguide/getting-started.html)
- [Amplify Libraries](https://docs.amplify.aws/lib/)
