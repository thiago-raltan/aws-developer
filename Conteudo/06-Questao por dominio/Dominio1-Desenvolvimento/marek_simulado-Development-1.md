# Simulado Marek - Development

## Parte 1: Provas 01, 02, 03

> **72 questoes** agrupadas por dominio -- Fonte: Provas Marek 01, 02, 03

---

## Pergunta 5 [P01] · Domínio: Development with AWS Services

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

## Pergunta 6 [P01] · Domínio: Development with AWS Services

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

## Pergunta 9 [P01] · Domínio: Development with AWS Services

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

## Pergunta 10 [P01] · Domínio: Development with AWS Services

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

## Pergunta 14 [P01] · Domínio: Development with AWS Services

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

## Pergunta 19 [P01] · Domínio: Development with AWS Services

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

## Pergunta 22 [P01] · Domínio: Development with AWS Services

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

## Pergunta 23 [P01] · Domínio: Development with AWS Services

AWS Budgets com alertas de previsão configurados **3 semanas atrás** — nenhum alerta recebido.

**Qual poderia ser o problema?**

- A. Conta sem privilégios suficientes para gerar previsão
- B. **AWS requer aproximadamente 5 semanas de dados de uso para gerar previsões** ✅
- C. Amazon CloudWatch está fora do ar
- D. A conta deve fazer parte do AWS Organizations

**Resposta: B**

---

## Pergunta 24 [P01] · Domínio: Development with AWS Services

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

## Pergunta 25 [P01] · Domínio: Development with AWS Services

Ao criar **arquivos de configuração do Elastic Beanstalk**, qual convenção de nomenclatura usar?

- A. **`.ebextensions/<mysettings>.config`** ✅
- B. `.config_<mysettings>.ebextensions`
- C. `.ebextensions_<mysettings>.config`
- D. `.config/<mysettings>.ebextensions`

**Resposta: A**

---

## Pergunta 26 [P01] · Domínio: Development with AWS Services

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

## Pergunta 30 [P01] · Domínio: Development with AWS Services

Um documento YAML começa com `Transform: 'AWS::Serverless-2016-10-31'`.

**O que a seção Transform representa?**

- A. Uma função intrínseca
- B. **Indica que é um SAM template** ✅
- C. Uma definição de função Lambda
- D. Um parâmetro CloudFormation

**Resposta: B**

---

## Pergunta 32 [P01] · Domínio: Development with AWS Services

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

## Pergunta 37 [P01] · Domínio: Development with AWS Services

Quais cenários **NÃO estão corretos** sobre EC2 Auto Scaling? (Selecione dois)

- A. Um Auto Scaling group pode conter instâncias EC2 em uma ou mais AZs dentro da mesma Region
- B. **Auto Scaling groups que abrangem múltiplas Regions precisam ser habilitados para todas as Regions** ✅ (INCORRETA — ASG não pode abranger múltiplas Regions)
- C. EC2 Auto Scaling tenta distribuir instâncias igualmente entre AZs
- D. **Um Auto Scaling group pode conter instâncias EC2 em apenas uma AZ de uma Region** ✅ (INCORRETA — pode ter várias AZs)
- E. Para Auto Scaling groups em uma VPC, instâncias EC2 são lançadas em subnets

**Resposta: B, D**

---

## Pergunta 41 [P01] · Domínio: Development with AWS Services

Você precisa de um mapa de AMIs por região no CloudFormation. Como invocar `!FindInMap`?

- A. `!FindInMap [ MapName ]`
- B. **`!FindInMap [ MapName, TopLevelKey, SecondLevelKey ]`** ✅
- C. `!FindInMap [ MapName, TopLevelKey ]`
- D. `!FindInMap [ MapName, TopLevelKey, SecondLevelKey, ThirdLevelKey ]`

**Resposta: B**

---

## Pergunta 43 [P01] · Domínio: Development with AWS Services

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

## Pergunta 44 [P01] · Domínio: Development with AWS Services

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

## Pergunta 48 [P01] · Domínio: Development with AWS Services

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

## Pergunta 57 [P01] · Domínio: Development with AWS Services

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

## Pergunta 59 [P01] · Domínio: Development with AWS Services

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

## Pergunta 2 [P02] · Domínio: Development with AWS Services

Quais etapas um developer pode tomar para otimizar a performance de uma função Lambda com uso intensivo de CPU e garantir tempo de resposta rápido?

- A. Aumentar o timeout da função
- B. Aumentar a CPU da função
- C. Aumentar o provisioned concurrency da função
- D. **Aumentar a memória da função** ✅

**Resposta: D**

**Explicação:**
A memória é o principal lever disponível para os desenvolvedores Lambda controlarem a performance. A quantidade de memória também determina a quantidade de CPU virtual disponível — adicionar mais memória aumenta proporcionalmente a CPU disponível.

- B está errada: não existe parâmetro direto de CPU no Lambda.
- C está errada: provisioned concurrency reduz cold starts, mas não aumenta CPU disponível.
- A está errada: timeout apenas estende o tempo máximo de execução.

---

## Pergunta 7 [P02] · Domínio: Development with AWS Services

Um CloudFormation template tem três stacks: Stack-A provisiona VPC, security group e subnets referenciados por Stack-B e Stack-C.

**Após executar os stacks, em qual ordem você deve deletá-los?**

- A. Stack A, depois Stack B, depois Stack C
- B. Stack A, Stack C, depois Stack B
- C. Stack C, depois Stack A, depois Stack B
- D. **Stack B, depois Stack C, depois Stack A** ✅

**Resposta: D**

**Explicação:**
Todos os imports devem ser removidos antes de poder deletar o stack exportador. Stack-B e Stack-C importam recursos de Stack-A, portanto devem ser deletados primeiro. Só então Stack-A pode ser deletado.

---

## Pergunta 10 [P02] · Domínio: Development with AWS Services

Uma universidade criou um portal para estudantes acessível via app mobile (Android e iOS) e aplicação web. Os estudantes podem fazer estudos em grupo online e criar perguntas em fóruns. Todas as alterações feitas em dispositivos mobile devem estar disponíveis offline e sincronizar com outros dispositivos.

**Qual serviço AWS atende a esses requisitos?**

- A. Cognito User Pools
- B. Elastic Beanstalk
- C. **AWS AppSync** ✅
- D. Cognito Identity Pools

**Resposta: C**

**Explicação:**
AWS AppSync é um serviço GraphQL gerenciado com suporte a acesso offline, resolução de conflitos e sincronização entre dispositivos. Apps mobile continuam funcionando offline, enfileiram alterações localmente e sincronizam automaticamente quando a conectividade retorna.

- D está errada: Identity Pools concedem credenciais temporárias AWS, não gerenciam sync de dados.
- A está errada: User Pools gerenciam autenticação de usuários, não sincronização de dados.
- B está errada: Elastic Beanstalk é para deploy de aplicações web, não sync de dados mobile.

---

## Pergunta 15 [P02] · Domínio: Development with AWS Services

Uma empresa quer automatizar seu fluxo de trabalho de fulfillment de pedidos e rastreamento de estoque, do momento da criação do pedido até a atualização do estoque e envio.

**Qual solução seria a mais otimizada?**

- A. Configurar Amazon EventBridge para rastrear o fluxo de trabalho
- B. Usar Amazon SQS queue para passar informações entre os sistemas
- C. **Usar AWS Step Functions para coordenar e gerenciar os componentes do fluxo de trabalho** ✅
- D. Usar Amazon SNS para desenvolver aplicações event-driven

