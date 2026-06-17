# AWS KMS — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Serviço gerenciado de criação e controle de chaves de criptografia. Integrado nativamente a dezenas de serviços AWS para criptografar dados em repouso e em trânsito, com controle de acesso granular via Key Policies e auditoria completa.

**Para que usamos:** Criptografar dados no S3 (SSE-KMS), DynamoDB, RDS, EBS, Secrets Manager; implementar envelope encryption na aplicação com `GenerateDataKey`; controle de quem pode criptografar/descriptografar dados sensíveis.

**Exemplo de prova:** Uma auditoria de segurança exige um relatório completo de quem descriptografou dados sensíveis armazenados no S3 com SSE-KMS, incluindo identidade, horário e IP de origem. Onde obter essas informações?
→ No **AWS CloudTrail**: toda chamada à API `kms:Decrypt` é registrada automaticamente com `userIdentity`, `eventTime`, `sourceIPAddress` e `requestParameters`. O CloudWatch Logs não captura chamadas KMS por padrão. CloudTrail é a fonte oficial de auditoria de API calls.

---

## Tipos de chave

| Tipo | Gerenciamento | Custo | Auditável |
|---|---|---|---|
| AWS Owned Key | AWS | Gratuito | Não |
| AWS Managed Key | AWS (para o serviço) | Gratuito | Sim (limitado) |
| Customer Managed Key (CMK) | Cliente | $1/mês + API calls | Sim (completo) |

---

## Operações principais

| API | Limite de dados | Uso |
|---|---|---|
| `Encrypt` | 4 KB | Criptografar dados pequenos |
| `Decrypt` | 4 KB | Descriptografar |
| `GenerateDataKey` | — | Envelope encryption (retorna plaintext + encrypted DEK) |
| `GenerateDataKeyWithoutPlaintext` | — | Só encrypted DEK |
| `ReEncrypt` | — | Troca de chave sem expor plaintext |

---

## Envelope Encryption (para dados > 4 KB)

```
1. GenerateDataKey → plaintext DEK + encrypted DEK
2. Criptografa dados com plaintext DEK (localmente)
3. Armazena encrypted DEK junto com dados
4. Descarta plaintext DEK

Descriptografar:
1. KMS.Decrypt(encrypted DEK) → plaintext DEK
2. Descriptografa dados com plaintext DEK
```

---

## Integrações AWS

S3 (SSE-KMS), DynamoDB, RDS, Lambda (env vars), Secrets Manager, EBS, EFS, CloudTrail logs.

---

## Key Policy

- **Obrigatória** — sem key policy, IAM policies não concedem acesso.
- Deve incluir Account root para administração.

---

## Limites e notas

- KMS é **regional** — chaves não cruzam regiões.
- Rotação automática: 1 ano (somente CMK, opcional).
- Chave excluída: espera de 7–30 dias (cancelável no período).

---

## Referências oficiais

- [AWS KMS](https://docs.aws.amazon.com/kms/latest/developerguide/overview.html)
