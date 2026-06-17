# Simulado Marek - Development

## Parte 2: Provas 04, 05, 06

> **68 questoes** agrupadas por dominio -- Fonte: Provas Marek 04, 05, 06

---

## Pergunta 1 [P04] · Domínio: Development with AWS Services

Você fez o upload de um arquivo zip para o AWS Lambda contendo código Node.js. Ao executar a função, você recebe a seguinte saída: `Error: Memory Size: 10,240 MB Max Memory Used`.

**Qual das seguintes opções explica o problema?**

- A. O arquivo zip está corrompido
- B. Você fez upload de um arquivo zip maior que 50 MB para o Lambda
- C. O arquivo zip descomprimido excede os limites do Lambda
- D. **Sua função Lambda ficou sem RAM** ✅

**Resposta: D**

**Explicação:**
O Lambda permite até 10.240 MB de memória. A função foi implantada com 10.240 MB de RAM, mas tentou usar mais do que isso e falhou.

- A está errada: se ocorreu um erro de memória, o arquivo foi extraído — logo não está corrompido.
- C está errada: a função conseguiu executar, então o zip foi descomprimido com sucesso.
- B está errada: pela mesma razão — a função executou, então o upload foi bem-sucedido.

---

## Pergunta 5 [P04] · Domínio: Development with AWS Services

Uma aplicação Elastic Beanstalk envia arquivos ao S3 e depois envia uma mensagem a uma SQS queue com o path do arquivo. O engenheiro quer atrasar a entrega de novas mensagens em pelo menos 10 segundos.

**Qual funcionalidade do SQS o engenheiro deve usar?**

- A. **Usar o parâmetro DelaySeconds** ✅
- B. Habilitar LongPolling
- C. Usar o parâmetro visibility timeout
- D. Implementar delay do lado da aplicação

**Resposta: A**

**Explicação:**
Delay queues permitem atrasar a entrega de novas mensagens por vários segundos (mínimo 0, máximo 15 minutos). As mensagens ficam invisíveis para os consumidores durante o período de delay.

- C está errada: visibility timeout impede outros consumidores de receber uma mensagem já recebida — não afeta novas mensagens.
- B está errada: LongPolling reduz chamadas vazias, mas não atrasa a entrega.
- D está errada: delay na aplicação não é robusto — se a aplicação travar, a mensagem pode ser perdida.

---

## Pergunta 7 [P04] · Domínio: Development with AWS Services

Você está adicionando novas tabelas ao DynamoDB e precisa permitir que sua aplicação faça query por primary key e por uma alternate key. Esta opção deve ser adicionada ao criar as tabelas, pois não pode ser modificada depois.

**Qual ação você deve tomar?**

- A. Criar um GSI
- B. Migrar para fora do DynamoDB
- C. **Criar um LSI** ✅
- D. Chamar Scan

**Resposta: C**

**Explicação:**
LSI (Local Secondary Index) permite definir uma alternate sort key para uma tabela DynamoDB. Ao contrário do GSI, o LSI **deve** ser criado no momento em que a tabela é criada e não pode ser adicionado ou removido depois.

- A está errada: GSI (Global Secondary Index) pode ter partition key e sort key diferentes da tabela base e pode ser criado a qualquer momento — não atende ao requisito de "deve ser adicionado ao criar".
- D está errada: Scan é uma operação de leitura, não uma estrutura de índice.

---

## Pergunta 8 [P04] · Domínio: Development with AWS Services

Um sistema de processamento de pedidos precisa: notificar departamentos quando um pedido é feito, enviar notificações idênticas a instâncias EC2 para fulfillment, e permitir reprocessamento de mensagens com erros. O sistema deve escalar transparentemente sem provisionamento manual.

**Qual solução atende a esse caso de uso da forma mais econômica?**

- A. SNS + Kinesis
- B. SNS + Lambda
- C. SQS + SES
- D. **SNS + SQS** ✅

**Resposta: D**

**Explicação:**
SNS com SQS (padrão fan-out) permite: SNS distribui a mensagem para múltiplos assinantes simultaneamente; SQS armazena as mensagens para processamento assíncrono com suporte a DLQ para reprocessamento; SQS escala transparentemente sem provisionamento.

- A está errada: Kinesis requer provisionamento manual de shards (exceto no modo on-demand, mas é mais caro).
- B está errada: instâncias EC2 não podem "fazer poll" de funções Lambda.
- C está errada: SQS com apenas um consumidor não suporta fan-out; SES é para envio de emails.

---

## Pergunta 15 [P04] · Domínio: Development with AWS Services

Você quer escalar um Auto Scaling group com base no número de requisições por minuto para bancos de dados MySQL em EC2.

**Como você consegue isso?**

- A. Habilitar detailed monitoring e usá-lo para escalar o ASG
- B. **Criar uma CloudWatch custom metric e construir um alarm para escalar o ASG** ✅
- C. Anexar um Elastic Load Balancer
- D. Anexar armazenamento Elastic File Storage adicional

**Resposta: B**

**Explicação:**
"Número de requisições por minuto" é uma custom metric que precisa ser criada, pois não está disponível nas métricas padrão do CloudWatch. Métricas de alta resolução permitem leituras de 1 segundo; depois você cria um alarm baseado nessa métrica para acionar a scaling policy.

- A está errada: o detailed monitoring não fornece informações sobre requisições por minuto para aplicações/bancos de dados.
- C e D estão erradas: ALB e EFS não têm relação com a política de auto scaling baseada em requisições.

---

## Pergunta 18 [P04] · Domínio: Development with AWS Services

A equipe de desenvolvimento quer inserir registros de fornecedores no DynamoDB assim que o fornecedor fizer upload de um arquivo em um bucket S3.

**Qual conjunto de etapas você recomendaria?**

- A. **Criar um S3 event para invocar uma função Lambda que insere registros no DynamoDB** ✅
- B. Desenvolver uma função Lambda que fará poll no bucket S3 e inserirá registros no DynamoDB
- C. Criar um cron job que executará uma Lambda em horário agendado para inserir registros
- D. Configurar um evento com EventBridge para monitorar o bucket S3 e inserir diretamente no DynamoDB

**Resposta: A**

**Explicação:**
S3 event notifications (`s3:ObjectCreated:*`) podem acionar uma função Lambda sempre que um objeto é criado no bucket. A Lambda executa o código customizado para inserir registros no DynamoDB.

- B e C estão erradas: polling e cron jobs são ineficientes — podem não haver arquivos a processar quando executados.
- D está errada: EventBridge não pode inserir diretamente no DynamoDB — precisaria de uma Lambda intermediária.

---

## Pergunta 19 [P04] · Domínio: Development with AWS Services

Você quer exportar logs de uma função Lambda (com `console.log()`) para um bucket S3 chamado `MyAlexaLog`.

**Como você consegue isso?**

- A. Usar integração do CloudWatch com Lambda
- B. **Usar integração do CloudWatch com S3** ✅
- C. Usar integração do CloudWatch com Kinesis
- D. Usar integração do CloudWatch com Glue

**Resposta: B**

**Explicação:**
Você pode exportar dados de log de CloudWatch Log Groups para um bucket S3. Basta configurar as definições do CloudWatch para enviar logs para S3 — sem necessidade de código adicional.

- A e C estão erradas: Lambda e Kinesis exigem processamento customizado adicional.
- D está errada: Glue é um serviço ETL — não adequado para exportação simples de logs.

---

## Pergunta 20 [P04] · Domínio: Development with AWS Services

Um Kinesis Data Stream com 10 shards está recebendo 3 MB/s (bem abaixo do limite de 10 MB/s), mas ainda recebe `ProvisionedThroughputExceededException`.

**Qual é a causa mais provável?**

- A. As métricas estão lentas para atualizar
- B. Você tem shards demais
- C. **A partition key selecionada não está distribuída o suficiente** ✅
- D. O período de retenção de dados é muito longo

**Resposta: C**

**Explicação:**
A partition key determina para qual shard cada registro é roteado. Se a partition key não for suficientemente distribuída, os dados ficam concentrados em poucos shards "quentes" (hot shards), que excedem os limites de throughput mesmo que a capacidade total do stream não seja atingida.

- A está errada: métricas do CloudWatch são relevantes para diagnóstico, não causam o erro.
- B está errada: excesso de shards causaria `LimitExceededException`, não `ProvisionedThroughputExceededException`.
- D está errada: o período de retenção não afeta throughput.

---

## Pergunta 24 [P04] · Domínio: Development with AWS Services

Você não se preocupa com dados stale e precisa realizar 16 eventually consistent reads por segundo de itens com 12 KB cada.

**Quantas read capacity units (RCUs) você precisa?**

- A. 192
- B. 12
- C. **24** ✅
- D. 48

**Resposta: C**

**Explicação:**
1 RCU = 1 strongly consistent read de até 4 KB, ou **2 eventually consistent reads** de até 4 KB.