**Resposta: C**

**Explicação:**
AWS Step Functions é um orquestrador serverless que facilita a sequência de funções Lambda e múltiplos serviços AWS em aplicações críticas de negócio. Mantém o estado da aplicação, implementa try/catch, retry e rollback automaticamente.

- B está errada: SQS é para fila de mensagens; não rastreia as etapas de um workflow automaticamente.
- A está errada: EventBridge é para reação a eventos de serviços SaaS/AWS, não orquestração de workflows.
- D está errada: SNS é para fan-out de mensagens em tempo real, não para orquestração de processos.

---

## Pergunta 22 [P02] · Domínio: Development with AWS Services

Desenvolvedores estão trabalhando em uma API no ambiente de desenvolvimento, mas as mudanças feitas nas APIs não são refletidas quando a API é chamada.

**Qual solução você recomendaria?**

- A. Usar Stage Variables para o estado de desenvolvimento da API
- B. **Reimplantar a API em um stage existente ou em um novo stage** ✅
- C. Developers precisam de permissões IAM no componente de execução do API Gateway
- D. Habilitar Lambda authorizer para acessar a API

**Resposta: B**

**Explicação:**
Após criar ou atualizar uma API, você deve reimplantá-la para torná-la acessível. Toda vez que você atualiza uma API (rotas, métodos, integrações, authorizers), precisa reimplantar em um stage existente ou novo.

- C está errada: o problema é de reimplantação, não de permissões IAM.
- D está errada: Lambda authorizer controla acesso, não reflete mudanças de API.
- A está errada: Stage Variables são atributos de configuração, não relacionados à visibilidade de mudanças.

---

## Pergunta 26 [P02] · Domínio: Development with AWS Services

Você recebeu um documento YAML que começa com `Transform: 'AWS::Serverless-2016-10-31'`.

**O que a seção Transform representa?**

- A. Representa uma função intrínseca
- B. Indica que é um CloudFormation Parameter
- C. **Indica que é um SAM template** ✅
- D. Representa uma definição de função Lambda

**Resposta: C**

**Explicação:**
A transformação `AWS::Serverless` é uma macro hospedada pelo CloudFormation que converte o template SAM em um CloudFormation template válido. A presença da seção `Transform` indica que o documento é um SAM template.

---

## Pergunta 29 [P02] · Domínio: Development with AWS Services

Uma aplicação de jogos suporta transferência de vouchers entre usuários. A equipe quer garantir que as transferências sejam capturadas no banco de dados de forma que os registros de ambos os usuários sejam escritos com sucesso ou o estado atual seja mantido.

**Quais soluções atendem a esses requisitos?** (Selecione duas)

- A. **Completar ambas as operações no RDS MySQL em um único bloco de transação** ✅
- B. **Usar as APIs de leitura e escrita transacionais do DynamoDB nas tabelas como uma operação all-or-nothing** ✅
- C. Usar as APIs transacionais do Amazon Athena como operação all-or-nothing
- D. Completar ambas as operações no Amazon Redshift em um único bloco de transação
- E. Realizar operações de leitura e escrita no DynamoDB com o parâmetro ConsistentRead definido como true

**Resposta: A, B**

**Explicação:**
- B: DynamoDB suporta transações ACID via `TransactWriteItems` e `TransactGetItems`.
- A: RDS MySQL suporta transações com blocos BEGIN/COMMIT.
- E está errada: ConsistentRead é sobre consistência de leitura, não sobre transações.
- C e D estão erradas: Athena é para queries analíticas e Redshift é um data warehouse — nenhum gerencia transações OLTP.

---

## Pergunta 32 [P02] · Domínio: Development with AWS Services

Uma equipe de banco de investimentos usa DynamoDB para trading de alta frequência onde múltiplos trades tentam atualizar um item simultaneamente.

**Qual ação garante que apenas o último valor atualizado de um item seja usado?**

- A. **Usar ConsistentRead = true ao realizar operações GetItem** ✅
- B. Usar ConsistentRead = true ao realizar operações UpdateItem
- C. Usar ConsistentRead = false ao realizar operações PutItem
- D. Usar ConsistentRead = true ao realizar operações PutItem

**Resposta: A**

**Explicação:**
Leituras fortemente consistentes (`ConsistentRead = true`) retornam os dados mais atualizados refletindo todas as operações de escrita bem-sucedidas anteriores. O parâmetro `ConsistentRead` se aplica apenas às operações de leitura: `GetItem`, `Query` e `Scan`.

- B, C e D estão erradas: `ConsistentRead` não se aplica a operações de escrita (`UpdateItem`, `PutItem`).

---

## Pergunta 33 [P02] · Domínio: Development with AWS Services

Uma empresa usa volumes Provisioned IOPS SSD (io1).

**Qual configuração é INVÁLIDA para volumes io1?**

- A. Volume de 200 GiB com 10.000 IOPS
- B. Volume de 200 GiB com 5.000 IOPS
- C. **Volume de 200 GiB com 15.000 IOPS** ✅
- D. Volume de 200 GiB com 2.000 IOPS

**Resposta: C**

**Explicação:**
A proporção máxima de IOPS provisionadas em relação ao tamanho do volume (em GiB) é 50:1. Para um volume de 200 GiB, o máximo de IOPS possível é 200 × 50 = **10.000 IOPS**. Uma configuração com 15.000 IOPS para 200 GiB é inválida.

---

## Pergunta 35 [P02] · Domínio: Development with AWS Services

Uma empresa multinacional quer que usuários autenticados por terceiros confiáveis criem e atualizem registros em tabelas específicas do DynamoDB.

**Qual solução você recomendaria?**

- A. **Usar Cognito Identity Pools para permitir que usuários autenticados de terceiros acessem o DynamoDB** ✅
- B. Criar um novo IAM group na conta da empresa para cada usuário autenticado de terceiros
- C. Criar um novo IAM user na conta da empresa para cada usuário autenticado de terceiros
- D. Usar Cognito User Pools para permitir que usuários autenticados de terceiros acessem o DynamoDB

**Resposta: A**

**Explicação:**
Cognito Identity Pools (federated identities) permite criar identidades únicas para usuários e federá-las com provedores de identidade. Com um identity pool, usuários obtêm credenciais temporárias AWS para acessar serviços como DynamoDB.

- D está errada: Cognito User Pools gerencia autenticação de usuários, mas não concede credenciais temporárias AWS para acessar serviços.
- B e C estão erradas: criar IAM users ou groups para cada usuário de terceiros é uma solução ineficiente.

---

## Pergunta 36 [P02] · Domínio: Development with AWS Services

Um novo projeto requer 10 strongly consistent reads por segundo de itens com 6KB cada.

**Quantas read capacity units você precisará ao configurar sua tabela DynamoDB?**

- A. 60
- B. 10
- C. 30
- D. **20** ✅

**Resposta: D**

**Explicação:**
1 RCU = 1 strongly consistent read por segundo para itens de até 4KB.

- Tamanho do item / 4KB = 6KB / 4KB = 1,5 → arredondado para **2 RCUs por item**
- 2 RCUs × 10 leituras/segundo = **20 RCUs**

---

## Pergunta 37 [P02] · Domínio: Development with AWS Services

Uma função Lambda deve realizar um upsert no DynamoDB — recuperar um item e atualizar alguns atributos, ou criar o item se não existir.

**Qual conjunto de permissões IAM MÍNIMO é necessário?**

