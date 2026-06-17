# Prova Marek 01 — AWS Certified Developer Associate

> **65 questões** | Domínios: Development with AWS Services · Security · Deployment · Troubleshooting and Optimization

---

## Pergunta 1 · Domínio: Troubleshooting and Optimization

Uma empresa quer melhorar a performance de seu popular serviço de API que oferece acesso de leitura não autenticado a informações estatísticas atualizadas diariamente via Amazon API Gateway e AWS Lambda.

**Quais medidas a empresa pode tomar?**

- A. Configurar usage plans e API keys no API Gateway
- B. **Habilitar API caching no API Gateway** ✅
- C. Configurar o API Gateway para usar Gateway VPC Endpoint
- D. Configurar o API Gateway para usar ElastiCache for Memcached

**Resposta: B**

**Explicação:**
API Gateway fornece cache de respostas para reduzir o número de chamadas ao endpoint e melhorar a latência das requisições. Habilitar API caching é a abordagem correta para esse caso.

- A está errada: usage plans controlam throttling e cotas, não melhoram diretamente a responsividade.
- C está errada: Gateway VPC Endpoints conectam a S3 e DynamoDB, não melhoram latência da API.
- D está errada: ElastiCache for Memcached é um serviço downstream e não se integra diretamente ao API Gateway para cache de respostas.

---

## Pergunta 2 · Domínio: Security

Qual das alternativas melhor descreve como a criptografia do KMS funciona?

- A. O KMS gera uma nova CMK para cada chamada Encrypt e criptografa os dados com ela
- B. O KMS recebe a CMK do cliente a cada chamada Encrypt e criptografa os dados com ela
- C. **O KMS armazena a CMK e recebe os dados dos clientes, que ele criptografa e retorna** ✅
- D. O KMS envia a CMK ao cliente, que realiza a criptografia e depois a deleta

**Resposta: C**

**Explicação:**
O KMS armazena a CMK (Customer Master Key) e realiza a criptografia internamente. O cliente envia os dados ao KMS, que os criptografa e devolve o resultado.

- A está errada: KMS não gera uma CMK nova a cada chamada.
- B está errada: CMKs importadas são configuradas uma vez, não enviadas em cada chamada.
- D está errada: KMS nunca envia a CMK ao cliente.

---

## Pergunta 3 · Domínio: Deployment

Uma equipe de desenvolvimento quer criar uma aplicação usando arquitetura serverless. Os desenvolvedores trabalham com Python, .NET e Javascript. A equipe quer modelar a infraestrutura de nuvem usando qualquer uma dessas linguagens de programação.

**Qual serviço/ferramenta AWS a equipe deve usar?**

- A. AWS CloudFormation
- B. AWS Serverless Application Model (SAM)
- C. AWS CodeDeploy
- D. **AWS Cloud Development Kit (CDK)** ✅

**Resposta: D**

**Explicação:**
O AWS CDK permite definir infraestrutura usando linguagens de programação como Python, JavaScript/TypeScript, Java e .NET.

- A está errada: CloudFormation usa JSON/YAML, não linguagens de programação diretamente.
- B está errada: SAM usa sintaxe declarativa em YAML.
- C está errada: CodeDeploy é um serviço de implantação, não de modelagem de infraestrutura.

---

## Pergunta 4 · Domínio: Security

A equipe de desenvolvimento usa Lambda via API Gateway, acessível por qualquer pessoa. O líder da equipe quer controle de acesso usando um **mecanismo de autorização de terceiros**.

**Qual opção você recomendaria?**

- A. API Gateway User Pools
- B. Cognito User Pools
- C. **Lambda Authorizer** ✅
- D. Permissões IAM com sigv4

**Resposta: C**

**Explicação:**
Um Lambda Authorizer é uma função Lambda que controla acesso à API, suportando bearer token (OAuth, SAML) — ideal para mecanismos de terceiros.

- A está errada: "API Gateway User Pools" não existe.
- B está errada: Cognito é gerenciado pela AWS, não é autenticação de terceiros.
- D está errada: sigv4 é autenticação nativa AWS.

---

## Pergunta 5 · Domínio: Development with AWS Services

AZ1 tem 2 instâncias e AZ2 tem 8 instâncias. O ELB tem **cross-zone load balancing** habilitado.

**Qual percentual de tráfego cada instância no AZ1 receberá?**

- A. **10%** ✅
- B. 20%
- C. 25%
- D. 15%

**Resposta: A**

**Explicação:**
Com cross-zone load balancing habilitado, o tráfego é distribuído igualmente entre todos os 10 instances. Cada instância recebe **10%**.

- C seria a resposta se cross-zone estivesse desabilitado: cada AZ recebe 50%, os 2 instances do AZ1 = 25% cada.

---

## Pergunta 6 · Domínio: Development with AWS Services

A região padrão é us-east-1. Você quer executar um comando para parar uma EC2 em **us-east-2**.

**Qual é a solução MAIS otimizada?**