- Tamanho do item: 12 KB / 4 KB = 3 (unidades de 4 KB por item)
- Para eventually consistent: 1 RCU cobre 2 leituras × 4 KB = 8 KB. Então 12 KB por leitura = 1,5 → arredonda para **2 RCUs por 2 leituras** → 1 RCU por leitura eventually consistent de 12 KB.
- 16 leituras / 2 (bônus eventually) × 3 (unidades de 4 KB) = **24 RCUs**

---

## Pergunta 30 [P04] · Domínio: Development with AWS Services

Você está configurando SQS queues para uma arquitetura que deve receber mensagens de 20 KiB a 200 KiB.

**É possível enviar essas mensagens ao SQS?**

- A. **Sim, o tamanho máximo de mensagem é 1024 KiB** ✅
- B. Não, o tamanho máximo é 128 KiB
- C. Sim, o tamanho máximo é 512 KiB
- D. Não, o tamanho máximo é 64 KiB

**Resposta: A**

**Explicação:**
O tamanho mínimo de mensagem SQS é 1 byte. O tamanho máximo é **1.048.576 bytes (1024 KiB)**. Mensagens de 20–200 KiB estão dentro do limite.

---

## Pergunta 31 [P04] · Domínio: Development with AWS Services

Você habilitou caching no API Gateway e quer invalidar o cache para que clientes recebam as respostas mais recentes.

**O que você deve fazer?**

- A. Usar o header `Bypass-Cache=1`
- B. Usar o request parameter `?bypass_cache=1`
- C. Usar o request parameter `?cache-control-max-age=0`
- D. **Usar o header `Cache-Control: max-age=0`** ✅

**Resposta: D**

**Explicação:**
Um cliente pode invalidar uma entrada de cache existente enviando uma requisição com o header `Cache-Control: max-age=0`. O cliente recebe a resposta diretamente do integration endpoint (em vez do cache), desde que tenha autorização.

- A e B estão erradas: esses headers/parâmetros não existem no API Gateway.
- C está errada: a invalidação requer um header, não um request parameter.

---

## Pergunta 39 [P04] · Domínio: Development with AWS Services

Você quer processamento event-driven toda vez que dados são modificados ou deletados em um banco de dados, usando uma abordagem serverless com Lambda para processar stream events.

**Qual banco de dados você escolheria?**

- A. **DynamoDB** ✅
- B. Kinesis
- C. RDS
- D. ElastiCache

**Resposta: A**

**Explicação:**
DynamoDB Streams captura uma sequência time-ordered de modificações em itens de uma tabela DynamoDB e as armazena em um log por até 24 horas. Lambda pode ser configurado para processar eventos do DynamoDB Streams nativamente.

- B está errada: Kinesis não é um banco de dados.
- C está errada: RDS por si só não tem capacidade de streaming nativa como DynamoDB Streams.
- D está errada: ElastiCache é um store in-memory de cache, não suporta streaming de eventos.

---

## Pergunta 42 [P04] · Domínio: Development with AWS Services

Um developer está configurando um ALB para rotear tráfego para instâncias EC2 e funções Lambda.

**Quais características do ALB estão corretas?** (Selecione duas)

- A. Se os targets são especificados por IP, o tráfego é roteado usando o primary private IP address
- B. **Você não pode especificar endereços IP publicamente roteáveis para um ALB** ✅
- C. **Um ALB tem três tipos de target possíveis: Instance, IP e Lambda** ✅
- D. Se os targets são especificados por instance ID, o tráfego é roteado usando qualquer private IP address
- E. Um ALB tem três tipos de target possíveis: Hostname, IP e Lambda

**Resposta: B, C**

**Explicação:**
- C: os tipos de target do ALB são Instance, IP e Lambda.
- B: quando o tipo de target é IP, você pode especificar IPs apenas de blocos CIDR específicos — endereços IP publicamente roteáveis não são permitidos.
- D está errada: com instance ID, o tráfego é roteado usando o **primary** private IP address da interface de rede principal.
- A está errada: com IPs, o tráfego pode ser roteado para qualquer private IP de uma ou mais network interfaces.
- E está errada: o tipo correto é Instance (não Hostname).

---

## Pergunta 43 [P04] · Domínio: Development with AWS Services

Uma empresa usa SQS e, por razões de segurança, precisa armazenar dados em queues criptografadas sem modificar o código existente.

**Qual passo você pode tomar para atender ao requisito?**

- A. Usar Secrets Manager
- B. **Habilitar SQS KMS encryption** ✅
- C. Usar o endpoint SSL
- D. Usar client-side encryption

**Resposta: B**

**Explicação:**
Server-side encryption (SSE) com KMS criptografa o conteúdo das mensagens nas queues em repouso. Pode ser habilitado nas configurações da queue sem modificar nenhum código da aplicação.

- C está errada: SSL criptografa dados em trânsito, mas não em repouso.
- D está errada: client-side encryption exigiria modificações no código.
- A está errada: Secrets Manager gerencia segredos (credenciais, API keys), não criptografia de mensagens SQS.

---

## Pergunta 46 [P04] · Domínio: Development with AWS Services

Seu app mobile precisa fazer chamadas de API ao DynamoDB. Você não quer armazenar credenciais AWS nos dispositivos e precisa de uma identidade diferente por dispositivo.

**Qual serviço permite isso?**

- A. IAM
- B. Cognito User Pools
- C. Cognito Sync
- D. **Cognito Identity Pools** ✅

**Resposta: D**

**Explicação:**
Cognito Identity Pools (federated identities) fornece credenciais temporárias AWS para usuários (autenticados ou convidados) acessarem serviços como DynamoDB. Cada dispositivo/usuário obtém credenciais únicas e temporárias.

- B está errada: Cognito User Pools gerencia autenticação de usuários (sign-up/sign-in), mas não concede credenciais AWS para acessar serviços.
- C está errada: Cognito Sync sincroniza dados de perfil entre dispositivos, não gerencia credenciais AWS.
- A está errada: criar um IAM user por dispositivo móvel não é escalável nem seguro.

---

## Pergunta 52 [P04] · Domínio: Development with AWS Services

Uma aplicação armazena PHI (Personal Health Information) em RDS MySQL criptografado. Um developer quer melhorar a performance com cache de dados acessados frequentemente e ordenação/ranking dos datasets em cache.

**Qual é a melhor abordagem mantendo o PHI sempre criptografado?**

- A. Migrar dados para EC2 Instance Store com criptografia habilitada
- B. **Armazenar os dados frequentemente acessados no Amazon ElastiCache for Redis com criptografia em trânsito e em repouso** ✅
- C. Armazenar os dados no Amazon ElastiCache for Memcached com criptografia habilitada
- D. Migrar os dados para DynamoDB Accelerator (DAX) com criptografia habilitada

**Resposta: B**

**Explicação:**
ElastiCache for Redis suporta estruturas de dados avançadas como Sorted Sets (necessários para ordenação/ranking) além de strings, listas, sets e hashes. Suporta criptografia in-transit e at-rest.

- C está errada: Memcached não suporta Sorted Sets nem operações de sort/rank.
- D está errada: DAX é um cache específico para DynamoDB, não pode ser usado com RDS MySQL.
- A está errada: Instance Store é armazenamento temporário de bloco — não adequado como cache de aplicação compartilhado.

---

## Pergunta 55 [P04] · Domínio: Development with AWS Services

Uma aplicação de alta performance requer milhões de conexões e precisa capturar o IP de origem e porta do usuário sem usar X-Forwarded-For.

**Qual opção atende às suas necessidades?**

- A. Classic Load Balancer
- B. Application Load Balancer
- C. Elastic Load Balancer
- D. **Network Load Balancer** ✅

**Resposta: D**

**Explicação:**
O NLB opera na camada 4 (transporte) do modelo OSI, suportando milhões de requisições por segundo. As conexões de entrada permanecem sem modificação — o software da aplicação não precisa suportar X-Forwarded-For para ver o IP e porta do cliente.

- B está errada: o ALB opera na camada 7 e usa X-Forwarded-For para preservar o IP do cliente.
- A e C estão erradas: Classic Load Balancer é básico e não adequado para esse volume; "Elastic Load Balancer" é o nome do serviço, não um tipo específico.

---

## Pergunta 58 [P04] · Domínio: Development with AWS Services

Um ALB precisa rotear tráfego de web browsers para `smart.com/api` e de dispositivos mobile para `smart.com/mobile`. Outra sugestão é rotear para `api.smart.com` e `mobile.smart.com`.

**Quais opções de roteamento foram discutidas?** (Selecione duas)

- A. Web browser version
- B. Client IP
- C. Cookie value
- D. **Path based** ✅
- E. **Host based** ✅

**Resposta: D, E**

**Explicação:**
- Path-based routing: roteamento baseado no caminho da URL (ex.: `/api` vai para um target group, `/mobile` para outro).
- Host-based routing: roteamento baseado no hostname do header Host (ex.: `api.smart.com` vs `mobile.smart.com`).
- B e A estão erradas: o roteamento não é baseado em IP do cliente nem na versão do browser.
- C está errada: cookie-based está relacionado a sticky sessions, não ao tipo de cliente.

