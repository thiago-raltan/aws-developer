# Prova Marek 05 — AWS Certified Developer Associate

> **65 questões** | Domínios: Development with AWS Services · Security · Deployment · Troubleshooting and Optimization

---

## Pergunta 1 · Domínio: Security

Sua empresa habilitou website hosting em um bucket S3, definiu o index.html como página padrão e criou um Alias record no Route 53 apontando para o endpoint do website. Ao testar o domínio `www.mycompany.com`, você recebe o erro: `HTTP 403 (Access Denied)`.

**O que você pode fazer para resolver esse erro?**

- A. Habilitar CORS
- B. Criar uma IAM role
- C. **Criar uma bucket policy** ✅
- D. Habilitar Encryption

**Resposta: C**

**Explicação:**
Para configurar um bucket existente como site estático com acesso público, você deve criar uma bucket policy que conceda permissão de leitura pública e editar as configurações de "block public access" para o bucket.

- B está errada: IAM roles são para serviços — usuários públicos não têm identidade IAM.
- A está errada: CORS é para requisições cross-domain — aqui o problema é de acesso público.
- D está errada: criptografia não afeta erros de acesso; 403 indica falta de permissão de leitura.

---

## Pergunta 2 · Domínio: Troubleshooting and Optimization

Você quer paginar resultados de um `aws s3api list-objects` mostrando 100 resultados por página, minimizando o número de chamadas de API.

**Quais opções do CLI você deve usar?** (Selecione duas)

- A. `--limit`
- B. `--next-token`
- C. **`--starting-token`** ✅
- D. **`--max-items`** ✅
- E. `--page-size`

**Resposta: C, D**

**Explicação:**
- `--max-items`: limita o número total de itens exibidos na saída do CLI.
- `--starting-token`: especifica o token a partir do qual iniciar a próxima página de resultados.

Usando `aws s3api list-objects --bucket my-bucket --max-items 100 --starting-token <token>`, você obtém 100 resultados por página.

- `--page-size`: controla quantos itens são recuperados por chamada de API em background — não limita o output total.
- `--limit` e `--next-token`: não existem no AWS CLI — são opções inventadas.

---

## Pergunta 3 · Domínio: Development with AWS Services

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

## Pergunta 4 · Domínio: Development with AWS Services

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

## Pergunta 5 · Domínio: Development with AWS Services

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

## Pergunta 6 · Domínio: Deployment

Sua organização usa CodePipeline com Elastic Beanstalk. Você está se aproximando do limite de versões que podem ser armazenadas no Elastic Beanstalk.

**Como você pode remover versões antigas que não estão em uso?**

- A. Usar Worker Environments
- B. Configurar um arquivo .ebextensions
- C. **Usar uma Lifecycle Policy** ✅
- D. Definir uma função Lambda

**Resposta: C**

**Explicação:**
Uma Application Version Lifecycle Policy instrui o Elastic Beanstalk a deletar versões antigas quando o número total excede um limite especificado ou quando elas têm uma certa idade. O Elastic Beanstalk aplica a política cada vez que uma nova versão é criada.

- B está errada: `.ebextensions` é para configurar o ambiente Beanstalk, não para gerenciar versões.
- D está errada: embora tecnicamente possível, requer muito scripting manual.
- A está errada: Worker Environments são para offloading de tarefas longas — não gerenciam versões.

---

## Pergunta 7 · Domínio: Deployment

Um CodeBuild project foi criado com buildspec definido. Após executar o build, o CodeBuild falha ao fazer pull de uma imagem Docker no ambiente de build.

**Qual é a causa mais provável?**

- A. **Permissões IAM ausentes para o CodeBuild Service** ✅
- B. O CodeBuild não pode trabalhar com imagens Docker customizadas
- C. A imagem Docker é muito grande
- D. A imagem Docker está sem tags

**Resposta: A**

**Explicação:**
Por padrão, usuários IAM não têm permissão para acessar recursos do ECR. O CodeBuild precisa de um conjunto mínimo de permissões IAM para descrever e fazer pull de imagens do ECR.

- B está errada: imagens Docker customizadas são suportadas pelo CodeBuild.
- C e D estão erradas: tamanho e tags de imagem não causam falha de pull de credenciais.

---

## Pergunta 8 · Domínio: Development with AWS Services

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

## Pergunta 9 · Domínio: Troubleshooting and Optimization

Uma aplicação crítica em EC2 precisa rastrear o tempo médio de resposta e enviar notificação ao gerente via SNS quando exceder um threshold.

**Quais opções você combinaria para atender aos requisitos?** (Selecione duas)

- A. Instalar e configurar SSM Agent nas instâncias para monitorar tempo de resposta e enviar ao CloudWatch
- B. Configurar uma EventBridge rule para enviar notificação SNS quando o threshold for excedido
- C. **Configurar a aplicação para escrever o tempo de resposta em um log file. Instalar o CloudWatch agent para enviar os logs para CloudWatch Logs. Criar um Metric Filter para o tempo de resposta** ✅
- D. Instalar e configurar o Amazon Inspector agent nas instâncias para ler os logs e enviar o tempo de resposta ao EventBridge
- E. **Criar um CloudWatch alarm para enviar notificação SNS quando o tempo médio de resposta exceder o threshold** ✅

**Resposta: C, E**

