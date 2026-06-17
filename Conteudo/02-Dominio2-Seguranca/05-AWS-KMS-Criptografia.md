# AWS KMS — Criptografia

> Foco DVA-C02 – Domínio 2: Security

---

## O que é o KMS

AWS Key Management Service gerencia **chaves criptográficas** para criptografia de dados em serviços AWS e aplicações.

---

## Tipos de chaves (KMS Keys)

| Tipo | Descrição | Custo |
|---|---|---|
| **AWS Managed Key** | Criada e gerenciada pela AWS para cada serviço | Gratuita |
| **Customer Managed Key (CMK)** | Criada pelo cliente; controle total de rotação/política | $1/mês + chamadas API |
| **AWS Owned Key** | Gerenciada internamente pela AWS; não visível para o cliente | Gratuita |

---

## Operações principais

| Operação | Uso |
|---|---|
| `Encrypt` | Criptografa até **4 KB** de dados |
| `Decrypt` | Descriptografa dados criptografados pelo KMS |
| `GenerateDataKey` | Gera **data key** em plaintext + ciphertext |
| `GenerateDataKeyWithoutPlaintext` | Só ciphertext (para armazenar sem descriptografar agora) |
| `ReEncrypt` | Recriptografa sem expor plaintext |

---

## Envelope Encryption

Padrão para criptografar **grandes volumes de dados**:

```
1. KMS GenerateDataKey → recebe: plaintext DEK + encrypted DEK
2. Usa plaintext DEK para criptografar os dados localmente
3. Armazena encrypted DEK junto com os dados criptografados
4. Descarta plaintext DEK da memória

Para descriptografar:
1. Envia encrypted DEK para KMS Decrypt → recebe plaintext DEK
2. Usa plaintext DEK para descriptografar os dados
```

- **DEK (Data Encryption Key)**: chave de dados gerada pelo KMS.
- Cada arquivo/objeto pode ter seu próprio DEK.
- KMS **não armazena** o DEK após retorná-lo.

---

## KMS Key Policies

```json
{
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {"AWS": "arn:aws:iam::123456789012:role/MyRole"},
      "Action": ["kms:Decrypt", "kms:GenerateDataKey"],
      "Resource": "*"
    }
  ]
}
```

- Key policy **sempre é necessária** (diferente de políticas IAM puras).
- Sem key policy permitindo, nenhuma policy IAM funciona com a chave.

---

## Integração com serviços AWS

| Serviço | Como usa KMS |
|---|---|
| **S3** | SSE-KMS: criptografia server-side |
| **DynamoDB** | Encryption at rest com CMK |
| **Lambda** | Variáveis de ambiente criptografadas |
| **Secrets Manager** | Criptografia do secret |
| **EBS** | Volumes criptografados |
| **RDS** | Encryption at rest |

---

## Conceitos críticos para a prova ⚠️

- KMS criptografa **no máximo 4 KB** diretamente — para dados maiores, use Envelope Encryption.
- `GenerateDataKey` = usa Envelope Encryption = correto para arquivos grandes.
- Rotação automática de CMK: a cada **1 ano** (opcional).
- KMS é **regional** — chaves não cruzam regiões automaticamente.
- `kms:Decrypt` é necessário tanto na key policy quanto na IAM policy.

---

## Pegadinhas da prova 🎯

- S3 SSE-KMS: cada request usa `kms:GenerateDataKey` e `kms:Decrypt` — pode gerar throttling.
- Usar CMK vs. AWS Managed Key: CMK permite controle de acesso granular e auditoria detalhada.
- `GenerateDataKeyWithoutPlaintext`: útil quando não vai criptografar imediatamente.

---

## Referências oficiais

- [AWS KMS](https://docs.aws.amazon.com/kms/latest/developerguide/overview.html)
- [Envelope encryption](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#enveloping)
- [KMS key policies](https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html)
