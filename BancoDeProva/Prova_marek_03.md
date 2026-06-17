# Prova Marek 03 — AWS Certified Developer Associate

> **65 questões** | Domínios: Development with AWS Services · Security · Deployment · Troubleshooting and Optimization

---

## Pergunta 1 · Domínio: Development with AWS Services

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

## Pergunta 2 · Domínio: Development with AWS Services

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

## Pergunta 3 · Domínio: Deployment

Sua arquitetura web consiste em múltiplas instâncias EC2 atrás de um Elastic Load Balancer com um Auto Scaling group (desired capacity = 5). Você quer integrar o CodeDeploy para automatizar o deployment, **redirecionando tráfego do ambiente original para o novo ambiente**.

**Qual opção atende ao critério?**

- A. Optar por Immutable deployment
- B. **Optar por Blue/Green deployment** ✅
- C. Optar por In-place deployment
- D. Optar por Rolling deployment

**Resposta: B**

**Explicação:**
O Blue/Green deployment provisiona a nova versão ao lado da versão antiga antes de redirecionar o tráfego de produção. Para EC2/On-Premises, o tráfego é transferido de um conjunto de instâncias do ambiente original para um conjunto de substituição.

- C está errada: In-place para a aplicação em cada instância, instala a nova versão e reinicia — sem redirecionamento de tráfego entre ambientes separados.
- A e D estão erradas: Immutable e Rolling são políticas do Elastic Beanstalk — não do CodeDeploy para instâncias EC2 diretamente.

---

## Pergunta 4 · Domínio: Development with AWS Services

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

## Pergunta 5 · Domínio: Security

Um app mobile de saúde usa algoritmos proprietários de Machine Learning. A equipe quer um sistema escalável de gerenciamento de usuários com login/cadastro e suporte a MFA com o **mínimo de esforço de desenvolvimento**.

**Quais opções você usaria?** (Selecione duas)

- A. Usar Amazon SNS para enviar código MFA via SMS
- B. Usar Lambda functions + DynamoDB para criar uma solução customizada
- C. **Usar Amazon Cognito para gerenciamento de usuários e o processo de login/cadastro** ✅
- D. **Usar Amazon Cognito para habilitar Multi-Factor Authentication (MFA) no login** ✅
- E. Usar Lambda functions + RDS para criar uma solução customizada

**Resposta: C, D**

**Explicação:**
O Amazon Cognito oferece sign-up, sign-in e controle de acesso de forma totalmente gerenciada, escalando para milhões de usuários. Os Cognito User Pools suportam nativmente MFA — sem código adicional.

- B e E estão erradas: criar soluções customizadas com Lambda + DynamoDB ou RDS exige muito mais esforço de desenvolvimento.
- A está errada: o Amazon SNS não pode enviar códigos MFA para aplicações (essa funcionalidade é apenas para usuários IAM e está sendo descontinuada).

---

## Pergunta 6 · Domínio: Troubleshooting and Optimization

Um developer quer habilitar X-Ray tracing em um servidor Linux on-premises que executa uma aplicação customizada acessada via API Gateway.

**Qual é a solução mais eficiente com mínima configuração?**

- A. Configurar uma Lambda para analisar dados de tráfego e retransmitir dados do X-Ray via PutTelemetryRecords API
- B. **Instalar e executar o X-Ray daemon nos servidores on-premises para capturar e retransmitir dados ao serviço X-Ray** ✅
- C. Instalar e executar o CloudWatch Unified Agent para capturar e retransmitir dados X-Ray via PutTraceSegments API
- D. Instalar e executar o X-Ray SDK nos servidores on-premises

**Resposta: B**

**Explicação:**
O X-Ray daemon é uma aplicação de software que escuta no UDP porta 2000, coleta dados de segmentos brutos e os retransmite para a API do X-Ray. Para executá-lo on-premises, faça o download, execute e conceda permissão para fazer upload de documentos de segmentos.

- D está errada: o X-Ray SDK gera dados de trace — mas ele envia para o **daemon**, que então encaminha ao X-Ray. O SDK sozinho não retransmite dados.
- C está errada: o CloudWatch Unified Agent não retransmite dados X-Ray.
- A está errada: uma Lambda não pode processar dados X-Ray de servidores on-premises.

---

## Pergunta 7 · Domínio: Troubleshooting and Optimization

Você quer configurar um Auto Scaling group para escalar com base na métrica de **uso médio de RAM** das instâncias EC2.

**Qual opção oferece a melhor solução?**

- A. Migrar a aplicação para AWS Lambda
- B. Habilitar detailed monitoring para EC2 e ASG para obter dados de RAM e criar um CloudWatch Alarm
- C. Criar um custom alarm para o ASG e fazer as instâncias dispararem via PutAlarmData API
- D. **Criar uma custom metric no CloudWatch e fazer as instâncias enviarem dados via PutMetricData; criar um alarm baseado nessa métrica** ✅

**Resposta: D**

**Explicação:**
RAM usage não é uma métrica padrão do CloudWatch — você deve criar uma custom metric. Usando o AWS CLI ou API, você publica a métrica via `PutMetricData`. High-resolution custom metrics permitem granularidade de 1 segundo, com alarmes avaliados a cada 10 segundos.

- B está errada: o detailed monitoring aumenta a frequência das métricas padrão do EC2 para 1 minuto — mas RAM não é uma métrica padrão e ainda não é coletada.
- A está errada: migrar para Lambda não resolve o monitoramento de RAM do ASG.
- C está errada: `PutAlarmData` não existe — a API correta é `PutMetricData`.

---

## Pergunta 8 · Domínio: Troubleshooting and Optimization

