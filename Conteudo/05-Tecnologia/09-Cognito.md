# Amazon Cognito — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Serviço de autenticação e autorização para aplicações web e mobile. Composto por dois componentes: **User Pools** (diretório de usuários, login, JWT) e **Identity Pools** (troca de tokens por credenciais AWS temporárias via STS).

**Para que usamos:** Autenticar usuários com login próprio ou federado (Google, Facebook, SAML), proteger APIs no API Gateway com Cognito Authorizer, permitir acesso direto a recursos AWS (S3, DynamoDB) a partir do frontend com credenciais temporárias.

**Exemplo de prova:** Usuários autenticados via Cognito User Pool precisam, além de chamar o API Gateway, também gravar diretamente em uma tabela DynamoDB a partir do app mobile (sem passar pelo backend). Como estruturar o acesso ao DynamoDB com segurança?
→ Após login no **User Pool** (obtendo JWT), trocar o token no **Identity Pool** (`GetCredentialsForIdentity`). O Cognito chama `sts:AssumeRoleWithWebIdentity` e retorna credenciais AWS temporárias com a **Authenticated Role** do Identity Pool — que tem policy IAM permitindo apenas o `dynamodb:PutItem` na tabela específica.

---

## User Pools

- Autenticação de usuários (quem é o usuário?).
- Emite: **ID Token**, **Access Token**, **Refresh Token** (JWT).
- Features: MFA, email/SMS verification, SAML/OIDC federation, hosted UI.

### Tokens (duração padrão)
| Token | Duração padrão | Uso |
|---|---|---|
| ID Token | 1 hora | Atributos do usuário (cliente) |
| Access Token | 1 hora | Escopos OAuth / API calls |
| Refresh Token | 30 dias | Renovar ID/Access tokens |

---

## Identity Pools (Federated Identities)

- Fornece credenciais AWS temporárias via STS.
- Fontes: User Pools, Google, Facebook, SAML, OIDC, anônimo.
- Retorna: Access Key + Secret Key + Session Token.

---

## Lambda Triggers (User Pool)

| Trigger | Momento |
|---|---|
| Pre sign-up | Antes de criar usuário |
| Post confirmation | Após confirmar |
| Pre authentication | Antes de autenticar |
| Post authentication | Após autenticar com sucesso |
| Pre token generation | Antes de emitir token (add custom claims) |
| Custom auth challenge | Fluxo customizado |

---

## Integração API Gateway

- **Cognito Authorizer**: valida JWT automaticamente.
- Não precisa de Lambda — validação nativa.
- Valida: assinatura, expiração, issuer, audience.

---

## Acesso a recursos AWS por usuário

```json
"Condition": {
  "StringEquals": {
    "s3:prefix": "users/${cognito-identity.amazonaws.com:sub}/"
  }
}
```

---

## Referências oficiais

- [Amazon Cognito](https://docs.aws.amazon.com/cognito/latest/developerguide/what-is-amazon-cognito.html)
