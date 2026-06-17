# AWS CodeDeploy

> Foco DVA-C02 – Domínio 3: Deployment

---

## O que é

Serviço gerenciado de deploy que automatiza implantações em **EC2, on-premises, Lambda e ECS**.

---

## Plataformas de deploy

| Plataforma | Estratégias disponíveis |
|---|---|
| **EC2/On-premises** | In-Place, Blue/Green |
| **Lambda** | Canary, Linear, AllAtOnce |
| **ECS** | Canary, Linear, AllAtOnce (Blue/Green com ALB) |

---

## appspec.yml

### Para EC2
```yaml
version: 0.0
os: linux
files:
  - source: /
    destination: /var/www/app
hooks:
  BeforeInstall:
    - location: scripts/stop_server.sh
      timeout: 30
  AfterInstall:
    - location: scripts/install_deps.sh
  ApplicationStart:
    - location: scripts/start_server.sh
  ValidateService:
    - location: scripts/validate.sh
      timeout: 60
```

### Para Lambda
```yaml
version: 0.0
Resources:
  - MyLambdaFunction:
      Type: AWS::Lambda::Function
      Properties:
        Name: MeuFunction
        Alias: prod
        CurrentVersion: "1"
        TargetVersion: "2"
Hooks:
  BeforeAllowTraffic: !Sub arn:aws:lambda:${AWS::Region}:${AWS::AccountId}:function:PreTrafficHook
  AfterAllowTraffic: !Sub arn:aws:lambda:${AWS::Region}:${AWS::AccountId}:function:PostTrafficHook
```

---

## Estratégias Lambda/ECS

| Estratégia | Comportamento |
|---|---|
| `AllAtOnce` | 100% do tráfego de uma vez |
| `Canary10Percent5Minutes` | 10% por 5 min, depois 90% |
| `Canary10Percent30Minutes` | 10% por 30 min, depois 90% |
| `Linear10PercentEvery1Minute` | +10% a cada 1 minuto |
| `Linear10PercentEvery10Minutes` | +10% a cada 10 minutos |

---

## Hooks para EC2 (ordem de execução)

```
ApplicationStop → DownloadBundle → BeforeInstall → Install 
→ AfterInstall → ApplicationStart → ValidateService
```

Para Blue/Green:
```
BeforeBlockTraffic → BlockTraffic → AfterBlockTraffic (no BLUE)
BeforeInstall → ... → ValidateService (no GREEN)
BeforeAllowTraffic → AllowTraffic → AfterAllowTraffic (no GREEN)
```

---

## Rollback automático

- Configurável para: falha no deploy ou falha em alarmes CloudWatch.
- Rollback imediato se `ValidateService` falhar.
- Pode configurar alertas CloudWatch para triggerar rollback.

---

## Conceitos críticos para a prova ⚠️

- `appspec.yml` deve estar na **raiz** do pacote de deploy.
- Agent do CodeDeploy deve estar instalado em instâncias EC2/on-premises.
- Lambda deploy: tráfego desviado via **alias weighted routing**.
- ECS Blue/Green: usa Application Load Balancer para desviar tráfego.
- Deployment group: define onde e como implantar (EC2 tags, ASG, Lambda function).

---

## Pegadinhas da prova 🎯

- On-premises requer **CodeDeploy Agent** + IAM Role com chave de acesso para o servidor.
- Lambda deploy NÃO usa `appspec.yml` para EC2 — tem campos específicos (`CurrentVersion`, `TargetVersion`).
- `AllAtOnce` é mais rápido mas tem downtime potencial para EC2.
- Blue/Green Lambda = alias shifting, não instâncias novas.

---

## Referências oficiais

- [AWS CodeDeploy](https://docs.aws.amazon.com/codedeploy/latest/userguide/welcome.html)
- [appspec.yml reference](https://docs.aws.amazon.com/codedeploy/latest/userguide/reference-appspec-file.html)
- [Lambda deployment strategies](https://docs.aws.amazon.com/codedeploy/latest/userguide/deployment-configurations-lambda.html)
