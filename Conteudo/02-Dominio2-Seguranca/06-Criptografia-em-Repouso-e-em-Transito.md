# Criptografia em Repouso e em Trânsito

> Foco DVA-C02 – Domínio 2: Security

---

## Criptografia em Repouso (At Rest)

Protege dados armazenados contra acesso físico não autorizado.

### Amazon S3
| Método | Gerenciamento da chave |
|---|---|
| **SSE-S3** | AWS gerencia completamente (AES-256) |
| **SSE-KMS** | KMS gerencia; auditável no CloudTrail |
| **SSE-C** | Cliente fornece a chave em cada request |
| **CSE (Client-Side)** | Cliente criptografa antes de enviar |

```bash
# SSE-KMS via CLI
aws s3 cp arquivo.txt s3://bucket/ --sse aws:kms --sse-kms-key-id alias/minha-chave
```

### DynamoDB
- Encryption at rest habilitado por padrão (AWS owned key).
- Pode usar CMK para auditoria via CloudTrail.

### RDS / Aurora
- Habilitado na criação; usa KMS.
- Read replicas e snapshots herdam a configuração de criptografia.
- Para criptografar DB existente: snapshot → copy (with encryption) → restore.

### Lambda (variáveis de ambiente)
- Criptografadas em repouso com KMS por padrão.
- Para criptografia adicional no console: use CMK + `kms:Decrypt` na execution role.

---

## Criptografia em Trânsito (In Transit)

Protege dados durante transferência via TLS/HTTPS.

### API Gateway
- Endpoint HTTPS por padrão; TLS 1.2 mínimo.
- Custom domain: precisa de certificado ACM.

### S3
- `aws:SecureTransport` condition: nega requests HTTP.
```json
{
  "Condition": {"Bool": {"aws:SecureTransport": "false"}},
  "Effect": "Deny",
  "Action": "s3:*",
  "Resource": "*"
}
```

### RDS / Aurora
- SSL/TLS disponível; force com parâmetro de grupo (`require_ssl`).
- Certificado CA disponível para download na AWS.

### ElastiCache Redis
- TLS in-transit disponível (habilitado na criação do cluster).

---

## AWS Certificate Manager (ACM)

- Provisiona e gerencia certificados SSL/TLS.
- **Gratuito** para certificados públicos.
- Integra com: API Gateway, ALB, CloudFront, Elastic Beanstalk.
- **Não pode ser exportado** (apenas integração nativa com serviços AWS).
- Renovação automática.

---

## Conceitos críticos para a prova ⚠️

- S3 SSE-KMS = auditável no CloudTrail; SSE-S3 = não auditável.
- RDS criptografia: não pode ser habilitada em DB existente sem recriação.
- ACM certificado para API Gateway **custom domain**: deve ser criado em **us-east-1** para CloudFront.
- DynamoDB: criptografia em repouso **sempre ativa** (sem opção de desabilitar).

---

## Pegadinhas da prova 🎯

- SSE-C: cliente envia a chave em cada request — AWS não armazena a chave.
- Client-side encryption: AWS nunca vê o dado descriptografado.
- Certificado ACM + CloudFront: **obrigatório** criar o cert em `us-east-1`.

---

## Referências oficiais

- [S3 Server-Side Encryption](https://docs.aws.amazon.com/AmazonS3/latest/userguide/serv-side-encryption.html)
- [DynamoDB encryption at rest](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/EncryptionAtRest.html)
- [AWS Certificate Manager](https://docs.aws.amazon.com/acm/latest/userguide/acm-overview.html)
- [RDS encryption](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.Encryption.html)
