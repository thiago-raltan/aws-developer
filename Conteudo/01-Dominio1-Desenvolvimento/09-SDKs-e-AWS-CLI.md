# AWS SDKs e AWS CLI

> Foco DVA-C02 – Domínio 1: Development with AWS Services

---

## AWS CLI

Ferramenta de linha de comando para interagir com a AWS.

### Configuração
```bash
aws configure
# AWS Access Key ID: AKIA...
# AWS Secret Access Key: ...
# Default region: us-east-1
# Default output format: json
```

Armazenamento: `~/.aws/credentials` e `~/.aws/config`.

### Perfis (Profiles)
```bash
aws configure --profile dev
aws s3 ls --profile dev
```

### Variáveis de ambiente (sobrepõem o config)
```bash
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
export AWS_SESSION_TOKEN=...       # Para roles assumidas
export AWS_DEFAULT_REGION=us-east-1
```

### Cadeia de resolução de credenciais
1. Variáveis de ambiente
2. Perfis CLI/SDK (`~/.aws/credentials`)
3. AWS SSO
4. Container credentials (ECS)
5. **Instance Profile (EC2/Lambda)** ← mais seguro em produção

---

## AWS SDKs

Disponíveis para: Python (boto3), JavaScript, Java, Go, .NET, Ruby, PHP, C++, Rust.

### Python (boto3)
```python
import boto3

# Client: baixo nível, acesso a toda a API
s3_client = boto3.client('s3', region_name='us-east-1')
response = s3_client.list_buckets()

# Resource: alto nível, orientado a objetos
s3 = boto3.resource('s3')
bucket = s3.Bucket('meu-bucket')
```

### Paginação
```python
paginator = s3_client.get_paginator('list_objects_v2')
for page in paginator.paginate(Bucket='meu-bucket'):
    for obj in page['Contents']:
        print(obj['Key'])
```

### Waiter
```python
waiter = ec2_client.get_waiter('instance_running')
waiter.wait(InstanceIds=['i-1234567890abcdef0'])
```

---

## Conceitos críticos para a prova ⚠️

- **Cadeia de credenciais**: variáveis de ambiente > perfil > container > instance profile.
- Em Lambda: credenciais vêm automaticamente da **execution role** — nunca hardcode.
- Nunca armazene credenciais em código ou em variáveis de ambiente do Lambda sem criptografia.
- `AWS_SESSION_TOKEN` é obrigatório quando usando credenciais temporárias (STS AssumeRole).
- **Retry automático**: SDK faz retry automático para erros transientes (5xx, ThrottlingException).

---

## Pegadinhas da prova 🎯

- `boto3.client` vs `boto3.resource`: client = acesso completo à API; resource = abstração de alto nível.
- Paginação é **obrigatória** para respostas grandes (DynamoDB Scan, S3 ListObjects).
- `AWS_DEFAULT_REGION` vs `AWS_REGION`: em Lambda, `AWS_REGION` está disponível.
- Profile no container ECS: usar **Task Role**, não credenciais de usuário IAM.

---

## Referências oficiais

- [AWS CLI User Guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)
- [boto3 Documentation](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html)
- [Credential provider chain](https://docs.aws.amazon.com/sdkref/latest/guide/standardized-credentials.html)