Você usa um template CloudFormation que aceita o nome do cluster ECS como parâmetro. Na primeira execução com 'MainCluster', 5 instâncias foram criadas corretamente. Na segunda execução com 'SecondCluster', as instâncias foram lançadas no 'MainCluster' em vez do 'SecondCluster'.

**Qual é a causa raiz do problema?**

- A. A instância EC2 não tem permissões IAM para entrar no outro cluster
- B. Os security groups estão apontando para o cluster ECS errado
- C. A imagem Docker do ECS agent precisa ser reconstruída
- D. **O parâmetro do nome do cluster não foi atualizado no arquivo `/etc/ecs/ecs.config` durante o bootstrap** ✅

**Resposta: D**

**Explicação:**
No arquivo `ecs.config`, o parâmetro `ECS_CLUSTER='your_cluster_name'` registra a instância no cluster correto. Se esse parâmetro não for atualizado durante o bootstrap da nova execução do template, as instâncias se registram no cluster padrão (ou o primeiro definido).

- A está errada: as instâncias estão se registrando — as permissões funcionam, apenas o cluster está errado.
- C está errada: o ECS agent funcionou corretamente na primeira execução.
- B está errada: security groups controlam tráfego de rede — não o registro em clusters ECS.

---

## Pergunta 9 · Domínio: Development with AWS Services

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

## Pergunta 10 · Domínio: Development with AWS Services

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

## Pergunta 11 · Domínio: Development with AWS Services

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

## Pergunta 12 · Domínio: Troubleshooting and Optimization

Você gerencia 10 instâncias EC2 com leituras intensas no RDS for PostgreSQL e quer preparar a arquitetura para disaster recovery.

**Quais funcionalidades ajudarão?** (Selecione duas)

- A. Habilitar automated backup em Multi-AZ que cria backups em múltiplas regiões
- B. **Habilitar automated backup em Multi-AZ que cria backups em uma única região AWS** ✅
- C. Usar RDS Provisioned IOPS em vez de General Purpose SSD
- D. Usar database cloning do RDS DB cluster
- E. **Usar cross-Region Read Replicas** ✅

**Resposta: B, E**

**Explicação:**
- **Cross-Region Read Replicas**: em caso de falha regional, você pode promover a Read Replica para ser a nova fonte primária.
- **Automated backup Multi-AZ em uma única região**: backups automáticos são feitos do standby (sem impacto de I/O no primário) e suportam point-in-time recovery.

- A está errada: backups automáticos são limitados a **uma única região** — manual snapshots e Read Replicas suportam múltiplas regiões.
- C está errada: Provisioned IOPS melhora performance — não é uma opção de disaster recovery.
- D está errada: database cloning é uma funcionalidade do Aurora — não do RDS.

---

## Pergunta 13 · Domínio: Deployment

Um developer precisa implantar instâncias EC2 em várias contas AWS e quer que apenas tipos de instância pré-aprovados possam ser selecionados no template CloudFormation.

**Como integrar a lista de tipos de instância autorizados ao template?**

- A. **Configurar um parâmetro com a lista de tipos de instância EC2 como AllowedValues no template CloudFormation** ✅
- B. Configurar parâmetros separados para cada tipo de instância EC2
- C. Configurar um pseudo parâmetro com a lista como AllowedValues
- D. Configurar um mapping com a lista de tipos de instância como parâmetros

**Resposta: A**

**Explicação:**
A seção `Parameters` do CloudFormation permite customizar templates. O campo `AllowedValues` define um array de valores permitidos para o parâmetro — ao fazer um deploy, o usuário só pode escolher um dos valores da lista.

- B está errada: parâmetros separados por tipo de instância são semanticamente incorretos e confusos.
- D está errada: a seção `Mappings` usa key-value pairs — não suporta parâmetros ou pseudo-parâmetros.
- C está errada: pseudo-parâmetros são predefinidos pela AWS (ex.: `AWS::Region`) — você não os declara no template.

---

## Pergunta 14 · Domínio: Deployment

Os desenvolvedores têm controle total do processo de entrega de software, do código ao deployment. Você, como team lead, é responsável por qualquer aprovação manual necessária.

**Qual abordagem suporta esse workflow?**

- A. Usar CodePipeline com Amazon VPC
- B. Criar CodePipelines profundamente integrados para cada ambiente
- C. Criar múltiplos CodePipelines para cada ambiente e linká-los via Lambda
- D. **Criar um único CodePipeline para todo o fluxo e adicionar um manual approval step** ✅

**Resposta: D**

**Explicação:**
Você pode adicionar uma approval action a um stage do CodePipeline onde o pipeline deve pausar aguardando aprovação ou rejeição manual. Isso permite que o team lead revise e aprove antes que o pipeline continue.

- C está errada: funções Lambda podem ser adicionadas como actions, mas o approval step é um processo de workflow — não pode ser delegado a um serviço externo.
- B está errada: múltiplos pipelines por ambiente não centraliza o processo de aprovação.
- A está errada: o uso de VPC com CodePipeline é uma feature de segurança (PrivateLink) — não resolve o requisito de aprovação manual.

---

## Pergunta 15 · Domínio: Security

Uma aplicação usa Cognito user pools e Identity pools para acesso seguro ao S3. O developer quer garantir que apenas usuários autorizados acessem seus próprios arquivos.

**Qual é a solução mais eficiente?**

- A. **Usar uma IAM policy com o prefixo de identidade do Amazon Cognito para permitir acesso apenas aos próprios objetos no S3** ✅
- B. Integrar API Gateway com Lambda para validar uploads/downloads
- C. Usar S3 Event Notifications para acionar Lambda de validação
- D. Usar CloudFront Lambda@Edge para validar uploads/downloads

**Resposta: A**

