# Dados Sensíveis: PII e PHI

> Foco DVA-C02 – Domínio 2: Security

---

## Definições

| Tipo | Exemplos | Regulamento |
|---|---|---|
| **PII** (Personally Identifiable Information) | Nome, CPF, email, endereço, IP | LGPD, GDPR |
| **PHI** (Protected Health Information) | Prontuários, diagnósticos, tratamentos | HIPAA |
| **PCI-DSS** | Dados de cartão de crédito | PCI DSS |

---

## Proteção de PII/PHI na AWS

### Amazon Macie
- Serviço ML para **descoberta e proteção de dados sensíveis** no S3.
- Identifica automaticamente: PII, credenciais, dados financeiros.
- Gera findings no Security Hub e CloudWatch Events.
- Use para auditorias de conformidade.

### S3 Object Lambda (remoção de PII)
- Remove PII dinamicamente durante a leitura.
- Configuração: S3 Access Point → Object Lambda Access Point → Lambda function.
- Usuários com acesso ao Object Lambda Access Point recebem dados sem PII.
- Usuários com acesso ao bucket direto recebem dados completos.

```
[Usuário Interno] → [S3 Bucket direto] → dados completos
[Terceiro]        → [Object Lambda AP] → Lambda remove PII → dados anonimizados
```

---

## Mascaramento e Tokenização

| Técnica | Descrição |
|---|---|
| **Mascaramento** | Substitui parcialmente (ex: `****-****-****-1234`) |
| **Tokenização** | Substitui por token sem relação com original |
| **Pseudoanonimização** | Substitui identificador por pseudônimo reversível |
| **Anonimização** | Irreversível — não é mais PII |

---

## Controle de acesso para PII

### S3 com IAM + Cognito Identity
```json
{
  "Condition": {
    "StringEquals": {
      "s3:prefix": "users/${cognito-identity.amazonaws.com:sub}/"
    }
  }
}
```
- Cada usuário acessa apenas sua pasta no S3.

### DynamoDB com Fine-Grained Access Control
```json
{
  "Condition": {
    "ForAllValues:StringEquals": {
      "dynamodb:LeadingKeys": "${cognito-identity.amazonaws.com:sub}"
    }
  }
}
```
- Usuário acessa apenas itens com seu ID como partition key.

---

## Log de auditoria

- **CloudTrail**: registra quem acessou qual dado e quando.
- **S3 Server Access Logging**: registra cada request ao bucket.
- **CloudWatch Logs**: logs de aplicação.
- Para PHI: logs devem ser protegidos e auditáveis (HIPAA requer).

---

## Conceitos críticos para a prova ⚠️

- S3 Object Lambda = **uma cópia** dos dados + múltiplas views (com/sem PII).
- Amazon Macie = **descoberta automática** de PII no S3.
- Retenção de dados: configure lifecycle policies para deletar PII após período legal.
- Criptografia de PII em repouso: **SSE-KMS** com CMK (permite auditoria granular).

---

## Pegadinhas da prova 🎯

- Macie é **S3-specific** — não analisa DynamoDB ou RDS diretamente.
- Object Lambda Access Point ≠ S3 Access Point (são recursos distintos).
- Para remover PII em resposta a GET do S3: Object Lambda (não event notification).

---

## Referências oficiais

- [Amazon Macie](https://docs.aws.amazon.com/macie/latest/user/what-is-macie.html)
- [S3 Object Lambda](https://docs.aws.amazon.com/AmazonS3/latest/userguide/transforming-objects.html)
- [DynamoDB fine-grained access control](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/specifying-conditions.html)
