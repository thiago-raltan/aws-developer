# AWS CodeDeploy — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Serviço que automatiza implantações de código em EC2, instâncias on-premises, funções Lambda e serviços ECS. Oferece controle granular sobre a estratégia de rollout do tráfego e rollback automático baseado em alarmes.

**Para que usamos:** Implantações com zero downtime usando Blue/Green ou estratégias Canary/Linear, rollback automático acionado por alarmes CloudWatch, hooks de validação antes e depois da troca de tráfego.

**Exemplo de prova:** Um deploy de uma nova versão Lambda com CodeDeploy deve redirecionar 10% do tráfego para a nova versão, aguardar 10 minutos e, se não houver erros (monitorado por alarme CloudWatch), migrar os 90% restantes automaticamente. Qual configuração usar?
→ Estratégia de deployment: **`Canary10Percent10Minutes`** (configuração pré-definida). Requer: alias Lambda com pesos configurados; `appspec.yml` com `Hooks` definindo funções de validação nos eventos `BeforeAllowTraffic` e `AfterAllowTraffic`; alarme CloudWatch vinculado ao deployment para rollback automático em caso de erro.

---

## Plataformas

EC2/On-premises, Lambda, ECS.

---

## appspec.yml — EC2

```yaml
version: 0.0
os: linux
files:
  - source: /
    destination: /var/www/app
hooks:
  BeforeInstall: [script.sh]
  AfterInstall: [script.sh]
  ApplicationStart: [script.sh]
  ValidateService: [script.sh]
```

Ordem hooks EC2: `ApplicationStop → DownloadBundle → BeforeInstall → Install → AfterInstall → ApplicationStart → ValidateService`

---

## Configurações Lambda/ECS

| Configuração | Comportamento |
|---|---|
| `AllAtOnce` | 100% de uma vez |
| `Canary10Percent5Minutes` | 10% por 5 min, depois 100% |
| `Canary10Percent30Minutes` | 10% por 30 min, depois 100% |
| `Linear10PercentEvery1Minute` | +10%/min (10 min total) |
| `Linear10PercentEvery10Minutes` | +10%/10min (100 min total) |

---

## Rollback automático

- Falha no deploy.
- Alarme CloudWatch disparado.
- Configurável por deployment group.

---

## Hooks Lambda

`BeforeAllowTraffic` → troca de tráfego → `AfterAllowTraffic`

---

## Referências oficiais

- [AWS CodeDeploy](https://docs.aws.amazon.com/codedeploy/latest/userguide/welcome.html)