**Explicação:**
Você pode criar uma IAM policy baseada em identidade que permite acesso apenas a objetos cujo nome inclui o ID federado do usuário (via variável `${cognito-identity.amazonaws.com:sub}`). Isso garante que cada usuário só acesse sua própria pasta — sem código adicional.

- C e B estão erradas: embora seja possível construir essas soluções, elas não impedem um upload inválido para a pasta de outro usuário.
- D está errada: a solução assume uma distribuição CloudFront — adiciona custo e latência desnecessários.

---

## Pergunta 16 · Domínio: Development with AWS Services

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

## Pergunta 17 · Domínio: Troubleshooting and Optimization

Uma empresa tem um stack serverless integrado com X-Ray. O volume de dados enviados ao X-Ray está alto e os custos mensais dispararam.

**Qual solução reduziria custos com mínima disrupção mantendo tendências de rastreamento?**

- A. Usar Filter Expressions no console X-Ray
- B. **Habilitar X-Ray sampling** ✅
- C. Implementar uma network sampling rule
- D. Configuração customizada para os X-Ray agents

**Resposta: B**

**Explicação:**
O X-Ray sampling determina quais requisições são rastreadas. Por padrão, rastreia a primeira requisição a cada segundo e 5% das demais. Você pode customizar as sampling rules diretamente no console AWS — sem nenhuma mudança no código da aplicação.

- A está errada: Filter Expressions filtram os resultados exibidos no console — não reduzem o volume de dados enviados ao X-Ray.
- C está errada: "network sampling rule" é uma opção inventada.
- D está errada: não existe "configuração customizada para X-Ray agents" — o que existe são custom sampling rules.

---

## Pergunta 18 · Domínio: Development with AWS Services

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

## Pergunta 19 · Domínio: Troubleshooting and Optimization

Um Auto Scaling group tem minimum = 1 e maximum = 5 distribuídos em 3 AZs. Durante um período de baixa utilização, uma AZ inteira foi desativada e a aplicação sofreu downtime.

**O que você pode fazer para garantir alta disponibilidade?**

- A. Mudar a métrica de scaling para network bytes
- B. Habilitar RDS Multi-AZ
- C. **Aumentar a capacidade mínima do Auto Scaling group para 2** ✅
- D. Configurar ASG fast failover

**Resposta: C**

**Explicação:**
Com minimum = 1, apenas uma instância foi lançada em uma única AZ. Quando essa AZ caiu, a aplicação ficou indisponível. Com minimum = 2, o Auto Scaling group lança 2 instâncias — uma em cada AZ — tornando a arquitetura resiliente a falhas de AZ.

- A está errada: mudar a métrica para network bytes não ajuda na distribuição geográfica das instâncias.
- D está errada: "ASG fast failover" não existe — é uma opção inventada.
- B está errada: RDS Multi-AZ melhora a disponibilidade do banco de dados — não da camada de aplicação.

---

## Pergunta 20 · Domínio: Troubleshooting and Optimization

Uma empresa tem mais de 100 instâncias `c4.large` executando algoritmos complexos. O gerente quer rastrear a utilização de CPU das instâncias EC2 **a cada 10 segundos**.

**Qual é a MELHOR solução?**

- A. Obtê-la diretamente das CloudWatch Metrics
- B. **Criar uma high-resolution custom metric e enviar os dados via um script acionado a cada 10 segundos** ✅
- C. Abrir um ticket de suporte com a AWS
- D. Habilitar EC2 detailed monitoring

**Resposta: B**

**Explicação:**
High-resolution custom metrics permitem publicar métricas no CloudWatch com resolução de 1 segundo. Você pode criar alarmes que avaliam a cada 10 segundos. O script coleta a CPU das instâncias e publica via `PutMetricData`.

- D está errada: o EC2 detailed monitoring envia dados a cada **1 minuto** — não a cada 10 segundos.
- A está errada: as métricas padrão do CloudWatch para EC2 têm granularidade de 1 ou 5 minutos.
- C está errada: é uma opção inventada como distrator.

---

## Pergunta 21 · Domínio: Development with AWS Services

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

## Pergunta 22 · Domínio: Security

Duas policies são aplicadas a um usuário IAM. A primeira **nega explicitamente** todo acesso ao EC2. A segunda **permite** a action `EC2:Describe`.

**O que acontecerá quando o usuário tentar usar a action `Describe`?**

- A. O usuário IAM fica em estado inválido por causa de policies conflitantes
- B. A ordem das policies importa: se a 1ª vem antes da 2ª, o acesso é negado; se a 2ª vem antes, é permitido
- C. **O usuário será negado porque uma das policies tem um explicit deny** ✅
- D. O usuário terá acesso porque tem um explicit allow

**Resposta: C**

**Explicação:**
No IAM, qualquer **explicit deny sempre prevalece** sobre qualquer allow. Quando um explicit deny está presente, o acesso é sempre negado — independentemente da ordem das policies ou de outros allows.

- A está errada: contas IAM não ficam "inválidas" por causa de policies conflitantes — as regras de avaliação são claras.
- D está errada: o explicit allow é sobrescrito pelo explicit deny.
- B está errada: a ordem das policies não importa no IAM — o explicit deny sempre ganha.

---

## Pergunta 23 · Domínio: Development with AWS Services

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

## Pergunta 24 · Domínio: Development with AWS Services

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

## Pergunta 25 · Domínio: Troubleshooting and Optimization

Um junior developer terminou uma container instance no Amazon ECS conforme instruído, mas ela continua aparecendo como recurso no cluster ECS.

**Qual solução você recomendaria?**

- A. Você terminou a instância enquanto estava no estado RUNNING
- B. A instância foi terminada via AWS CLI em vez do Amazon ECS CLI
- C. Um software customizado falhou e a instância ficou em estado não saudável
- D. **Você terminou a container instance enquanto estava no estado STOPPED** ✅

**Resposta: D**