- A. **Usar o parâmetro `--region`** ✅
- B. Usar injeção de dependência com boto3
- C. Substituir a região padrão usando `aws configure`
- D. Criar um novo IAM user apenas para essa outra região

**Resposta: A**

**Explicação:**
O parâmetro `--region` executa o comando em uma região diferente da padrão sem alterar configurações globais.

- C está errada: mudaria a região padrão para todos os comandos.
- D está errada: desnecessário e aumenta complexidade.
- B está errada: boto3 é SDK Python, não CLI.

---

## Pergunta 7 · Domínio: Security

O manager quer acesso a pastas específicas por usuário em S3 (`bucket-a/user/user-x/`) com **uma única policy genérica** para todos.

**Qual recurso IAM você recomendaria?**

- A. IAM policy resource
- B. **IAM policy variables** ✅
- C. IAM policy condition
- D. IAM policy principal

**Resposta: B**

**Explicação:**
Policy variables (como `${aws:username}`) são substituídas dinamicamente na avaliação da policy, permitindo uma única policy para todos os usuários.

---

## Pergunta 8 · Domínio: Troubleshooting and Optimization

Uma empresa quer usar **aplicações serverless pré-construídas** para acelerar o desenvolvimento.

**Qual serviço AWS representa a solução mais simples?**

- A. AWS Marketplace
- B. **AWS Serverless Application Repository (SAR)** ✅
- C. AWS Service Catalog
- D. AWS AppSync

**Resposta: B**

**Explicação:**
O SAR é um repositório gerenciado de aplicações serverless pré-construídas — deploy sem clonar ou compilar código.

---

## Pergunta 9 · Domínio: Development with AWS Services

Uma gaming API baseada em Lambda. Cada request tem um identificador único. Durante throttling, requests podem ser retentados. A API deve lidar com **requests duplicados sem inconsistências ou perda de dados**.

**Qual abordagem você recomendaria?**

- A. ElastiCache for Memcached — verificar cache antes de processar
- B. RDS MySQL — verificar tabela antes de processar
- C. DynamoDB — retornar erro de cliente em duplicatas
- D. **DynamoDB — verificar tabela antes de processar** ✅

**Resposta: D**

**Explicação:**
DynamoDB é serverless, altamente escalável e com PITR. Verificar o identificador antes de processar garante idempotência sem inconsistências.

- A está errada: Memcached não tem replicação — dados podem ser perdidos.
- B está errada: RDS não escala tão bem para picos massivos de escrita.
- C está errada: retornar erro em duplicata é uma resposta inconsistente.

---

## Pergunta 10 · Domínio: Development with AWS Services

Aplicação hospedada por terceiros em `yourapp.3rdparty.com`. Você quer que usuários acessem via `www.mydomain.com` no Route 53.

**Qual registro Route 53 você deve criar?**

- A. Criar um registro A
- B. Criar um registro PTR
- C. **Criar um registro CNAME** ✅
- D. Criar um Alias Record

**Resposta: C**

**Explicação:**
CNAME mapeia um nome de domínio para outro. Como `www.mydomain.com` é subdomínio (não zone apex), CNAME é correto.

- A está errada: registro A aponta para IP.
- B está errada: PTR é reverso (IP → FQDN).
- D está errada: Alias records são apenas para recursos AWS.

---

## Pergunta 11 · Domínio: Deployment

Uma empresa global de e-commerce quer realizar **testes de carga geográfica** implantando recursos em múltiplas AWS Regions, **sem código adicional de aplicação**.

**Como a empresa pode atender a esses requisitos?**

- A. CloudFormation template + funções Lambda por região para criar stacks
- B. AWS Organizations template + CLI `create-stack-set`
- C. AWS CDK Toolkit + CDK CLI por região
- D. **CloudFormation template + CLI `create-stack-set`** ✅

**Resposta: D**

**Explicação:**
CloudFormation StackSets cria, atualiza ou deleta stacks em múltiplas contas e regiões com uma única operação.

---

## Pergunta 12 · Domínio: Deployment

Um developer precisa de uma aplicação implantada no EC2 com **controle total sobre as etapas de deploy** usando **blue-green deployment**.

**Qual serviço vai ajudar?**

- A. Elastic Beanstalk
- B. CodeBuild
- C. CodePipeline
- D. **CodeDeploy** ✅

**Resposta: D**

**Explicação:**
CodeDeploy automatiza deploys para EC2 e tem suporte nativo a blue/green deployment com controle granular das etapas.

---

## Pergunta 13 · Domínio: Security

Um bucket S3 foi acidentalmente tornado público. O developer quer identificar **problemas similares com mínimo esforço**.

**Qual recurso/serviço vai ajudar?**

- A. S3 Analytics
- B. **IAM Access Analyzer** ✅
- C. Access Advisor no IAM console
- D. S3 Object Lock

**Resposta: B**

**Explicação:**
IAM Access Analyzer identifica recursos compartilhados com entidades externas à zona de confiança, gerando findings ativos para acessos não intencionais.

---

## Pergunta 14 · Domínio: Development with AWS Services