- A. dynamodb:UpdateItem, dynamodb:GetItem, dynamodb:PutItem
- B. dynamodb:GetRecords, dynamodb:PutItem, dynamodb:UpdateTable
- C. **dynamodb:UpdateItem, dynamodb:GetItem** ✅
- D. dynamodb:AddItem, dynamodb:GetItem

**Resposta: C**

**Explicação:**
`UpdateItem` edita atributos de um item existente ou adiciona um novo item à tabela se não existir. Não é necessário incluir `PutItem` para um upsert, pois `UpdateItem` já cobre essa funcionalidade.

- A está errada: inclui `PutItem` desnecessariamente.
- D está errada: `AddItem` não é uma ação válida do DynamoDB.
- B está errada: `GetRecords` e `UpdateTable` não são relevantes para o caso de uso.

---

## Pergunta 41 [P02] · Domínio: Development with AWS Services

Um Auto Scaling group tem maximum capacity=3, current capacity=2 e uma scaling policy que adiciona 3 instâncias.

**Qual é o resultado esperado ao executar essa policy?**

- A. O Auto Scaling adiciona 3 instâncias e remove 2 eventualmente
- B. O Auto Scaling adiciona 3 instâncias
- C. **O Auto Scaling adiciona apenas 1 instância** ✅
- D. O Auto Scaling não adiciona instâncias, mas sugere alterar a policy

**Resposta: C**

**Explicação:**
Quando o cálculo da capacidade produz um número fora do intervalo mínimo/máximo, o Auto Scaling garante que a nova capacidade nunca exceda os limites. Com maximum=3 e current=2, apenas 1 instância pode ser adicionada (2+1=3=maximum).

---

## Pergunta 42 [P02] · Domínio: Development with AWS Services

Um laboratório de diagnóstico quer fazer backup de uma tabela DynamoDB no Amazon S3 para download local.

**Qual opção NÃO é viável?**

- A. Usar AWS Glue para copiar a tabela para o S3 e baixar localmente
- B. Usar AWS Data Pipeline para exportar a tabela para um bucket S3 e baixar localmente
- C. **Usar o recurso de backup on-demand do DynamoDB para escrever no S3 e baixar localmente** ✅
- D. Usar Hive com Amazon EMR para exportar dados para um bucket S3 e baixar localmente

**Resposta: C**

**Explicação:**
O DynamoDB possui dois métodos de backup (On-demand e Point-in-time recovery) que escrevem no S3, mas você não tem acesso aos buckets S3 usados para esses backups — não é possível baixar localmente.

- B está errado: Data Pipeline com EMR é o método mais simples para backup com menor quantidade de recursos AWS.
- D está errado: EMR com Hive permite exportar dados para um bucket S3 acessível.
- A está errado: AWS Glue é ideal para backups contínuos automatizados acessíveis via Athena.

---

## Pergunta 43 [P02] · Domínio: Development with AWS Services

Ao definir um business workflow como state machine no AWS Step Functions, qual estado representa uma única unidade de trabalho realizada pela state machine?

- A. **`"HelloWorld": {"Type": "Task", "Resource": "arn:aws:lambda:..."}` — state do tipo Task** ✅
- B. `"FailState": {"Type": "Fail", ...}` — state do tipo Fail
- C. `"No-op": {"Type": "Task", "Result": {...}}` — sem campo Resource
- D. `"wait_until": {"Type": "Wait", ...}` — state do tipo Wait

**Resposta: A**

**Explicação:**
Um Task state (`"Type": "Task"`) representa uma única unidade de trabalho realizada pela state machine, invocando uma função Lambda ou outro serviço AWS.

- D está errada: Wait state atrasa a execução por um tempo especificado.
- C está errada: o campo `Resource` é obrigatório no Task state — sem ele, é um estado Pass.
- B está errada: Fail state encerra a execução da state machine marcando como falha.

---

## Pergunta 44 [P02] · Domínio: Development with AWS Services

Uma empresa de mídia quer reservar capacidade para suas instâncias EC2 críticas.

**Qual tipo de Reserved Instance você selecionaria para fornecer capacity reservations?**

- A. Tanto Regional quanto Zonal Reserved Instances
- B. **Zonal Reserved Instances** ✅
- C. Regional Reserved Instances
- D. Nem Regional nem Zonal Reserved Instances

**Resposta: B**

**Explicação:**
Zonal Reserved Instances fornecem tanto desconto quanto capacity reservation em uma Availability Zone específica. Regional Reserved Instances fornecem desconto, mas NÃO fornecem capacity reservation.

---

## Pergunta 47 [P02] · Domínio: Development with AWS Services

Consumidores de uma SQS queue precisam de tempo adicional para processar mensagens. A equipe quer atrasar a entrega de novas mensagens por alguns segundos.

**Qual solução você recomendaria?**

- A. Usar visibility timeout para atrasar a entrega de novas mensagens
- B. **Usar delay queues para atrasar a entrega de novas mensagens** ✅
- C. Usar dead-letter queues para atrasar a entrega de novas mensagens
- D. Usar FIFO queues para atrasar a entrega de novas mensagens

**Resposta: B**

**Explicação:**
Delay queues permitem atrasar a entrega de novas mensagens por vários segundos (mínimo 0, máximo 15 minutos). As mensagens permanecem invisíveis para os consumidores durante o período de delay.

- A está errada: visibility timeout impede outros consumidores de receber uma mensagem que já foi recebida — não afeta novas mensagens.
- C e D estão erradas: DLQs e FIFO queues não têm a funcionalidade de delay de entrega de novas mensagens.

---

## Pergunta 50 [P02] · Domínio: Development with AWS Services

Uma startup percebeu que operações de escrita no DynamoDB estão sobrescrevendo itens existentes com a mesma primary key.

**Qual opção de escrita do DynamoDB deve ser usada para prevenir essa sobrescrita?**

- A. Usar operação Scan
- B. Batch writes
- C. **Conditional writes** ✅
- D. Atomic Counters

**Resposta: C**

**Explicação:**
Conditional writes permitem que operações como `PutItem`, `UpdateItem` e `DeleteItem` sejam bem-sucedidas apenas se os atributos do item atenderem a uma ou mais condições esperadas. Por exemplo, `PutItem` somente se não existir um item com a mesma primary key.

- B está errada: Batch writes reduz round trips de rede, mas não previne sobrescrita.
- D está errada: Atomic Counters são para incremento incondicional de atributos numéricos.
- A está errada: Scan lê todos os itens da tabela — é uma operação de leitura, não de escrita.

---

## Pergunta 52 [P02] · Domínio: Development with AWS Services

Um ambiente de testes usa volumes General Purpose SSD (gp2).

**A qual tamanho de volume gp2 o ambiente atingirá o máximo de IOPS?**

- A. 2,7 TiB
- B. 10,6 TiB
- C. 16 TiB
- D. **5,3 TiB** ✅

**Resposta: D**

**Explicação:**
Para volumes gp2, a performance base escala linearmente a 3 IOPS por GiB. O máximo é 16.000 IOPS, atingido a partir de 5.334 GiB ≈ **5,3 TiB**.

---

## Pergunta 56 [P02] · Domínio: Development with AWS Services

Uma empresa comprou 1 m4.xlarge Reserved Instance, mas usou 3 instâncias m4.xlarge simultaneamente por 1 hora.

**Como as instâncias são cobradas?**

