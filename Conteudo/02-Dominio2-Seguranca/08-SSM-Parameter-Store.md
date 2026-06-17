# AWS SSM Parameter Store

> Foco DVA-C02 – Domínio 2: Security

---

## O que é

AWS Systems Manager Parameter Store armazena dados de configuração e secrets de forma hierárquica e versionada.

---

## Tipos de parâmetro

| Tipo | Criptografia | Limite | Custo |
|---|---|---|---|
| **String** | Não | 8 KB (Standard) | Gratuito |
| **StringList** | Não | 8 KB | Gratuito |
| **SecureString** | Sim (KMS) | 8 KB | Gratuito (Standard) |

### Tiers
| | Standard | Advanced |
|---|---|---|
| Tamanho máximo | 8 KB | 8 KB |
| Máximo de parâmetros | 10.000 | 100.000 |
| TTL de parâmetro | Não | Sim |
| Notificações (EventBridge) | Não | Sim |
| Custo | Gratuito | $0.05/10K API interactions |

---

## Hierarquia de parâmetros

```
/minha-app/
  prod/
    database/password
    database/username
    api/key
  dev/
    database/password
```

- Navegação por caminhos.
- `GetParametersByPath`: busca todos os parâmetros de um caminho.

```python
import boto3

ssm = boto3.client('ssm')
# Buscar parâmetro único
response = ssm.get_parameter(
    Name='/minha-app/prod/database/password',
    WithDecryption=True  # para SecureString
)
value = response['Parameter']['Value']

# Buscar todos de um path
response = ssm.get_parameters_by_path(
    Path='/minha-app/prod/',
    Recursive=True,
    WithDecryption=True
)
```

---

## SecureString com KMS

- Usa KMS para criptografar o valor.
- Para ler: `WithDecryption=True` + permissão `kms:Decrypt` na execution role.
- Pode usar CMK ou AWS managed key (`alias/aws/ssm`).

---

## Integração com CloudFormation

```yaml
Parameters:
  DBPassword:
    Type: AWS::SSM::Parameter::Value<String>
    Default: /minha-app/prod/database/password
```

---

## Políticas de parâmetro (Advanced tier)

- **Expiration**: deleta automaticamente após data.
- **ExpirationNotification**: notifica antes de expirar.
- **NoChangeNotification**: notifica se não mudou em X dias.

---

## Conceitos críticos para a prova ⚠️

- `WithDecryption=True` é obrigatório para SecureString — sem isso, retorna valor cifrado.
- Parameter Store **não** rota automaticamente — use Secrets Manager para rotação.
- Paths permitem uso de IAM com condição `ssm:name`: `StringLike: /minha-app/*`.
- Lambda pode buscar parâmetros no init phase (fora do handler) para cache.

---

## Pegadinhas da prova 🎯

- Para rotação automática: **Secrets Manager** (não Parameter Store).
- Para configurações simples sem custo: **Parameter Store** (tier Standard).
- `GetParameters` (plural) busca até 10 parâmetros de uma vez.
- Parâmetros do CloudFormation com SSM: o template referencia o **nome** do parâmetro, não o valor.

---

## Referências oficiais

- [SSM Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html)
- [Parameter Store security](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-paramstore-access.html)
- [Parameter hierarchies](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-paramstore-hierarchies.html)