---

## Pergunta 59 [P04] · Domínio: Development with AWS Services

Uma aplicação on-premises processa uploads de usuários e os salva em um diretório local no servidor. Após migrar para AWS, todos os uploads devem estar disponíveis para todas as instâncias de um Auto Scaling group.

**Qual opção você recomendaria?**

- A. Usar Instance Store e compartilhar arquivos via software de sincronização
- B. **Usar Amazon S3 e fazer mudanças no código da aplicação para que todos os uploads sejam feitos no S3** ✅
- C. Usar Amazon EBS e configurar a AMI para usar um snapshot da mesma instância EBS ao lançar novas instâncias
- D. Usar Amazon EBS e compartilhar arquivos via software de sincronização

**Resposta: B**

**Explicação:**
S3 é um storage de objetos altamente disponível e escalável. Usar a API `PutObject` do S3 para armazenar uploads em um único bucket torna os arquivos acessíveis a todas as instâncias do ASG.

- C está errada: volumes EBS são vinculados a uma instância; snapshots só capturam dados estáticos — não dados gerados após o launch.
- A e D estão erradas: sincronização de arquivos entre instâncias é complexa e propensa a erros.

---

## Pergunta 64 [P04] · Domínio: Development with AWS Services

Você configurou um NACL e um Security Group para permitir tráfego HTTP de entrada na porta 80. No entanto, os usuários ainda não conseguem se conectar ao site.

**Qual configuração adicional é necessária?**

- A. **Adicionar uma regra ao NACL para permitir tráfego de saída nas portas 1024-65535** ✅
- B. Adicionar uma regra ao Security Group permitindo tráfego de saída na porta 80
- C. Adicionar uma regra ao NACL para permitir tráfego de saída nas portas 32768-61000
- D. Adicionar uma regra ao NACL para permitir tráfego de saída nas portas 1025-5000

**Resposta: A**

**Explicação:**
NACLs são stateless — você precisa de regras explícitas para entrada E saída. Para responder a requisições HTTP, o servidor precisa enviar respostas para a porta efêmera usada pelo cliente. O Elastic Load Balancer usa o range **1024-65535** como portas efêmeras — portanto, essa é a regra de saída correta no NACL.

- B está errada: Security groups são stateful — respostas para tráfego permitido de entrada são automaticamente permitidas.
- C e D estão erradas: 32768-61000 é o range usado por kernels Linux; 1025-5000 é usado pelo Windows Server 2003 — mas a pergunta pede o range abrangente do ELB (1024-65535).

---

## Pergunta 3 [P05] · Domínio: Development with AWS Services

Sua função Lambda em Node.js precisa usar drivers para conectar a um banco de dados RDS PostgreSQL.

**Como você empacota a função Lambda para incluir as dependências?**

- A. **Colocar a função e as dependências em uma pasta e zipá-las juntas** ✅
- B. Zipar a função e as dependências separadamente e fazer upload no Lambda como duas partes
- C. Zipar a função com um arquivo package.json para que o Lambda resolva as dependências
- D. Fazer upload do código pelo console AWS e das dependências como um zip separado

**Resposta: A**

**Explicação:**
Um deployment package Lambda é um arquivo ZIP contendo o código da função e suas dependências. Você cria uma pasta com o código e todas as dependências necessárias, zipa tudo junto e faz upload para o Lambda (diretamente ou via S3 se > 50 MB).

- B, C e D estão erradas: há apenas uma forma de implantar uma função Lambda — fornecendo um ZIP com tudo que a função precisará.

---

## Pergunta 4 [P05] · Domínio: Development with AWS Services

Uma empresa usa S3 para armazenar dados anonimizados de clientes gerados diariamente. A equipe precisa analisar os dados para encontrar informações financeiras sensíveis.

**Qual opção você recomendaria de forma mais eficiente?**

- A. Usar Macie buscando por `SensitiveData:S3Object/CustomIdentifier`
- B. Usar Lambda baseada em Python ativada por S3 event notification para detectar informações sensíveis
- C. Usar Macie buscando por `SensitiveData:S3Object/Personal`
- D. **Usar Macie para analisar o output do batch job buscando por `SensitiveData:S3Object/Financial`** ✅

**Resposta: D**

**Explicação:**
Amazon Macie é um serviço de segurança de dados que usa machine learning para descobrir dados sensíveis no S3. Para dados financeiros (números de contas bancárias, cartões de crédito), o tipo de finding correto é `SensitiveData:S3Object/Financial`.

- C está errada: `Personal` é para PII (endereços, números de CPF/ID) e PHI (dados de saúde).
- A está errada: `CustomIdentifier` é para critérios de detecção personalizados.
- B está errada: manter uma aplicação customizada para detectar informações financeiras é ineficiente — o Macie já faz isso de forma gerenciada.

---

## Pergunta 5 [P05] · Domínio: Development with AWS Services

Uma tabela DynamoDB com RCU e WCU provisionadas funcionou por mais de um ano sem throttling. Após criar um LSI e um GSI em uma nova tabela para suportar novos tipos de queries, um mês depois a tabela começa a ter throttling. As métricas mostram que o RCU e WCU da tabela principal ainda são suficientes.

**O que está acontecendo?**

- A. As métricas estão atrasadas no CloudWatch
- B. O LSI está fazendo throttling — você precisa provisionar mais RCU/WCU ao LSI
- C. **O GSI está fazendo throttling — você precisa provisionar mais RCU/WCU ao GSI** ✅
- D. Ter LSI e GSI juntos na mesma tabela causa throttling por definição

**Resposta: C**

**Explicação:**
GSIs têm sua própria capacidade de throughput, separada da tabela base. Se o GSI tiver capacidade de escrita insuficiente em relação à tabela base, as escritas na tabela serão throttled. A capacidade de escrita do GSI deve ser maior ou igual à da tabela base.

- B está errada: LSIs usam o RCU e WCU da tabela principal — não é possível provisionar capacidade separada para eles.
- D está errada: ter LSI e GSI juntos é uma prática válida e recomendada.

---

## Pergunta 8 [P05] · Domínio: Development with AWS Services

Sua empresa quer gerenciar funções Lambda via CloudFormation em vez do console AWS.

**Como você declara uma função Lambda no CloudFormation?** (Selecione duas)

- A. **Fazer upload de todo o código como zip para o S3 e referenciar o objeto no bloco `AWS::Lambda::Function`** ✅
- B. **Escrever o código Lambda inline no CloudFormation no bloco `AWS::Lambda::Function` desde que não haja dependências de terceiros** ✅
- C. Escrever o código Lambda inline e referenciar as dependências como zip no S3
- D. Fazer upload de todo o código como pasta para o S3 e referenciar a pasta
- E. Fazer upload para o CodeCommit e referenciar o repositório no bloco Lambda

**Resposta: A, B**

**Explicação:**
- A: você pode zipar o código com todas as dependências, fazer upload para S3 e referenciar o objeto no CloudFormation.
- B: para runtimes Node.js e Python, você pode escrever o código inline no template CloudFormation, **desde que não haja dependências de terceiros** (apenas libraries da AWS como SDK, cfn-response, boto3 são pré-carregadas).
- C está errada: código inline não pode referenciar dependências de um zip no S3.
- D está errada: S3 não aceita referência de pasta — precisa ser um objeto zip.
- E está errada: CodeCommit não é suportado como fonte direta de código Lambda no CloudFormation.

---

## Pergunta 13 [P05] · Domínio: Development with AWS Services

Sua função Lambda cria muitos arquivos intermediários que precisam ser armazenados em disco e descartados quando a função para de rodar.

**Qual é a melhor forma de armazenar arquivos temporários?**

- A. **Usar o diretório local `/tmp`** ✅
- B. Criar um diretório `tmp/` no arquivo zip da função
- C. Usar um bucket S3
- D. Usar o diretório local `/opt`

**Resposta: A**

**Explicação:**
O Lambda fornece 512 MB de espaço temporário em `/tmp`. Esse espaço existe durante a vida do execution context e é descartado quando o container é reciclado.

- B está errada: não é possível acessar um diretório dentro de um arquivo zip.
- D está errada: `/opt` é onde Lambda Layers são extraídas — não é espaço temporário de escrita.
- C está errada: S3 não é temporário — os arquivos persistem após a função terminar.

---

## Pergunta 18 [P05] · Domínio: Development with AWS Services

Um developer criou um novo ALB mas não registrou nenhum target nos target groups.

**Qual erro seria gerado pelo Load Balancer?**

- A. **HTTP 503: Service unavailable** ✅
- B. HTTP 502: Bad gateway
- C. HTTP 500: Internal server error
- D. HTTP 504: Gateway timeout

**Resposta: A**

**Explicação:**
O ALB retorna HTTP 503 quando os target groups não têm nenhum target registrado.

