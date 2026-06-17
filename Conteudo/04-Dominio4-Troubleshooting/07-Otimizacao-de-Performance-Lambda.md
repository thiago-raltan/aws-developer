# Otimização de Performance — Lambda

> Foco DVA-C02 – Domínio 4: Troubleshooting and Optimization

---

## Estratégias de otimização

### 1. Memória e CPU
- CPU é proporcional à memória alocada.
- **Lambda Power Tuning**: ferramenta que testa a função em diferentes configurações de memória.
- Custo = GB × segundos — mais memória + execução mais rápida pode ser mais barato.

```
128 MB × 10s = $X
1024 MB × 1s = $Y  ← pode ser mais barato e mais rápido
```

### 2. Código fora do handler (Execution Context Reuse)

```python
import boto3
import os

# Inicializado UMA VEZ (cold start); reutilizado em warm invocations
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(os.environ['TABLE_NAME'])

# Cache em memória
config_cache = None

def lambda_handler(event, context):
    global config_cache
    if config_cache is None:
        config_cache = carregar_config()  # apenas 1x por container
    # usa config_cache
```

### 3. Conexões de banco de dados
- Inicie conexões **fora do handler**.
- Use **RDS Proxy** para Lambda + RDS (pool de conexões).
- DynamoDB: conexão HTTP, não há problema de pool.

### 4. Pacote de deploy enxuto
- Remova dependências não utilizadas.
- Use Lambda Layers para compartilhar libs.
- Considere container image apenas quando necessário.

### 5. Provisioned Concurrency
- Pré-inicializa N execution environments.
- Elimina cold start para o número provisionado.
- Custo: cobrado por hora + invocação.

### 6. Lambda SnapStart (Java)
- Snapshot do estado após inicialização.
- Restaura snapshot em vez de re-inicializar.
- Reduz cold start de segundos para milissegundos.
- Disponível apenas para Java 11+.

---

## Identificando problemas de performance

| Sintoma | Métrica | Solução |
|---|---|---|
| Execuções lentas | `Duration` alto | Aumentar memória / otimizar código |
| Muitos cold starts | `Init Duration` presente | Provisioned Concurrency |
| Out of memory | `Max Memory Used` = `Memory Size` | Aumentar memória |
| Throttling | `Throttles` > 0 | Aumentar reserved/account concurrency |
| Erros de banco | Logs com timeout | RDS Proxy / otimizar queries |

---

## Análise com CloudWatch Logs Insights

```sql
-- Identificar cold starts
fields @timestamp, @initDuration, @duration
| filter @initDuration > 0
| sort @initDuration desc

-- P99 de latência
fields @duration
| stats pct(@duration, 99) as p99, avg(@duration) as avg by bin(5m)
```

---

## Conceitos críticos para a prova ⚠️

- **Aumentar memória** = solução mais simples para funções lentas por CPU.
- Código fora do handler = reuso de conexões entre invocações quentes.
- `/tmp` persiste entre warm invocations — use para cache de arquivos.
- `INIT_REPORT` linha nos logs indica cold start.

---

## Pegadinhas da prova 🎯

- ProvisionedConcurrency elimina cold start para o número configurado — acima disso, há cold starts normalmente.
- SnapStart com Java: hooks `beforeCheckpoint` / `afterRestore` para re-inicializar recursos.
- Lambda Layers não reduzem cold start por si só — o código ainda é carregado.

---

## Referências oficiais

- [Lambda performance optimization](https://docs.aws.amazon.com/lambda/latest/dg/best-practices.html)
- [Lambda provisioned concurrency](https://docs.aws.amazon.com/lambda/latest/dg/provisioned-concurrency.html)
- [Lambda Power Tuning](https://docs.aws.amazon.com/lambda/latest/dg/best-practices.html)
- [Lambda SnapStart](https://docs.aws.amazon.com/lambda/latest/dg/snapstart.html)