- A. **Uma instância é cobrada a 1 hora de Reserved Instance e as outras duas são cobradas a 2 horas de On-Demand** ✅
- B. Todas são cobradas a 1 hora de On-Demand
- C. Uma instância é cobrada a 1 hora de On-Demand e as outras duas a 2 horas de Reserved Instance
- D. Todas são cobradas a 1 hora de Reserved Instance

**Resposta: A**

**Explicação:**
O benefício de desconto da Reserved Instance se aplica a no máximo 3.600 segundos (1 hora) de uso de instância por hora-relógio. Com 3 instâncias rodando simultaneamente, apenas 1 recebe o desconto da Reserved Instance; as outras 2 são cobradas a preço On-Demand.

---

## Pergunta 57 [P02] · Domínio: Development with AWS Services

Um developer quer estabelecer um workflow de desenvolvimento acelerado para uma aplicação serverless, permitindo deploy de mudanças incrementais sem implantar toda a aplicação.

**O que o developer deve fazer?**

- A. **Usar o comando `sam sync` do AWS SAM para implantar mudanças incrementais** ✅
- B. Usar o comando `sam deploy` do AWS SAM para implantar mudanças incrementais
- C. Usar o comando `cdk deploy` do AWS CDK para implantar mudanças incrementais
- D. Usar o comando `cdk diff` do AWS CDK para implantar mudanças incrementais

**Resposta: A**

**Explicação:**
O comando `sam sync` foi projetado especificamente para sincronizar mudanças locais com a aplicação serverless implantada na AWS de forma incremental e rápida, sem reimplantar toda a stack.

- B está errada: `sam deploy` realiza um deploy completo da aplicação mesmo para pequenas mudanças.
- C está errada: `cdk deploy` é para projetos CDK, não SAM, e não otimiza deploys incrementais.
- D está errada: `cdk diff` apenas mostra diferenças entre o stack local e o implantado — não faz deploy.

---

## Pergunta 58 [P02] · Domínio: Development with AWS Services

Um líder de equipe precisa gerar relatórios semanais de builds do CodeBuild (quantidade, % sucesso/falha, tempo total) e analisar logs de builds com falha no Athena.

**Qual opção vai ajudar?**

- A. Usar Amazon EventBridge
- B. **Habilitar integração S3 e CloudWatch Logs** ✅
- C. Usar AWS CloudTrail e entregar logs ao S3
- D. Usar integração com AWS Lambda

**Resposta: B**

**Explicação:**
CodeBuild reporta métricas via CloudWatch (total de builds, falhas, sucessos, duração). Os dados de logs podem ser exportados do CloudWatch Logs para um bucket S3 e então analisados com Athena para queries customizadas.

- A está errada: EventBridge integra com CodeBuild, mas para análise de logs o CloudWatch + S3 é mais adequado.
- C está errada: CloudTrail registra chamadas de API, não métricas de builds.
- D está errada: Lambda seria necessário para leitura programática de logs, mas CloudWatch + S3 já oferece essa funcionalidade nativa.

---

## Pergunta 60 [P02] · Domínio: Development with AWS Services

Um jogo permite compras com moedas virtuais. Para cada compra, tanto a tabela de jogadores quanto a tabela de itens no DynamoDB precisam ser atualizadas simultaneamente como operação all-or-nothing.

**Como você implementaria essa funcionalidade?**

- A. Usar a API BatchWriteItem para atualizar múltiplas tabelas simultaneamente
- B. **Usar a API TransactWriteItems do DynamoDB Transactions** ✅
- C. Usar DynamoDB Streams para capturar transações na tabela de itens e sincronizar com a tabela de jogadores
- D. Usar DynamoDB Streams para capturar transações na tabela de jogadores e sincronizar com a tabela de itens

**Resposta: B**

**Explicação:**
`TransactWriteItems` agrupa até 25 ações de escrita em uma única operação all-or-nothing. As ações são concluídas atomicamente — ou todas têm sucesso ou nenhuma é aplicada.

- A está errada: BatchWriteItem pode ter sucesso parcial (algumas operações bem-sucedidas, outras não).
- C e D estão erradas: DynamoDB Streams captura mudanças de itens, mas não garante atomicidade entre tabelas.

---

## Pergunta 61 [P02] · Domínio: Development with AWS Services

Instâncias EC2 na Conta A precisam acessar dados PII em múltiplos buckets S3 na Conta B.

**Qual solução você recomendaria?**

- A. Criar uma IAM role (instance profile) na Conta A definindo Conta B como trusted entity + inline policy para acessar S3 na Conta B
- B. Adicionar bucket policy em todos os buckets S3 da Conta B para permitir acesso das instâncias EC2 da Conta A
- C. Copiar a AMI das instâncias da Conta A para a Conta B e lançar instâncias na Conta B
- D. **Criar uma IAM role com acesso S3 na Conta B definindo Conta A como trusted entity. Criar outra role (instance profile) na Conta A e anexar às instâncias EC2 com inline policy para assumir a role da Conta B** ✅

**Resposta: D**

**Explicação:**
O padrão correto para cross-account access:
1. Conta B: criar IAM role com acesso S3, definir Conta A como trusted entity
2. Conta A: criar instance profile para as EC2s com permissão `sts:AssumeRole` da role da Conta B

- A está errada: a trusted entity deve ser a conta que vai assumir a role (Conta A), não a conta destino (Conta B).
- B está errada: apenas bucket policy na Conta B não é suficiente — é necessário também a IAM policy na Conta A.
- C está errada: copiar AMI não resolve o problema de acesso cross-account.

---

## Pergunta 63 [P02] · Domínio: Development with AWS Services

Um developer instalou o Kinesis Agent for Windows para transmitir logs JSON ao S3 via Kinesis Data Firehose.

**Qual tipo de destino NÃO é suportado pelo Kinesis Firehose?**

- A. Qual dos seguintes sink types NÃO é suportado pelo Kinesis Firehose?
- B. **Amazon ElastiCache com Amazon S3 como backup** ✅
- C. Amazon Elasticsearch Service com backup opcional no S3
- D. Amazon Redshift com Amazon S3
- E. Amazon S3 como destino direto do Firehose

**Resposta: B**

**Explicação:**
ElastiCache é um serviço de cache in-memory (Redis/Memcached) e NÃO é um destino suportado pelo Kinesis Data Firehose. Os destinos suportados são: S3, Redshift, Amazon ES (OpenSearch), e Splunk.

---

## Pergunta 64 [P02] · Domínio: Development with AWS Services

Um volume EBS em us-east-1a ficou disponível após a instância ser terminada. Um colega tenta anexar o volume a uma nova instância EC2 em us-east-1e, mas não consegue.

**Qual explicação você daria?**

- A. As permissões IAM necessárias estão ausentes
- B. Volumes EBS são travados por Region
- C. **Volumes EBS são travados por AZ** ✅
- D. O volume EBS está criptografado

**Resposta: C**

**Explicação:**
Quando você cria um volume EBS, ele é automaticamente replicado dentro de sua Availability Zone. Você pode anexar um volume EBS apenas a uma instância EC2 na mesma Availability Zone. `us-east-1a` e `us-east-1e` são AZs diferentes.

---

## Pergunta 1 [P03] · Domínio: Development with AWS Services

Uma empresa precisa garantir a replicação de qualquer dado armazenado em seus buckets S3 para fins de conformidade.

**Quais das seguintes características estão corretas ao configurar um bucket S3 para replicação?** (Selecione duas)