- 502: o target retornou uma resposta inválida ao load balancer.
- 500: erro de configuração do load balancer (ex.: múltiplos certificates para o mesmo domínio no mesmo HTTPS listener).
- 504: o target não respondeu no tempo limite.

---

## Pergunta 23 [P05] · Domínio: Development with AWS Services

Uma API REST no API Gateway invoca uma função Lambda. A performance é satisfatória, mas a equipe quer otimizar o startup time para melhorar a experiência do cliente.

**Como você otimizaria a função Lambda para inicialização mais rápida?**

- A. Configurar reserved concurrency para garantir o número máximo de instâncias concorrentes
- B. Habilitar API caching no API Gateway para cachear respostas da Lambda
- C. **Configurar provisioned concurrency para que a função responda imediatamente às invocações** ✅
- D. Configurar um interface VPC endpoint com AWS PrivateLink para acessar o API Gateway

**Resposta: C**

**Explicação:**
Provisioned concurrency inicializa o número solicitado de execution environments previamente, de modo que estejam prontos para responder imediatamente. Funções com provisioned concurrency têm latência de startup consistente — ideais para APIs latency-sensitive.

- A está errada: reserved concurrency limita o número máximo de instâncias concorrentes — não elimina cold starts.
- B está errada: API caching reduz chamadas ao Lambda para dados estáticos — não reduz o tempo de inicialização.
- D está errada: VPC endpoint afeta o caminho de rede, não o tempo de inicialização do Lambda.

---

## Pergunta 27 [P05] · Domínio: Development with AWS Services

Uma empresa de análise de mídia construiu uma aplicação de streaming usando SAM.

**Qual é a ordem correta de execução para implantar a aplicação?**

- A. Desenvolver SAM template localmente → upload para CodeCommit → deploy para CodeDeploy
- B. Desenvolver SAM template localmente → deploy para S3 → usar a aplicação na nuvem
- C. Desenvolver SAM template localmente → upload para Lambda → deploy para a nuvem
- D. **Desenvolver SAM template localmente → upload do template para S3 → deploy da aplicação para a nuvem** ✅

**Resposta: D**

**Explicação:**
O fluxo correto com AWS SAM: desenvolver o template localmente → usar `sam deploy` que zipa os artefatos, faz upload para S3 e implanta na nuvem usando CloudFormation como mecanismo de deployment.

---

## Pergunta 31 [P05] · Domínio: Development with AWS Services

Uma REST API tem 80% das requisições de leitura compartilhadas entre todos os usuários. Os dados são armazenados no DynamoDB e o conteúdo estático no S3.

**Como você melhoraria a performance minimizando custos com o menor esforço de desenvolvimento?**

- A. Habilitar DAX para DynamoDB e ElastiCache Memcached para S3
- B. **Habilitar DynamoDB Accelerator (DAX) para DynamoDB e CloudFront para S3** ✅
- C. Habilitar ElastiCache Redis para DynamoDB e CloudFront para S3
- D. Habilitar ElastiCache Redis para DynamoDB e ElastiCache Memcached para S3

**Resposta: B**

**Explicação:**
- DAX: cache in-memory totalmente gerenciado para DynamoDB, compatível com a API do DynamoDB — mínimo esforço de desenvolvimento (basta apontar para o cluster DAX).
- CloudFront: CDN para S3, reduz latência e custo de egress — nenhuma mudança no código.
- C está errada: integrar ElastiCache com DynamoDB exige modificações significativas no código.
- A e D estão erradas: ElastiCache não pode servir conteúdo estático do S3 diretamente.

---

## Pergunta 32 [P05] · Domínio: Development with AWS Services

Um app mobile popular recupera dados de uma tabela DynamoDB. Um partition está recebendo muito mais tráfego que os outros, causando problemas de hot partition.

**Qual tecnologia permite reduzir o tráfego de leitura no DynamoDB com mínimo esforço?**

- A. ElastiCache
- B. Mais partições
- C. DynamoDB Streams
- D. **DynamoDB DAX** ✅

**Resposta: D**

**Explicação:**
DAX (DynamoDB Accelerator) é um cache in-memory totalmente gerenciado para DynamoDB que entrega até 10x de melhoria de performance. É nativo ao DynamoDB — mínimo esforço de integração, pois é compatível com a API existente.

- A está errada: ElastiCache pode ser usado para cachear resultados DynamoDB, mas exige modificações de código para verificar o cache antes de consultar o DynamoDB.
- C está errada: DynamoDB Streams é para captura de mudanças de itens, não para caching.
- B está errada: o DynamoDB gerencia partições automaticamente.

---

## Pergunta 33 [P05] · Domínio: Development with AWS Services

Para a Black Friday, a equipe quer implementar uma estratégia de caching no ElastiCache que aguente picos de tráfego. Um requisito chave é que o cache nunca fique fora de sincronia com o backend quando os preços e descrições são atualizados.

**Qual solução você recomendaria?**

- A. **Usar estratégia de escrever no backend primeiro e depois invalidar o cache** ✅
- B. Usar estratégia de escrever no backend primeiro e esperar o cache expirar via TTL
- C. Atualizar o cache e o backend ao mesmo tempo
- D. Escrever diretamente no cache e sincronizar o backend depois

**Resposta: A**

**Explicação:**
Esta estratégia é similar ao Write-Through: escreve no backend primeiro e invalida o cache. O caching engine então busca o valor mais recente do backend, garantindo que o cache sempre esteja sincronizado.

- B está errada: durante o TTL, o cache ficaria desatualizado — o requisito é não ter stale data.
- C está errada: cache e backend são sistemas separados — não é possível atualizar ambos atomicamente.
- D está errada: escrever no cache primeiro e sincronizar depois viola o requisito de consistência.

---

## Pergunta 37 [P05] · Domínio: Development with AWS Services

Um developer usa cross-stack referencing criando um stack `NetworkStack` que exporta `subnetId`. Para usar o valor exportado em outro stack, qual função deve ser usada?

- A. **`!ImportValue`** ✅
- B. `!Sub`
- C. `!Ref`
- D. `!GetAtt`

**Resposta: A**

**Explicação:**
`Fn::ImportValue` (ou `!ImportValue`) retorna o valor de um output exportado por outro stack. É a função correta para cross-stack references no CloudFormation.

- C está errada: `!Ref` retorna o valor de um parâmetro ou recurso dentro do mesmo stack.
- D está errada: `!GetAtt` retorna um atributo de um recurso no template.
- B está errada: `!Sub` substitui variáveis em uma string.

---

## Pergunta 38 [P05] · Domínio: Development with AWS Services

Uma aplicação mobile crítica usa Cognito User Pools com MFA. A empresa quer rastrear cada login de usuário via notificação por email para a equipe de segurança.

**Qual é a forma mais otimizada de implementar isso?**

- A. Configurar uma Lambda como trigger para operações autenticadas de Cognito identity pools
- B. Criar uma Lambda com SES e configurá-la como trigger pre-authentication do Cognito
- C. **Criar uma Lambda com SES e configurá-la como trigger post-authentication do Cognito** ✅
- D. Configurar Cognito user pools para enviar todos os dados de login ao Kinesis Data Streams e usar Lambda para analisar

**Resposta: C**

**Explicação:**
O trigger post-authentication do Cognito é invocado **após** o login bem-sucedido do usuário — exatamente quando queremos enviar a notificação. A Lambda usa SES para enviar o email.

- B está errada: o trigger pre-authentication é invocado antes da autenticação — serve para validar/rejeitar tentativas, não para rastrear logins bem-sucedidos.
- A está errada: Cognito Identity Pools são para autorização (credenciais AWS temporárias), não autenticação de usuários.
- D está errada: enviar dados via Kinesis + Lambda para análise é desnecessariamente complexo.

---

## Pergunta 39 [P05] · Domínio: Development with AWS Services

Você quer recuperar um subconjunto de dados de um arquivo CSV no S3 — um mês de dados e apenas 3 colunas de 10. Você quer minimizar custo de computação e rede.

**O que você deve usar?**

- A. S3 Analytics
- B. **S3 Select** ✅
- C. S3 Inventory
- D. S3 Access Logs

**Resposta: B**

**Explicação:**
S3 Select permite que aplicações recuperem apenas um subconjunto de dados de um objeto usando expressões SQL simples. Reduz a quantidade de dados transferidos e processados — melhora de performance de até 400%.

- A está errada: S3 Analytics analisa padrões de acesso para decidir sobre tiering de storage.
- C está errada: S3 Inventory gera relatórios de inventário dos objetos no bucket.
- D está errada: S3 Access Logs registra requisições ao bucket — não filtra dados de objetos.

---

## Pergunta 40 [P05] · Domínio: Development with AWS Services

Qual opção do CLI permite recuperar um subconjunto de atributos de um DynamoDB scan?

- A. `--max-items`
- B. `--page-size`
- C. **`--projection-expression`** ✅
- D. `--filter-expression`

**Resposta: C**