**Explicação:**
- C: o CloudWatch agent coleta métricas de sistema e logs de instâncias EC2 e on-premises. Um Metric Filter extrai a métrica de tempo de resposta dos logs.
- E: um CloudWatch alarm monitora a métrica e dispara a notificação SNS quando o threshold é excedido.
- A está errada: SSM Agent gerencia recursos para o Systems Manager — não coleta logs e não os envia ao CloudWatch.
- D está errada: Amazon Inspector é para análise de vulnerabilidades, não para coleta de logs.
- B está errada: seria necessário um CloudWatch alarm mesmo assim; EventBridge sozinho não cria a métrica.

---

## Pergunta 10 · Domínio: Deployment

Você criou um ambiente de teste no Elastic Beanstalk que inclui um banco de dados RDS. Você quer ter acesso ao banco de dados após a destruição do ambiente.

**Como você garante isso?**

- A. Fazer uma exclusão seletiva no Elastic Beanstalk
- B. Converter o ambiente para Worker Environment
- C. **Fazer um snapshot do banco de dados antes de ser deletado** ✅
- D. Alterar as variáveis de ambiente do Elastic Beanstalk

**Resposta: C**

**Explicação:**
Um RDS DB instance vinculado a um ambiente Elastic Beanstalk tem seu ciclo de vida vinculado ao ambiente. Quando o ambiente é terminado, o banco de dados é deletado. A única forma de preservar os dados é fazer um snapshot manual antes de terminar o ambiente.

- A está errada: "selective delete" não é uma funcionalidade do Elastic Beanstalk.
- B está errada: você não pode converter ambientes Beanstalk — apenas alterar configurações.
- D está errada: variáveis de ambiente não afetam o provisionamento do RDS.

---

## Pergunta 11 · Domínio: Troubleshooting and Optimization

Qual variável de ambiente pode ser usada pelo AWS X-Ray SDK para garantir que o daemon seja descoberto corretamente no ECS?

- A. `AWS_XRAY_CONTEXT_MISSING`
- B. `AWS_XRAY_DEBUG_MODE`
- C. **`AWS_XRAY_DAEMON_ADDRESS`** ✅
- D. `AWS_XRAY_TRACING_NAME`

**Resposta: C**

**Explicação:**
`AWS_XRAY_DAEMON_ADDRESS` define o host e porta do X-Ray daemon listener. Por padrão, o SDK usa `127.0.0.1:2000`. No ECS, o daemon pode estar rodando em um endereço diferente — essa variável informa ao SDK onde encontrá-lo.

- D está errada: `AWS_XRAY_TRACING_NAME` define o nome do serviço para os segments.
- A está errada: `AWS_XRAY_CONTEXT_MISSING` define o comportamento quando não há segmento aberto.
- B está errada: `AWS_XRAY_DEBUG_MODE` habilita logs de debug no console.

---

## Pergunta 12 · Domínio: Security

Instâncias EC2 em uma subnet privada de um VPC customizado precisam acessar imagens no S3 e atualizar registros no DynamoDB. Você quer fornecer acesso privado sem usar a internet pública.

**Como você faria isso?**

- A. **Criar um gateway endpoint separado para S3 e DynamoDB. Adicionar duas entradas na route table do VPC customizado apontando para esses gateway endpoints** ✅
- B. Criar um gateway endpoint para DynamoDB e um API endpoint para S3
- C. Criar um gateway endpoint para S3 e um interface endpoint para DynamoDB
- D. Criar um interface endpoint separado para S3 e DynamoDB

**Resposta: A**

**Explicação:**
S3 e DynamoDB suportam **gateway endpoints** — os únicos dois serviços AWS que suportam esse tipo. Você adiciona rotas na route table do VPC apontando para esses endpoints, e o tráfego não sai da rede Amazon.

- C e D estão erradas: DynamoDB não suporta interface endpoints — apenas gateway endpoints.
- B está errada: "API endpoint" para S3 não existe.

---

## Pergunta 13 · Domínio: Development with AWS Services

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

## Pergunta 14 · Domínio: Troubleshooting and Optimization

Uma aplicação de análise de dados ingere mensagens e as armazena no RDS via Lambda, mas cada mensagem leva mais de 15 minutos para processar.

**Qual opção seria mais escalável?**

- A. Usar DynamoDB em vez de RDS
- B. Contatar o suporte AWS para aumentar o timeout do Lambda para 60 minutos
- C. **Provisionar instâncias EC2 em um Auto Scaling group para fazer poll das mensagens de uma SQS queue** ✅
- D. Provisionar uma única instância EC2 para fazer poll das mensagens

**Resposta: C**

**Explicação:**
Como o processamento leva mais de 15 minutos (limite máximo do Lambda), Lambda não pode ser usado. Para ser escalável, as instâncias EC2 devem ser provisionadas via Auto Scaling group para lidar com variações no workload.

- B está errada: o suporte AWS não pode aumentar o limite de timeout do Lambda.
- A está errada: mudar o banco de dados não resolve o problema de timeout.
- D está errada: uma única instância EC2 pode não suportar picos súbitos de mensagens.

---

## Pergunta 15 · Domínio: Security

Você quer centralizar traces do X-Ray de múltiplas contas AWS em uma conta unificada para ter uma visão consolidada.

**O que você deve configurar no X-Ray daemon?** (Selecione duas)

- A. Criar um usuário IAM na conta unificada e gerar access/secret keys
- B. Configurar o X-Ray daemon para usar access e secret keys
- C. **Configurar o X-Ray daemon para usar uma IAM instance role** ✅
- D. **Criar uma role na conta unificada e permitir que roles de cada sub-conta assumam essa role** ✅
- E. Habilitar "Cross Account collection" no console do X-Ray

