# Containers: ECR, ECS e EKS

> Foco DVA-C02 – Domínio 3: Deployment

---

## Amazon ECR (Elastic Container Registry)

Registro privado de imagens Docker gerenciado.

```bash
# Autenticar, build, tag e push
aws ecr get-login-password | docker login --username AWS --password-stdin ACCOUNT_ID.dkr.ecr.REGION.amazonaws.com
docker build -t minha-app .
docker tag minha-app:latest ACCOUNT_ID.dkr.ecr.REGION.amazonaws.com/minha-app:latest
docker push ACCOUNT_ID.dkr.ecr.REGION.amazonaws.com/minha-app:latest
```

- **Lifecycle policies**: deleta imagens antigas automaticamente.
- **Image scanning**: vulnerabilidades (básico gratuito; enhanced com Inspector).
- **Cross-account**: resource-based policy.
- **Replication**: cross-region e cross-account.

---

## Amazon ECS (Elastic Container Service)

### Conceitos
| Conceito | Descrição |
|---|---|
| **Cluster** | Grupo de capacidade computacional |
| **Task Definition** | Blueprint do container (imagem, CPU, RAM, ports, env vars) |
| **Task** | Instância em execução de uma Task Definition |
| **Service** | Mantém N tasks em execução; integra com ALB |

### Launch Types
| | EC2 | Fargate |
|---|---|---|
| Gerenciamento de servidor | Você gerencia as instâncias | AWS gerencia (serverless) |
| Controle | Total | Limitado |
| Custo | Instâncias alocadas | Por vCPU/GB de memória usados |
| Ideal | Workloads de longa duração, customização | Simplificado, escala automática |

### Task Role vs. Task Execution Role
| | Task Role | Task Execution Role |
|---|---|---|
| Quem usa | Código dentro do container | ECS agent (pull de imagem, logs) |
| Permissões | DynamoDB, S3, etc. | ECR pull, CloudWatch Logs write |

---

## Amazon EKS (Elastic Kubernetes Service)

- Kubernetes gerenciado na AWS.
- Mais complexo que ECS; mais portabilidade (padrão da indústria).
- **Node types**: EC2 self-managed, EC2 managed node groups, Fargate.
- Integra com ALB, NLB via AWS Load Balancer Controller.

---

## ECS com CodeDeploy (Blue/Green)

```
[CodeDeploy] → cria novo task set no ECS
              → direciona tráfego via ALB target groups
              → monitora alarmes CloudWatch
              → troca de BLUE para GREEN
              → termina BLUE
```

---

## Conceitos críticos para a prova ⚠️

- **Fargate**: sem gerenciamento de EC2; paga por vCPU + memória por segundo.
- Task Definition: versões imutáveis; nova versão = novo número.
- ECS Service com ALB: service discovery automático + health checks.
- Secrets no ECS: referencie Secrets Manager ou Parameter Store na Task Definition.
- `awsvpc` network mode: cada task recebe ENI própria (obrigatório no Fargate).

---

## Pegadinhas da prova 🎯

- Fargate **não suporta** todos os network modes — apenas `awsvpc`.
- Task Role ≠ Task Execution Role — são dois IAM roles diferentes.
- ECR token expira em **12 horas** — renove automaticamente em pipelines.
- EKS ≠ ECS: EKS = Kubernetes; ECS = serviço proprietário AWS.

---

## Referências oficiais

- [Amazon ECR](https://docs.aws.amazon.com/AmazonECR/latest/userguide/what-is-ecr.html)
- [Amazon ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html)
- [Amazon EKS](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)
- [ECS task roles](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html)