Gaming company — armazenar informações de jogos (nome, versão, categoria + atributos inconsistentes). Requisitos:
1. Por nome + versão → detalhes do jogo.
2. Por nome → todos os jogos.
3. Por categoria → todos os jogos.

**Qual é a solução mais eficiente?**

- A. **DynamoDB: PK=(name), SK=(version) + GSI (category=PK, name=SK)** ✅
- B. RDS MySQL com `name` como primary key
- C. DynamoDB: PK=(category), SK=(version) + GSI (name=PK)
- D. ElastiCache for Memcached

**Resposta: A**

**Explicação:**
- PK (name) + SK (version) atende requisitos 1 e 2.
- GSI (category + name) atende requisito 3.
- RDS não suporta atributos inconsistentes eficientemente.
- ElastiCache é cache temporário, não banco de dados.

---

## Pergunta 15 · Domínio: Security

O líder da equipe quer enviar **apenas uma parte do tráfego** para uma nova versão do Lambda com **mínimo downtime** em caso de rollback.

**Qual opção você recomendaria?**

- A. Alias → nova versão com 100% do tráfego
- B. Deploy direto; rollback pelo ARN da versão
- C. Múltiplos aliases — novo alias aponta para alias atual
- D. **Alias → nova versão com 10% do tráfego; rollback = 100% para versão atual** ✅

**Resposta: D**

**Explicação:**
A configuração de Lambda alias routing divide tráfego entre duas versões. Rollback imediato sem downtime — basta redirecionar o alias.

- A e B estão erradas: enviam 100% para a nova versão.
- C está errada: alias não pode apontar para outro alias.

---

## Pergunta 16 · Domínio: Troubleshooting and Optimization

Empresa multinacional quer **debug e trace de dados entre contas** com visualização centralizada.

**Qual solução você sugeriria?**

- A. EventBridge
- B. **X-Ray** ✅
- C. CloudTrail
- D. VPC Flow Logs

**Resposta: B**

**Explicação:**
O X-Ray agent pode assumir uma role para publicar dados em uma conta diferente, habilitando visualização centralizada de traces distribuídos cross-account.

---

## Pergunta 17 · Domínio: Deployment

Qual representa a **ordem correta de etapas** para criar uma app usando AWS CDK?

- A. CloudFormation template → Adicionar código → Build → Synthesize → Deploy
- B. **CDK template → Adicionar código → Build (opcional) → Synthesize → Deploy** ✅
- C. CloudFormation template → Adicionar código → Synthesize → Deploy → Build
- D. CDK template → Adicionar código → Synthesize → Deploy → Build

**Resposta: B**

**Explicação:**
Workflow: `cdk init` → adicionar código → build opcional → `cdk synth` → `cdk deploy`.

---

## Pergunta 18 · Domínio: Troubleshooting and Optimization

Quais são **verdadeiras** sobre a configuração de **user data** do EC2? (Selecione duas)

- A. Com a instância em execução, é possível atualizar user data com credenciais root
- B. Por padrão, user data executa a cada reinicialização
- C. Por padrão, scripts de user data não têm privilégios root
- D. **Por padrão, scripts de user data são executados com privilégios root** ✅
- E. **Por padrão, user data executa apenas no primeiro boot** ✅

**Resposta: D, E**

---

## Pergunta 19 · Domínio: Development with AWS Services

ECS Fargate tasks espalhadas entre AZs precisam de **acesso cross-AZ persistente e compartilhado** aos volumes.

**Qual solução é a melhor escolha?**

- A. Bind mounts
- B. **Amazon EFS volumes** ✅
- C. AWS Gateway Storage volumes
- D. Docker volumes

**Resposta: B**

**Explicação:**
EFS é elástico, multi-AZ e suporta acesso compartilhado persistente entre tasks Fargate de diferentes AZs.

- D está errada: Docker volumes são apenas para EC2, não Fargate.
- A está errada: bind mounts são armazenamento temporário.

---

## Pergunta 20 · Domínio: Security

Uma IAM policy para Billing foi configurada, mas os usuários ainda **não conseguem ver o serviço no console**.

**Qual poderia ser o motivo?**

- A. O IAM user deve ser criado sob o Billing
- B. Somente root user tem acesso ao Billing console
- C. **É necessário ativar o acesso IAM ao Billing and Cost Management console** ✅
- D. Os usuários podem ter outra policy restritiva

**Resposta: C**

**Explicação:**
Por padrão, usuários IAM não têm acesso ao Billing. É necessário **ativar o acesso IAM** nas configurações da conta root antes que as policies tenham efeito.

---

## Pergunta 21 · Domínio: Troubleshooting and Optimization

O Kinesis `PutRecords` retorna `ProvisionedThroughputExceededException` em picos.

**Quais opções você recomendaria?** (Selecione duas)

- A. **Usar retry com mecanismo de exponential backoff** ✅
- B. Aumentar a frequência ou o tamanho dos requests
- C. Diminuir o número de KCL consumers
- D. **Diminuir a frequência ou o tamanho dos requests** ✅
- E. Mesclar os shards