- A. S3 lifecycle actions NÃO são replicadas com a replicação S3
- B. Ao habilitar a replicação, todos os objetos antigos e novos serão replicados
- C. Objetos replicados não retêm metadados
- D. Object tags não podem ser replicadas entre regiões com Cross-Region Replication
- E. **SRR e CRR podem ser configuradas no nível de bucket, de prefixo compartilhado ou de objeto usando S3 object tags** ✅
- F. **S3 lifecycle actions NÃO são replicadas com a replicação S3** ✅

**Resposta: A, E**

**Explicação:**
- **SRR/CRR configuradas por bucket/prefixo/objeto**: a replicação pode ser configurada no nível de bucket, de um prefixo compartilhado, ou de objeto usando tags — adicionando uma replication configuration no bucket de origem especificando o bucket de destino.
- **Lifecycle actions não são replicadas**: para ter a mesma lifecycle configuration em origem e destino, você deve habilitá-la explicitamente nos dois buckets.

- D está errada: object tags **podem** ser replicadas entre regiões com CRR.
- B está errada: a replicação só replica objetos adicionados **após** ser habilitada — objetos existentes não são replicados automaticamente.
- C está errada: objetos replicados **retêm** todos os metadados (incluindo hora de criação e version IDs).

---

## Pergunta 2 [P03] · Domínio: Development with AWS Services

Uma empresa quer automatizar e orquestrar um fluxo de dados multi-origem de alto volume em uma solução de gestão de dados escalável. A solução deve garantir que as regras de negócio e transformações sejam executadas em sequência, suportar reprocessamento em caso de erros e exigir manutenção mínima.

**Qual serviço AWS a empresa deve usar para gerenciar e automatizar a orquestração dos fluxos de dados?**

- A. AWS Glue
- B. **AWS Step Functions** ✅
- C. Amazon Kinesis Data Streams
- D. AWS Batch

**Resposta: B**

**Explicação:**
O AWS Step Functions é um serviço de workflow visual que ajuda desenvolvedores a usar serviços AWS para construir aplicações distribuídas, automatizar processos, orquestrar microserviços e criar pipelines de dados e ML.

- C está errada: o Kinesis Data Streams é um serviço de streaming de dados em tempo real — não orquestra workflows.
- A está errada: o AWS Glue é um serviço de integração de dados serverless — focado em ETL, não em orquestração de regras de negócio.
- D está errada: o AWS Batch gerencia jobs de computação em lote — não orquestra workflows com decisões condicionais.

---

## Pergunta 4 [P03] · Domínio: Development with AWS Services

Você migrou um banco de dados SQL Server on-premises para o RDS em uma subnet privada de um VPC. A aplicação Java foi migrada para uma função Lambda.

**O que você deve implementar para conectar a Lambda ao RDS?**

- A. Usar Lambda layers para conectar à internet e ao RDS separadamente
- B. **Configurar a Lambda para conectar ao VPC com a subnet privada e o Security Group necessário para acessar o RDS** ✅
- C. Usar variáveis de ambiente para passar a connection string do RDS
- D. Configurar a Lambda para conectar à subnet pública e usar Security Group para acessar o RDS na subnet privada

**Resposta: B**

**Explicação:**
Você pode configurar uma Lambda para conectar a subnets privadas em um VPC. O Lambda cria interfaces de rede elásticas para cada combinação de security group e subnet na configuração do VPC da função — permitindo acesso a recursos privados como o RDS.

- A está errada: Lambda Layers são para incluir bibliotecas e dependências — não configuram acesso ao RDS.
- D está errada: conectar uma Lambda a uma subnet pública não lhe dá acesso à internet nem IP público. Para acesso à internet, o VPC precisa de um NAT gateway.
- C está errada: variáveis de ambiente podem conter a connection string, mas você ainda precisa de acesso de rede ao RDS.

---

## Pergunta 9 [P03] · Domínio: Development with AWS Services

Seu empresa usa um Application Load Balancer para rotear tráfego para aplicações em EC2. Como parte de novas regras de conformidade, você precisa capturar o endereço IP do cliente.

**Como você faria isso?**

- A. Obter os IPs dos Elastic Load Balancing logs
- B. Obter os IPs dos server access logs
- C. **Usar o header `X-Forwarded-For`** ✅
- D. Usar o header `X-Forwarded-From`

**Resposta: C**

**Explicação:**
O header `X-Forwarded-For` armazena o IP real do cliente. Como o load balancer intercepta o tráfego, os logs do servidor contêm apenas o IP do load balancer. O Elastic Load Balancing armazena o IP do cliente no header `X-Forwarded-For` e passa para o servidor.

- B está errada: os server access logs contêm apenas o IP do load balancer.
- A está errada: os ELB logs registram requisições ao load balancer — incluindo requisições que nunca chegaram às instâncias.
- D está errada: `X-Forwarded-From` não existe — é uma opção inventada.

---

## Pergunta 10 [P03] · Domínio: Development with AWS Services

Uma empresa de redes sociais considera usar Amazon ElastiCache para melhorar a performance dos bancos de dados existentes.

**Quais casos de uso são o MELHOR fit para ElastiCache?** (Selecione duas)

- A. Melhorar latência e throughput para workloads com muita escrita
- B. Executar queries JOIN muito complexas
- C. Melhorar performance de workloads ETL
- D. **Melhorar latência e throughput para workloads com muita leitura** ✅
- E. **Melhorar performance de workloads computacionalmente intensivos** ✅

**Resposta: D, E**

**Explicação:**
O ElastiCache é ideal para: workloads com muita leitura (redes sociais, games, compartilhamento de mídia) e workloads computacionalmente intensivos (como engines de recomendação) — ao armazenar objetos frequentemente lidos no cache.

- A está errada: caching não é bom para aplicações com muita escrita — o cache fica desatualizado rapidamente.
- C está errada: workloads ETL processam grandes volumes de dados — use AWS Glue ou Amazon EMR.
- B está errada: queries JOIN complexas devem ser executadas em bancos relacionais como RDS ou Aurora.

---

## Pergunta 11 [P03] · Domínio: Development with AWS Services

Uma empresa de streaming com mais de 100 milhões de membros usa AWS para toda sua computação e armazenamento. A rede gera múltiplos terabytes de flow logs diariamente. A empresa precisa ingerir e analisar esses dados em tempo real com flexibilidade para direcionar para sistemas downstream.

**Qual tecnologia/serviço a empresa deve usar?**

- A. AWS Glue
- B. Amazon SQS
- C. Amazon Kinesis Data Firehose
- D. **Amazon Kinesis Data Streams** ✅

**Resposta: D**

**Explicação:**
O Kinesis Data Streams (KDS) captura gigabytes de dados por segundo de centenas de milhares de fontes. Fornece ordenação de registros e a capacidade de ler/reprocessar registros na mesma ordem para múltiplas aplicações Kinesis — ideal para billing + auditoria no mesmo stream.

- C está errada: o Kinesis Data Firehose carrega dados em datastores (S3, Redshift, Elasticsearch, Splunk) — não suporta consumers customizados com a mesma flexibilidade do KDS.
- B está errada: o SQS não suporta múltiplos consumers consumindo o mesmo stream de dados em ordem.
- A está errada: o AWS Glue é para ETL — não processa dados em tempo real de forma eficiente.

---

## Pergunta 16 [P03] · Domínio: Development with AWS Services