**Explicação:**
Se você terminar uma container instance enquanto ela está no estado **STOPPED**, ela não é automaticamente removida do cluster. Você precisa deregistrar manualmente a instância usando o console Amazon ECS ou o AWS CLI. Após deregistrada, ela não aparecerá mais no cluster.

- A está errada: se você terminar uma instância no estado **RUNNING**, ela é automaticamente removida (deregistrada) do cluster.
- B e C estão erradas: essas são afirmações incorretas adicionadas como distratores.

---

## Pergunta 26 · Domínio: Troubleshooting and Optimization

Você tem um site de armazenamento de arquivos com um ALB internet-facing roteando para 10 instâncias EC2. Os usuários reclamam que o site sempre pede re-autenticação ao mudar de página.

**Qual pode ser a razão?**

- A. O ALB está em modo slow-start
- B. **O Load Balancer não tem stickiness habilitado** ✅
- C. As instâncias EC2 estão desconectando usuários porque nunca têm acesso aos IPs dos clientes
- D. O Load Balancer não tem TLS habilitado

**Resposta: B**

**Explicação:**
Sticky sessions roteiam requisições do mesmo cliente sempre para a mesma instância. Sem stickiness, cada requisição pode ir para uma instância diferente — que não tem a sessão do usuário, causando re-autenticação. O ALB usa o cookie `AWSALB` para implementar stickiness.

- A está errada: o slow-start mode dá tempo para instâncias se aquecerem — não afeta gerenciamento de sessão.
- C está errada: o IP do cliente está disponível via header `X-Forwarded-For`.
- D está errada: TLS criptografa dados em trânsito — não gerencia sessões.

---

## Pergunta 27 · Domínio: Troubleshooting and Optimization

Uma empresa hospeda um site estático no S3 para entusiastas de aviação. Com centenas de milhares de visitantes mensais globais, usuários fora dos EUA experimentam respostas lentas.

**Qual serviço pode mitigar esse problema?**

- A. **Usar Amazon CloudFront** ✅
- B. Usar Amazon S3 Transfer Acceleration
- C. Usar Amazon S3 Caching
- D. Usar Amazon ElastiCache for Redis

**Resposta: A**

**Explicação:**
O CloudFront é uma CDN que entrega conteúdo estático e dinâmico globalmente via Edge Locations. Ao cachear o conteúdo do S3 nas edge locations mais próximas dos usuários, reduz drasticamente a latência para usuários internacionais.

- B está errada: o S3 Transfer Acceleration acelera uploads para o S3 — não serve conteúdo para usuários finais.
- C está errada: "Amazon S3 Caching" é uma opção inventada.
- D está errada: o ElastiCache é um cache in-memory para bancos de dados — não serve conteúdo web diretamente.

---

## Pergunta 28 · Domínio: Development with AWS Services

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

## Pergunta 29 · Domínio: Development with AWS Services

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

## Pergunta 30 · Domínio: Troubleshooting and Optimization

Uma empresa migrou para um stack serverless com Lambda. Os gerentes querem fazer troubleshooting ativo de falhas nas funções.

**Qual solução você sugeriria?**

- A. Usar CodeDeploy para identificar e notificar falhas
- B. Usar CodeCommit para identificar e notificar falhas
- C. Usar Amazon EventBridge para identificar e notificar falhas
- D. **Os desenvolvedores devem inserir logging statements no código Lambda que ficam disponíveis via CloudWatch Logs** ✅

**Resposta: D**

**Explicação:**
O Lambda integra automaticamente com CloudWatch Logs e envia todos os logs do código para um log group `/aws/lambda/<nome-da-função>`. Inserindo `console.log()`, `print()` ou chamadas equivalentes, você pode monitorar o comportamento da função em tempo real.

- C está errada: o EventBridge dispara funções Lambda — não identifica falhas no código.
- A e B estão erradas: o CodeDeploy gerencia deployments e o CodeCommit é controle de código — nenhum identifica falhas no código Lambda.

---

## Pergunta 31 · Domínio: Security

Uma empresa financeira quer manter dados no S3 sempre criptografados, com uma solução AWS gerenciada que permita **criar, rotacionar e remover as chaves de criptografia**.

**Qual opção você recomendaria?**

- A. SSE-C (Server-Side Encryption with Customer-Provided Keys)
- B. **SSE-KMS (Server-Side Encryption with CMKs stored in AWS KMS)** ✅
- C. SSE-S3 (Server-Side Encryption with Amazon S3-Managed Keys)
- D. Server-Side Encryption with Secrets Manager

**Resposta: B**

**Explicação:**
O SSE-KMS usa Customer Master Keys (CMKs) gerenciadas no AWS KMS. Com CMKs **customer-managed**, você pode criar, rotacionar, desabilitar e definir políticas de acesso — mantendo controle total sobre as chaves, com auditoria via CloudTrail.

- C está errada: o SSE-S3 rotaciona chaves automaticamente, mas você não tem controle sobre criação/remoção das chaves.
- A está errada: o SSE-C exige que você gerencie todo o ciclo de vida das chaves e as forneça em cada requisição — sem a gestão facilitada pelo KMS.
- D está errada: o Secrets Manager não fornece criptografia de objetos S3.

---

## Pergunta 32 · Domínio: Development with AWS Services

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

## Pergunta 33 · Domínio: Development with AWS Services

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

## Pergunta 34 · Domínio: Security

O departamento Financeiro quer dar acesso ao bucket S3 de dados para o departamento de RH em outra conta AWS.

**Qual das opções abaixo NÃO é viável para acesso cross-account de objetos S3?**

- A. Usar Cross-account IAM roles para acesso programático e via console
- B. **Usar IAM roles e resource-based policies para delegar acesso cross-account entre partições AWS diferentes** ✅
- C. Usar Access Control List (ACL) e IAM policies para acesso somente programático
- D. Usar Resource-based policies e IAM policies para acesso somente programático