**Explicação:**
`--projection-expression` especifica os atributos a serem retornados em operações de leitura como GetItem, Query ou Scan. Atributos múltiplos são separados por vírgula.

- D está errada: `--filter-expression` filtra os **resultados** do Scan/Query após a leitura — consome a mesma capacidade.
- B está errada: `--page-size` controla quantos itens são recuperados por chamada de API.
- A está errada: `--max-items` limita o número total de itens no output.

---

## Pergunta 42 [P05] · Domínio: Development with AWS Services

Você usa SQS FIFO queues para ordenação de mensagens por `user_id`.

**Qual parâmetro de mensagem você deve definir com o valor de `user_id` para garantir a ordenação?**

- A. `MessageDeduplicationId`
- B. **`MessageGroupId`** ✅
- C. `MessageOrderId`
- D. `MessageHash`

**Resposta: B**

**Explicação:**
`MessageGroupId` especifica a qual grupo de mensagens uma mensagem pertence. Mensagens do mesmo grupo são sempre processadas uma de cada vez, em ordem estrita. Usar `user_id` como `MessageGroupId` garante que todas as mensagens de um usuário sejam processadas em ordem.

- A está errada: `MessageDeduplicationId` é para deduplicação, não para ordenação.
- C e D estão erradas: não existem esses parâmetros no SQS.

---

## Pergunta 44 [P05] · Domínio: Development with AWS Services

Uma aplicação bancária precisa atualizar a tabela `Exchanges` e a tabela `AccountBalance` no DynamoDB ao mesmo tempo ou nenhuma das duas.

**Qual funcionalidade do DynamoDB você deve usar?**

- A. **DynamoDB Transactions** ✅
- B. DynamoDB Indexes
- C. DynamoDB Streams
- D. DynamoDB TTL

**Resposta: A**

**Explicação:**
DynamoDB Transactions permitem fazer mudanças coordenadas all-or-nothing em múltiplos itens tanto dentro quanto entre tabelas. Fornecem ACID (Atomicity, Consistency, Isolation, Durability).

- B está errada: indexes (GSI/LSI) são para queries com diferentes partition/sort keys.
- C está errada: Streams captura changelog de mudanças — não garante atomicidade entre tabelas.
- D está errada: TTL é para expirar dados baseado em timestamp.

---

## Pergunta 47 [P05] · Domínio: Development with AWS Services

Um Kinesis Data Stream passou de 6 para 10 shards. Uma aplicação baseada em KCL roda em instâncias EC2.

**Qual é o número máximo de instâncias EC2 que podem ser implantadas para processar os shards?**

- A. **10** ✅
- B. 1
- C. 20
- D. 6

**Resposta: A**

**Explicação:**
Cada KCL worker processa um ou mais shards. A qualquer momento, cada shard é vinculado a um único worker via lease. O número máximo de workers (instâncias EC2) é igual ao número de shards — ter mais instâncias que shards resulta em instâncias ociosas.

---

## Pergunta 48 [P05] · Domínio: Development with AWS Services

Uma empresa faz upload diário de um arquivo comprimido de aproximadamente 2 GB para o S3.

**Qual é a forma mais rápida de fazer esse upload?**

- A. Transferir via FTP para uma instância EC2 na mesma região e depois mover para o S3
- B. **Fazer upload do arquivo usando multipart upload com S3 Transfer Acceleration** ✅
- C. Fazer upload do arquivo em uma única operação
- D. Fazer upload do arquivo usando multipart upload

**Resposta: B**

**Explicação:**
A combinação de multipart upload + S3 Transfer Acceleration é a mais rápida:
- Multipart upload divide o arquivo em partes que são enviadas em paralelo — melhora throughput.
- Transfer Acceleration usa edge locations do CloudFront para rotear o tráfego pelo backbone da AWS — melhora velocidade para longas distâncias.

- C está errada: para arquivos > 100 MB, multipart upload é recomendado.
- D está errada: multipart upload sem Transfer Acceleration não aproveita a rede global da AWS.
- A está errada: é um processo indireto e demorado.

---

## Pergunta 50 [P05] · Domínio: Development with AWS Services

Um site de avaliação de restaurantes suporta múltiplos idiomas via query string `?lang=pt`. Quando acessado diretamente, retorna o idioma correto. Quando acessado via CloudFront, sempre exibe um único idioma.

**Como você corrige esse problema?**

- A. Reduzir o Default TTL para o CloudFront encaminhar requisições à origin mais frequentemente
- B. Criar uma nova cache policy com cache behavior = None para melhorar a performance
- C. Criar uma nova cache policy com cache behavior baseado em request headers selecionados
- D. **Criar uma nova cache policy com cache behavior = Query string forwarding and caching. No campo de whitelist incluir o parâmetro de linguagem. Atualizar a distribuição CloudFront** ✅

**Resposta: D**

**Explicação:**
O CloudFront pode cachear diferentes versões do conteúdo com base em query string parameters. Para isso, você deve configurar "Forward all, cache based on whitelist" e especificar o parâmetro `lang` no whitelist. O CloudFront encaminhará o parâmetro à origin e cacheará versões separadas por idioma.

- B está errada: None ignora query strings — retorna o mesmo objeto independentemente do idioma.
- C está errada: o problema é com query strings, não com request headers.
- A está errada: reduzir TTL não resolve o problema de idioma.

---

## Pergunta 51 [P05] · Domínio: Development with AWS Services

Você quer que seu ambiente Elastic Beanstalk exponha um endpoint HTTPS em vez de HTTP para criptografia em trânsito.

**O que deve ser feito para configurar HTTPS no Beanstalk?**

- A. **Criar um arquivo de configuração na pasta `.ebextensions` para configurar o Load Balancer** ✅
- B. Usar um CloudFormation template separado para carregar o certificado SSL no Load Balancer
- C. Configurar Health Checks
- D. Abrir a porta 80 no security group

**Resposta: A**

**Explicação:**
Para habilitar HTTPS, você cria um arquivo `.ebextensions/securelistener-alb.config` que configura um HTTPS listener na porta 443 com o certificado SSL. Esta é a forma padrão de configurar o load balancer do Elastic Beanstalk via código.

- B está errada: um CloudFormation template separado não pode modificar o load balancer gerenciado pelo Beanstalk.
- C está errada: Health Checks não têm relação com certificados SSL.
- D está errada: porta 80 é para HTTP — você quer HTTPS (porta 443).

---

## Pergunta 54 [P05] · Domínio: Development with AWS Services

Você quer invocar uma função Lambda a cada hora (como um cron job) de forma serverless.

**Qual event source você usaria?**

- A. SQS
- B. **EventBridge** ✅
- C. Kinesis
- D. Amazon S3

**Resposta: B**

**Explicação:**
O EventBridge permite criar rules com schedule expressions (taxa fixa ou expressão Cron) para executar funções Lambda periodicamente — sem servidor adicional.

- A, C e D estão erradas: SQS, Kinesis e S3 não têm capacidade de agendamento cron nativo.

---

## Pergunta 56 [P05] · Domínio: Development with AWS Services

Uma instância EC2 tem uma IAM instance role com acesso de leitura e escrita ao bucket S3 `my_bucket`. Após remover a IAM role da instância, as escritas pararam de funcionar, mas as leituras continuam funcionando.

**Qual é a causa mais provável?**

- A. Remover uma instance role pode levar alguns minutos para ter efeito
- B. **A S3 bucket policy autoriza leituras** ✅
- C. Quando uma leitura é feita em um bucket, há um grace period de 5 minutos para fazer a mesma leitura
- D. A instância EC2 está usando credenciais IAM temporárias em cache

**Resposta: B**

**Explicação:**
Ao avaliar permissões de uma instância EC2 acessando S3, a união das permissões da IAM policy (instance role) e da bucket policy são consideradas. Após remover a IAM role, apenas a bucket policy entra em vigor — e ela autoriza leituras mas não escritas.

- A está errada: a remoção é imediata.
- C está errada: cada requisição é avaliada individualmente pelo IAM — não há grace period.
- D está errada: as credenciais temporárias pertencem à role que foi removida.

---

## Pergunta 64 [P05] · Domínio: Development with AWS Services

Uma aplicação e-commerce com 3 tiers (web, aplicação e banco) fica lenta durante picos de tráfego. A equipe identificou gargalos no tier de aplicação e quer uma solução de longo prazo.

**Qual solução melhora os tempos de resposta durante picos de tráfego?**

- A. Usar SQS com chamadas Lambda assíncronas para desacoplar application e data tiers
- B. **Usar escalabilidade horizontal para os tiers web e de aplicação com Auto Scaling groups e Application Load Balancer** ✅
- C. Usar escalabilidade vertical para a instância de aplicação provisionando uma instância EC2 maior
- D. Usar escalabilidade horizontal para a camada de persistência adicionando Oracle RAC na AWS

**Resposta: B**