Um estagiário quer entender a seguinte bucket policy S3:
- Statement 1: Allow `s3:ListAllMyBuckets` em `arn:aws:s3:::*`
- Statement 2: Allow `s3:ListBucket` e `s3:GetBucketLocation` em `arn:aws:s3:::*`
- Statement 3: Allow operações de objeto em `arn:aws:s3:::*/*`
- Statement 4: Deny `s3:*` em bucket `Production` com condição `NumericGreaterThanIfExists aws:MultiFactorAuthAge > 1800`

**Para que serve essa policy?**

- A. Permite gerenciar um único bucket e nega tudo sem MFA nos últimos 30 minutos
- B. Permite acesso ao home directory no S3
- C. Permite acesso total ao S3 a um usuário Cognito, mas nega o bucket Production se não autenticado
- D. **Permite acesso total ao S3, mas nega explicitamente acesso ao bucket Production se o usuário não fez login com MFA nos últimos 30 minutos** ✅

**Resposta: D**

**Explicação:**
Esta policy permite acesso total ao S3 (listagem, leitura, escrita), mas usa `NumericGreaterThanIfExists` com `aws:MultiFactorAuthAge > 1800` para negar acesso ao bucket `Production` se o MFA não estiver presente ou se tiver mais de 30 minutos. Acesso programático ao bucket Production exige credenciais temporárias geradas via `GetSessionToken` nos últimos 30 minutos.

---

## Pergunta 18 [P03] · Domínio: Development with AWS Services

Uma empresa tem um backend serverless com workflows computacionalmente pesados em funções Lambda. A equipe notou lag de performance.

**Qual é a MELHOR solução?**

- A. Usar provisioned concurrency para os workflows pesados
- B. Invocar as funções Lambda de forma assíncrona
- C. **Aumentar a quantidade de memória disponível para as funções Lambda** ✅
- D. Usar reserved concurrency para os workflows pesados

**Resposta: C**

**Explicação:**
No modelo de recursos do Lambda, a memória alocada determina proporcionalmente o poder de CPU e outros recursos. Aumentar a memória de 128 MB a 10.240 MB (em incrementos de 64 MB) disponibiliza mais poder de processamento — sem mudanças de código.

- B está errada: invocação assíncrona não altera a capacidade de processamento da função.
- A e D estão erradas: provisioned e reserved concurrency controlam **quantas instâncias** da função podem rodar simultaneamente — não a capacidade de CPU/memória de cada instância.

---

## Pergunta 21 [P03] · Domínio: Development with AWS Services

Uma empresa de mídia usa filas SQS para gerenciar transações. O payload das mensagens está crescendo além do limite de 256 KB do SQS.

**O que pode ser feito para que a fila aceite mensagens de tamanho maior?**

- A. **Usar o SQS Extended Client** ✅
- B. Solicitar aumento de service limit à AWS
- C. Usar compressão gzip
- D. Usar a MultiPart API

**Resposta: A**

**Explicação:**
O SQS Extended Client Library (para Java) usa S3 para armazenar payloads de mensagens até 2 GB. A biblioteca gerencia automaticamente o armazenamento da mensagem no S3 e inclui a referência na mensagem SQS.

- D está errada: não existe MultiPart API para SQS.
- B está errada: embora alguns limites possam ser aumentados, a AWS já oferece o Extended Client para esse propósito.
- C está errada: compressão gzip pode ajudar, mas os dados codificados adicionam bulk e não é a solução ideal.

---

## Pergunta 23 [P03] · Domínio: Development with AWS Services

Sua empresa tem um contrato de 3 anos com um provedor de saúde. Os backups mensais do banco de dados devem ser retidos por toda a duração do contrato. O limite de retenção de backups automáticos do RDS (máximo 35 dias) não atende ao requisito.

**Qual solução você usaria?**

- A. **Criar um cron event no CloudWatch que aciona uma Lambda que dispara o snapshot do banco de dados** ✅
- B. Habilitar RDS Read Replicas
- C. Habilitar RDS automatic backups
- D. Habilitar RDS Multi-AZ

**Resposta: A**

**Explicação:**
Usando um EventBridge Rule com schedule expression e uma Lambda function, você cria snapshots manuais do RDS periodicamente. Snapshots manuais não têm limite de retenção — você os mantém pelo tempo que precisar.

- C está errada: backups automáticos têm retenção máxima de 35 dias — insuficiente para 3 anos.
- B está errada: Read Replicas aumentam capacidade de leitura — não são para backup de longo prazo.
- D está errada: Multi-AZ melhora disponibilidade — não afeta retenção de backups.

---

## Pergunta 24 [P03] · Domínio: Development with AWS Services

Uma equipe verifica a viabilidade do AWS Step Functions para um workflow bancário de aprovação de empréstimos, que inclui etapas de **aprovação humana**.

**Quais são as características chave do AWS Step Functions?** (Selecione duas)

- A. **Você deve usar Express Workflows para workloads com alta taxa de eventos e curta duração** ✅
- B. Standard e Express Workflows suportam todas as integrações, atividades e design patterns
- C. Express Workflows têm duração máxima de 5 minutos e Standard de 180 dias (6 meses)
- D. **Standard Workflows são adequados para workflows de longa duração, duráveis e auditáveis que também suportam etapas de aprovação humana** ✅
- E. Standard Workflows não suportam etapas de aprovação humana

**Resposta: A, D**

**Explicação:**
- **Standard Workflows**: adequados para workflows de longa duração, duráveis e auditáveis (ex.: processamento de empréstimos, billing, pedidos). Suportam human approval steps.
- **Express Workflows**: para workloads com alta taxa de eventos (>100.000/segundo) e curta duração.

- E está errada: Standard Workflows **suportam** human approval steps.
- C está errada: Standard Workflows têm duração máxima de **1 ano** (não 180 dias).
- B está errada: Express Workflows **não suportam** activities, job-run (.sync) e Callback patterns.

---

## Pergunta 28 [P03] · Domínio: Development with AWS Services

Uma fintech fatura seus clientes por unidade de clickstream data. A empresa precisa processar dados para billing e auditoria **na mesma ordem** com uma janela de **7 dias**.

**Qual serviço permite isso?**

- A. AWS Kinesis Data Analytics
- B. **AWS Kinesis Data Streams** ✅
- C. AWS Kinesis Data Firehose
- D. Amazon SQS

**Resposta: B**

**Explicação:**
O Kinesis Data Streams fornece ordenação de registros e a capacidade de ler/reprocessar registros **na mesma ordem** para múltiplas aplicações. A retenção padrão é 24 horas, podendo ser configurada para até 365 dias — permitindo que a aplicação de auditoria processe o mesmo stream até 7 dias após o billing.

- C está errada: o Kinesis Data Firehose carrega dados em datastores — não suporta consumers que leem na mesma ordem.
- A está errada: o Kinesis Data Analytics é para queries SQL em streams em tempo real.
- D está errada: o SQS não permite que a mesma mensagem seja consumida por múltiplos consumers na mesma ordem horas depois.

---

## Pergunta 29 [P03] · Domínio: Development with AWS Services

Você quer habilitar detailed monitoring em uma instância EC2 em execução usando o AWS CLI.

**Qual comando você executaria?**

- A. `aws ec2 monitor-instances --instance-id i-1234567890abcdef0`
- B. `aws ec2 run-instances --image-id ami-09092360 --monitoring Enabled=true`
- C. `aws ec2 run-instances --image-id ami-09092360 --monitoring State=enabled`
- D. **`aws ec2 monitor-instances --instance-ids i-1234567890abcdef0`** ✅

**Resposta: D**

**Explicação:**
`aws ec2 monitor-instances --instance-ids` (plural) habilita detailed monitoring para instâncias já em execução.