**Resposta: C, D**

**Explicação:**
O X-Ray daemon pode assumir uma role para publicar dados em uma conta diferente da que está rodando:

1. Criar uma role na conta unificada (destino) com permissões de escrita no X-Ray.
2. Configurar a trust policy da role para confiar nas sub-contas.
3. Configurar o X-Ray daemon nas sub-contas para usar uma IAM instance role que possa assumir a role da conta unificada.

- A e B estão erradas: usar access/secret keys hardcoded não é a melhor prática de segurança.
- E está errada: "Cross Account collection" não é uma opção do console X-Ray.

---

## Pergunta 16 · Domínio: Deployment

Você precisa criar um serviço ECS no cluster padrão mantendo pelo menos 10 instâncias de uma task definition usando o AWS CLI.

**Qual comando deve ser executado?**

- A. `aws ecr create-service --service-name ecs-simple-service --task-definition ecs-demo --desired-count 10`
- B. `aws ecs run-task --cluster default --task-definition ecs-demo`
- C. `docker-compose create ecs-simple-service`
- D. **`aws ecs create-service --service-name ecs-simple-service --task-definition ecs-demo --desired-count 10`** ✅

**Resposta: D**

**Explicação:**
`aws ecs create-service` cria um serviço ECS na região padrão chamado `ecs-simple-service` usando a task definition `ecs-demo`, mantendo 10 instâncias da task.

- A está errada: `aws ecr` refere-se ao Elastic Container Registry — para gerenciar imagens, não serviços.
- B está errada: `run-task` inicia tasks avulsas, não cria um serviço persistente.
- C está errada: `docker-compose create` é para ambientes Docker locais.

---

## Pergunta 17 · Domínio: Troubleshooting and Optimization

A equipe de desenvolvimento quer escrever uma função Lambda que envie notificações para mudanças de estado no CodePipeline.

**Quais etapas você sugeriria para associar a função Lambda à event source?**

- A. **Configurar uma EventBridge rule usando CodePipeline como event source com a Lambda function como target** ✅
- B. Usar o console Lambda para configurar um trigger com CodePipeline como event source
- C. Configurar um CloudWatch alarm que monitora mudanças de status no CodePipeline e aciona a Lambda
- D. Usar o console do CodePipeline para configurar um trigger para a Lambda

**Resposta: A**

**Explicação:**
O EventBridge integra nativamente com o CodePipeline. Você cria uma rule que detecta mudanças de estado no pipeline (stages, actions) e invoca a função Lambda como target.

- B está errada: não é possível configurar um trigger com CodePipeline como event source via console Lambda.
- C está errada: CloudWatch alarms monitoram métricas, não mudanças de estado do CodePipeline.
- D está errada: o console do CodePipeline não permite configurar triggers para Lambda diretamente.

---

## Pergunta 18 · Domínio: Development with AWS Services

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

## Pergunta 19 · Domínio: Troubleshooting and Optimization

Aplicações em instâncias EC2 processam mensagens de uma SQS queue mas às vezes experimentam erros com mensagens que não são processadas. Para isolar as mensagens problemáticas para debugging adicional, qual opção vai ajudar?

- A. Reduzir o VisibilityTimeout
- B. **Implementar uma Dead Letter Queue (DLQ)** ✅
- C. Usar DeleteMessage
- D. Aumentar o VisibilityTimeout

**Resposta: B**

**Explicação:**
DLQs são usadas por filas fonte como destino para mensagens que não podem ser processadas com sucesso. Permitem isolar mensagens problemáticas para determinar por que o processamento não está funcionando.

- C está errada: DeleteMessage remove a mensagem permanentemente — impossibilita análise.
- A e D estão erradas: alterar o VisibilityTimeout não isola mensagens com falha.

---

## Pergunta 20 · Domínio: Troubleshooting and Optimization

Uma equipe tem aplicações on-premises e em instâncias EC2. A aplicação on-premises controla as demais. A equipe quer usar CloudWatch para monitorar e fazer troubleshooting da aplicação on-premises.

**Qual solução você sugeriria?**

- A. Configurar CloudWatch Logs para ler diretamente os logs do servidor on-premises
- B. Fazer upload dos logs do servidor on-premises para S3 e deixar o CloudWatch processar do S3
- C. **Configurar o CloudWatch agent no servidor on-premises usando credenciais de um IAM user com permissões para CloudWatch** ✅
- D. Fazer upload dos logs para uma instância EC2 que encaminha para o CloudWatch

**Resposta: C**

**Explicação:**
O CloudWatch agent pode coletar métricas e logs de servidores on-premises. Para habilitar o envio de dados de um servidor on-premises, você deve especificar o access key e secret key de um IAM user com permissões de CloudWatch.

- A está errada: o CloudWatch Logs não pode se comunicar diretamente com servidores on-premises sem o agente.
- B e D estão erradas: exigem customizações significativas e não são tão bem integradas quanto o CloudWatch Agent.

---

## Pergunta 21 · Domínio: Deployment

Um Auto Scaling group de 3 instâncias EC2 tem performance severamente impactada quando o número cai abaixo de 2. A empresa usa "all-at-once" deployment e quer uma estratégia mais eficaz.

**Qual estratégia de deployment representa o menor custo com capacidade total mantida?**

- A. Usar rolling deployment com batch size = 2
- B. **Usar rolling with additional batch com batch size = 1** ✅
- C. Configurar um ALB na frente do ASG e escolher duas AZs diferentes
- D. Usar traffic-splitting deployment com 50% do tráfego