**Explicação:**
Escalabilidade horizontal (adicionar mais instâncias) permite execução paralela de workloads. O ALB distribui o tráfego automaticamente entre instâncias. O Auto Scaling group adiciona instâncias conforme necessário, garantindo performance adequada durante picos.

- A está errada: a aplicação usa transações síncronas — Lambda assíncrono mudaria a arquitetura.
- C está errada: escalabilidade vertical é uma solução temporária que não funciona a longo prazo.
- D está errada: o problema está no tier de aplicação, não no de persistência.

---

## Pergunta 65 [P05] · Domínio: Development with AWS Services

Sua organização tem um bucket S3 com versioning habilitado e vários administradores com acesso IAM.

**Qual das seguintes afirmações sobre versioning NÃO é verdadeira neste cenário?**

- A. Deletar um arquivo é uma operação recuperável
- B. Qualquer arquivo não versionado antes de habilitar o versioning terá versão 'null'
- C. **Versioning pode ser habilitado apenas para uma pasta específica** ✅
- D. Sobrescrever um arquivo aumenta o número de suas versões

**Resposta: C**

**Explicação:**
O estado de versioning se aplica a **todos** os objetos do bucket — nunca apenas a alguns. Ao habilitar o versioning, todos os objetos passam a ser versionados e recebem IDs de versão únicos. Não é possível habilitar versioning para pastas específicas.

- A está errada (é verdadeira): ao deletar um objeto, o S3 insere um delete marker e você pode restaurar versões anteriores.
- B está errada (é verdadeira): objetos armazenados antes de habilitar o versioning recebem version ID `null`.
- D está errada (é verdadeira): sobrescrever um objeto cria uma nova versão no bucket.

---

## Pergunta 2 [P06] · Domínio: Development with AWS Services

Você está trabalhando em uma empresa de nuvem serverless. Você fez o deploy inicial e quer adicionar stages ao API Gateway (prod, test, dev) associando-os a deployments existentes. Os stages precisam apontar para uma variante de função Lambda que pode ser atualizada ao longo do tempo.

**Quais funcionalidades você deve adicionar para isso?** (Selecione duas)

- A. Integração Lambda + X-Ray
- B. **Stage Variables** ✅
- C. Mapping Templates
- D. **Lambda Aliases** ✅
- E. Lambda Versions

**Resposta: B, D**

**Explicação:**
- **Stage Variables**: pares nome-valor definidos como atributos de configuração de um deployment stage. Funcionam como variáveis de ambiente e permitem que um mesmo API aponte para backends diferentes por stage (ex.: beta.example.com para o stage beta).
- **Lambda Aliases**: um alias é como um ponteiro para uma versão específica da Lambda. Permite criar aliases "dev", "test", "prod" que podem ser atualizados ao longo do tempo para apontar para versões diferentes — mutáveis ao contrário das versões.

- E está errada: versões são imutáveis — não podem ser atualizadas com o tempo.
- A está errada: X-Ray é para rastreamento e debug, não para gestão de versões.
- C está errada: Mapping Templates transformam payloads — não gerenciam versões.

---

## Pergunta 3 [P06] · Domínio: Development with AWS Services

Você está provisionando uma tabela DynamoDB e precisa realizar 10 leituras fortemente consistentes por segundo de itens com 4 KB cada.

**Quantas Read Capacity Units (RCUs) são necessárias?**

- A. 20
- B. 40
- C. **10** ✅
- D. 5

**Resposta: C**

**Explicação:**
Uma RCU representa uma leitura fortemente consistente por segundo para um item de até 4 KB.

1) Tamanho do item / 4 KB = 4 KB / 4 KB = **1 RCU por item**
2) 1 RCU × 10 leituras/segundo = **10 RCUs**

---

## Pergunta 5 [P06] · Domínio: Development with AWS Services

Um developer hospeda um site estático no S3 atrás de uma distribuição CloudFront com domínio customizado. O pipeline CI/CD usa CodeBuild para fazer build e upload dos arquivos para o bucket S3. O conteúdo atualizado é visível no bucket e pelo endpoint do S3, mas o CloudFront continua servindo conteúdo antigo.

**O que você recomenda para resolver o problema?**

- A. Modificar a configuração CORS do bucket S3 para permitir todas as origens e fazer redeploy
- B. **Invocar uma invalidação do CloudFront para os caminhos alterados** ✅
- C. Habilitar versioning no bucket S3 e continuar fazendo upload com as mesmas chaves
- D. Adicionar um passo pós-build para ressincronizar o bucket S3

**Resposta: B**

**Explicação:**
Uma invalidação do CloudFront instrui o CloudFront a remover os objetos especificados dos caches das edge locations, fazendo com que a próxima requisição busque o conteúdo atualizado da origin (S3). Você pode usar wildcards (ex.: `/app/*.js`) para invalidar um conjunto de arquivos. O CloudFront oferece 1.000 caminhos de invalidação gratuitos por mês.

- A está errada: configuração CORS controla requisições cross-domain — não força atualização do cache.
- D está errada: reescrever os objetos no S3 não invalida o cache das edge locations do CloudFront.
- C está errada: o CloudFront cacheia por chave (URL), não por versão do S3 — o objeto continuará em cache até ser invalidado.

---

## Pergunta 7 [P06] · Domínio: Development with AWS Services

Um developer quer criptografar um payload XML grande usando AWS KMS antes de ir para produção.

**Qual é o tamanho máximo de dados suportado pelo AWS KMS para criptografia direta?**

- A. 1 MB
- B. 16 KB
- C. **4 KB** ✅
- D. 10 MB

**Resposta: C**

**Explicação:**
O AWS KMS suporta criptografia direta de até 4 KB (4.096 bytes) de dados. Para dados maiores, use **envelope encryption**: crie uma data key no KMS, criptografe os dados com essa data key localmente e criptografe a data key com o CMK do KMS — reduzindo o tráfego de rede ao mínimo.

---

## Pergunta 10 [P06] · Domínio: Development with AWS Services

Você precisa escrever 6 objetos por segundo, cada um com 4,5 KB no DynamoDB.

**Quantas Write Capacity Units (WCUs) são necessárias?**

- A. 24
- B. 46
- C. 15
- D. **30** ✅

**Resposta: D**

**Explicação:**
Uma WCU representa uma escrita por segundo para um item de até 1 KB. Tamanhos são arredondados para o próximo múltiplo de 1 KB.

1) 4,5 KB → arredondado para **5 KB** → 5 WCUs por item
2) 5 WCUs × 6 objetos/segundo = **30 WCUs**

---

## Pergunta 11 [P06] · Domínio: Development with AWS Services

Um ALB tem a função Lambda A como target, mas a Lambda A não consegue processar requisições. A equipe descobriu que outra Lambda B na mesma conta está excedendo os limites de concorrência.

**Como a equipe pode resolver isso?**

- A. **Configurar reserved concurrency para a Lambda B, limitando sua concorrência máxima** ✅
- B. Usar uma distribuição CloudFront em vez de ALB para a Lambda A
- C. Configurar provisioned concurrency para a Lambda B para limitar sua concorrência
- D. Usar API Gateway em vez de ALB para a Lambda A

**Resposta: A**

**Explicação:**
Reserved concurrency limita a concorrência **máxima** de uma função — sem afetar outras funções. Ao reservar concorrência para a Lambda B, você impede que ela consuma todo o pool de concorrência da conta, garantindo que a Lambda A possa executar.

- C está errada: provisioned concurrency garante instâncias pré-inicializadas para reduzir cold starts — não limita a concorrência máxima.
- B e D estão erradas: mudar o serviço de trigger da Lambda A não afeta a concorrência da Lambda B.

---

## Pergunta 12 [P06] · Domínio: Development with AWS Services

Uma empresa de plataforma de comunicação em nuvem precisa redesenhar sua arquitetura monolítica para alta disponibilidade e escalabilidade.

**Quais opções podem ser usadas para implementar a nova arquitetura?** (Selecione duas)

- A. SES + S3
- B. EBS + RDS
- C. CloudWatch + CloudFront
- D. **API Gateway + Lambda** ✅
- E. **ALB + ECS** ✅

**Resposta: D, E**

**Explicação:**
- **ALB + ECS**: o ECS é altamente escalável para containers Docker em clusters gerenciados. O ALB distribui o tráfego entre múltiplas AZs.
- **API Gateway + Lambda**: o API Gateway + Lambda é serverless, totalmente escalável e altamente disponível — ideal para APIs REST modernas.

- A está errada: SES + S3 fornecem apenas email e armazenamento de objetos.
- C está errada: CloudWatch + CloudFront fornecem monitoramento e CDN.
- B está errada: EBS + RDS fornecem block storage e banco de dados — não arquitetura de aplicação.

---

## Pergunta 13 [P06] · Domínio: Development with AWS Services

Uma empresa quer armazenar arquivos menos acessados no AWS, acessíveis concorrentemente por centenas de instâncias EC2, com o menor custo possível e acesso imediato quando necessário.

**Qual serviço você recomendaria?**

