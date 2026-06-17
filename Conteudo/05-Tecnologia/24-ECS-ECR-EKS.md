# ECS, ECR e EKS — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Trio de serviços de containers: **ECR** (registry privado para imagens Docker com scan de vulnerabilidades), **ECS** (orquestrador de containers gerenciado com Fargate serverless ou EC2), **EKS** (Kubernetes gerenciado para times com expertise em K8s).

**Para que usamos:** Rodar microsserviços em containers com escala automática; ECR como repositório seguro de imagens no CI/CD; ECS Fargate para containers serverless sem gerenciar instâncias EC2; EKS para workloads que já usam Kubernetes.

**Exemplo de prova:** Uma Task Definition ECS Fargate precisa acessar credenciais armazenadas no Secrets Manager em tempo de execução, sem expor os valores como texto puro na definição da task. Como injetar o segredo de forma segura?
→ Na Task Definition, usar o campo **`secrets`** no `containerDefinitions`, mapeando o nome da variável de ambiente para o **ARN do segredo** no Secrets Manager (ou SSM Parameter Store). A **Task Role** deve ter `secretsmanager:GetSecretValue`. O ECS injeta o valor automaticamente como variável de ambiente no start do container — nunca armazenado em texto puro.

---

## ECR

```bash
# Login
aws ecr get-login-password | docker login --username AWS --password-stdin ACCOUNT.dkr.ecr.REGION.amazonaws.com
# Push
docker build -t ACCOUNT.dkr.ecr.REGION.amazonaws.com/minha-app:latest .
docker push ACCOUNT.dkr.ecr.REGION.amazonaws.com/minha-app:latest
```
- Token válido: **12 horas**.
- Lifecycle policies: limpar imagens antigas.
- Image scanning: vulnerabilidades.

---

## ECS — Componentes

`Cluster → Service → Task → Container`

| | EC2 Launch Type | Fargate |
|---|---|---|
| Servidor | Você gerencia | AWS gerencia |
| Network mode | bridge, host, awsvpc | awsvpc (obrigatório) |
| Custo | Por instância | Por vCPU + GB/s |

---

## Roles ECS

| Role | Quem usa | Permissões |
|---|---|---|
| **Task Role** | Código no container | DynamoDB, S3, etc. |
| **Task Execution Role** | ECS agent | ECR pull, CloudWatch Logs |

---

## Secrets no ECS

```json
"Secrets": [
  {
    "Name": "DB_PASSWORD",
    "ValueFrom": "arn:aws:secretsmanager:...:secret:db-pass"
  }
]
```
Referência no Task Definition — injetado como variável de ambiente.

---

## EKS

- Kubernetes gerenciado pela AWS.
- Node types: managed node groups, self-managed, Fargate.
- Integração nativa com ALB (AWS Load Balancer Controller).

---

## Referências oficiais

- [Amazon ECR](https://docs.aws.amazon.com/AmazonECR/latest/userguide/what-is-ecr.html)
- [Amazon ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html)
- [Amazon EKS](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)
