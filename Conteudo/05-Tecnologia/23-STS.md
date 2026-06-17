# AWS STS — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Serviço que emite credenciais de segurança temporárias (Access Key ID, Secret Access Key e Session Token) para usuários ou serviços que precisam de acesso limitado no tempo a recursos AWS, sem precisar de identidade IAM permanente.

**Para que usamos:** Cross-account access via `AssumeRole`, federação com identidades externas (SAML 2.0, OIDC/Cognito) via `AssumeRoleWithWebIdentity`, permissões temporárias com expiração automática para minimizar risco de vazamento.

**Exemplo de prova:** Uma aplicação rodando na conta A precisa listar objetos no S3 da conta B. A aplicação usa uma IAM Role. Qual a sequência exata de configurações necessárias?
→ **(1) Conta B:** criar IAM Role com **Trust Policy** permitindo `sts:AssumeRole` pelo ARN da role da conta A + **Permission Policy** com `s3:ListBucket` e `s3:GetObject`. **(2) Conta A:** a role da aplicação precisa de permissão `sts:AssumeRole` para o ARN da role na conta B. **(3) Aplicação:** chamar `sts:AssumeRole` → recebe credenciais temporárias → usa para acessar o S3 da conta B.

---

## Operações principais

| Operação | Uso | Duração max |
|---|---|---|
| `AssumeRole` | Assume role (mesma conta ou cross-account) | 12h |
| `AssumeRoleWithWebIdentity` | Usa token OIDC (Cognito, Google) | 12h |
| `AssumeRoleWithSAML` | Usa SAML assertion | 12h |
| `GetSessionToken` | Credenciais temporárias com MFA | 36h |
| `GetFederationToken` | Para usuário federado | 36h |

---

## Credenciais retornadas

```json
{
  "AccessKeyId": "ASIA...",
  "SecretAccessKey": "...",
  "SessionToken": "...",    ← OBRIGATÓRIO
  "Expiration": "2024-01-01T12:00:00Z"
}
```

---

## Cross-account — passos

1. Conta destino: criar role com **Trust Policy** permitindo conta origem.
2. Conta origem: usuário/role precisa de `sts:AssumeRole` na policy.
3. Chamar `sts:AssumeRole` com ARN do role de destino.

---

## External ID (Confused Deputy Protection)

```json
"Condition": {"StringEquals": {"sts:ExternalId": "meu-id-unico"}}
```
- Obrigatório em integrações com parceiros terceiros.

---

## Role chaining

- AssumeRole a partir de outro role assumido.
- Duração máxima: **1 hora** (sem extensão possível).

---

## Referências oficiais

- [AWS STS](https://docs.aws.amazon.com/STS/latest/APIReference/welcome.html)