- A. Amazon EFS Standard
- B. Amazon EBS
- C. **Amazon EFS Standard-IA** ✅
- D. Amazon S3 Standard-IA

**Resposta: C**

**Explicação:**
O EFS Standard-IA (Infrequent Access) reduz os custos de armazenamento para arquivos não acessados diariamente, mantendo alta disponibilidade, durabilidade e acesso POSIX para milhares de instâncias EC2 simultâneas.

- D está errada: S3 é object storage — não file storage com semântica POSIX.
- A está errada: EFS Standard é para workloads de acesso frequente — mais caro que o necessário.
- B está errada: EBS é block storage para uma única instância EC2 — não permite acesso concorrente de centenas de instâncias.

---

## Pergunta 14 [P06] · Domínio: Development with AWS Services

Você está projetando uma tabela DynamoDB para um banco de dados de filmes e precisa escolher o partition key apropriado.

**Qual atributo único satisfaz esse requisito?**

- A. `producer_name`
- B. **`movie_id`** ✅
- C. `lead_actor_name`
- D. `movie_language`

**Resposta: B**

**Explicação:**
`movie_id` tem alta cardinalidade — cada filme tem um ID único, distribuindo os dados uniformemente entre as partições. Os outros atributos têm baixa cardinalidade (múltiplos filmes compartilham o mesmo produtor, ator principal ou idioma), causando hot partitions.

---

## Pergunta 19 [P06] · Domínio: Development with AWS Services

Um gerente de projeto quer migrar um ambiente Elastic Beanstalk da conta AWS do Time A para a do Time B.

**Qual procedimento você sugeriria?**

- A. Criar um export configuration no console Beanstalk do Time A e compartilhar com a IAM Role do Time B
- B. Criar uma saved configuration no Time A e configurá-la para Export; no Time B usar a opção Import
- C. **Criar uma saved configuration no Time A, baixar para a máquina local, ajustar parâmetros específicos da conta e fazer upload no bucket S3 do Time B; criar a aplicação via 'Saved Configurations' no console Beanstalk do Time B** ✅
- D. Não é possível migrar um ambiente Elastic Beanstalk entre contas AWS

**Resposta: C**

**Explicação:**
A única forma de migrar ambientes Elastic Beanstalk entre contas é usar saved configurations (arquivos YAML que definem platform version, tier, configurações e tags). O fluxo é: salvar a configuração → baixar → ajustar parâmetros específicos da conta (key pair, subnet ID, nome da aplicação) → fazer upload no S3 da conta destino → criar aplicação via 'Saved Configurations'.

- B está errada: não existe opção direta de Export/Import entre contas no Beanstalk.
- D está errada: é possível — seguindo o procedimento correto.

---

## Pergunta 23 [P06] · Domínio: Development with AWS Services

Uma aplicação ECS no Fargate precisa que dados de log sejam armazenados centralmente no AWS.

**Como você configuraria esse requisito?**

- A. O ECS envia métricas ao CloudWatch em períodos de 1 minuto automaticamente
- B. **Usar o awslogs log driver para configurar os containers nas tasks para enviar informações de log ao CloudWatch Logs; adicionar os parâmetros `logConfiguration` na task definition** ✅
- C. Usar o awslogs log driver — as instâncias de container ECS requerem ao menos a versão 1.9.0 do container agent
- D. Baixar e instalar o CloudWatch agent unificado nas instâncias ECS

**Resposta: B**

**Explicação:**
Para o launch type Fargate, você precisa adicionar os parâmetros `logConfiguration` na task definition com o driver `awslogs`. Isso configura os containers para enviar logs ao CloudWatch Logs. Não é necessário instalar nada — a configuração é feita na task definition.

- C está errada: a versão mínima do container agent (1.9.0) é requisito para o **EC2 launch type**, não Fargate.
- A está errada: as métricas automáticas são system-level (CPU, memória) — não logs de aplicação.
- D está errada: o Fargate é serverless — você não tem acesso à instância EC2 subjacente para instalar agentes.

---

## Pergunta 24 [P06] · Domínio: Development with AWS Services

Sua aplicação SQS precisa recuperar mensagens de uma fila e você especifica o número máximo de mensagens a recuperar.

**Qual é o número máximo de mensagens que podem ser recuperadas de uma vez?**

- A. 5
- B. 20
- C. **10** ✅
- D. 100

**Resposta: C**

**Explicação:**
Ao chamar a API `ReceiveMessage`, você pode especificar o número máximo de mensagens a recuperar — até **10**. Você não pode especificar quais mensagens recuperar, apenas o número máximo.

---

## Pergunta 27 [P06] · Domínio: Development with AWS Services

Um novo desenvolvedor quer aprender sobre Auto Scaling no EC2.

**Quais afirmações corretas sobre o Auto Scaling você explicaria?** (Selecione duas)

- A. Você não pode usar EC2 Auto Scaling para health checks se não estiver usando ELB
- B. EC2 Auto Scaling groups são construtos regionais que abrangem AZs e regiões AWS
- C. Toda vez que você cria um Auto Scaling group a partir de uma instância existente, ele cria uma nova AMI
- D. **O Amazon EC2 Auto Scaling funciona com Application Load Balancers e Network Load Balancers** ✅
- E. **O Amazon EC2 Auto Scaling não pode adicionar um volume a uma instância existente se o volume atual está chegando à capacidade** ✅

**Resposta: D, E**

**Explicação:**
- D: o EC2 Auto Scaling integra com ALB e NLB, incluindo seus health checks.
- E: um volume é anexado a novas instâncias quando são lançadas — o Auto Scaling não adiciona volumes a instâncias existentes. Para isso, use a API do EC2.

- B está errada: Auto Scaling groups abrangem AZs dentro de uma região — **não** múltiplas regiões.
- C está errada: criar um ASG a partir de uma instância existente não cria uma nova AMI.
- A está errada: você pode usar EC2 health checks sem ELB para substituir instâncias não saudáveis.

---

## Pergunta 30 [P06] · Domínio: Development with AWS Services

Funções Lambda processam workloads pesados (big data, arquivos grandes, cálculos estatísticos). Você quer melhorar a performance **sem mudar o código**.

**O que você deve fazer?**

- A. Mudar o runtime para Golang
- B. Aumentar o timeout da Lambda
- C. Mudar o tipo de instância da Lambda
- D. **Aumentar a RAM atribuída à Lambda** ✅

**Resposta: D**

**Explicação:**
No modelo de recursos do Lambda, a memória alocada determina proporcionalmente o poder de CPU. Com 1.769 MB, a função tem o equivalente a 1 vCPU. Aumentar a memória de 128 MB a 10.240 MB (em incrementos de 1 MB) aumenta tanto a RAM quanto a CPU disponível — sem nenhuma mudança de código.

- C está errada: "tipo de instância" não é um conceito do Lambda — é serverless.
- A está errada: mudar o runtime requer mudanças de código.
- B está errada: aumentar o timeout prolonga o tempo de execução — não melhora a performance do código.

---

## Pergunta 34 [P06] · Domínio: Development with AWS Services

Sua empresa tem um load balancer no VPC com o DNS `myDns-1234567890.us-east-1.elb.amazonaws.com`. Aplicações clientes resolvem o IP do DNS e então referenciam diretamente o IP. Após um tempo, as aplicações param de funcionar.

**Qual é a razão?**

- A. Seus security groups não são estáveis
- B. **O load balancer é altamente disponível e seu IP público pode mudar — o DNS name é constante** ✅
- C. Você precisa habilitar stickiness
- D. Você precisa desabilitar deployments multi-AZ

**Resposta: B**

**Explicação:**
Os load balancers da AWS são altamente disponíveis — os IPs dos nós podem mudar ao longo do tempo. Nunca resolva e armazene o IP de um load balancer. Sempre use o **DNS name** para referenciar o load balancer.

---

## Pergunta 41 [P06] · Domínio: Development with AWS Services

Sua equipe assinou um contrato de 1 ano com um cliente para uma aplicação web 3-tier com tráfego estável o dia todo, que precisa ser confiável sem downtime.

**Qual opção você escolheria?**

- A. Amazon EC2 Spot Instances
- B. Amazon EC2 On Demand Instances
- C. **Amazon EC2 Reserved Instances** ✅
- D. Instância EC2 on-premises

**Resposta: C**

**Explicação:**
Reserved Instances oferecem um desconto de faturamento em comparação com On-Demand e garantem reserva de capacidade. Para workloads previsíveis de 1 ano, Reserved Instances são significativamente mais econômicas.

- A está errada: Spot Instances podem ser interrompidas sem aviso prévio — inadequadas para aplicações que requerem disponibilidade contínua.
- B está errada: On-Demand custam mais que Reserved para uso de 1 ano.
- D está errada: on-premises exige manutenção de hardware físico — contrário ao objetivo de migrar para a nuvem.

---

## Pergunta 46 [P06] · Domínio: Development with AWS Services

Você está escrevendo um template CloudFormation com um EC2 e um RDS. Após criar os recursos, você quer exibir o endpoint de conexão do banco RDS.