**Resposta: A, D**

**Explicação:**
`ProvisionedThroughputExceededException` indica taxa muito alta. Boas práticas: retry com backoff exponencial + reduzir frequência/tamanho dos requests.

- B e E são o oposto do correto.
- C está errada: KCL consumers são leitores — o problema é nos produtores.

---

## Pergunta 22 · Domínio: Development with AWS Services

Você quer que os **dados de uma tabela DynamoDB expirem automaticamente após uma semana**.

**O que você deve usar?**

- A. Usar uma função Lambda
- B. Usar DAX
- C. Usar DynamoDB Streams
- D. **Usar TTL** ✅

**Resposta: D**

**Explicação:**
TTL define data de expiração por item. Items expirados são deletados automaticamente sem consumir write throughput.

---

## Pergunta 23 · Domínio: Development with AWS Services

AWS Budgets com alertas de previsão configurados **3 semanas atrás** — nenhum alerta recebido.

**Qual poderia ser o problema?**

- A. Conta sem privilégios suficientes para gerar previsão
- B. **AWS requer aproximadamente 5 semanas de dados de uso para gerar previsões** ✅
- C. Amazon CloudWatch está fora do ar
- D. A conta deve fazer parte do AWS Organizations

**Resposta: B**

---

## Pergunta 24 · Domínio: Development with AWS Services

Uma SQS queue junto com **todo o seu conteúdo** deve ser deletada após os testes.

**Qual API SQS deve ser usada?**

- A. RemovePermission
- B. **DeleteQueue** ✅
- C. RemoveQueue
- D. PurgeQueue

**Resposta: B**

**Explicação:**
`DeleteQueue` deleta a fila e todo seu conteúdo. Aguardar 60 segundos antes de recriar com mesmo nome.

- D está errada: `PurgeQueue` remove apenas as mensagens, mantém a fila.

---

## Pergunta 25 · Domínio: Development with AWS Services

Ao criar **arquivos de configuração do Elastic Beanstalk**, qual convenção de nomenclatura usar?

- A. **`.ebextensions/<mysettings>.config`** ✅
- B. `.config_<mysettings>.ebextensions`
- C. `.ebextensions_<mysettings>.config`
- D. `.config/<mysettings>.ebextensions`

**Resposta: A**

---

## Pergunta 26 · Domínio: Development with AWS Services

Uma empresa SaaS quer expor APIs públicas para desenvolvedores mobile como **ofertas de produto** com controle de rate e quota.

**Qual opção permite fazer isso?**

- A. Usar Lambda Authorizers customizados
- B. Usar CloudFront Usage Plans
- C. **Usar API Gateway Usage Plans** ✅
- D. Usar AWS Billing Usage Plans

**Resposta: C**

**Explicação:**
API Gateway Usage Plans combinados com API Keys definem quem acessa quais APIs e com que throttling e cotas.

---

## Pergunta 27 · Domínio: Troubleshooting and Optimization

Uma organização quer **analisar as requisições de entrada do ALB** para padrões de latência e endereços IP de clientes.

**Qual recurso vai coletar as informações necessárias?**

- A. CloudWatch metrics
- B. CloudTrail logs
- C. ALB request tracing
- D. **ALB access logs** ✅

**Resposta: D**

**Explicação:**
ALB access logs capturam informações detalhadas por request: IP do cliente, latências, path e respostas — armazenados no S3.

---

## Pergunta 28 · Domínio: Deployment

Fazendo deploy de app Java no Elastic Beanstalk. RDS deve **persistir entre deploys**. ElastiCache pode ser recriado.

**Quais configurações permitem isso?** (Selecione duas)

- A. ElastiCache externo via environment variables
- B. ElastiCache incluído no source code
- C. **RDS externo via environment variables** ✅
- D. RDS definido em `.ebextensions/`
- E. **ElastiCache definido em `.ebextensions/`** ✅

**Resposta: C, E**

**Explicação:**
- C: RDS externo sobrevive à deleção do ambiente Beanstalk.
- E: ElastiCache em `.ebextensions/` é recriado a cada deploy — adequado para sessões descartáveis.

---

## Pergunta 29 · Domínio: Deployment

Após um deploy no Beanstalk, todos os **EC2 burst balances foram perdidos**.

**Qual tipo de deploy causou isso?**

- A. Rolling deployment
- B. Falha no canary deployment
- C. All-at-once deployment
- D. **Immutable updates ou traffic splitting** ✅

**Resposta: D**

**Explicação:**
Deployments que substituem todas as instâncias perdem burst balances: Immutable updates, Traffic splitting e Managed platform updates com instance replacement habilitado.

---

## Pergunta 30 · Domínio: Development with AWS Services

Um documento YAML começa com `Transform: 'AWS::Serverless-2016-10-31'`.

**O que a seção Transform representa?**

- A. Uma função intrínseca
- B. **Indica que é um SAM template** ✅
- C. Uma definição de função Lambda
- D. Um parâmetro CloudFormation

**Resposta: B**

---

