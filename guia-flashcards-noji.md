# Guia — Criar e Importar Flashcards no Noji (DVA-C02)

## 1. Formato do CSV

O Noji aceita CSV com duas colunas: **frente** e **verso**.

```
frente,verso
"O que é o AWS Lambda?","Serviço de computação serverless que executa código em resposta a eventos sem provisionar servidores."
```

**Regras:**
- Separador: vírgula `,`
- Valores com vírgula ou quebra de linha devem estar entre aspas duplas `"`
- Encoding: **UTF-8**
- Sem cabeçalho obrigatório (mas pode incluir)

---

## 2. Como importar no Noji

1. Acesse [noji.io](https://noji.io) ou abra o app
2. Crie um novo baralho (deck)
3. Dentro do deck → botão **"+"** → **Importar**
4. Selecione o arquivo `.csv`
5. Mapeie as colunas (frente / verso)
6. Confirme a importação

---

## 3. Plano de geração dos CSVs

Gerar um CSV por domínio para facilitar a organização em decks separados:

| Arquivo CSV | Domínio | Cards |
|-------------|---------|-------|
| `flashcards-dominio1-desenvolvimento.csv` | Desenvolvimento com serviços AWS (32%) | ~60 |
| `flashcards-dominio2-seguranca.csv` | Segurança (26%) | ~40 |
| `flashcards-dominio3-implantacao.csv` | Implantação (24%) | ~40 |
| `flashcards-dominio4-troubleshooting.csv` | Solução de problemas e otimização (18%) | ~30 |

**Total estimado:** ~170 cards

---

## 4. Tipos de perguntas a gerar

- **Conceitual:** "O que é X?" / "Para que serve Y?"
- **Comparativo:** "Qual a diferença entre X e Y?"
- **Decisão:** "Quando usar X em vez de Y?"
- **Configuração:** "Quais parâmetros configuram X no Lambda?"
- **Cenário:** "Uma aplicação precisa de X — qual serviço usar?"

---

## 5. Tópicos prioritários por peso no exame

### Domínio 1 — Desenvolvimento (32%)
- [ ] Lambda: configuração, ciclo de vida, destinos, DLQ
- [ ] DynamoDB: chaves de partição, GSI, LSI, Query vs Scan, consistência
- [ ] SQS vs SNS vs EventBridge: quando usar cada um
- [ ] Kinesis: streams, shards, consumidores
- [ ] API Gateway: tipos de integração, estágios, authorizers
- [ ] S3: eventos, lifecycle, presigned URLs
- [ ] SDK/CLI: autenticação, paginação, retry

### Domínio 2 — Segurança (26%)
- [ ] IAM: roles, policies, trust policy, permission boundary
- [ ] Cognito: User Pools vs Identity Pools
- [ ] KMS: CMK, envelope encryption, key rotation
- [ ] Secrets Manager vs SSM Parameter Store
- [ ] STS: AssumeRole, tokens temporários
- [ ] Criptografia: client-side vs server-side (SSE-S3, SSE-KMS, SSE-C)

### Domínio 3 — Implantação (24%)
- [ ] CodePipeline: estágios, ações, artefatos
- [ ] CodeBuild: buildspec.yml, variáveis de ambiente
- [ ] CodeDeploy: appspec.yml, estratégias (in-place, blue/green)
- [ ] CloudFormation: recursos, parâmetros, outputs, cross-stack
- [ ] AWS SAM: template.yaml, sam build, sam deploy
- [ ] Estratégias: canário, azul/verde, rolling, all-at-once
- [ ] Elastic Beanstalk: deployment policies, .ebextensions

### Domínio 4 — Troubleshooting (18%)
- [ ] CloudWatch: métricas, logs, alarmes, dashboards, EMF
- [ ] X-Ray: traces, segments, subsegments, anotações
- [ ] Lambda: cold start, timeout, throttling, erros de memória
- [ ] API Gateway: erros 4xx vs 5xx, logs de acesso
- [ ] CloudTrail: eventos de gerenciamento vs dados

---

## 6. Próximos passos

- [ ] Gerar `flashcards-dominio1-desenvolvimento.csv`
- [ ] Gerar `flashcards-dominio2-seguranca.csv`
- [ ] Gerar `flashcards-dominio3-implantacao.csv`
- [ ] Gerar `flashcards-dominio4-troubleshooting.csv`
- [ ] Criar os 4 decks no Noji
- [ ] Importar cada CSV no deck correspondente
- [ ] Iniciar revisão com repetição espaçada
