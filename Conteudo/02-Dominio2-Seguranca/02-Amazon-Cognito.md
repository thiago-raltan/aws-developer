# Amazon Cognito

> Foco DVA-C02 – Domínio 2: Security

---

## Componentes

### User Pools
- Diretório de usuários para autenticação.
- Fornece JWT tokens: **ID Token**, **Access Token**, **Refresh Token**.
- Funcionalidades: registro, login, MFA, recuperação de senha, email/SMS verification.
- Integrações: API Gateway (Cognito Authorizer), Application Load Balancer.

### Identity Pools (Federated Identities)
- Fornece **credenciais AWS temporárias** (via STS) para usuários autenticados ou não.
- Fontes de identidade: User Pools, Google, Facebook, Apple, SAML, OpenID Connect.
- Mapeia usuários para IAM roles (authenticated role + unauthenticated/guest role).

---

## Fluxo completo

```
[Usuário] → login em User Pool → recebe JWT
[Usuário] → envia JWT para Identity Pool → recebe credenciais AWS temporárias
[Usuário] → usa credenciais para acessar S3/DynamoDB/etc diretamente
```

---

## User Pool — Triggers Lambda

| Trigger | Quando executa |
|---|---|
| **Pre sign-up** | Antes de criar o usuário |
| **Post confirmation** | Após confirmar cadastro |
| **Pre authentication** | Antes de autenticar |
| **Post authentication** | Após autenticar com sucesso ← **enviar notificações** |
| **Pre token generation** | Antes de emitir tokens (adicionar claims customizados) |
| **Custom authentication** | Fluxo de autenticação customizado |

---

## Tokens JWT

```
Header.Payload.Signature
```

- **ID Token**: contém atributos do usuário (email, name, etc.) — para o cliente.
- **Access Token**: contém escopos e grupos — para autorizar API calls.
- **Refresh Token**: obtém novos ID/Access tokens (expiração longa).

Validação no API Gateway: **Cognito User Pool Authorizer** valida automaticamente.

---

## Acesso a recursos AWS com Identity Pool

```json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::meu-bucket/private/${cognito-identity.amazonaws.com:sub}/*"
  }]
}
```

- `${cognito-identity.amazonaws.com:sub}` = ID único do usuário no Identity Pool.
- Permite isolamento de dados por usuário no S3.

---

## Conceitos críticos para a prova ⚠️

- User Pool = **autenticação** (quem é o usuário?).
- Identity Pool = **autorização** (o que o usuário pode fazer na AWS?).
- JWT do User Pool pode ser validado pelo **API Gateway** sem Lambda.
- Lambda Authorizer retorna uma **IAM policy** — Cognito Authorizer retorna Allow/Deny.
- Grupos do User Pool podem ser mapeados para IAM roles via Identity Pool.

---

## Pegadinhas da prova 🎯

- **Post authentication trigger** = notificação de login (não Pre).
- Identity Pool não requer User Pool — pode usar qualquer Identity Provider.
- Tokens JWT expiram: ID/Access = 1h padrão; Refresh = 30 dias padrão.
- User Pool Authorizer no API Gateway valida a **assinatura** do JWT.

---

## Referências oficiais

- [Amazon Cognito User Pools](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools.html)
- [Amazon Cognito Identity Pools](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-identity.html)
- [Cognito Lambda triggers](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-working-with-lambda-triggers.html)
