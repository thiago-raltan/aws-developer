# Variáveis de Ambiente Seguras

> Foco DVA-C02 – Domínio 2: Security

---

## Variáveis de ambiente no Lambda

- Armazenadas junto com a configuração da função.
- **Criptografadas em repouso** com KMS automaticamente.
- Disponíveis no código via `os.environ['VAR_NAME']`.
- Limite: 4 KB total.

### Criptografia adicional (console)

1. Habilitar "Enable helpers for encryption in transit".
2. Selecionar CMK.
3. Código adiciona chamada `kms.decrypt()` ao ler a variável.

```python
import boto3
import base64
import os

def get_secret():
    encrypted = os.environ['DB_PASSWORD']
    kms = boto3.client('kms')
    return kms.decrypt(
        CiphertextBlob=base64.b64decode(encrypted)
    )['Plaintext'].decode()
```

---

## Práticas recomendadas por serviço

### Lambda
- Use **Parameter Store ou Secrets Manager** para secrets.
- Variáveis de ambiente: apenas configurações não sensíveis (região, nome da tabela, ARNs).
- **Nunca** coloque credenciais IAM em variáveis de ambiente.

### EC2 / ECS
- **Instance Profile / Task Role**: credenciais AWS gerenciadas automaticamente.
- Secrets: use Secrets Manager ou Parameter Store SecureString.
- **Nunca** use variáveis de ambiente de sistema operacional para secrets em produção.

### CodeBuild
- `buildspec.yml` pode referenciar Parameter Store e Secrets Manager.
- **Secrets no buildspec não devem ser hardcoded**.

```yaml
env:
  secrets-manager:
    DB_PASSWORD: arn:aws:secretsmanager:us-east-1:123456789012:secret:db-password
  parameter-store:
    API_KEY: /minha-app/prod/api-key
```

---

## Princípio do Menor Privilégio (Least Privilege)

- Conceda apenas as permissões **mínimas necessárias**.
- Use **resource-level permissions** sempre que possível (ARN específico, não `*`).
- Revise regularmente políticas com **IAM Access Analyzer**.
- Prefira **roles** a usuários IAM com access keys.

---

## Rotação e revogação

| Cenário | Ação recomendada |
|---|---|
| Credencial comprometida | Revogar imediatamente + CloudTrail audit |
| Rotação periódica | Secrets Manager automática |
| Acesso temporário | STS AssumeRole com duração limitada |
| Auditoria de uso | CloudTrail + IAM Access Advisor |

---

## Conceitos críticos para a prova ⚠️

- Lambda execução: credenciais vêm do **execution role** automaticamente — nunca hardcode.
- Variáveis de ambiente Lambda: limite de **4 KB** total.
- `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY` no Lambda = credenciais do execution role temporárias.
- Armazenar secrets no código ou repositório Git = **vulnerabilidade grave**.

---

## Pegadinhas da prova 🎯

- CodeBuild com `env.secrets-manager`: usa Secrets Manager nativamente no buildspec.
- Para passar secrets para container ECS: use **Secrets Manager** referenciado na task definition.
- Lambda Layer não é lugar para armazenar secrets (é código versionado e distribuído).

---

## Referências oficiais

- [Lambda environment variables](https://docs.aws.amazon.com/lambda/latest/dg/configuration-envvars.html)
- [CodeBuild environment variables](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-env-vars.html)
- [IAM best practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)