**Resposta: B**

**Explicação:**
IAM roles e resource-based policies delegam acesso cross-account apenas **dentro de uma única partição AWS**. Por exemplo, você não pode usar uma S3 resource-based policy em uma conta na China (aws-cn) para permitir acesso de usuários na partição padrão (aws).

- A está errada (é válida): cross-account IAM roles são suportadas para acesso programático e via console.
- D e C estão erradas (são válidas): resource-based policies + IAM policies e ACLs + IAM policies são mecanismos válidos.

---

## Pergunta 35 · Domínio: Security

Uma equipe quer configurar IAM Database Authentication para seus bancos de dados RDS.

**Quais engines do RDS suportam IAM Database Authentication?** (Selecione duas)

- A. RDS SQL Server
- B. **RDS MySQL** ✅
- C. **RDS PostgreSQL** ✅
- D. RDS Oracle
- E. RDS Db2

**Resposta: B, C**

**Explicação:**
A autenticação de banco de dados IAM funciona com **MySQL, MariaDB e PostgreSQL** (tanto para RDS quanto para Aurora). Com esse método, você usa um token de autenticação gerado pelo IAM em vez de senha — o token tem duração de 15 minutos.

- A e D estão erradas: SQL Server e Oracle não suportam IAM database authentication.
- E está errada: o RDS não suporta o engine Db2 da IBM.

---

## Pergunta 36 · Domínio: Troubleshooting and Optimization

Seu team lead revisou seu código Python para funções Lambda que usam S3. Ele recomendou **reutilização do execution context** para melhorar a performance.

**Qual ação implementará a recomendação?**

- A. Atribuir mais RAM à função
- B. Habilitar integração com X-Ray
- C. **Mover a inicialização do Amazon S3 client para fora do function handler** ✅
- D. Usar variáveis de ambiente para passar parâmetros operacionais

**Resposta: C**

**Explicação:**
AWS best practices para Lambda recomendam inicializar SDK clients (como o cliente S3) e conexões de banco de dados **fora do function handler** — no escopo global do módulo. Invocações subsequentes processadas pela mesma instância da função reutilizam esses recursos, economizando tempo de inicialização.

- D está errada: variáveis de ambiente evitam hardcoding — não reutilizam o execution context.
- A está errada: mais RAM melhora throughput — mas a recomendação específica era sobre reutilização de contexto.
- B está errada: X-Ray é para rastreamento e debugging — não afeta reutilização de contexto.

---

## Pergunta 37 · Domínio: Deployment

**Quais serviços dependem do CloudFormation para provisionar recursos?** (Selecione dois)

- A. AWS Lambda
- B. AWS CodeBuild
- C. **AWS Serverless Application Model (AWS SAM)** ✅
- D. AWS Autoscaling
- E. **AWS Elastic Beanstalk** ✅

**Resposta: C, E**

**Explicação:**
- **AWS Elastic Beanstalk**: usa CloudFormation para lançar recursos no ambiente e propagar mudanças de configuração.
- **AWS SAM**: templates SAM são uma extensão dos templates CloudFormation — o SAM usa CloudFormation como mecanismo de deployment.

- A está errada: Lambda não precisa de CloudFormation para executar.
- D está errada: Auto Scaling pode usar CloudFormation, mas não é um requisito obrigatório.
- B está errada: CodeBuild pode usar CloudFormation como deployment action via CodePipeline, mas não é obrigatório.

---

## Pergunta 38 · Domínio: Development with AWS Services

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

## Pergunta 39 · Domínio: Troubleshooting and Optimization

Sua empresa quer desacoplar componentes com processamento demorado do Elastic Beanstalk para garantir responsividade sob carga.

**Qual tipo de ambiente Elastic Beanstalk você deve usar?**

- A. Single Instance Worker node
- B. **Dedicated Worker environment** ✅
- C. Single Instance with Elastic IP
- D. Load-balancing, Autoscaling environment

**Resposta: B**

**Explicação:**
O Worker environment do Elastic Beanstalk é projetado para tarefas de longa duração que seriam executadas de forma bloqueante. Ele faz poll de uma SQS queue, processa tarefas assincronamente e permite que o front end continue responsivo.

- A está errada: "Single Instance Worker node" refere-se a worker nodes do Kubernetes (Amazon EKS) — não é um tipo de ambiente Elastic Beanstalk.
- C está errada: Single Instance with Elastic IP é para aplicações simples de baixo tráfego — não para tarefas assíncronas.
- D está errada: o Load-balancing, Autoscaling environment serve tráfego web — não é otimizado para tarefas de fila.

---

## Pergunta 40 · Domínio: Development with AWS Services

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

## Pergunta 41 · Domínio: Development with AWS Services

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

## Pergunta 42 · Domínio: Development with AWS Services

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

## Pergunta 43 · Domínio: Security

Uma empresa de trading quer minimizar os custos de uso do SQS ao migrar seus sistemas de mensageria.

**Qual opção você recomendaria?**

- A. Usar SQS short polling
- B. Usar SQS visibility timeout
- C. Usar SQS message timer
- D. **Usar SQS long polling** ✅

**Resposta: D**

**Explicação:**
O SQS long polling reduz custos eliminando respostas vazias (quando não há mensagens) e respostas falsas vazias. Com long polling, o SQS só retorna resposta quando pelo menos uma mensagem está disponível (ou o tempo de espera expirar). O tempo máximo de espera é 20 segundos.

- A está errada: short polling responde imediatamente mesmo sem mensagens — gerando muitas respostas vazias pagas.
- B e C estão erradas: visibility timeout e message timer não são mecanismos de recuperação de mensagens — são distratores.