## Pergunta 31 · Domínio: Deployment

Rolling deployment: 2 batches com sucesso, o restante falhou. As instâncias do deploy com falha foram terminadas.

**O que acontece com as instâncias com falha após a terminação?**

- A. **O Elastic Beanstalk as substitui com instâncias rodando a versão do deploy mais recente com sucesso** ✅
- B. Substituir pela versão mais antiga de deploy com sucesso
- C. O Elastic Beanstalk não vai substituir as instâncias com falha
- D. Seleção manual pelo AWS Console é necessária

**Resposta: A**

---

## Pergunta 32 · Domínio: Development with AWS Services

Qual é a única **resource-based policy** que o serviço IAM suporta?

- A. Permissions boundary
- B. **Trust policy** ✅
- C. Access control list (ACL)
- D. AWS Organizations SCP

**Resposta: B**

**Explicação:**
O IAM service suporta apenas um tipo de resource-based policy: a **trust policy**, anexada a uma IAM role definindo quais principals podem assumi-la.

---## Pergunta 33 · Domínio: Security

Quais credenciais de segurança só podem ser criadas pelo **root user da conta AWS**?

- A. EC2 Instance Key Pairs
- B. **CloudFront Key Pairs** ✅
- C. IAM User Access Keys
- D. Senhas de IAM User

**Resposta: B**

**Explicação:**
CloudFront Key Pairs para signed URLs só podem ser criados pelo root user.

---

## Pergunta 34 · Domínio: Troubleshooting and Optimization

A equipe de auditoria precisa de um relatório de **quando e quem realizou chamadas de API contra o SSM Parameter Store**.

**Qual opção pode ser usada?**

- A. **Usar AWS CloudTrail** ✅
- B. Usar o recurso List do SSM Parameter Store
- C. Usar SSM Parameter Store Access Logs no CloudWatch Logs
- D. Usar SSM Parameter Store Access Logs no S3

**Resposta: A**

---

## Pergunta 35 · Domínio: Deployment

Algumas instâncias devem servir a versão antiga, outras a nova durante o deploy — **sem custo adicional**.

**Qual tipo de deploy atende a esse requisito?**

- A. Rolling with additional batches
- B. Immutable
- C. All at once
- D. **Rolling** ✅

**Resposta: D**

**Explicação:**
Rolling atualiza instâncias em batches sem aumentar o número total de instâncias → mesmo custo. Algumas instâncias servem a versão antiga enquanto outras servem a nova.

---

## Pergunta 36 · Domínio: Deployment

Um developer quer focar **apenas em escrever código**, sem se preocupar com provisionamento, configuração e deploy de servidores no EC2.

**Qual serviço AWS você recomendaria?**

- A. **Elastic Beanstalk** ✅
- B. CloudFormation
- C. Serverless Application Model
- D. CodeDeploy

**Resposta: A**

---

## Pergunta 37 · Domínio: Development with AWS Services

Quais cenários **NÃO estão corretos** sobre EC2 Auto Scaling? (Selecione dois)

- A. Um Auto Scaling group pode conter instâncias EC2 em uma ou mais AZs dentro da mesma Region
- B. **Auto Scaling groups que abrangem múltiplas Regions precisam ser habilitados para todas as Regions** ✅ (INCORRETA — ASG não pode abranger múltiplas Regions)
- C. EC2 Auto Scaling tenta distribuir instâncias igualmente entre AZs
- D. **Um Auto Scaling group pode conter instâncias EC2 em apenas uma AZ de uma Region** ✅ (INCORRETA — pode ter várias AZs)
- E. Para Auto Scaling groups em uma VPC, instâncias EC2 são lançadas em subnets

**Resposta: B, D**

---

## Pergunta 38 · Domínio: Deployment

Qual seção de um CloudFormation template **NÃO pode** ser associada a uma Condition?

- A. Resources
- B. Conditions
- C. Outputs
- D. **Parameters** ✅

**Resposta: D**

**Explicação:**
Conditions só podem ser associadas a **Resources** e **Outputs**. A seção Parameters não suporta associação com Conditions.

---

## Pergunta 39 · Domínio: Troubleshooting and Optimization

O X-Ray funciona no PC, mas **falha ao enviar dados de dentro da EC2**.

**O que NÃO ajuda a depurar o problema?**

- A. EC2 X-Ray Daemon
- B. EC2 Instance Role
- C. **X-Ray sampling** ✅
- D. CloudTrail

**Resposta: C**

**Explicação:**
Sampling controla a quantidade de dados registrados — não ajuda a diagnosticar por que os dados não estão sendo enviados.

---

## Pergunta 40 · Domínio: Deployment

O manager quer que os scripts CloudFormation exibam o **número da conta** de cada account.

**Qual Pseudo parâmetro você usaria?**

- A. AWS::Region
- B. AWS::NoValue
- C. **AWS::AccountId** ✅
- D. AWS::StackName

**Resposta: C**

---

## Pergunta 41 · Domínio: Development with AWS Services