**Qual função intrínseca retorna o valor necessário?**

- A. `!Sub`
- B. **`!GetAtt`** ✅
- C. `!FindInMap`
- D. `!Ref`

**Resposta: B**

**Explicação:**
`Fn::GetAtt` (ou `!GetAtt`) retorna o valor de um atributo de um recurso no template. Para obter o endpoint de conexão do RDS, use `!GetAtt MyDBInstance.Endpoint.Address`.

- D está errada: `!Ref` retorna o valor do parâmetro ou o identificador físico do recurso — não atributos específicos como endpoint.
- A está errada: `!Sub` substitui variáveis em strings.
- C está errada: `!FindInMap` busca valores em um mapa declarado na seção `Mappings`.

---

## Pergunta 53 [P06] · Domínio: Development with AWS Services

Uma aplicação mobile usa SQS para enviar mensagens a sistemas downstream. Um requisito é que as mensagens sejam armazenadas na fila por 12 dias.

**Como você configuraria esse requisito?**

- A. **Alterar a configuração de retenção de mensagens da fila** ✅
- B. Usar uma fila SQS FIFO
- C. Habilitar Long Polling para a fila SQS
- D. O período máximo de retenção de mensagens SQS é 7 dias, portanto 12 dias não é possível

**Resposta: A**

**Explicação:**
O SQS deleta automaticamente mensagens que excedem o período de retenção configurado. O padrão é 4 dias, mas você pode configurar de 60 segundos a **14 dias** usando `SetQueueAttributes`.

- D está errada: o período máximo é 14 dias (1.209.600 segundos).
- C está errada: Long Polling afeta como mensagens são recebidas — não o período de retenção.
- B está errada: filas FIFO garantem ordem e deduplicação — não controlam período de retenção.

---

## Pergunta 54 [P06] · Domínio: Development with AWS Services

Um developer configura um EC2 Auto Scaling Group que precisa lançar instâncias Spot e On-Demand. O CodeDeploy agent precisa ser instalado automaticamente em todas as instâncias Amazon Linux.

**Qual é a forma mais eficiente operacionalmente?**

- A. **Usar launch templates para configurar o ASG com instâncias Spot e On-Demand; usar o campo User data para adicionar um script que instala o CodeDeploy agent ao iniciar** ✅
- B. Usar launch configurations para configurar o ASG com instâncias Spot e On-Demand
- C. Configurar o AWS RAM para agendar a instalação automática do CodeDeploy agent
- D. Usar o AWS Systems Manager para instalar e atualizar o CodeDeploy agent automaticamente

**Resposta: A**

**Explicação:**
Launch templates (ao contrário de launch configurations) suportam múltiplos tipos de instâncias e instâncias Spot + On-Demand no mesmo ASG. O campo User data permite executar um script de instalação do CodeDeploy agent automaticamente ao iniciar cada instância.

- B está errada: launch configurations não suportam múltiplos tipos de instância nem mistura Spot + On-Demand — a AWS recomenda não usá-las mais.
- D está errada: o SSM Agent precisa ser instalado primeiro em todas as instâncias antes de poder instalar o CodeDeploy agent — menos eficiente.
- C está errada: AWS RAM é para compartilhar recursos entre contas — não para instalar software.

---

## Pergunta 55 [P06] · Domínio: Development with AWS Services

A equipe quer permitir que uma função Lambda na conta A acesse uma tabela DynamoDB na conta B.

**Qual solução você recomendaria?**

- A. Criar um clone da Lambda na conta B para que ela possa acessar o DynamoDB na mesma conta
- B. **Criar uma IAM role na conta B com acesso ao DynamoDB; modificar a trust policy da role na conta B para permitir que a execution role da Lambda assuma essa role; atualizar o código da Lambda para chamar a API `AssumeRole`** ✅
- C. Criar uma IAM role na conta B; modificar a trust policy da execution role na conta A para assumir a role na conta B
- D. Adicionar uma resource policy à tabela DynamoDB na conta B para conceder acesso à Lambda da conta A

**Resposta: B**

**Explicação:**
Para acesso cross-account:
1. Criar uma execution role na conta A com permissão de `AssumeRole`.
2. Criar uma IAM role na conta B com acesso ao DynamoDB.
3. Modificar a **trust policy da role na conta B** para confiar na execution role da Lambda na conta A.
4. Atualizar o código da Lambda para chamar `AssumeRole` e usar as credenciais temporárias resultantes.

- A está errada: clonar a Lambda não resolve o requisito de acesso cross-account.
- D está errada: o DynamoDB não suporta resource policies como S3 ou Lambda.
- C está errada: a trust policy a ser modificada é a da role na **conta B** (destino), não da role na conta A.

---

## Pergunta 57 [P06] · Domínio: Development with AWS Services

Uma equipe avalia o RDS Multi-AZ para sua aplicação principal.

**Quais afirmações sobre RDS Multi-AZ são corretas?** (Selecione duas)

- A. Para escalabilidade de leitura, a instância standby do Multi-AZ pode servir requisições de leitura
- B. **O RDS aplica atualizações de OS realizando manutenção no standby, promovendo-o para primário e então fazendo manutenção no antigo primário** ✅
- C. **O Amazon RDS automaticamente inicia failover para o standby se o banco primário falhar** ✅
- D. Atualizações são replicadas assincronamente para o standby
- E. Para backups automáticos, a atividade de I/O é suspensa no banco primário pois backups não são feitos do standby

**Resposta: B, C**

**Explicação:**
- B: durante manutenção de OS em Multi-AZ, o RDS: (1) aplica a manutenção no standby → (2) promove o standby para primário → (3) aplica manutenção no antigo primário (agora standby). Mínimo impacto.
- C: o failover Multi-AZ é automático e não requer intervenção administrativa.

- A está errada: o standby Multi-AZ não serve requisições de leitura — para isso, use read replicas.
- D está errada: a replicação Multi-AZ é **síncrona** (não assíncrona).
- E está errada: em Multi-AZ, os backups automáticos são feitos do **standby** — eliminando o impacto de I/O no banco primário.

---

## Pergunta 61 [P06] · Domínio: Development with AWS Services

Uma aplicação e-commerce escreve log files no S3 e os lê em paralelo em near real-time. Quando sobrescreve um log file existente e tenta lê-lo imediatamente, qual é o comportamento esperado?

**Qual afirmação descreve melhor o comportamento do S3 neste cenário?**

- A. Um processo substitui um objeto e imediatamente tenta lê-lo — o S3 pode retornar os dados anteriores até a propagação
- B. **Um processo substitui um objeto e imediatamente tenta lê-lo — o S3 sempre retorna a versão mais recente** ✅
- C. Um processo substitui um objeto e imediatamente tenta lê-lo — o S3 não retorna nenhum dado até a propagação
- D. Um processo substitui um objeto e imediatamente tenta lê-lo — o S3 pode retornar os novos dados até a propagação

**Resposta: B**

**Explicação:**
O Amazon S3 fornece consistência forte de read-after-write automaticamente. Após uma escrita bem-sucedida (seja novo objeto ou substituição), qualquer leitura subsequente retorna imediatamente a versão mais recente. Todas as operações GET, PUT e LIST são fortemente consistentes.

- A, C e D estão erradas: descrevem comportamentos de consistência eventual — o S3 agora é fortemente consistente.

---

## Pergunta 65 [P06] · Domínio: Development with AWS Services

Um developer habilitou logging no CloudWatch para o API Gateway e quer entender os pontos-chave da configuração.

**Quais são os pontos-chave ao configurar logging no nível de método para o API Gateway?** (Selecione dois)

- A. Você é cobrado por acessar métricas CloudWatch no nível de método e stage, mas não no nível de API
- B. **O AWS STS é usado pelo API Gateway para logging no CloudWatch Logs; portanto, o AWS STS deve estar habilitado para a região que você está usando** ✅
- C. **Para habilitar CloudWatch Logs, você deve especificar o ARN de uma IAM role que permita ao API Gateway escrever no CloudWatch Logs em seu nome** ✅
- D. Log groups e streams do API Gateway só podem ser deletados e recriados fazendo redeploy da API
- E. Em access logging, apenas variáveis `$context` e `$input` são suportadas

**Resposta: B, C**

**Explicação:**
- B: o API Gateway chama o AWS STS para assumir a IAM role que você fornece — certifique-se que o STS está habilitado na região que você está usando.
- C: para habilitar CloudWatch Logs, você deve fornecer o ARN de uma IAM role com a trust relationship para `apigateway.amazonaws.com` e a managed policy `AmazonAPIGatewayPushToCloudWatchLogs`.

- E está errada: em access logging, apenas variáveis `$context` são suportadas — não `$input`.
- A está errada: você é cobrado por métricas CloudWatch no **nível de método** (não por API-level ou stage-level).
- D está errada: log groups e streams podem ser deletados pelo console CloudWatch (embora não seja recomendado).
