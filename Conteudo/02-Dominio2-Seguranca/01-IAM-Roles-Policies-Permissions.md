# IAM — Roles, Policies e Permissions

> Foco DVA-C02 – Domínio 2: Security

---

## Componentes IAM

| Componente | Descrição |
|---|---|
| **User** | Identidade permanente para pessoa ou aplicação |
| **Group** | Coleção de users; herdam políticas do grupo |
| **Role** | Identidade temporária assumida por serviços/usuários |
| **Policy** | Documento JSON que define permissões |

---

## Tipos de políticas

| Tipo | Onde é aplicada | Gerenciamento |
|---|---|---|
| **Identity-based** | Anexada a user/group/role | Gerenciada (AWS ou customer) ou inline |
| **Resource-based** | Anexada ao recurso (S3 bucket, SQS queue) | Inline no recurso |
| **Permissions boundary** | Limite máximo de permissões de uma identity | Gerenciada |
| **SCP (Service Control Policy)** | Conta/OU em AWS Organizations | Gerenciada na organização |
| **Session policy** | Passada ao assumir role | Inline na chamada AssumeRole |

---

## Estrutura da política (JSON)

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject"],
      "Resource": "arn:aws:s3:::meu-bucket/*",
      "Condition": {
        "StringEquals": {
          "aws:RequestedRegion": "us-east-1"
        }
      }
    }
  ]
}
```

### Elementos obrigatórios
- `Effect`: **Allow** ou **Deny**.
- `Action`: ação(ões) AWS (ex: `s3:GetObject`, `*`).
- `Resource`: ARN do recurso.

---

## Lógica de avaliação de permissões

```
1. Deny explícito → DENIED (sempre)
2. Allow explícito → ALLOWED
3. Sem Allow → DENIED (implicit deny)
```

Ordem de avaliação:
1. SCPs (Organizations)
2. Resource-based policies
3. Identity-based policies
4. Permissions boundaries
5. Session policies

---

## IAM Roles para serviços

| Serviço | Como usa Role |
|---|---|
| **Lambda** | Execution role (permite Lambda chamar outros serviços) |
| **EC2** | Instance profile (role atribuída à instância) |
| **ECS** | Task role (role por task) |
| **CodeBuild** | Service role (permite build acessar recursos) |

---

## Policy conditions comuns

```json
"Condition": {
  "IpAddress": {"aws:SourceIp": "203.0.113.0/24"},
  "Bool": {"aws:MultiFactorAuthPresent": "true"},
  "StringLike": {"s3:prefix": "home/${aws:username}/*"},
  "DateLessThan": {"aws:CurrentTime": "2024-12-31T00:00:00Z"}
}
```

---

## Conceitos críticos para a prova ⚠️

- **Deny explícito sempre prevalece** — mesmo com Allow em outra política.
- `*` em Action ou Resource = permissão total (evite em produção).
- **Permissions boundary**: limita o máximo; não concede permissões por si só.
- Cross-account: precisa de trust policy no role + identity policy no usuário origem.
- `aws:SecureTransport`: condição para forçar HTTPS.

---

## Pegadinhas da prova 🎯

- User sem grupo + sem política direta = sem permissões (implicit deny).
- IAM policy avaliada por **conta** — não por região (IAM é global).
- Role para Lambda = execution role ≠ resource-based policy da função.
- `sts:AssumeRole` é a ação necessária para assumir um role.

---

## Referências oficiais

- [IAM policies and permissions](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html)
- [Policy evaluation logic](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_evaluation-logic.html)
- [IAM roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html)
