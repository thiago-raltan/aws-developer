# Estratégias de Implantação: Blue/Green, Canário e Contínua

> Foco DVA-C02 – Domínio 3: Deployment

---

## Comparativo de estratégias

| Estratégia | Downtime | Rollback | Risco | AWS Services |
|---|---|---|---|---|
| **In-Place (Rolling)** | Possível | Lento | Médio | CodeDeploy EC2, Beanstalk Rolling |
| **Blue/Green** | Zero | Imediato | Baixo | CodeDeploy, Beanstalk, ECS, Lambda |
| **Canary** | Zero | Imediato | Muito baixo | CodeDeploy Lambda/ECS, Route 53 |
| **Linear** | Zero | Imediato | Baixo | CodeDeploy Lambda/ECS |
| **All at Once** | Sim | Manual | Alto | Beanstalk, CodeDeploy |

---

## Blue/Green Deployment

```
[Load Balancer]
      ↓
  [BLUE — v1.0]  ←── tráfego atual (100%)
  [GREEN — v2.0] ←── novo ambiente (0% tráfego)

Após validação:
      ↓
  [BLUE — v1.0]  ←── standby (0%)
  [GREEN — v2.0] ←── tráfego (100%)
```

- **Rollback**: redirecionar tráfego de volta ao Blue (instantâneo).
- No Elastic Beanstalk: "Swap URLs" entre ambientes.
- No CodeDeploy + ECS: ALB target group routing.
- No Lambda: alias weighted routing.

---

## Canary Deployment

- Envia uma **pequena porcentagem** do tráfego para a nova versão.
- Monitora métricas e alarmes.
- Se OK: redireciona todo o tráfego.
- Se falha: rollback automático.

```
Lambda: Canary10Percent10Minutes
  → 10% para v2 por 10 minutos
  → Se sem erros: 100% para v2
  → Se com erros: volta 100% para v1
```

---

## Linear Deployment

- Incrementa o tráfego gradualmente.
- `Linear10PercentEvery1Minute`: +10% a cada minuto (10 minutos para 100%).

---

## Elastic Beanstalk — Políticas de deploy

| Política | Descrição |
|---|---|
| **All at Once** | Deploy em todas as instâncias simultaneamente; downtime potencial |
| **Rolling** | Deploy em lotes; reduz capacidade temporariamente |
| **Rolling with additional batch** | Mantém capacidade total criando instâncias extras |
| **Immutable** | Novas instâncias em novo ASG; troca completa |
| **Traffic splitting** | Canary: % do tráfego para novas instâncias |
| **Blue/Green** | Swap URLs entre dois ambientes |

---

## Route 53 — Weighted Routing para Canary

```
Record A: v1.app.com → weight 90
Record A: v2.app.com → weight 10
```

- Não é específico de AWS deploy services — aplicável a qualquer stack.

---

## CodeDeploy — Configurações predefinidas

| Configuração | Plataforma | Descrição |
|---|---|---|
| `CodeDeployDefault.AllAtOnce` | EC2/Lambda/ECS | 100% de uma vez |
| `CodeDeployDefault.HalfAtATime` | EC2 | 50% de cada vez |
| `CodeDeployDefault.OneAtATime` | EC2 | 1 instância por vez |
| `CodeDeployDefault.LambdaCanary10Percent5Minutes` | Lambda | 10% por 5 min |
| `CodeDeployDefault.ECSCanary10Percent5Minutes` | ECS | 10% por 5 min |

---

## Conceitos críticos para a prova ⚠️

- Blue/Green = **dois ambientes completos**; Canary = **divisão de tráfego** com rollback automático.
- CodeDeploy + Lambda: usa **alias weighted routing** (não instâncias novas).
- Beanstalk **Blue/Green** requer dois ambientes separados + Swap URLs.
- Beanstalk **Immutable**: mais seguro que Rolling (sem instâncias mistas com versões diferentes).

---

## Pegadinhas da prova 🎯

- Beanstalk "Rolling" pode ter versões mistas por um tempo — evite se consistência é crítica.
- CodeDeploy Canary no Lambda: hooks `BeforeAllowTraffic` e `AfterAllowTraffic` para validação.
- Beanstalk Blue/Green: **troca de URL** (DNS), não de IP — leva tempo de propagação DNS.

---

## Referências oficiais

- [CodeDeploy deployment configurations](https://docs.aws.amazon.com/codedeploy/latest/userguide/deployment-configurations.html)
- [Beanstalk deployment policies](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using-features.rolling-version-deploy.html)
- [Lambda traffic shifting](https://docs.aws.amazon.com/lambda/latest/dg/configuration-aliases.html#configuring-alias-routing)