---

## Pergunta 44 · Domínio: Security

O site de uma empresa de marketing digital é hospedado no bucket S3 **A**. As web fonts hospedadas no bucket S3 **B** não carregam no site.

**Qual solução resolve o problema?**

- A. Configurar CORS no bucket A para permitir qualquer origem
- B. Atualizar bucket policies em ambos os buckets
- C. **Configurar CORS no bucket B para permitir a origem do bucket A** ✅
- D. Habilitar versioning em ambos os buckets

**Resposta: C**

**Explicação:**
CORS (Cross-Origin Resource Sharing) define como aplicações web carregadas em um domínio podem interagir com recursos em outro domínio. O bucket **B** (que serve as fonts) precisa de uma CORS rule que permita requisições da origem do site no bucket **A**.

- A está errada: a configuração CORS deve estar no bucket **B** (a fonte dos recursos requisitados) — não no bucket A.
- B está errada: bucket policies controlam acesso, mas o problema é CORS — não permissões de acesso.
- D está errada: versioning não resolve problemas de carregamento cross-origin.

---

## Pergunta 45 · Domínio: Development with AWS Services

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

## Pergunta 46 · Domínio: Deployment

Uma organização migra para AWS CodeCommit e CodeBuild. Eles querem que o ambiente de build **permita scaling e execução de builds em paralelo**.

**Qual opção você escolheria?**

- A. Habilitar CodeBuild Auto Scaling
- B. Executar o CodeBuild em um Auto Scaling group
- C. Escolher um tipo de instância de alta performance para o CodeBuild
- D. **O CodeBuild escala automaticamente — a organização não precisa fazer nada** ✅

**Resposta: D**

**Explicação:**
O AWS CodeBuild é um serviço totalmente gerenciado que **escala automaticamente** para atender às solicitações de build no pico. Não há servidores para provisionar ou gerenciar — o CodeBuild processa múltiplos builds em paralelo sem configuração adicional.

- A e B estão erradas: o CodeBuild já escala automaticamente — não precisa de configuração de Auto Scaling.
- C está errada: o tipo de instância do CodeBuild pode ser configurado para performance, mas não afeta a capacidade de scaling automático.

---

## Pergunta 47 · Domínio: Security

Uma empresa precisa de 14.000 IOPS consistentes para dados duráveis e seguros. Os padrões de conformidade exigem que os dados sejam seguros em todos os estágios de seu ciclo de vida nos volumes EBS.

**Qual afirmação é verdadeira sobre segurança de dados no EBS?**

- A. Volumes EBS suportam criptografia em trânsito mas não em repouso
- B. Volumes EBS não suportam criptografia em trânsito mas suportam criptografia em repouso com KMS
- C. **Volumes EBS suportam criptografia em trânsito e em repouso com KMS** ✅
- D. Volumes EBS não suportam nenhum tipo de criptografia

**Resposta: C**

**Explicação:**
O Amazon EBS com AWS KMS criptografa:
- Dados em repouso dentro do volume
- Todos os dados em trânsito entre o volume e a instância EC2
- Todos os snapshots criados do volume
- Todos os volumes criados a partir desses snapshots

As operações de criptografia ocorrem nos servidores que hospedam as instâncias EC2.

---

## Pergunta 48 · Domínio: Troubleshooting and Optimization

Uma função Lambda lê dados de objetos S3 e escreve em uma tabela DynamoDB. A função dispara corretamente a partir de uma notificação de evento S3, mas falha ao tentar escrever no DynamoDB.

**Qual é a causa provável da falha?**

- A. A tabela DynamoDB não tem um Gateway VPC Endpoint
- B. **A função Lambda não tem permissões IAM para escrever no DynamoDB** ✅
- C. O limite de provisioned concurrency da Lambda foi excedido
- D. O limite de reserved concurrency da Lambda foi excedido

**Resposta: B**

**Explicação:**
Para que a Lambda escreva no DynamoDB, sua service role deve ter uma IAM policy com permissões como `dynamodb:PutItem`, `dynamodb:UpdateItem`, etc. Sem essas permissões, a chamada à API do DynamoDB resulta em `AccessDenied`.

- A está errada: o Lambda não está provisionado em um VPC por padrão — não precisa de um Gateway VPC Endpoint para acessar o DynamoDB.
- C e D estão erradas: provisioned e reserved concurrency controlam o número de instâncias concorrentes — não causam erros de escrita no DynamoDB.

---

## Pergunta 49 · Domínio: Deployment

Uma empresa quer **isolar o esforço de desenvolvimento** configurando simulações de componentes de API de outras equipes.

**Qual tipo de integração do API Gateway é mais adequado?**

- A. **MOCK** ✅
- B. HTTP_PROXY
- C. AWS_PROXY
- D. HTTP

**Resposta: A**

**Explicação:**
A integração MOCK permite que o API Gateway retorne uma resposta sem enviar a requisição ao backend. É ideal para:
- Testar a configuração de integração sem incorrer em custos do backend
- Desenvolvimento colaborativo onde equipes simulam componentes de outras equipes
- Retornar headers CORS para OPTIONS requests

- C está errada: AWS_PROXY integra com Lambda — envia requisições reais ao backend.
- B está errada: HTTP_PROXY permite acesso a endpoints HTTP do backend — não simula.
- D está errada: HTTP requer configuração de request e response de integração — não simula.

---

## Pergunta 50 · Domínio: Troubleshooting and Optimization

O load balancer está configurado para rotear tráfego igualmente entre instâncias e AZs, mas o ELB roteia mais tráfego para algumas instâncias/AZs que outras.

**Quais podem ser as razões?** (Selecione duas)