- A está errada: a opção correta é `--instance-ids` (plural), não `--instance-id`.
- B está errada: essa sintaxe é usada para habilitar detailed monitoring **ao lançar** uma nova instância.
- C está errada: sintaxe inválida.

---

## Pergunta 32 [P03] · Domínio: Development with AWS Services

Um novo membro da equipe está criando uma Dead Letter Queue (DLQ) para funções Lambda.

**Em quais casos o Lambda adiciona uma mensagem na DLQ?** (Selecione duas)

- A. A invocação Lambda é síncrona
- B. O evento foi processado com sucesso
- C. A invocação Lambda falhou apenas uma vez, mas teve sucesso depois
- D. **O evento falhou em todas as tentativas de processamento** ✅
- E. **A invocação Lambda é assíncrona** ✅

**Resposta: D, E**

**Explicação:**
- **Assíncrona**: quando uma invocação assíncrona excede a idade máxima ou falha em todas as tentativas de retry, o Lambda descarta o evento ou o envia para a DLQ (se configurada).
- **Todas as tentativas falharam**: a DLQ é acionada quando o evento não pode ser processado com sucesso em nenhuma tentativa.

- A está errada: invocações síncronas retornam o erro diretamente ao chamador — não usam DLQ.
- B e C estão erradas: eventos processados com sucesso não vão para a DLQ.

---

## Pergunta 33 [P03] · Domínio: Development with AWS Services

Você lançou uma plataforma de aprendizado online usando Lambda e API Gateway. Quer introduzir gradualmente a versão 2 roteando apenas **10% do tráfego** para a nova Lambda.

**Qual solução você adotaria?**

- A. Usar environment variables
- B. Fazer deploy da Lambda em um VPC
- C. **Usar AWS Lambda Aliases** ✅
- D. Usar Tags para distinguir as versões

**Resposta: C**

**Explicação:**
Um Lambda alias pode apontar para **duas versões com pesos de tráfego**. Você configura o alias para enviar 90% para a versão 1 e 10% para a versão 2 — sem nenhuma mudança nas event sources. Quando a versão 2 estiver validada, você atualiza o alias para 100%.

- D está errada: tags são para organização e billing — não controlam roteamento de tráfego.
- A está errada: variáveis de ambiente ajustam comportamento — não distribuem tráfego entre versões.
- B está errada: implantar Lambda em VPC adiciona isolamento de rede — não distribui tráfego.

---

## Pergunta 38 [P03] · Domínio: Development with AWS Services

Uma empresa usa RDS como banco de dados. Foi decidido configurar uma camada de caching gerenciada de alta confiabilidade na frente do RDS, onde a **regeneração do conteúdo do cache é cara**.

**Qual é a melhor escolha?**

- A. **Implementar Amazon ElastiCache Redis em Cluster Mode** ✅
- B. Implementar Amazon ElastiCache Memcached
- C. Migrar o banco de dados para o Amazon Redshift
- D. Instalar Redis em uma instância EC2

**Resposta: A**

**Explicação:**
O ElastiCache for Redis com Cluster Mode habilitado oferece escalabilidade horizontal (adicionar/remover shards), replicação e snapshots. Com Cluster Mode, você pode ter até 90 shards e escalar para centenas de TBs sem downtime — crucial quando a regeneração do cache é cara.

- B está errada: o Memcached é mais simples, mas não suporta snapshots, replicação ou transações — inadequado para dados cuja regeneração é cara.
- D está errada: instalar Redis em EC2 requer gerenciamento manual de manutenção e patches.
- C está errada: o Amazon Redshift é um data warehouse — não é uma camada de caching.

---

## Pergunta 40 [P03] · Domínio: Development with AWS Services

A equipe de e-commerce está preocupada que o alto volume de pedidos na Black Friday possa sobrecarregar o SQS e causar falhas de mensagens.

**Qual passo você recomendaria?**

- A. **Amazon SQS é altamente escalável e não requer nenhuma intervenção para lidar com os altos volumes esperados** ✅
- B. Habilitar auto-scaling na fila SQS
- C. Converter a fila para FIFO, já que mensagens ordenadas serão processadas mais rápido
- D. Pré-configurar a fila SQS para aumentar a capacidade quando as mensagens atingirem um threshold

**Resposta: A**

**Explicação:**
O Amazon SQS usa a nuvem AWS para escalar dinamicamente conforme a demanda — sem necessidade de planejamento de capacidade ou pré-provisionamento. Para a maioria das filas Standard, há capacidade para aproximadamente 120.000 mensagens inflight simultaneamente.

- D está errada: o SQS escala automaticamente — não há pré-configuração manual.
- B está errada: filas SQS são auto-escaláveis por definição.
- C está errada: você não pode converter uma fila Standard existente em FIFO — precisa criar uma nova.

---

## Pergunta 41 [P03] · Domínio: Development with AWS Services

Uma equipe usa buckets S3 compartilhados para upload de arquivos. Objetos têm proprietários diferentes, dificultando o gerenciamento.

**Qual funcionalidade permite automaticamente que o proprietário do bucket seja o proprietário de todos os objetos, independentemente de qual conta fez o upload?**

- A. Usar S3 CORS
- B. Usar S3 Access Analyzer
- C. Usar Bucket ACLs
- D. **Usar S3 Object Ownership** ✅

**Resposta: D**

**Explicação:**
O S3 Object Ownership permite definir que o proprietário do bucket seja também o proprietário de todos os novos objetos. Com a configuração "Bucket owner preferred", qualquer objeto carregado com o canned ACL `bucket-owner-full-control` automaticamente pertence ao proprietário do bucket.

- A está errada: CORS controla requisições cross-domain — não proprietário de objetos.
- B está errada: S3 Access Analyzer revisa buckets com acesso público/compartilhado — não altera proprietários.
- C está errada: Bucket ACLs controlam acesso ao bucket — não a propriedade dos objetos.

---

## Pergunta 42 [P03] · Domínio: Development with AWS Services

Você trabalha com o AWS CLI criando funções Lambda com mais de 50 variáveis de ambiente com dados sensíveis de tabelas de banco de dados.

**Qual é o limite total de variáveis de ambiente no Lambda?**

- A. Total não deve exceder 8 KB; máximo de 50 variáveis
- B. Total não deve exceder 4 KB; máximo de 35 variáveis
- C. **Total não deve exceder 4 KB; sem limite no número de variáveis** ✅
- D. Total não deve exceder 8 KB; sem limite no número de variáveis

**Resposta: C**

**Explicação:**
O tamanho total de todas as variáveis de ambiente não pode exceder **4 KB**. Não há limite no número de variáveis que podem ser criadas — apenas no tamanho total.

---

## Pergunta 45 [P03] · Domínio: Development with AWS Services

Sua empresa quer adotar uma arquitetura serverless e implantar containers Docker da forma mais **simples e com menos esforço**.

**Qual opção você escolheria?**

- A. Amazon EKS on Fargate
- B. Amazon ECS on EC2
- C. **Amazon ECS on Fargate** ✅
- D. AWS Elastic Beanstalk

**Resposta: C**

**Explicação:**
O Amazon ECS on Fargate é a opção mais simples para containers serverless. O Fargate elimina a necessidade de provisionar/gerenciar servidores — você especifica CPU e memória por task, e a AWS gerencia a infraestrutura.