Você precisa de um mapa de AMIs por região no CloudFormation. Como invocar `!FindInMap`?

- A. `!FindInMap [ MapName ]`
- B. **`!FindInMap [ MapName, TopLevelKey, SecondLevelKey ]`** ✅
- C. `!FindInMap [ MapName, TopLevelKey ]`
- D. `!FindInMap [ MapName, TopLevelKey, SecondLevelKey, ThirdLevelKey ]`

**Resposta: B**

---

## Pergunta 42 · Domínio: Deployment

App com alto tráfego e alta disponibilidade. Deploy via Beanstalk **sem afetar performance e disponibilidade**, de forma **economicamente eficiente**.

**Qual política de deploy é a MAIS otimizada?**

- A. Rolling
- B. All at once
- C. Immutable
- D. **Rolling with additional batch** ✅

**Resposta: D**

**Explicação:**
Rolling with additional batch lança um batch extra mantendo capacidade total durante o deploy. Evita redução de disponibilidade sem o overhead do Immutable.

---

## Pergunta 43 · Domínio: Development with AWS Services

RDS PostgreSQL com **workloads de leitura intensiva** — performance de leitura ideal com **menor esforço de desenvolvimento**.

**Qual solução atende a esse requisito?**

- A. ElastiCache for Redis como camada de cache
- B. **RDS com read replicas; refatorar queries para usar o endpoint das replicas** ✅
- C. ElastiCache for Memcached como camada de cache
- D. RDS Multi-AZ; refatorar queries para usar o endpoint standby

**Resposta: B**

**Explicação:**
Read replicas distribuem tráfego de leitura horizontalmente e suportam queries SQL diretamente.

- A e C estão erradas: ElastiCache não executa queries SQL.
- D está errada: o standby Multi-AZ não está disponível para leitura (em single standby).

---

## Pergunta 44 · Domínio: Development with AWS Services

Quais características tornam um **Elastic Load Balancer** uma boa escolha? (Selecione duas)

- A. **Construir um sistema altamente disponível** ✅
- B. Comunica-se com EC2 usando IPs públicos
- C. **Separar tráfego público do tráfego privado** ✅
- D. Implantar instâncias EC2 em múltiplas AWS Regions
- E. Melhorar a escalabilidade vertical

**Resposta: A, C**

**Explicação:**
- A: ELB distribui tráfego entre AZs roteando apenas para targets saudáveis.
- C: Internet-facing LB tem IPs públicos, mas comunica com EC2 via IPs privados.

---

## Pergunta 45 · Domínio: Troubleshooting and Optimization

Um developer quer **formatar a resposta de dados** de uma função Lambda via API Gateway.

**Qual recurso do API Gateway pode ser usado?**

- A. Fazer deploy de um shell script interceptor
- B. Usar um interceptor Lambda customizado
- C. **Usar API Gateway Mapping Templates** ✅
- D. Usar uma stage variable do API Gateway

**Resposta: C**

**Explicação:**
Mapping Templates usam VTL para transformar o payload entre o formato do cliente e o formato do backend.

---

## Pergunta 46 · Domínio: Deployment

Dois stacks em regiões diferentes criaram CloudFormation exports com o mesmo nome `ELBDNSName`. O deploy em us-east-2 falhou.

**Qual é a causa do erro?**

- A. Exported Output Values devem ter nomes únicos em todas as Regions
- B. Output Values devem ter nomes únicos dentro de uma única Region
- C. **Exported Output Values devem ter nomes únicos dentro de uma única Region** ✅
- D. Output Values devem ter nomes únicos em todas as Regions

**Resposta: C**

---

## Pergunta 47 · Domínio: Security

Security Group e NACL configurados com inbound para as portas necessárias, mas **não conseguem conectar ao serviço** na EC2.

**O que você recomendaria?**

- A. NACLs são stateful; Security Groups são stateless
- B. Regras de NACLs não devem ser modificadas via CLI
- C. IAM Role no Security Group difere do da NACL
- D. **Security Groups são stateful; NACLs são stateless — deve-se permitir tanto inbound quanto outbound** ✅

**Resposta: D**

**Explicação:**
NACLs são stateless: é necessário permitir inbound (porta do serviço) E outbound (portas efêmeras 1024-65535 para tráfego de retorno).

---

## Pergunta 48 · Domínio: Development with AWS Services

Quais estão corretas sobre a **API SQS CreateQueue**? (Selecione duas)

- A. A DLQ de uma FIFO queue pode ser uma standard queue
- B. **O visibility timeout padrão é 30 segundos** ✅
- C. Queue tags são case insensitive
- D. `MessageRetentionPeriod` configura o delay de entrega
- E. **Não é possível alterar o tipo da queue após a criação** ✅

**Resposta: B, E**

**Explicação:**
- B: Visibility timeout padrão = 30 segundos (0 a 43.200).
- E: Não é possível converter standard → FIFO.
- A está errada: DLQ de FIFO também deve ser FIFO.
- C está errada: tags são case-sensitive.
- D está errada: o atributo de delay é `DelaySeconds`.