**Resposta: B**

**Explicação:**
"Rolling with additional batch" lança um batch extra de instâncias antes de retirar qualquer instância existente de serviço, mantendo a capacidade total durante o deploy. Com batch size = 1, apenas 1 instância é atualizada por vez, garantindo que as outras 2 continuem servindo tráfego.

- A está errada: com rolling + batch size 2, durante o deploy apenas 1 instância fica disponível — abaixo do mínimo de 2.
- C está errada: adicionar AZs é para resiliência, não para estratégia de deploy.
- D está errada: traffic-splitting exige criar um conjunto completo de novas instâncias — solução mais cara.

---

## Pergunta 22 · Domínio: Troubleshooting and Optimization

Você está em uma instância EC2 bastion host e quer saber o security group e o instance ID da instância atual.

**Qual opção vai te ajudar?**

- A. Consultar user data em `http://169.254.169.254/latest/user-data`
- B. **Consultar o metadata em `http://169.254.169.254/latest/meta-data`** ✅
- C. Criar uma IAM role e executar chamada describe
- D. Consultar user data em `http://254.169.254.169/latest/meta-data`

**Resposta: B**

**Explicação:**
O instance metadata está disponível em `http://169.254.169.254/latest/meta-data/` a partir de qualquer instância EC2 em execução, sem necessidade de credenciais. Você pode recuperar informações como instance ID, security groups, IP address, etc.

- A está errada: user data contém os scripts de inicialização que você especificou no launch — não metadados da instância.
- C está errada: describe-instances requer o instance ID como input — que é exatamente o que você quer descobrir.
- D está errada: o endereço IP está invertido.

---

## Pergunta 23 · Domínio: Development with AWS Services

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

## Pergunta 24 · Domínio: Security

Você quer que os artefatos de build do CodeBuild sejam automaticamente criptografados ao final do build.

**Como você configura o CodeBuild para isso?**

- A. Usar o AWS Encryption SDK
- B. **Especificar uma KMS key a ser usada** ✅
- C. Usar um AWS Lambda Hook
- D. Usar In Flight encryption (SSL)

**Resposta: B**

**Explicação:**
Para criptografar os artefatos de build, o CodeBuild precisa de acesso a uma CMK do KMS. Por padrão, usa a AWS-managed CMK para S3. Você pode especificar uma CMK customizada via variável de ambiente `CODEBUILD_KMS_KEY_ID` ou nas configurações do projeto.

- A e C estão erradas: o Encryption SDK e Lambda hooks não são relevantes para criptografia automática de artefatos.
- D está errada: SSL criptografa dados em trânsito, não artefatos em repouso.

---

## Pergunta 25 · Domínio: Troubleshooting and Optimization

Você usa SQS FIFO queues e quer garantir que mensagens duplicadas não sejam enviadas para a fila.

**Qual parâmetro de mensagem você deve definir para deduplicar mensagens?**

- A. `ReceiveRequestAttemptId`
- B. `ContentBasedDeduplication`
- C. **`MessageDeduplicationId`** ✅
- D. `MessageGroupId`

**Resposta: C**

**Explicação:**
`MessageDeduplicationId` é o token usado para deduplicação de mensagens enviadas. Se uma mensagem com um determinado ID for enviada com sucesso, qualquer mensagem com o mesmo ID enviada dentro de 5 minutos será aceita mas não entregue.

- D está errada: `MessageGroupId` garante a **ordem** das mensagens por grupo, não deduplicação.
- A está errada: `ReceiveRequestAttemptId` é para deduplicação de chamadas ReceiveMessage (não para envio).
- B está errada: `ContentBasedDeduplication` é uma **configuração da fila** (não um parâmetro de mensagem) que usa hash SHA-256 do corpo para gerar o ID de deduplicação automaticamente.

---

## Pergunta 26 · Domínio: Security

Uma aplicação web usa STS para requisitar credenciais, mas após uma hora a aplicação para de funcionar.

**Qual é a causa mais provável?**

- A. Uma função Lambda revoga seu acesso a cada hora
- B. **Sua aplicação precisa renovar as credenciais após 1 hora quando elas expiram** ✅
- C. Sua IAM policy está incorreta
- D. O serviço IAM tem downtime uma vez por hora

**Resposta: B**

**Explicação:**
Credenciais criadas com STS usando credenciais da conta têm duração entre 900 segundos (15 minutos) e 3.600 segundos (1 hora), com padrão de 1 hora. A aplicação precisa implementar lógica de renovação quando as credenciais expirarem.

- C está errada: se a policy estivesse incorreta, um reboot não resolveria.
- A está errada: Lambda não pode revogar credenciais diretamente — apenas IAM policies podem.
- D está errada: o serviço IAM é gerenciado pela AWS e altamente disponível.

---

## Pergunta 27 · Domínio: Development with AWS Services

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

## Pergunta 28 · Domínio: Troubleshooting and Optimization

Você está rodando um serviço DNS em uma instância EC2 onde o DNS aponta para o IP da instância. Você quer atualizar o serviço sem downtime.

**Qual opção vai ajudar?**

- A. Fornecer um static private IP
- B. **Elastic IP** ✅
- C. Usar Route 53
- D. Criar um Load Balancer e um Auto Scaling group

**Resposta: B**

**Explicação:**
Serviços DNS são identificados por IP público. Um Elastic IP fornece um IP público estático que pode ser transferido entre instâncias, permitindo atualizar o serviço DNS sem alterar o IP — sem downtime.

