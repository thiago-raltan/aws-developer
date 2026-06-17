# AWS AppConfig

> Foco DVA-C02 – Domínio 3: Deployment

---

## O que é

Serviço para gerenciar e implantar **configurações de aplicação** de forma segura e controlada.

Casos de uso:
- Feature flags (ligar/desligar funcionalidades sem redeploy).
- Configurações de runtime.
- Parâmetros de aplicação.

---

## Componentes

```
Application
    └── Environment (prod, dev)
            └── Configuration Profile (fonte da config)
                        └── Deployment Strategy (como implantar)
```

| Componente | Descrição |
|---|---|
| **Application** | Container lógico |
| **Environment** | prod, staging, dev |
| **Configuration Profile** | Fonte: SSM Parameter Store, S3, AppConfig hosted |
| **Deployment Strategy** | Velocidade de rollout; validators |

---

## Deployment Strategies predefinidas

| Estratégia | Duração | Crescimento |
|---|---|---|
| `AppConfig.AllAtOnce` | Imediato | 100% |
| `AppConfig.Linear50PercentEvery30Seconds` | 1 min | 50% a cada 30s |
| `AppConfig.Canary10Percent20Minutes` | 21 min | 10% → 100% |

---

## Validação de configuração

- **JSON Schema validator**: valida formato antes de implantar.
- **Lambda validator**: validação customizada (ex: regras de negócio).

---

## Integração com Lambda

```python
import boto3
import json

appconfig = boto3.client('appconfigdata')

# Iniciar sessão de configuração
session = appconfig.start_configuration_session(
    ApplicationIdentifier='minha-app',
    EnvironmentIdentifier='prod',
    ConfigurationProfileIdentifier='feature-flags',
    RequiredMinimumPollIntervalInSeconds=30
)

# Buscar configuração
response = appconfig.get_latest_configuration(
    ConfigurationToken=session['InitialConfigurationToken']
)
config = json.loads(response['Configuration'].read())
feature_habilitada = config.get('nova_feature', False)
```

**Melhor prática**: use a **Lambda Extension** do AppConfig para cache local.

---

## Lambda Extension AppConfig

- Roda como processo separado no execution environment.
- Faz cache da configuração localmente.
- Lambda acessa via `localhost:2772` (HTTP).
- Reduz latência e custo (menos chamadas à API).

```python
import urllib.request

def get_config():
    url = 'http://localhost:2772/applications/minha-app/environments/prod/configurations/feature-flags'
    return json.loads(urllib.request.urlopen(url).read())
```

---

## Conceitos críticos para a prova ⚠️

- AppConfig = **feature flags e configurações** dinâmicas sem redeploy.
- Rollback automático se validator falhar ou alarme CloudWatch disparar.
- Lambda Extension: cache local evita chamada à API a cada invocação.
- Diferente do SSM Parameter Store: AppConfig tem rollout controlado e validação.

---

## Pegadinhas da prova 🎯

- AppConfig ≠ Secrets Manager: AppConfig é para configurações, não credenciais.
- Configuration Profile pode usar SSM Parameter Store como fonte.
- Lambda Extension AppConfig: cache é renovado automaticamente segundo TTL configurado.

---

## Referências oficiais

- [AWS AppConfig](https://docs.aws.amazon.com/appconfig/latest/userguide/what-is-appconfig.html)
- [AppConfig Lambda extension](https://docs.aws.amazon.com/appconfig/latest/userguide/appconfig-integration-lambda-extensions.html)
- [AppConfig deployment strategies](https://docs.aws.amazon.com/appconfig/latest/userguide/appconfig-creating-deployment-strategy.html)