- A. Pode haver conexões TCP de curta duração entre clientes e instâncias
- B. **Sticky sessions estão habilitadas no load balancer** ✅
- C. Após desabilitar uma AZ, as targets nessa AZ continuam registradas e recebem bursts de tráfego
- D. Para ALBs, cross-zone load balancing é desabilitado por padrão
- E. **Instâncias de um tipo de capacidade específico não estão igualmente distribuídas entre AZs** ✅

**Resposta: B, E**

**Explicação:**
- **Sticky sessions**: roteiam requisições do mesmo cliente sempre para a mesma instância — causando distribuição desigual.
- **Instâncias de capacidades diferentes**: um Classic Load Balancer com listeners HTTP/HTTPS pode rotear mais tráfego para instâncias de maior capacidade para evitar sobrecarga das de menor capacidade.

- A está errada: conexões TCP de **longa** duração (não curtas) podem causar distribuição desigual.
- D está errada: para ALBs, cross-zone load balancing está **sempre habilitado**.
- C está errada: após desabilitar uma AZ, as targets permanecem registradas, mas o load balancer **não roteia tráfego para elas**.

---

## Pergunta 51 · Domínio: Deployment

Uma equipe implantou uma API REST no API Gateway em dois stages: `test` e `prod`. Após o teste, a equipe quer **promover o stage test para o prod**.

**Qual é a solução mais eficiente?**

- A. Fazer deploy da API sem escolher um stage
- B. **Atualizar o valor da stage variable do nome `test` para `prod`** ✅
- C. Re-implantar a API no stage prod
- D. Deletar o stage prod existente e criar um novo com o mesmo nome

**Resposta: B**

**Explicação:**
Você pode promover o stage test para prod atualizando o valor de uma stage variable para apontar para o deployment do stage test, ou reimplantando a API no stage prod. A opção mais direta e com menos risco é atualizar a stage variable.

- A está errada: uma API só pode ser implantada em um stage — não é possível fazer deploy sem escolher um.
- D está errada: deletar e recriar o stage prod resulta em downtime.
- C está errada: reimplantar ao prod é válido, mas não é a opção "mais eficiente" listada.

---

## Pergunta 52 · Domínio: Development with AWS Services

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

## Pergunta 53 · Domínio: Development with AWS Services

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

## Pergunta 54 · Domínio: Development with AWS Services

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

## Pergunta 55 · Domínio: Security

Uma empresa de telecomunicações armazena dados críticos de clientes no S3.

**Quais mecanismos podem ser usados para controlar acesso a dados no S3?** (Selecione duas)

- A. Permissions boundaries, IAM policies
- B. IAM database authentication, Bucket policies
- C. **Query String Authentication, Access Control Lists (ACLs)** ✅
- D. Query String Authentication, Permissions boundaries
- E. **Bucket policies, IAM policies** ✅

**Resposta: C, E**

**Explicação:**
O S3 suporta **quatro mecanismos** de controle de acesso:
1. **IAM policies**: controle granular por usuário/role
2. **Bucket policies**: regras amplas para o bucket inteiro
3. **ACLs**: permissões específicas (READ, WRITE, FULL_CONTROL) por conta/grupo
4. **Query String Authentication (pre-signed URLs)**: acesso temporário com expiração

- A está errada: Permissions boundaries são um recurso IAM avançado — não são um mecanismo direto de acesso ao S3.
- B está errada: IAM database authentication é para autenticação em bancos de dados RDS — não para S3.
- D está errada: combina Query String Auth (válido) com Permissions boundaries (não é mecanismo S3).

---

## Pergunta 56 · Domínio: Development with AWS Services

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

## Pergunta 57 · Domínio: Development with AWS Services

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

## Pergunta 58 · Domínio: Security

Uma aplicação em EC2 precisa autenticar e enviar mensagens via uma chat API quando detecta transações inválidas. O access token deve ser criptografado em repouso e em trânsito, com **acesso cross-account** possível e **mínimo overhead de gerenciamento**.

**Qual é a solução mais eficiente?**

- A. Usar Parameter Store com KMS CMK, configurar resource-based policy para acesso cross-account
- B. **Usar AWS Secrets Manager com KMS CMK, configurar resource-based policy no secret para acesso cross-account; atualizar a IAM role das instâncias EC2 para acessar o Secrets Manager** ✅
- C. Usar SSE-KMS para armazenar o token como objeto criptografado no S3 com resource-based policy
- D. Armazenar o token criptografado com KMS em uma tabela DynamoDB com resource-based policy

**Resposta: B**

**Explicação:**
O AWS Secrets Manager foi projetado especificamente para armazenar segredos de aplicações (access tokens, credenciais). Suporta:
- Criptografia via KMS
- Resource-based policies (permite acesso cross-account)
- Rotação automática de segredos

- A está errada: o SSM Parameter Store **não suporta resource-based policies** — apenas parameter policies para controle de ciclo de vida.
- D está errada: o DynamoDB **não suporta resource-based policies** e é má prática armazenar credenciais em banco de dados.
- C está errada: armazenar credenciais em S3 é uma má prática de segurança.

---

## Pergunta 59 · Domínio: Deployment

Um workflow usa CodeCommit e CodeDeploy para implantar em instâncias EC2 com a tag `ProdBuilders`. Você quer **arquivar no máximo 2 revisões** nas instâncias para economizar espaço em disco.

**O que permite fazer isso?**

- A. AWS CloudWatch Log Agent
- B. Integrar com AWS CodePipeline
- C. **CodeDeploy Agent** ✅
- D. Colocar um load balancer na frente das instâncias

**Resposta: C**

**Explicação:**
O CodeDeploy Agent arquiva revisões e arquivos de log nas instâncias. Você pode usar a opção `:max_revisions:` no arquivo de configuração do agente para especificar o número de revisões a arquivar. Todas as outras são deletadas, exceto o arquivo de log do último deployment bem-sucedido.