- A está errada: um private IP não é acessível pela internet.
- C está errada: Route 53 é um serviço DNS da AWS — o caso de uso é sobre rodar seu próprio software DNS.
- D está errada: load balancers fornecem um DNS name, não um IP fixo.

---

## Pergunta 29 · Domínio: Troubleshooting and Optimization

Você usa ElastiCache para caching em uma aplicação de blog. Quando um blog é atualizado, você quer garantir que os dados mais recentes sejam servidos (sem stale data).

**Qual estratégia de caching você recomendaria?**

- A. Usar DAX
- B. **Usar uma estratégia Write Through** ✅
- C. Usar uma estratégia Lazy Loading sem TTL
- D. Usar uma estratégia Lazy Loading com TTL

**Resposta: B**

**Explicação:**
A estratégia Write Through adiciona/atualiza dados no cache sempre que dados são escritos no banco de dados. Qualquer novo blog ou atualização será escrito tanto no banco quanto no cache simultaneamente — garantindo que o cache nunca fique desatualizado.

- C e D estão erradas: com Lazy Loading, uma atualização no banco não reflete imediatamente no cache — haverá dados stale até o próximo acesso ou expiração do TTL.
- A está errada: DAX é um cache específico para DynamoDB — a questão menciona ElastiCache.

---

## Pergunta 30 · Domínio: Security

Uma aplicação usa uma distribuição CloudFront com OAI (Origin Access Identity) para acessar um bucket S3 com acesso explicitamente negado para outros. Um developer quer permitir acesso à página de login para usuários não autenticados, mantendo o conteúdo privado seguro.

**O que você recomendaria?**

- A. Configurar uma segunda origin como failover origin
- B. Configurar uma nova distribuição com a mesma origin e path pattern da página de login
- C. Configurar um segundo cache behavior com path pattern `*` com acesso restrito e mudar o padrão para a página de login
- D. **Configurar um segundo cache behavior com a mesma origin que o padrão e definir o path pattern como o caminho da página de login com acesso irrestrito. Manter as configurações do cache behavior padrão inalteradas** ✅

**Resposta: D**

**Explicação:**
Adicionando um segundo cache behavior listado acima do padrão, com o path pattern da página de login e viewer access irrestrito, usuários não autenticados podem acessar a página de login. O cache behavior padrão (`*`) continua com acesso restrito para todo o conteúdo privado.

- C está errada: o path pattern do cache behavior padrão é sempre `*` e não pode ser alterado.
- B está errada: uma segunda distribuição com apenas o default behavior não usa a segunda origin.
- A está errada: failover origin só atua quando a origin primária está indisponível — não é adequado para controle de acesso.

---

## Pergunta 31 · Domínio: Development with AWS Services

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

## Pergunta 32 · Domínio: Development with AWS Services

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

## Pergunta 33 · Domínio: Development with AWS Services

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

## Pergunta 34 · Domínio: Deployment

Seu cliente quer rodar 3 containers Docker diferentes simultaneamente em cada instância EC2 de um Auto Scaling group usando Elastic Beanstalk.

**Qual plataforma Elastic Beanstalk você escolheria?**

- A. Docker single-container platform
- B. Third-party platform
- C. Custom platform
- D. **Docker multi-container platform** ✅

**Resposta: D**

**Explicação:**
A plataforma Multi-container Docker do Elastic Beanstalk usa o Amazon ECS para coordenar deploys de múltiplos containers em ambientes Docker. É a plataforma correta quando você precisa rodar múltiplos containers em cada instância.

- A está errada: single-container platform suporta apenas um container por instância.
- C está errada: custom platform é para criar uma plataforma completamente nova — não necessário aqui.
- B está errada: "Third-party platform" é uma opção inventada.

---

## Pergunta 35 · Domínio: Security

Funções Lambda gerenciadas com SAM precisam ler arquivos de buckets S3.

**Qual policy SAM você deve inserir no template serverless para dar acesso de leitura aos buckets?**

- A. `SQSPollerPolicy`
- B. **`S3ReadPolicy`** ✅
- C. `LambdaInvokePolicy`
- D. `S3CrudPolicy`

**Resposta: B**

**Explicação:**
`S3ReadPolicy` concede permissão de leitura a objetos em um bucket S3. As SAM policy templates são uma forma conveniente de definir permissões no template SAM sem precisar escrever policies IAM completas.

- D está errada: `S3CrudPolicy` concede create, read, update e delete — mais permissões do que necessário.
- A está errada: `SQSPollerPolicy` é para fazer poll de uma SQS queue.
- C está errada: `LambdaInvokePolicy` é para invocar funções Lambda.

---

## Pergunta 36 · Domínio: Security

Uma aplicação e-commerce cripta transações em bulk com KMS antes de enviá-las para uma aplicação de contabilidade. Após essa mudança, a aplicação passa a receber `ThrottlingException`.

**Quais medidas o developer deve tomar para resolver isso?** (Selecione duas)

- A. Usar um bucket-level key para SSE-KMS
- B. **Reduzir a taxa de requisições e implementar backoff e retry logic** ✅
- C. Enviar eventos CloudTrail do KMS para CloudWatch Logs
- D. Escrever queries no CloudWatch Logs Insights e abrir caso de suporte para aumentar quota
- E. **Usar o recurso de data key caching com a biblioteca AWS Encryption SDK** ✅

**Resposta: B, E**