---

## Pergunta 49 · Domínio: Security

Uma empresa de mídia quer que **usuários brasileiros** sejam atendidos apenas pelos servidores brasileiros.

**Qual política de roteamento do Route 53 atende a esse requisito?**

- A. Failover
- B. Latency
- C. Weighted
- D. **Geolocation** ✅

**Resposta: D**

**Explicação:**
Geolocation routing roteia com base na localização geográfica da query DNS, permitindo restringir acesso por país.

---

## Pergunta 50 · Domínio: Deployment

Qual tipo de credencial **NÃO é suportado** pelo IAM para CodeCommit?

- A. **Usuário e senha IAM** ✅
- B. SSH Keys
- C. AWS Access Keys
- D. Git credentials

**Resposta: A**

**Explicação:**
Usuário/senha do IAM não podem acessar CodeCommit. Métodos suportados: Git credentials (HTTPS), SSH Keys, AWS Access Keys + credential helper.

---

## Pergunta 51 · Domínio: Troubleshooting and Optimization

App ECS processa pedidos via SQS. `ApproximateNumberOfMessagesVisible` com picos altos. Outras métricas ECS dentro dos limites.

**Qual abordagem melhora a performance com baixo custo?**

- A. Usar ECS service scheduler
- B. **Usar a métrica backlog per instance com target tracking scaling policy** ✅
- C. Usar ECS step scaling policy
- D. Usar Docker swarm

**Resposta: B**

**Explicação:**
A métrica **backlog per instance** (mensagens na fila / instâncias ativas) com target tracking permite que Auto Scaling ajuste com precisão proporcional ao volume de trabalho real.

---

## Pergunta 52 · Domínio: Security

O líder da equipe quer identificar **IAM roles não utilizadas** para aplicar o princípio do menor privilégio.

**Qual serviço vai ajudar?**

- A. AWS Security Hub
- B. **IAM Access Analyzer** ✅
- C. Amazon Inspector
- D. AWS Trusted Advisor

**Resposta: B**

**Explicação:**
IAM Access Analyzer gera findings para roles não utilizadas, access keys inativas e senhas de usuários inativas.

---

## Pergunta 53 · Domínio: Deployment

Um novo colaborador adicionou uma **seção inválida** a um CloudFormation template.

**Qual representa uma seção inválida?**

- A. Seção 'Resources'
- B. **Seção 'Dependencies'** ✅
- C. Seção 'Parameters'
- D. Seção 'Conditions'

**Resposta: B**

**Explicação:**
Não existe seção `Dependencies` no CloudFormation. Seções válidas: `AWSTemplateFormatVersion`, `Description`, `Metadata`, `Parameters`, `Mappings`, `Conditions`, `Transform`, `Resources`, `Outputs`.

---

## Pergunta 54 · Domínio: Security

Bucket policy que **nega uploads sem SSE-KMS encryption**.

**Qual policy é a mais adequada?**

- A. `StringEquals` + `aws:kms`
- B. `StringNotEquals` + `false`
- C. Action `s3:GetObject` + `AES256`
- D. **`StringNotEquals` + `aws:kms` em `s3:PutObject`** ✅

```json
{
  "Effect": "Deny",
  "Action": "s3:PutObject",
  "Condition": {
    "StringNotEquals": {
      "s3:x-amz-server-side-encryption": "aws:kms"
    }
  }
}
```

**Resposta: D**

**Explicação:**
`StringNotEquals` + `aws:kms` nega qualquer PutObject que não inclua o header SSE-KMS correto.

---

## Pergunta 55 · Domínio: Security

Uma empresa de cybersecurity precisa de **hardware single-tenant** — opção mais econômica.

**Qual opção EC2?**

- A. Dedicated Hosts
- B. **Dedicated Instances** ✅
- C. Spot Instances
- D. On-Demand Instances

**Resposta: B**

**Explicação:**
Dedicated Instances rodam em hardware single-tenant e são mais baratas que Dedicated Hosts. Podem compartilhar hardware com outras instâncias da mesma conta que não sejam Dedicated.

---

## Pergunta 56 · Domínio: Security

Uma web app .NET precisa de autenticação que **retorne JWT (JSON Web Token)**.

**Qual serviço AWS vai ajudar?**

- A. API Gateway
- B. **Cognito User Pools** ✅
- C. Cognito Identity Pools
- D. Cognito Sync

**Resposta: B**

**Explicação:**
Cognito User Pools retorna tokens JWT (ID token, Access token, Refresh token) seguindo OpenID Connect após autenticação.

- C está errada: Identity Pools concedem credenciais temporárias AWS, não JWTs.

---

## Pergunta 57 · Domínio: Development with AWS Services

Uma startup com conta AWS nova usou T2.micro por **35 segundos**.

**Qual é a duração de uso da instância cobrada?**

- A. **0 segundos** ✅
- B. 35 segundos
- C. 30 segundos
- D. 60 segundos

**Resposta: A**

**Explicação:**
Contas com menos de 12 meses têm T2.micro **gratuito** dentro do Free Tier.