- A está errada: o CloudWatch Log Agent coleta logs e os envia ao CloudWatch — não gerencia revisões de aplicação.
- B está errada: o CodePipeline automatiza pipelines de release — não controla arquivos nas instâncias.
- D está errada: um load balancer distribui tráfego — não gerencia revisões em disco.

---

## Pergunta 60 · Domínio: Development with AWS Services

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

---

## Pergunta 61 · Domínio: Troubleshooting and Optimization

Uma aplicação bancária precisa enviar alertas e notificações em tempo real com base em atualizações dos serviços backend. A empresa quer **evitar mecanismos complexos de polling**.

**Qual tipo de API do Amazon API Gateway é o mais adequado?**

- A. HTTP APIs
- B. REST ou HTTP APIs
- C. **WebSocket APIs** ✅
- D. REST APIs

**Resposta: C**

**Explicação:**
Em uma WebSocket API, cliente e servidor podem enviar mensagens um ao outro a qualquer momento. Servidores backend podem fazer **push** de dados para clientes conectados sem precisar que o cliente faça polling. Casos de uso: chat em tempo real, dashboards de stock tickers, alertas e notificações em tempo real.

- A, B e D estão erradas: REST e HTTP APIs seguem o modelo request-response — o servidor não pode iniciar o envio de dados para o cliente (sem polling).

---

## Pergunta 62 · Domínio: Security

Uma aplicação em EC2 processa pedidos à noite e precisa acessar pedidos armazenados no S3.

**Como você recomendaria que a instância EC2 acesse os pedidos de forma segura?**

- A. Criar uma bucket policy que autorize acesso público
- B. **Usar uma IAM role** ✅
- C. Criar um usuário IAM programático e armazenar as chaves em `~/.aws/credentials` na instância EC2
- D. Usar EC2 User Data

**Resposta: B**

**Explicação:**
IAM roles para EC2 fornecem credenciais temporárias automaticamente via instance profile — sem necessidade de gerenciar access keys. A aplicação usa o SDK da AWS que busca as credenciais automaticamente do metadata service.

- C está errada: armazenar access key e secret key em `~/.aws/credentials` na instância é uma prática insegura — qualquer pessoa com acesso à instância pode roubar as credenciais.
- A está errada: acesso público violaria a segurança dos pedidos.
- D está errada: EC2 User Data é para scripts de inicialização — não para configurar acesso seguro ao S3.

---

## Pergunta 63 · Domínio: Security

Uma empresa de e-commerce tem um workflow de processamento de pedidos com **tarefas em paralelo e decision steps**, todos implementados via funções Lambda.

**Qual é a MELHOR solução?**

- A. Usar AWS Glue para orquestrar o workflow
- B. Usar AWS Batch para orquestrar o workflow
- C. Usar AWS Step Functions activities para orquestrar o workflow
- D. **Usar AWS Step Functions state machines para orquestrar o workflow** ✅

**Resposta: D**

**Explicação:**
O AWS Step Functions permite definir state machines usando a Amazon States Language (JSON). States podem tomar decisões com base no input, executar ações em paralelo e passar output para outros states — ideal para workflows com múltiplos caminhos e execução paralela.

- C está errada: activities do Step Functions associam código externo (ex.: em EC2) a tasks específicas — não orquestram o workflow em si.
- A e B estão erradas: AWS Glue (ETL) e AWS Batch (computação em lote) não orquestram workflows com lógica de decisão.

---

## Pergunta 64 · Domínio: Security

Sua aplicação é implantada com Elastic Beanstalk. Arquivos de configuração YAML são atualizados frequentemente. A equipe **não quer reimplantar a aplicação a cada mudança de configuração** — preferem gerenciar as configurações externamente, de forma segura, e carregá-las dinamicamente em runtime.

**Qual opção permite isso?**

- A. **Usar SSM Parameter Store** ✅
- B. Usar S3
- C. Usar Stage Variables
- D. Usar Environment variables

**Resposta: A**

**Explicação:**
O AWS Systems Manager Parameter Store fornece armazenamento seguro e hierárquico para dados de configuração e segredos. A aplicação pode buscar parâmetros dinamicamente em runtime sem reimplantação. Os parâmetros SecureString são criptografados com KMS.

- D está errada: variáveis de ambiente não são criptografadas em repouso e ficam visíveis em texto claro no console AWS e em respostas da API do Elastic Beanstalk.
- C está errada: Stage Variables são para gerenciar releases da API no API Gateway — não para configuração de aplicações Beanstalk.
- B está errada: embora o S3 seja possível, o Parameter Store é mais seguro, integrado e gerenciado — sem necessidade de configuração adicional de criptografia e controle de acesso.

---

## Pergunta 65 · Domínio: Security

Sua API pública no API Gateway, acessada por clientes de outro domínio, mais que dobrou de uso. Os custos aumentaram e você quer **impedir que domínios não autorizados acessem sua API**.

**Qual ação você deve tomar?**

- A. Usar Mapping Templates
- B. Usar Account-level throttling
- C. Atribuir um Security Group ao API Gateway
- D. **Restringir o acesso usando CORS** ✅

**Resposta: D**

**Explicação:**
O CORS (Cross-Origin Resource Sharing) controla quais origens (domínios) podem fazer requisições à sua API. Ao configurar CORS no API Gateway para permitir apenas origens específicas, você bloqueia requisições de domínios não autorizados.

- B está errada: throttling limita o **número de requisições por segundo** — não restringe origens.
- A está errada: Mapping Templates transformam payloads — não controlam acesso.
- C está errada: o API Gateway não usa Security Groups — usa resource policies. Além disso, Security Groups são para tráfego de rede, não para controle de origens.

---