**Explicação:**
- B: implementar exponential backoff permite que a aplicação se auto-ajuste à taxa de requisições permitida pelo KMS.
- E: data key caching armazena data keys no cache — a aplicação reutiliza data keys cached em vez de gerar novas para cada operação, reduzindo drasticamente as chamadas ao KMS.
- A está errada: bucket-level keys são para SSE-KMS no S3 — S3 não é mencionado no caso de uso.
- C e D estão erradas: analisar logs e abrir tickets não resolve o problema imediatamente.

---

## Pergunta 37 · Domínio: Development with AWS Services

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

## Pergunta 38 · Domínio: Development with AWS Services

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

## Pergunta 39 · Domínio: Development with AWS Services

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

## Pergunta 40 · Domínio: Development with AWS Services

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

## Pergunta 41 · Domínio: Troubleshooting and Optimization

Você quer rodar o X-Ray daemon para containers Docker implantados usando AWS Fargate.

**O que você precisa fazer para garantir que o setup funcione?** (Selecione duas)

- A. Fornecer a IAM instance role correta para a instância EC2
- B. Implantar o X-Ray daemon agent como processo em sua instância EC2
- C. **Implantar o X-Ray daemon agent como sidecar container** ✅
- D. Implantar o X-Ray daemon agent como daemon set no ECS
- E. **Fornecer a IAM task role correta para o container X-Ray** ✅

**Resposta: C, E**

**Explicação:**
- C: no Fargate, você não controla a instância EC2 subjacente. O X-Ray daemon deve ser implantado como um container sidecar na mesma task definition.
- E: no Fargate, somente IAM task roles podem ser fornecidas (não instance roles). A role deve ter permissões para `xray:PutTraceSegments` e `xray:PutTelemetryRecords`.
- A e B estão erradas: Fargate não dá acesso à instância EC2 subjacente.
- D está errada: daemon sets são apenas para o modo ECS classic (EC2 launch type).

---

## Pergunta 42 · Domínio: Development with AWS Services

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

## Pergunta 43 · Domínio: Troubleshooting and Optimization

Um developer definiu uma integração Lambda no API Gateway usando uma stage variable. Ao invocar o método, recebe "Internal server error" com status 500.

**Quais etapas o developer deve tomar para corrigir o problema?**

- A. Ao definir a Lambda como valor da stage variable, usar o ARN da função e não o alias
- B. Criar uma IAM role que sua função Lambda pode assumir ao invocar recursos AWS
- C. **Atualizar a resource-based IAM policy da função Lambda para conceder permissão de invocação ao API Gateway** ✅
- D. Implementar error retries e exponential backoff para corrigir o erro de rate exceeded

**Resposta: C**

**Explicação:**
Se a resource-based policy da função Lambda não inclui permissões para o API Gateway invocar a função, o API Gateway retorna "Internal server error". Ao usar stage variables para chamar Lambda via API Gateway, você deve adicionar manualmente as permissões necessárias à resource-based policy da Lambda.

- A está errada: ao usar stage variables, use o **nome local** da função (não o ARN). O console API Gateway expande a stage variable para um ARN automaticamente.
- B está errada: você deve conceder permissões de invocação ao **API Gateway** (não criar uma role para a Lambda assumir).
- D está errada: "Rate Exceeded" e "Internal server error" são erros diferentes.

---

## Pergunta 44 · Domínio: Development with AWS Services

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

## Pergunta 45 · Domínio: Troubleshooting and Optimization

Um site de redes sociais usa ElastiCache com RDS. O dataset completo de usuários não cabe no cache com custo razoável. A aplicação aceita dados stale por até 1 minuto. Você quer cachear apenas os perfis mais acessados.

**Qual estratégia de caching você recomenda?**

- A. Usar uma estratégia Write Through com TTL
- B. Usar uma estratégia Lazy Loading sem TTL
- C. **Usar uma estratégia Lazy Loading com TTL** ✅
- D. Usar uma estratégia Write Through sem TTL

**Resposta: C**

**Explicação:**
Lazy Loading carrega dados no cache apenas quando necessário — apenas perfis acessados ficam no cache. O TTL de 1 minuto garante que dados stale expirem automaticamente, mantendo a consistência dentro do limite aceito.

- B está errada: sem TTL, os dados nunca expiram — stale data pode acumular indefinidamente.
- A e D estão erradas: Write Through preencheria o cache com todos os usuários (mesmo os não acessados) — ultrapassando o limite de custo.

---

## Pergunta 46 · Domínio: Security

Uma empresa quer migrar um serviço de edição de vídeo para EC2. Os vídeos são lidos de um bucket S3 privado.

**Qual solução você recomendaria seguindo as melhores práticas de segurança?**

- A. **Criar uma EC2 service role com permissões de leitura para o bucket S3 e anexá-la ao EC2 instance profile** ✅
- B. Criar uma S3 service role com permissões de leitura para o bucket S3 e anexá-la ao EC2 instance profile
- C. Criar um IAM user com permissões de leitura para o S3 e configurar credenciais via AWS CLI na instância
- D. Criar um IAM user e configurar credenciais nos user data da instância EC2

**Resposta: A**

**Explicação:**
Como melhor prática, não distribua credenciais de usuários IAM para aplicações. Crie uma IAM role com permissões de leitura para o S3 e aplique ao EC2 instance profile — a aplicação recebe credenciais temporárias automaticamente.

- B está errada: não existe "S3 service role" — deve ser uma EC2 service role.
- C e D estão erradas: armazenar credenciais de IAM user na instância (seja via CLI, user data ou código) é uma má prática de segurança.

---

## Pergunta 47 · Domínio: Development with AWS Services

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