---

## Pergunta 58 · Domínio: Deployment

Qual **NÃO é** um tipo de recurso SAM válido?

- A. AWS::Serverless::Api
- B. **AWS::Serverless::UserPool** ✅
- C. AWS::Serverless::Function
- D. AWS::Serverless::SimpleTable

**Resposta: B**

**Explicação:**
`UserPool` pertence ao Cognito, não é um tipo SAM. Tipos válidos: `Function`, `Api`, `HttpApi`, `SimpleTable`, `Application`, `LayerVersion`, `StateMachine`.

---

## Pergunta 59 · Domínio: Development with AWS Services

Uma empresa quer fornecer **acesso beta para developers** a uma nova versão da API (incompatível com versões anteriores) sem afetar clientes existentes.

**Abordagem mais eficiente operacionalmente?**

- A. **Criar um development stage no API Gateway e apontar os developers para esse stage** ✅
- B. Criar novas API keys e distribuir aos developers
- C. Criar uma nova API Gateway API
- D. Configurar canary release com stage variable

**Resposta: A**

**Explicação:**
Um stage separado (`dev`) integrado ao backend da nova versão isola completamente os developers sem afetar clientes de produção.

- D está errada: canary release divide tráfego no mesmo stage — alguns clientes acessariam a nova versão.

---

## Pergunta 60 · Domínio: Security

RDS connection strings estão hardcoded. A empresa quer **armazenar segredos com segurança e rotacionar credenciais automaticamente**.

**Qual serviço AWS resolve isso?**

- A. **Secrets Manager** ✅
- B. SSM Parameter Store
- C. KMS
- D. Systems Manager

**Resposta: A**

**Explicação:**
Secrets Manager foi projetado para armazenar, rotacionar e recuperar segredos com integração nativa com RDS, Redshift e DocumentDB.

- B está errada: SSM Parameter Store não rotaciona credenciais automaticamente.

---

## Pergunta 61 · Domínio: Troubleshooting and Optimization

Uma função Lambda requer **alta utilização de CPU**. Como reduzir o tempo médio de execução?

- A. Fazer deploy usando Lambda layers
- B. Fazer deploy em múltiplas AWS Regions
- C. **Fazer deploy com alocação de memória no valor máximo** ✅
- D. Fazer deploy com alocação de CPU no valor máximo

**Resposta: C**

**Explicação:**
Lambda aloca CPU em proporção à memória. Para maximizar CPU → maximizar memória (até 10.240 MB). Não existe parâmetro direto de CPU.

---

## Pergunta 62 · Domínio: Deployment

CodeBuild está demorando muito — erro na resolução de dependências de terceiros. Como **evitar builds longos no futuro**?

**Qual é a melhor solução?**

- A. Usar Amazon CloudWatch
- B. Usar VPC Flow Logs
- C. **Habilitar CodeBuild timeouts** ✅
- D. Usar AWS Lambda

**Resposta: C**

**Explicação:**
CodeBuild timeouts terminam automaticamente builds que excedem o tempo configurado (5 min a 8 horas).

---

## Pergunta 63 · Domínio: Security

O developer deve garantir que **PutObject requests sem SSE-S3 encryption** não sejam processadas.

**Qual solução garante isso?**

- A. Definir encryption key no HTTP header
- B. Header `x-amz-server-side-encryption: sse:s3`
- C. **Header `x-amz-server-side-encryption: AES256` + bucket policy `StringNotEquals`** ✅
- D. Header `x-amz-server-side-encryption: aws:kms`

**Resposta: C**

**Explicação:**
Para SSE-S3, o header correto é `AES256`. A bucket policy com `StringNotEquals` nega uploads sem o header correto.

---

## Pergunta 64 · Domínio: Security

Quais entidades AWS podem ser usadas para fazer **deploy de certificados de servidor SSL/TLS**? (Selecione duas)

- A. AWS CloudFormation
- B. AWS Secrets Manager
- C. **AWS Certificate Manager** ✅
- D. **IAM** ✅
- E. AWS Systems Manager

**Resposta: C, D**

**Explicação:**
- ACM: ferramenta preferida — gratuita com renovação automática.
- IAM: para regiões não suportadas pelo ACM, com certificados de provedores externos.

---

## Pergunta 65 · Domínio: Troubleshooting and Optimization

O ELB marcou todas as instâncias como **unhealthy**, mas o site é acessível diretamente pelo IP.

**Qual poderia ser o motivo?** (Selecione dois)

- A. É necessário attach Elastic IP às instâncias
- B. EBS volumes montados incorretamente
- C. **A rota para o health check está mal configurada** ✅
- D. Runtime da web app não suportado pelo ALB
- E. **O security group da instância EC2 não permite tráfego do security group do ALB** ✅

**Resposta: C, E**

**Explicação:**
O site acessível pelo IP indica que a aplicação funciona — o problema está na comunicação ALB → instância:
- Security group da instância bloqueando tráfego do SG do ALB.
- Rota do health check incorreta (ex: path que não existe).