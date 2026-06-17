# AWS Secrets Manager

> Foco DVA-C02 – Domínio 2: Security

---

## O que é

Serviço gerenciado para armazenar, recuperar e **rotacionar automaticamente** secrets (senhas, API keys, tokens, credenciais de banco).

---

## Funcionalidades principais

| Feature | Descrição |
|---|---|
| **Armazenamento** | JSON criptografado com KMS |
| **Rotação automática** | Lambda executa rotação em intervalo configurado |
| **Cross-account** | Resource-based policy para acesso de outras contas |
| **Auditoria** | Integrado com CloudTrail |
| **Versionamento** | `AWSCURRENT`, `AWSPENDING`, `AWSPREVIOUS` |

---

## Rotação automática

```
[Secrets Manager] → agenda rotação → [Lambda rotation function]
                                        ↓
                                   1. createSecret (gera novo)
                                   2. setSecret (atualiza no serviço)
                                   3. testSecret (verifica novo)
                                   4. finishSecret (promove AWSCURRENT)
```

- Suporte nativo para: RDS, Redshift, DocumentDB, outros via Lambda customizada.
- `rotation_lambda_arn` define qual Lambda executa a rotação.

---

## Acesso via SDK

```python
import boto3
import json

client = boto3.client('secretsmanager')
response = client.get_secret_value(SecretId='minha-app/db-password')
secret = json.loads(response['SecretString'])
password = secret['password']
```

---

## Resource-based policy (cross-account)

```json
{
  "Statement": [{
    "Effect": "Allow",
    "Principal": {"AWS": "arn:aws:iam::987654321098:role/AppRole"},
    "Action": "secretsmanager:GetSecretValue",
    "Resource": "*"
  }]
}
```

---

## Comparativo: Secrets Manager vs. Parameter Store

| | Secrets Manager | SSM Parameter Store |
|---|---|---|
| Rotação automática | ✅ Nativa | ❌ Manual (Lambda) |
| Cross-account | ✅ Nativo | ❌ Limitado |
| Custo | ~$0.40/secret/mês | Gratuito (Standard) ou $0.05/10K ops (Advanced) |
| Tamanho máximo | 64 KB | 8 KB (Standard) / 8 KB (Advanced) |
| Hierarquia | Não | Sim (`/app/env/key`) |
| Versionamento | Sim (labels) | Sim (número) |
| Ideal | Credentials de banco, API keys com rotação | Configurações, flags de feature, parâmetros |

---

## Conceitos críticos para a prova ⚠️

- Secrets Manager é **preferido** quando há necessidade de **rotação automática**.
- Custo: Secrets Manager é pago; Parameter Store tem tier gratuito.
- Integração Lambda: use **cache** do SDK ou Lambda Extension para evitar chamadas desnecessárias.
- `AWSPENDING`: versão que está sendo rotacionada; `AWSCURRENT`: versão atual.

---

## Pegadinhas da prova 🎯

- Parameter Store SecureString **não rota automaticamente** — use Secrets Manager para rotação.
- Acesso cross-account: Secrets Manager tem resource policy nativa; Parameter Store requer configuração adicional.
- Se o custo for mencionado na questão e não precisar de rotação: **Parameter Store** é a resposta.

---

## Referências oficiais

- [AWS Secrets Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html)
- [Secrets Manager rotation](https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotating-secrets.html)
- [Secrets Manager vs Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html)