## Pergunta 48 · Domínio: Development with AWS Services

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

## Pergunta 49 · Domínio: Security

Uma função Lambda é invocada via API Gateway. O API Gateway controla o acesso.

**Qual mecanismo NÃO é suportado para autenticação no API Gateway?**

- A. Lambda Authorizer
- B. Cognito User Pools
- C. Permissões IAM com sigv4
- D. **STS** ✅

**Resposta: D**

**Explicação:**
AWS STS gera credenciais temporárias para usuários IAM ou federados, mas não é um mecanismo de autenticação diretamente suportado pelo API Gateway. Os mecanismos suportados são: IAM roles e policies (com SigV4), Lambda Authorizers e Cognito User Pools.

---

## Pergunta 50 · Domínio: Development with AWS Services

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

## Pergunta 51 · Domínio: Development with AWS Services

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

## Pergunta 52 · Domínio: Security

Você quer expor tanto HTTPS quanto HTTP no Elastic Beanstalk, onde HTTP deve redirecionar para HTTPS.

**O que deve ser feito?** (Selecione três)

- A. **Abrir as portas 80 e 443** ✅
- B. **Configurar as instâncias EC2 para redirecionar tráfego HTTP para HTTPS** ✅
- C. Abrir apenas a porta 443
- D. **Atribuir um certificado SSL ao Load Balancer** ✅
- E. Abrir apenas a porta 80
- F. Configurar as instâncias EC2 para redirecionar HTTPS para HTTP

**Resposta: A, B, D**

**Explicação:**
- D: o certificado SSL no Load Balancer habilita o HTTPS listener.
- A: ambas as portas 80 (HTTP) e 443 (HTTPS) devem estar abertas no load balancer.
- B: as instâncias EC2 recebem o tráfego HTTP e redirecionam para HTTPS, garantindo que todo tráfego seja criptografado.

- C e E estão erradas: abrir apenas uma porta não permite os dois protocolos.
- F está errada: redirecionar HTTPS para HTTP elimina a criptografia.

---

## Pergunta 53 · Domínio: Deployment

Você quer realizar tarefas repetitivas e agendadas de forma assíncrona em uma aplicação implantada no Elastic Beanstalk.

**Qual configuração do Elastic Beanstalk você deve usar?**

- A. Configurar um Web Server environment e um arquivo `cron.yaml`
- B. Configurar um Web Server environment e um arquivo `.ebextensions`
- C. **Configurar um Worker environment e um arquivo `cron.yaml`** ✅
- D. Configurar um Worker environment e um arquivo `.ebextensions`

**Resposta: C**

**Explicação:**
O Worker environment é projetado para tarefas assíncronas que consomem mensagens de uma SQS queue. Para tarefas agendadas (cron), você cria um arquivo `cron.yaml` no Worker environment que define os jobs periódicos.

- A e B estão erradas: Web Server environments não podem realizar tarefas repetitivas/agendadas de forma nativa.
- D está errada: `.ebextensions` configura o ambiente, mas não define cron jobs para workers.

---

## Pergunta 54 · Domínio: Development with AWS Services

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

## Pergunta 55 · Domínio: Troubleshooting and Optimization

Você quer dar a 200 usuários IAM um espaço pessoal no bucket S3 `my_company_space` com o prefixo `/home/<username>`, onde cada um tem acesso de leitura/escrita.

**Como você faz isso de forma eficiente?**

- A. Criar uma customer-managed policy por usuário e anexar a cada um
- B. Criar inline policies para cada usuário conforme são adicionados
- C. Criar uma S3 bucket policy e alterá-la conforme usuários são adicionados ou removidos
- D. **Criar uma customer-managed policy com policy variables e anexá-la a um grupo com todos os usuários** ✅

**Resposta: D**

**Explicação:**
Policy variables (como `${aws:username}`) permitem escrever uma única policy que funciona para muitos usuários sem criar uma cópia separada por usuário. A variável é substituída pelo valor real no momento da avaliação da policy.

- A e B estão erradas: criar policies individuais não escala para 200 usuários.
- C está errada: S3 bucket policy tem limite de tamanho (até 20 KB) e modificá-la a cada mudança de usuário não escala.

---

## Pergunta 56 · Domínio: Development with AWS Services

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

## Pergunta 57 · Domínio: Security

Quando sua empresa criou uma conta AWS, você começou com um root user com acesso completo a todos os serviços.

**O que você deve fazer para seguir as melhores práticas para o uso do root user?**

- A. **Deve ser acessível por apenas um admin após habilitar Multi-factor authentication** ✅
- B. Deve ser acessível por 3 a 6 membros da equipe de TI
- C. Deve ser acessível usando access key ID e secret access key
- D. Não deve ser acessível por ninguém — descarte as senhas após criar a conta

**Resposta: A**

**Explicação:**
As melhores práticas da AWS recomendam: (1) usar MFA para a conta root; (2) apenas o proprietário da conta deve ter acesso às credenciais root; (3) não criar access keys para o root user.

- B está errada: apenas o proprietário deve ter acesso ao root — crie um grupo IAM com permissões admin para a equipe.
- C está errada: a AWS recomenda não criar access keys para o root user.
- D está errada: você ainda precisa da senha armazenada em algum lugar seguro.

---

## Pergunta 58 · Domínio: Deployment

Você quer um dashboard único para todas as necessidades de CI/CD de um projeto, com visão holística sem controle granular de cada componente.

**Qual serviço você recomenda?**

- A. CodeBuild
- B. **CodeStar** ✅
- C. CodePipeline
- D. CodeDeploy

