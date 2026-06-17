# AWS IAM — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Serviço de gerenciamento de identidade e acesso que controla quem (autenticação) pode fazer o quê (autorização) nos recursos AWS. Permite definir permissões granulares via policies JSON para usuários, grupos, roles e recursos.

**Para que usamos:** Conceder permissões mínimas necessárias (least privilege), criar roles para serviços AWS acessarem outros serviços, políticas baseadas em recursos (resource-based), cross-account access e auditoria de permissões.

**Exemplo de prova:** Uma função Lambda na conta A precisa ler objetos de um bucket S3 na conta B. Como conceder o acesso corretamente sem criar um usuário IAM com access keys?
→ **Duas etapas:** (1) Na conta B: adicionar uma **bucket policy** no S3 que permite o ARN da role da Lambda na conta A executar `s3:GetObject`. (2) Na conta A: a execution role da Lambda deve ter permissão `s3:GetObject` no bucket da conta B. A Lambda usa suas credenciais temporárias da role — nunca access keys hardcodadas.

---

## Tipos de políticas

| Tipo | Onde é anexada |
|---|---|
| Identity-based | User, Group, Role |
| Resource-based | S3 bucket, SQS queue, Lambda, KMS key |
| Permissions boundary | Limita o máximo de um identity |
| SCP | Conta/OU no Organizations |
| Session policy | Na chamada AssumeRole |

---

## Lógica de avaliação

```
1. Deny explícito → DENY (sempre)
2. SCP nega → DENY
3. Permissions boundary nega → DENY
4. Allow explícito → ALLOW
5. Implicit deny → DENY
```

---

## Elementos da política

```json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "AllowS3Read",
    "Effect": "Allow",
    "Action": ["s3:GetObject"],
    "Resource": "arn:aws:s3:::meu-bucket/*",
    "Condition": {"Bool": {"aws:SecureTransport": "true"}}
  }]
}
```

---

## Roles para serviços

| Serviço | Tipo de role |
|---|---|
| Lambda | Execution Role |
| EC2 | Instance Profile |
| ECS Task | Task Role + Task Execution Role |
| CodeBuild | Service Role |
| CloudFormation | Stack Role |

---

## Trust Policy (para assumir role)

```json
{
  "Statement": [{
    "Effect": "Allow",
    "Principal": {"Service": "lambda.amazonaws.com"},
    "Action": "sts:AssumeRole"
  }]
}
```

---

## Conditions comuns

`aws:SourceIp`, `aws:SecureTransport`, `aws:MultiFactorAuthPresent`, `aws:RequestedRegion`, `aws:CurrentTime`, `s3:prefix`, `dynamodb:LeadingKeys`.

---

## Referências oficiais

- [IAM User Guide](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)
