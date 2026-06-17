# Lambda — Performance e Concorrência

> Foco DVA-C02 – Domínio 1: Development with AWS Services

---

## Concorrência Lambda

### Tipos de concorrência
| Tipo | Descrição |
|---|---|
| **Account concurrency** | Limite total da conta (padrão 1.000, ajustável) |
| **Reserved concurrency** | Reserva N unidades para a função; limita também o máximo |
| **Provisioned concurrency** | Pré-inicializa containers (elimina cold start) |
| **Burst concurrency** | Escala inicial rápida (burst limit por região) |

### Fórmula de concorrência
```
Concorrência = (invocações/s) × (duração média em segundos)
```
Ex: 100 req/s × 2 s = 200 concurrent executions necessárias.

### Reserved vs. Provisioned
| | Reserved | Provisioned |
|---|---|---|
| Elimina cold start | Não | Sim |
| Garante capacidade | Sim | Sim |
| Custo | Sem custo extra | Custo por hora |
| Uso | Isolamento de função | APIs críticas de baixa latência |

---

## Cold Start

### Causa
- Novo container precisa ser inicializado (Init phase).
- Ocorre quando: primeira invocação, após período de inatividade, escalonamento além de containers disponíveis.

### Fatores que aumentam cold start
- Runtime pesado (Java > Python > Node.js).
- Pacote de deploy grande.
- VPC attachment (ENI provisioning).
- Muitas dependências.

### Soluções
1. **Provisioned Concurrency**: pré-aquece N containers.
2. **Lambda SnapStart** (Java 11+): snapshot do estado inicializado.
3. Reduzir tamanho do pacote (zip otimizado).
4. Mover inicializações para fora do handler.

---

## Otimizações de performance

### Código fora do handler (warm invocation)
```python
import boto3
# Inicializado uma vez, reutilizado em warm invocations
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(os.environ['TABLE_NAME'])

def lambda_handler(event, context):
    # table já está pronto
    response = table.get_item(Key={'id': event['id']})
    return response['Item']
```

### Memória e CPU
- Aumentar memória = **mais CPU** proporcional.
- Testar com AWS Lambda Power Tuning (ferramenta open-source).

### /tmp para cache
- Armazene arquivos pesados em `/tmp` (até 10 GB).
- Persiste entre warm invocations.

---

## Throttling e Erros

| Erro | Causa | Solução |
|---|---|---|
| `TooManyRequestsException` (429) | Concorrência excedida | Aumentar limite, usar SQS como buffer |
| `Task timed out` | Execução > timeout configurado | Aumentar timeout, otimizar código |
| `OOMException` | Memória insuficiente | Aumentar memória |
| `ENILimitReached` | Limite de ENIs na VPC | Aumentar IPs disponíveis na subnet |

---

## Conceitos críticos para a prova ⚠️

- **Reserved concurrency = 0** desativa a função (throttles todas as invocações).
- `ThrottleReason: ReservedFunctionConcurrencyExceeded` vs `ConcurrentInvocationLimitExceeded`.
- Lambda SnapStart: disponível apenas para **Java** com runtimes corrigidos.
- Provisioned Concurrency é cobrada por hora, independente de uso.

---

## Pegadinhas da prova 🎯

- Aumentar memória pode reduzir custo total se a função ficar muito mais rápida (custo = GB-s).
- `Reserved concurrency` limita **e** reserva — cuidado ao reservar muito.
- Cold start em VPC: Lambda agora usa **Hyperplane ENIs** (reutilizados entre funções) — problema menos grave que antigamente.

---

## Referências oficiais

- [Lambda concurrency](https://docs.aws.amazon.com/lambda/latest/dg/lambda-concurrency.html)
- [Lambda provisioned concurrency](https://docs.aws.amazon.com/lambda/latest/dg/provisioned-concurrency.html)
- [Lambda SnapStart](https://docs.aws.amazon.com/lambda/latest/dg/snapstart.html)
- [Lambda power tuning](https://docs.aws.amazon.com/lambda/latest/dg/best-practices.html)