**Resposta: B**

**Explicação:**
AWS CodeStar oferece uma interface unificada para gerenciar atividades de desenvolvimento de software em um único lugar — configuração completa de CI/CD em minutos, dashboard de projeto com rastreamento de progresso e integração com Jira para gestão de issues.

- A, C e D estão erradas: CodeBuild, CodePipeline e CodeDeploy são serviços individuais dentro do ecossistema CodeStar — não oferecem visão holística de projeto.

---

## Pergunta 59 · Domínio: Troubleshooting and Optimization

Você coletou X-Ray traces de múltiplas aplicações e quer indexar os traces para buscar e filtrar por eles eficientemente.

**O que você deve usar na sua instrumentação?**

- A. Sampling
- B. Segments
- C. Metadata
- D. **Annotations** ✅

**Resposta: D**

**Explicação:**
Annotations são pares key-value simples que são indexados para uso com filter expressions. Use annotations para agrupar traces no console X-Ray ou ao chamar a API `GetTraceSummaries`. O X-Ray indexa até 50 annotations por trace.

- C está errada: Metadata são pares key-value com valores de qualquer tipo (incluindo objetos e listas) — mas **não são indexados** e não podem ser usados em filter expressions.
- B está errada: Segments são as unidades de trabalho reportadas pelos recursos computacionais.
- A está errada: Sampling é um algoritmo para determinar quais requisições são rastreadas.

---

## Pergunta 60 · Domínio: Troubleshooting and Optimization

Uma aplicação roda em múltiplas instâncias EC2 atrás de um ALB. O health check está configurado. Ao acessar o site pela internet, visitantes recebem timeout errors.

**O que deve ser verificado primeiro?**

- A. IAM Roles
- B. **Security Groups** ✅
- C. O ALB está fazendo warm up
- D. A aplicação está fora do ar

**Resposta: B**

**Explicação:**
Timeout errors geralmente indicam que o tráfego está sendo bloqueado antes de chegar à aplicação. A primeira coisa a verificar são as regras do security group das instâncias EC2 — você precisa de uma regra de entrada que permita tráfego do load balancer na porta correta.

- A está errada: IAM roles causam erros de autorização de API, não timeouts de rede.
- D está errada: se a aplicação estivesse fora do ar, o health check falharia e o ALB não encaminharia tráfego — mas o erro seria diferente.
- C está errada: slow start mode do ALB não causa timeouts — apenas latência inicialmente mais alta.

---

## Pergunta 61 · Domínio: Security

Uma empresa de segurança exige que todos os developers realizem server-side encryption com encryption keys fornecidas pelo cliente ao fazer operações no S3.

**Qual método de criptografia atende ao requisito?**

- A. SSE-KMS
- B. Client-Side Encryption
- C. SSE-S3
- D. **SSE-C** ✅

**Resposta: D**

**Explicação:**
SSE-C (Server-Side Encryption with Customer-Provided Keys) permite que você forneça suas próprias encryption keys. O S3 gerencia a criptografia ao escrever e a descriptografia ao acessar, mas você mantém o controle sobre as chaves.

- A está errada: SSE-KMS usa chaves gerenciadas pelo AWS KMS — não pelo cliente diretamente.
- C está errada: SSE-S3 usa chaves gerenciadas pelo S3 — o cliente não tem controle sobre as chaves.
- B está errada: Client-Side Encryption é realizada **antes** de enviar ao S3 — não é server-side.

---

## Pergunta 62 · Domínio: Deployment

Você quer testar novas versões da API do Lambda em um volume baixo de tráfego.

**Qual funcionalidade do API Gateway vai ajudar?**

- A. Mapping Templates
- B. **Canary Deployment** ✅
- C. Stage Variables
- D. Custom Authorizers

**Resposta: B**

**Explicação:**
Canary Deployment no API Gateway separa o tráfego da API em produção e canary com uma proporção pré-configurada. Uma pequena porcentagem do tráfego vai para a nova versão (canary), enquanto o restante vai para a versão de produção. Permite testar novas versões com baixo risco.

- C está errada: Stage Variables são variáveis de configuração por estágio — não controlam distribuição de tráfego.
- A está errada: Mapping Templates transformam o payload de requisição/resposta.
- D está errada: Custom Authorizers (Lambda Authorizers) controlam autenticação/autorização.

---

## Pergunta 63 · Domínio: Troubleshooting and Optimization

Uma aplicação usa RDS MySQL e a carga crescente pode exceder o storage disponível.

**Qual solução requer o mínimo de esforço de desenvolvimento?**

- A. Migrar para DynamoDB que aloca storage automaticamente
- B. Migrar para Aurora que oferece storage auto-scaling
- C. Criar read replica para RDS MySQL
- D. **Habilitar storage auto-scaling para RDS MySQL** ✅

**Resposta: D**

**Explicação:**
O storage auto-scaling do RDS MySQL aumenta automaticamente o storage quando detecta que está com pouco espaço livre (< 10% do storage alocado, por pelo menos 5 minutos, com pelo menos 6 horas desde a última modificação). É a solução mais simples — apenas uma configuração.

- B está errada: migrar para Aurora exige esforço significativo de operações de banco de dados.
- A está errada: migrar para DynamoDB (NoSQL) exige mudanças substanciais no código da aplicação.
- C está errada: read replicas aumentam capacidade de leitura, não de storage.

---

## Pergunta 64 · Domínio: Development with AWS Services

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

## Pergunta 65 · Domínio: Development with AWS Services

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