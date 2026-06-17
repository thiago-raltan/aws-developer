# AWS STS e AssumeRole

> Foco DVA-C02 – Domínio 2: Security

---

## O que é o STS

AWS Security Token Service fornece **credenciais temporárias** com expiração.

Retorna:
- `AccessKeyId`
- `SecretAccessKey`
- `SessionToken` ← **obrigatório** junto com as outras duas

---

## Operações STS principais

| Operação | Uso |
|---|---|
| `AssumeRole` | Assume um IAM role (mesma conta ou cross-account) |
| `AssumeRoleWithWebIdentity` | Assume role com token OIDC (Cognito, Google, etc.) |
| `AssumeRoleWithSAML` | Assume role com SAML assertion |
| `GetSessionToken` | Credenciais temporárias para usuário IAM (com MFA) |
| `GetFederationToken` | Credenciais para usuário federado |

---

## AssumeRole — Fluxo

```
[Account A - Lambda/EC2] → sts:AssumeRole → [Account B - Role ARN]
                                               ↓ Trust Policy (permite Account A)
                                          Credenciais temporárias (1h padrão)
```

### Trust Policy (no role de destino)
```json
{
  "Statement": [{
    "Effect": "Allow",
    "Principal": {
      "AWS": "arn:aws:iam::123456789012:root"
    },
    "Action": "sts:AssumeRole",
    "Condition": {
      "StringEquals": {"sts:ExternalId": "unique-external-id"}
    }
  }]
}
```

### External ID
- Protege contra **confused deputy attack**.
- Parceiros terceiros devem fornecer ExternalId ao assumir role na sua conta.

---

## Cross-Account Access

```
Conta A (usuário/app) → AssumeRole → Conta B (role com trust policy)
```

1. Criar role em **Conta B** com trust policy permitindo **Conta A**.
2. Adicionar política de permissões ao role (o que pode fazer na Conta B).
3. Em Conta A: adicionar `sts:AssumeRole` na policy do usuário/role.
4. Chamar `sts:AssumeRole` com o ARN do role da Conta B.

---

## Duração das credenciais

| Operação | Padrão | Mínimo | Máximo |
|---|---|---|---|
| `AssumeRole` | 1h | 15 min | 12h (se role permite) |
| `AssumeRoleWithWebIdentity` | 1h | 15 min | 12h |
| `GetSessionToken` | 12h | 15 min | 36h |

---

## Conceitos críticos para a prova ⚠️

- `SessionToken` **sempre** deve ser usado junto com as credenciais temporárias.
- Role chaining: assumir role A e depois assumir role B a partir de A — máximo **1 hora** sem extensão.
- `ExternalId` é crucial em integrações com terceiros.
- Serviços AWS (Lambda, EC2) assumem roles automaticamente via **Instance Profile / Execution Role** — sem sts:AssumeRole explícito.

---

## Pegadinhas da prova 🎯

- Credenciais temporárias têm `SessionToken` — ferramentas antigas que não suportam podem falhar.
- Cross-account: precisa de permissão em **ambos os lados** (trust policy no destino + sts:AssumeRole na origem).
- Role chaining limita a duração a no máximo **1 hora**.

---

## Referências oficiais

- [AWS STS](https://docs.aws.amazon.com/STS/latest/APIReference/welcome.html)
- [IAM roles and AssumeRole](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use.html)
- [Cross-account access](https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_cross-account-with-roles.html)
