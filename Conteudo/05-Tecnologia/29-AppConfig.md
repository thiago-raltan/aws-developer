# AWS AppConfig — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Serviço para criar, gerenciar, validar e implantar configurações de aplicação de forma separada do código. Permite rollout gradual de mudanças de configuração com validação via JSON Schema ou Lambda, e rollback automático em caso de alarme.

**Para que usamos:** Feature flags (ativar/desativar funcionalidades sem redeploy), configurações dinâmicas de comportamento da aplicação, rollout gradual de configurações novas para um percentual de instâncias/ambientes, experimentos A/B controlados.

**Exemplo de prova:** Uma equipe quer ativar gradualmente uma nova feature apenas para 10% dos usuários, sem fazer novo deploy da Lambda e com a possibilidade de reverter imediatamente se houver aumento de erros. Como implementar?
→ Armazenar um **feature flag** no AppConfig (ex: `{"novaFeature": true, "percentual": 10}`). A Lambda busca a configuração com cache local (TTL de 30s–5min usando o **AppConfig Lambda Extension**). Configurar um **deployment strategy** gradual no AppConfig com alarme CloudWatch vinculado — se os erros aumentarem, o AppConfig faz rollback automático da configuração, sem redeploy da função.

---

## Componentes

```
Application → Environment (prod/dev) → Configuration Profile
                                              ↓
                                      Deployment Strategy
```

---

## Fontes de configuração (Configuration Profile)

- AppConfig hosted configuration (JSON/YAML/texto).
- SSM Parameter Store.
- S3 bucket.

---

## Deployment Strategies

| Estratégia | Rollout |
|---|---|
| AllAtOnce | 100% imediato |
| Linear50PercentEvery30Seconds | 50% a cada 30s |
| Canary10Percent20Minutes | 10% + 100% após 20 min |

---

## Validação

- **JSON Schema**: valida estrutura.
- **Lambda**: validação de regras de negócio.

---

## Lambda Extension

- Cache local em `localhost:2772`.
- Renovação automática por TTL.
- Sem chamada API por invocação.

```python
import urllib.request
config = json.loads(
    urllib.request.urlopen(
        'http://localhost:2772/applications/app/environments/prod/configurations/flags'
    ).read()
)
```

---

## Rollback automático

- Alarme CloudWatch dispara → rollback.
- Validação falha → deploy cancelado.

---

## Referências oficiais

- [AWS AppConfig](https://docs.aws.amazon.com/appconfig/latest/userguide/what-is-appconfig.html)