- A está errada: EKS on Fargate também é serverless, mas o Kubernetes tem maior complexidade de operação — não é o mais simples.
- B está errada: ECS on EC2 requer gerenciamento das instâncias EC2 do cluster — não é serverless.
- D está errada: o Elastic Beanstalk usa instâncias EC2 — não é serverless.

---

## Pergunta 52 [P03] · Domínio: Development with AWS Services

Você está criando uma aplicação mobile que precisa de acesso ao API Gateway. Usuários precisam se registrar antes de acessar e você quer **gerenciamento de usuários totalmente gerenciado**.

**Qual opção de autenticação você usaria?**

- A. **Usar Cognito User Pools** ✅
- B. Usar API Gateway User Pools
- C. Usar Lambda Authorizer
- D. Usar permissões IAM com sigv4

**Resposta: A**

**Explicação:**
O Cognito User Pools é um diretório de usuários totalmente gerenciado que suporta registro, login, e acesso. Você cria um authorizer do tipo `COGNITO_USER_POOLS` no API Gateway — após login, o cliente usa o token obtido no header `Authorization`.

- C está errada: um Lambda Authorizer é para autenticação customizada (OAuth, SAML) — não é gerenciamento de usuários totalmente gerenciado.
- D está errada: IAM com SigV4 requer criação de um usuário IAM por visitante — impraticável para uma aplicação pública.
- B está errada: "API Gateway User Pools" é uma opção inventada.

---

## Pergunta 53 [P03] · Domínio: Development with AWS Services

Uma aplicação hospedada em EC2 deve exibir fotos de perfil de funcionários armazenadas em um bucket S3 **privado** de forma segura.

**Qual solução você recomendaria?**

- A. Tornar o bucket S3 público
- B. Manter as imagens codificadas em base64 em uma tabela DynamoDB
- C. **Salvar a chave S3 de cada foto em uma tabela DynamoDB e usar uma Lambda para gerar dinamicamente uma pre-signed URL** ✅
- D. Manter as imagens codificadas em base64 em uma tabela RDS

**Resposta: C**

**Explicação:**
Pre-signed URLs permitem acesso temporário a objetos S3 privados. A Lambda recupera a chave S3 do DynamoDB, gera uma pre-signed URL usando o IAM instance profile da instância EC2 e a retorna para a aplicação web exibir a imagem.

- A está errada: tornar o bucket público viola os requisitos de segurança.
- B e D estão erradas: armazenar imagens codificadas em base64 em bancos de dados é uma má prática — aumenta o tamanho dos dados e não aproveita os recursos otimizados do S3 para objetos binários.

---

## Pergunta 54 [P03] · Domínio: Development with AWS Services

Uma aplicação web 3-tier usa API Gateway como camada de aplicação com um banco RDS. O objetivo é **reduzir o número de chamadas ao endpoint e melhorar a latência**.

**O que você pode fazer?**

- A. Usar Mapping Templates
- B. Usar Amazon Kinesis Data Streams
- C. Usar Stage Variables
- D. **Habilitar API Gateway Caching** ✅

**Resposta: D**

**Explicação:**
O API Gateway Caching armazena respostas do endpoint em cache por um período TTL configurável (padrão 300s, máximo 3600s). Requisições subsequentes são respondidas diretamente do cache — reduzindo chamadas ao backend e melhorando a latência.

- A está errada: Mapping Templates transformam payloads — não reduzem chamadas ao backend.
- C está errada: Stage Variables são variáveis de configuração por stage — não cacheiam respostas.
- B está errada: Kinesis Data Streams é para streaming de dados em tempo real — não reduz chamadas de API.

---

## Pergunta 56 [P03] · Domínio: Development with AWS Services

Sua tabela DynamoDB tem 400 WCUs distribuídas em 4 partições. Uma partição recebe 250 WCU/segundo enquanto as outras recebem muito menos. Você recebe `ProvisionedThroughputExceededException`.

**Qual é a causa provável?**

- A. WCUs são aplicadas em todas as tabelas DynamoDB e precisam de reconfiguração
- B. A IAM policy configurada está errada
- C. **Você tem uma hot partition** ✅
- D. O monitoramento do CloudWatch está com atraso

**Resposta: C**

**Explicação:**
Quando uma partição recebe volume desproporcional de leituras/escritas, ela é chamada de "hot partition". Mesmo que a capacidade total provisionada seja suficiente, o DynamoDB distribui a capacidade entre partições — e uma partição não pode exceder sua parcela alocada. Use DynamoDB Adaptive Capacity ou redesenhe a partition key para distribuir melhor o tráfego.

- D está errada: o erro é do próprio DynamoDB — não do CloudWatch.
- B está errada: `ProvisionedThroughputExceededException` não é um erro de autorização.
- A está errada: RCUs e WCUs são específicos por tabela — não compartilhados entre tabelas.

---

## Pergunta 57 [P03] · Domínio: Development with AWS Services

Uma equipe quer criptografar um objeto de **111 GB** usando AWS KMS.

**Qual é a melhor solução?**

- A. Usar a API `Encrypt` para criptografar os dados como ciphertext usando um CMK
- B. Usar a API `GenerateDataKeyWithoutPlaintext` e criptografar os dados com a chave criptografada
- C. **Usar a API `GenerateDataKey` que retorna uma plaintext key e uma cópia criptografada; usar a plaintext key para criptografar os dados** ✅
- D. Usar a API `GenerateDataKeyWithPlaintext` que retorna uma cópia criptografada; usar a plaintext key para criptografar

**Resposta: C**

**Explicação:**
Para criptografar dados grandes fora do AWS KMS (envelope encryption):
1. Chamar `GenerateDataKey` → recebe a **plaintext data key** e uma cópia criptografada.
2. Usar a **plaintext data key** para criptografar os dados localmente.
3. Apagar a plaintext data key da memória.
4. Armazenar a data key criptografada junto com os dados criptografados.
5. Para descriptografar: chamar `Decrypt` na data key criptografada, depois descriptografar os dados.

- A está errada: a API `Encrypt` suporta no máximo 4 KB — não pode criptografar 111 GB diretamente.
- B está errada: `GenerateDataKeyWithoutPlaintext` retorna apenas a chave criptografada — você não pode usá-la diretamente para criptografar dados (precisa descriptografá-la primeiro).
- D está errada: `GenerateDataKeyWithPlaintext` é uma opção inventada.

---

## Pergunta 60 [P03] · Domínio: Development with AWS Services

Um novo usuário IAM tem permissão `s3:PutObject`. O bucket S3 usa SSE-KMS como criptografia padrão. Ao tentar fazer um `PutObject`, a aplicação recebe `AccessDenied`.

**Como você resolveria esse problema?**

- A. Corrigir a bucket policy para permitir uploads de objetos criptografados
- B. **Corrigir a policy do usuário IAM para permitir a action `kms:GenerateDataKey`** ✅
- C. Corrigir a ACL do bucket para permitir uploads criptografados
- D. Corrigir a policy do usuário IAM para permitir a action `s3:Encrypt`

**Resposta: B**

**Explicação:**
Quando um bucket usa SSE-KMS, o S3 precisa de uma data key do KMS para criptografar cada objeto. Para isso, a IAM policy do usuário deve incluir `kms:GenerateDataKey` na CMK do bucket. Sem essa permissão, o PutObject falha com `AccessDenied` mesmo que o usuário tenha `s3:PutObject`.

- A e C estão erradas: o usuário já tem acesso ao bucket — o problema é a permissão KMS ausente.
- D está errada: `s3:Encrypt` não é uma action IAM válida — é uma opção inventada.
