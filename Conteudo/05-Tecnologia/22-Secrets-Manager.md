# AWS Secrets Manager — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Serviço para armazenar, gerenciar e rotacionar automaticamente segredos como credenciais de banco de dados, API keys e tokens OAuth. Integra-se nativamente com RDS, Redshift e DocumentDB para rotação automática sem downtime.

**Para que usamos:** Eliminar credenciais hardcodadas no código, rotação automática de senhas de banco de dados, auditoria de acesso a segredos via CloudTrail, compartilhar segredos entre contas AWS de forma segura.

**Exemplo de prova:** Uma Lambda busca credenciais RDS do Secrets Manager a cada invocação. O Secrets Manager rotaciona as credenciais a cada 30 dias. Durante uma rotação, a Lambda começou a retornar erros de autenticação por breve período. Como corrigir?
→ Implementar **cache de segredo na Lambda** com TTL menor que o intervalo de rotação (ex: cache de 5 minutos). Adicionar lógica de **retry**: ao receber `AuthenticationException`, forçar busca do segredo fresco (invalidar cache e chamar `GetSecretValue` novamente). O Secrets Manager mantém a versão anterior (`AWSPREVIOUS`) temporariamente durante a rotação.

---

## Funcionalidades

| Feature | Detalhe |
|---|---|
| Armazenamento | JSON criptografado com KMS |
| Rotação automática | Lambda rotaciona em intervalo configurado |
| Versionamento | AWSCURRENT, AWSPENDING, AWSPREVIOUS |
| Cross-account | Resource-based policy |
| Auditoria | CloudTrail |
| Custo | ~$0.40/secret/mês + $0.05/10K API calls |

---

## SDK

```python
import boto3, json
client = boto3.client('secretsmanager')
secret = json.loads(
    client.get_secret_value(SecretId='minha-app/db')['SecretString']
)
```

---

## Rotação — fases

1. `createSecret`: gera novo valor.
2. `setSecret`: atualiza no serviço destino.
3. `testSecret`: valida o novo valor.
4. `finishSecret`: promove para AWSCURRENT.

---

## Comparativo com Parameter Store

| | Secrets Manager | SSM Parameter Store |
|---|---|---|
| Rotação automática | Sim | Não |
| Custo | Pago | Gratuito (standard) |
| Cross-account | Fácil | Limitado |
| Ideal | Credenciais de DB, API keys | Configurações de app |

---

## Lambda Extension

- Cache local de secrets no execution environment.
- Acesso via `localhost:2773`.
- Reduz latência e custo (menos API calls).

---

## Referências oficiais

- [AWS Secrets Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html)
