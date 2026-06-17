# Prova Marek 06 — AWS Certified Developer Associate

> **65 questões** | Domínios: Development with AWS Services · Security · Deployment · Troubleshooting and Optimization

---

## Pergunta 1 · Domínio: Troubleshooting and Optimization

Uma empresa de e-commerce usa filas SQS para desacoplar sua arquitetura. A equipe observou falhas no processamento de mensagens em um cenário de borda: quando um usuário faz um pedido para um produto que já foi deletado, o código falha.

**Como você recomendaria tratar essas falhas de mensagens?**

- A. Usar short polling para lidar com falhas de processamento
- B. **Usar uma Dead Letter Queue (DLQ) para lidar com falhas de processamento** ✅
- C. Usar long polling para lidar com falhas de processamento
- D. Usar uma temporary queue para lidar com falhas de processamento

**Resposta: B**

**Explicação:**
DLQs são usadas por filas-fonte como destino para mensagens que não podem ser consumidas com sucesso. Permitem isolar mensagens problemáticas para determinar por que o processamento falhou.

- D está errada: temporary queues são para o padrão request-response — não para tratamento de falhas.
- A e C estão erradas: short polling e long polling controlam como as mensagens são recebidas — não lidam com falhas de processamento.

---

## Pergunta 2 · Domínio: Development with AWS Services

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

## Pergunta 3 · Domínio: Development with AWS Services

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

## Pergunta 4 · Domínio: Deployment

Como engenheiro de confiabilidade, você quer implantar novas versões da aplicação em diferentes conjuntos de instâncias EC2 em momentos diferentes, permitindo uma transição suave com CodeDeploy.

**Qual opção do CodeDeploy permite isso?**

- A. Definir múltiplas CodeDeploy Applications
- B. **CodeDeploy Deployment Groups** ✅
- C. CodeDeploy Hooks
- D. CodeDeploy Agent

**Resposta: B**

**Explicação:**
Um Deployment Group é um conjunto de instâncias individuais alvo para deployment. Permite separar quais instâncias recebem atualizações e quando — por exemplo, um grupo para produção e outro para staging.

- D está errada: o CodeDeploy Agent é instalado nas instâncias para habilitá-las a receber deployments.
- C está errada: Hooks são scripts executados em lifecycle events (ApplicationStart, ApplicationStop, etc.).
- A está errada: múltiplas Applications são para projetos diferentes — não para deployments em fases.

---

## Pergunta 5 · Domínio: Development with AWS Services

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

## Pergunta 6 · Domínio: Troubleshooting and Optimization

Uma empresa quer implementar autenticação para uma nova API RESTful no API Gateway. Cada requisição deve incluir headers HTTP com client ID e user ID, que devem ser comparados com dados de autenticação em uma tabela DynamoDB.

**O que você recomendaria para implementar essa autenticação?**

- A. Configurar um API Gateway Model que exija as credenciais e conceder acesso ao DynamoDB
- B. **Desenvolver um Lambda Authorizer que referencia a tabela DynamoDB** ✅
- C. Atualizar as integration requests do API Gateway para exigir credenciais e conceder acesso ao DynamoDB
- D. Usar Amazon Cognito para referenciar a tabela de autenticação no DynamoDB

**Resposta: B**

**Explicação:**
Um Lambda Authorizer é uma funcionalidade do API Gateway que usa uma função Lambda para controlar o acesso à API. É ideal para implementar esquemas de autorização customizados usando parâmetros de requisição para determinar a identidade do chamador. Existem dois tipos: TOKEN (bearer token como JWT/OAuth) e REQUEST (combinação de headers, query strings, etc.).

- A está errada: API Gateway Models definem estruturas de payload — não autenticação.
- C está errada: integration requests mapeiam parâmetros entre cliente e backend — não controlam autenticação.
- D está errada: Cognito User Pools são para autenticação via IdPs sociais ou corporativos — exigiria migração dos dados de autenticação.

---

## Pergunta 7 · Domínio: Development with AWS Services

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

## Pergunta 8 · Domínio: Troubleshooting and Optimization

Com o modelo de consistência forte do S3, a equipe quer entender o impacto da mudança.

**Quais são as características corretas do modelo de consistência forte do S3?** (Selecione duas)

- A. **Se você deletar um bucket e imediatamente listar todos os buckets, o bucket deletado ainda pode aparecer na lista** ✅
- B. Um processo deleta um objeto e imediatamente tenta lê-lo — o S3 pode retornar os dados pois a deleção ainda não propagou
- C. Um processo substitui um objeto e imediatamente tenta lê-lo — o S3 pode retornar os dados antigos
- D. Um processo deleta um objeto e imediatamente lista as chaves do bucket — o objeto ainda pode ser visível por alguns minutos
- E. **Um processo deleta um objeto e imediatamente tenta lê-lo — o S3 não retorna dados pois o objeto foi deletado** ✅

**Resposta: A, E**

**Explicação:**
- A: configurações de bucket (como listagem de buckets) têm modelo eventual — um bucket deletado pode aparecer brevemente na lista.
- E: o S3 fornece consistência forte de read-after-write para PUTs e DELETEs — após deletar um objeto, leituras imediatas retornam "objeto não encontrado".

- B e D estão erradas: descrevem comportamento eventual — o S3 agora é fortemente consistente para objetos.
- C está errada: após substituir um objeto, o S3 retorna o novo dado imediatamente.

---

## Pergunta 9 · Domínio: Troubleshooting and Optimization

Um Auto Scaling group tem desired capacity = 3 e maximum capacity = 3. As instâncias estão configuradas para escalar quando CPU > 60%. A utilização atual é de 80%.

**O que acontecerá?**

- A. O sistema disparará CloudWatch alarms para o suporte AWS
- B. O desired capacity subirá para 4 e o maximum capacity ficará em 3
- C. **O sistema continuará rodando normalmente** ✅
- D. O desired capacity e o maximum capacity subirão para 4

**Resposta: C**

**Explicação:**
Você já está rodando no maximum capacity. O Auto Scaling não pode escalar além do maximum capacity configurado. O desired capacity não pode ultrapassar o maximum capacity — a tentativa de scale-out será ignorada.

- B está errada: o desired capacity não pode exceder o maximum.
- D está errada: o maximum capacity não muda automaticamente.
- A está errada: o CloudWatch pode disparar alarmes, mas não notifica o suporte AWS automaticamente.

---

## Pergunta 10 · Domínio: Development with AWS Services

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

## Pergunta 11 · Domínio: Development with AWS Services

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

## Pergunta 12 · Domínio: Development with AWS Services

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

## Pergunta 13 · Domínio: Development with AWS Services

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

## Pergunta 14 · Domínio: Development with AWS Services

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

## Pergunta 15 · Domínio: Deployment

Uma empresa quer implantar uma nova versão de sua aplicação no Elastic Beanstalk com **mínimo downtime** e capacidade de **rollback rápido**.

**Qual opção você recomendaria?**

- A. **Fazer o deploy da nova versão em um ambiente separado via Blue/Green Deployment e trocar os records do Route 53** ✅
- B. Usar a política de deployment 'Rolling'
- C. Usar a política de deployment 'All at once'
- D. Usar a política 'Rolling with additional batch'

**Resposta: A**

**Explicação:**
Com Blue/Green Deployment no Elastic Beanstalk, você implanta a nova versão em um ambiente separado e troca os CNAMEs (via Route 53) para redirecionar o tráfego instantaneamente. Rollback é igualmente rápido — basta trocar os CNAMEs de volta.

- C está errada: "All at once" causa downtime durante o deploy.
- B e D estão erradas: ambas as políticas rolling permitem rollback apenas via redeploy manual — mais lento que a troca de CNAMEs.

---

## Pergunta 16 · Domínio: Troubleshooting and Optimization

Sua organização tem desenvolvedores que fazem merge de código regularmente em um repositório CodeCommit. Você quer configurar uma regra que reaja a mudanças no CodeCommit.

**Qual opção você escolheria?**

- A. Usar CloudTrail Event rules com Amazon SES
- B. Usar função Lambda com Amazon SNS
- C. **Usar Amazon EventBridge Rules** ✅
- D. Usar Lambda Event Rules

**Resposta: C**

**Explicação:**
O EventBridge integra nativamente com o CodeCommit e CodePipeline para detectar e reagir a mudanças de estado. Você cria rules que disparam ações (SNS, Lambda, etc.) quando o pipeline, stage ou action muda de estado.

- A está errada: não existe "CloudTrail Event Rule".
- B está errada: o CodePipeline não dispara funções Lambda diretamente — precisa do EventBridge.
- D está errada: não existe "Lambda Event Rule".

---

## Pergunta 17 · Domínio: Deployment

Sua equipe criou templates CloudFormation reutilizáveis com parâmetros de entrada. Você quer salvar esses templates na nuvem.

**Qual opção de storage você escolheria?**

- A. EFS
- B. ECR
- C. **S3** ✅
- D. EBS

**Resposta: C**

**Explicação:**
O CloudFormation faz upload de templates locais para um bucket S3 automaticamente. Se você não tiver um bucket, o CloudFormation cria um único bucket por região. Templates armazenados no S3 são referenciados pelo CloudFormation durante a criação/atualização de stacks.

- EBS: block storage para instâncias EC2 — não adequado para templates.
- EFS: file storage para EC2 Linux — não suportado pelo CloudFormation.
- ECR: registry para imagens de container — não aplicável.

---

## Pergunta 18 · Domínio: Deployment

Uma empresa usa CloudFormation para criar clusters ECS. Após criar task definitions e atribuir roles, os containers das tasks não estão usando as permissões IAM atribuídas.

**Qual configuração do ECS em `/etc/ecs/ecs.config` deve ser definida para permitir que tasks usem IAM roles?**

- A. `ECS_ENGINE_AUTH_DATA`
- B. **`ECS_ENABLE_TASK_IAM_ROLE`** ✅
- C. `ECS_CLUSTER`
- D. `ECS_AVAILABLE_LOGGING_DRIVERS`

**Resposta: B**

**Explicação:**
`ECS_ENABLE_TASK_IAM_ROLE` habilita IAM roles para tasks em containers com os modos de rede `bridge` e `default`. Sem essa configuração, as tasks não conseguem usar as IAM roles atribuídas.

- A está errada: `ECS_ENGINE_AUTH_DATA` é para dados de autenticação Docker.
- D está errada: `ECS_AVAILABLE_LOGGING_DRIVERS` registra os drivers de log disponíveis.
- C está errada: `ECS_CLUSTER` especifica o cluster ao qual o agente ECS deve se registrar.

---

## Pergunta 19 · Domínio: Development with AWS Services

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

## Pergunta 20 · Domínio: Security

A equipe de segurança exige mecanismos de criptografia mais rígidos para Kinesis Data Streams **sem exigir mudanças de código**.

**Quais funcionalidades atendem ao requisito?** (Selecione duas)

- A. SSE-C
- B. Client-Side Encryption
- C. Envelope Encryption
- D. **Criptografia KMS para dados em repouso** ✅
- E. **Criptografia em trânsito com HTTPS endpoint** ✅

**Resposta: D, E**

**Explicação:**
- **KMS encryption**: o Kinesis Data Streams criptografa automaticamente os dados em repouso usando o CMK do KMS — sem alterações no código.
- **HTTPS**: o protocolo HTTPS garante que os dados em trânsito sejam criptografados — sem alterações no código.

- A está errada: SSE-C é para S3, não Kinesis.
- B e C estão erradas: ambas exigem mudanças no código.

---

## Pergunta 21 · Domínio: Troubleshooting and Optimization

Sua aplicação web tem 5 instâncias EC2 atrás de um ALB. Você percebe que todos os IPs capturados pela aplicação são o IP do ALB.

**O que você deve fazer para identificar o IP real do cliente?**

- A. Verificar o header `X-Forwarded-Proto` no backend
- B. **Verificar o header `X-Forwarded-For` no backend** ✅
- C. Modificar o frontend para que os usuários enviem seu IP nas requisições
- D. Verificar o cookie do cliente

**Resposta: B**

**Explicação:**
O header `X-Forwarded-For` contém o IP do cliente original. O Elastic Load Balancing armazena o IP do cliente nesse header e o passa para o servidor. Você deve ler esse header na aplicação em vez do IP da conexão TCP.

- A está errada: `X-Forwarded-Proto` informa o protocolo (HTTP ou HTTPS) — não o IP.
- C e D estão erradas: exigem modificações desnecessárias no cliente.

---

## Pergunta 22 · Domínio: Troubleshooting and Optimization

Uma startup usa Elastic Beanstalk. Mesmo após o Load Balancer marcar uma instância EC2 como não saudável, o ASG não a substituiu.

**Qual configuração você sugere para automatizar a substituição?**

- A. Os parâmetros de health check foram configurados apenas para verificar a saúde da instância
- B. Os parâmetros de health check foram configurados somente para a instância; a falha foi de aplicação
- C. **O tipo de health check do ASG deve ser alterado de EC2 para ELB usando um arquivo de configuração** ✅
- D. O Auto Scaling group não substitui automaticamente instâncias marcadas pelo load balancer
- E. O campo ping path do Load Balancer está configurado incorretamente

**Resposta: C**

**Explicação:**
Por padrão, o health check do ASG é do tipo EC2 (verifica apenas o status da instância). Para que o ASG substitua instâncias marcadas como não saudáveis pelo Load Balancer, você deve alterar o tipo de health check de EC2 para ELB usando um arquivo de configuração no `.ebextensions`.

- D está errada: se o tipo de health check for ELB, o ASG substituirá automaticamente as instâncias não saudáveis.
- E está errada: um ping path incorreto tornaria **todas** as instâncias não saudáveis — não apenas uma.

---

## Pergunta 23 · Domínio: Development with AWS Services

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

## Pergunta 24 · Domínio: Development with AWS Services

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

## Pergunta 25 · Domínio: Deployment

Você quer fazer pull de imagens Docker do repositório ECR chamado `demo` para testes locais.

**Quais comandos você deve executar?** (Selecione dois)

- A. `docker build -t 1234567890.dkr.ecr.eu-west-1.amazonaws.com/demo:latest`
- B. `aws docker push 1234567890.dkr.ecr.eu-west-1.amazonaws.com/demo:latest`
- C. **`docker pull 1234567890.dkr.ecr.eu-west-1.amazonaws.com/demo:latest`** ✅
- D. **`$(aws ecr get-login --no-include-email)`** ✅
- E. `docker login -u $AWS_ACCESS_KEY_ID -p $AWS_SECRET_ACCESS_KEY`

**Resposta: C, D**

**Explicação:**
- `$(aws ecr get-login --no-include-email)`: obtém um token de autenticação válido por 12 horas e executa o comando `docker login` automaticamente.
- `docker pull ...`: faz pull da imagem do repositório ECR após a autenticação.

- E está errada: você não pode fazer login no ECR com `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY` diretamente via `docker login`.
- B está errada: `docker push` envia imagens — você quer `docker pull`.
- A está errada: `docker build` constrói imagens a partir de Dockerfiles.

---

## Pergunta 26 · Domínio: Security

Seu colega alertou que objetos privados estão sendo referenciados com URLs públicas. Após o administrador tornar o bucket privado, você quer criar uma aplicação que permita acesso com restrição de tempo.

**Qual opção dará acesso aos objetos?**

- A. Usando Routing Policy
- B. Usando bucket policy
- C. Usando IAM policy
- D. **Usando pre-signed URL** ✅

**Resposta: D**

**Explicação:**
Pre-signed URLs permitem que o proprietário do objeto compartilhe acesso temporário a objetos S3 privados. Ao criar uma URL, você especifica credenciais de segurança, bucket, chave do objeto, método HTTP (GET para download) e expiração. A URL é válida apenas pelo período especificado.

- B está errada: bucket policies podem restringir por IP de origem — mas não têm restrição de tempo integrada de forma simples.
- A está errada: Routing Policy é para DNS no Route 53.
- C está errada: IAM policies concedem acesso a usuários/roles — não a usuários públicos com restrição de tempo.

---

## Pergunta 27 · Domínio: Development with AWS Services

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

## Pergunta 28 · Domínio: Security

Uma empresa tem dados confidenciais em um bucket S3 criptografado com KMS. Um developer quer aplicar criptografia em trânsito para todos os usuários com permissão de `GetObject` em múltiplas contas.

**Qual é a melhor solução?**

- A. Configurar uma resource-based policy na KMS key para negar acesso quando `"aws:SecureTransport": "false"`
- B. **Configurar uma resource-based policy no bucket S3 para negar acesso quando `"aws:SecureTransport": "false"`** ✅
- C. Configurar uma resource-based policy na KMS key para permitir acesso quando `"aws:SecureTransport": "false"`
- D. Configurar uma resource-based policy no bucket S3 para permitir acesso quando `"aws:SecureTransport": "false"`

**Resposta: B**

**Explicação:**
A condition key `aws:SecureTransport` verifica se uma requisição foi enviada via HTTP (false) ou HTTPS (true). Para forçar HTTPS, crie uma bucket policy com `Effect: Deny` quando `aws:SecureTransport` for `false`. Isso se aplica a todos os usuários que acessam o bucket, independentemente da conta.

- A e C estão erradas: a operação `S3 GetObject` é controlada pela bucket policy, não pela KMS key policy.
- D está errada: negar quando `SecureTransport = false` significa bloquear HTTP — a lógica inversa (permitir quando false) deixaria HTTP acessível.

---

## Pergunta 29 · Domínio: Troubleshooting and Optimization

Um developer precisa criar uma IAM policy para permitir que instâncias de container ECS usem as APIs do CloudWatch Logs.

**Qual policy é a mais adequada?**

- A. Policy com `CreateLogGroup`, `CreateLogStream`, `PutLogEvents`
- B. **Policy com `CreateLogGroup`, `CreateLogStream`, `PutLogEvents`, `DescribeLogStreams`** ✅
- C. Policy com `CreateLogGroup`, `CreateLogStream`, `PutLogEvents`, `DescribeLogGroups`
- D. Policy com `CreateLogGroup`, `CreateLogStream`, `PutLogEvents`, `ecs:DescribeServices` restrito ao ARN do Log Group

**Resposta: B**

**Explicação:**
A policy correta deve incluir:
- `logs:CreateLogGroup` — criar log groups
- `logs:CreateLogStream` — criar log streams
- `logs:PutLogEvents` — enviar eventos de log
- `logs:DescribeLogStreams` — listar detalhes dos log streams

- A está errada: falta `DescribeLogStreams` — necessário para que o agente funcione corretamente.
- C está errada: `DescribeLogGroups` não é a permissão necessária — é `DescribeLogStreams`.
- D está errada: `ecs:DescribeServices` não é relevante para CloudWatch Logs; além disso, o resource deve usar wildcard `*`, não um ARN específico.

---

## Pergunta 30 · Domínio: Development with AWS Services

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

## Pergunta 31 · Domínio: Troubleshooting and Optimization

Um build no CodeBuild está falhando e o developer precisa debugar rapidamente os comandos no BuildSpec.

**Qual abordagem vai ajudar?**

- A. SSH no container Docker do CodeBuild
- B. Congelar o CodeBuild durante a próxima execução
- C. Habilitar monitoramento detalhado
- D. **Executar o CodeBuild localmente usando o CodeBuild Agent** ✅

**Resposta: D**

**Explicação:**
O suporte a Local Build do CodeBuild permite testar e debugar builds em sua máquina local. Com o CodeBuild Agent você pode: testar a integridade do buildspec localmente, construir a aplicação antes de fazer commit e identificar/corrigir erros rapidamente.

- A está errada: não é possível fazer SSH em containers do CodeBuild.
- B está errada: você pode parar o build — não "congelar".
- C está errada: monitoramento detalhado é para instâncias EC2 — não ajuda no debug do buildspec.

---

## Pergunta 32 · Domínio: Troubleshooting and Optimization

Um colega configurou notificações de evento S3 para um bucket de auditoria. Após validar, você percebe que alguns eventos estão faltando.

**Qual pode ser a razão?**

- A. A action de notificação está escrevendo no mesmo bucket que dispara a notificação
- B. O versioning está habilitado e notificações são disparadas apenas para uma versão
- C. Alguém criou uma nova configuração de notificação que sobrescreveu a sua
- D. **Se duas escritas são feitas em um único objeto não-versionado ao mesmo tempo, é possível que apenas uma notificação de evento seja enviada** ✅

**Resposta: D**

**Explicação:**
As notificações de evento S3 são entregues pelo menos uma vez, mas se duas escritas ocorrerem simultaneamente em um objeto não-versionado, apenas uma notificação pode ser enviada. Para garantir uma notificação por escrita, habilite o versioning — cada escrita bem-sucedida cria uma nova versão e dispara sua própria notificação.

- C está errada: se a configuração tivesse sido sobrescrita, nenhuma notificação seria recebida — mas a equipe está recebendo a maioria.
- B está errada: com versioning habilitado, cada versão dispara sua notificação — o versioning melhora a situação.
- A está errada: escrever no mesmo bucket causa loop de execução, não ausência de eventos.

---

## Pergunta 33 · Domínio: Deployment

A equipe quer referenciar o VPC criado no stack `NetworkStack` no stack de aplicação web.

**Qual solução você recomendaria?**

- A. Usar cross-stack reference com campo `Outputs` para o VPC; usar `Ref` no stack de aplicação
- B. Usar cross-stack reference com campo `Outputs` para o VPC; usar `Fn::ImportValue` no stack de aplicação
- C. **Usar cross-stack reference com campo `Export` no output do `NetworkStack`; usar `Fn::ImportValue` no stack de aplicação** ✅
- D. Usar cross-stack reference com campo `Export` no output; usar `Ref` no stack de aplicação

**Resposta: C**

**Explicação:**
Para cross-stack references no CloudFormation:
1. No stack exportador: use o campo `Export` dentro de `Outputs` para expor o valor.
2. No stack importador: use `Fn::ImportValue` (ou `!ImportValue`) para importar o valor exportado.

- B e A estão erradas: o campo correto para exportar é `Export`, não `Outputs` (que é o bloco pai).
- D está errada: `Ref` não pode importar valores de outros stacks.

---

## Pergunta 34 · Domínio: Development with AWS Services

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

## Pergunta 35 · Domínio: Troubleshooting and Optimization

Um gerente tentou encontrar o usuário que criou um volume EBS pesquisando nos logs do CloudTrail, mas não encontrou o evento.

**Qual é a explicação correta?**

- A. As verificações de status do volume EBS estão desabilitadas
- B. **Os logs de eventos do CloudTrail para 'CreateVolume' não estão disponíveis para volumes EBS criados durante um launch de EC2** ✅
- C. As métricas do CloudWatch para EBS estão desabilitadas
- D. Os logs do CloudTrail para 'ManageVolume' não estão disponíveis para volumes EBS criados durante um launch de EC2

**Resposta: B**

**Explicação:**
O CloudTrail não registra o evento `CreateVolume` para volumes EBS criados automaticamente como parte de um lançamento de instância EC2. Para rastrear quem criou um volume nesses casos, você deve verificar os eventos de `RunInstances` no CloudTrail.

- D está errada: `ManageVolume` é uma opção inventada.
- A e C estão erradas: status checks e métricas do CloudWatch monitoram o estado do volume — não registram metadados de criação.

---

## Pergunta 36 · Domínio: Security

Uma empresa usa muitos volumes EBS e não quer gerenciar sua própria infraestrutura de chaves de criptografia.

**Quais afirmações sobre criptografia EBS são corretas?** (Selecione duas)

- A. **Encryption by default é uma configuração por região — ao habilitá-la, não é possível desabilitá-la para volumes ou snapshots individuais nessa região** ✅
- B. Encryption by default é uma configuração por AZ
- C. Você pode criptografar um volume não-criptografado existente diretamente usando o KMS SDK
- D. **Um volume restaurado de um snapshot criptografado ou uma cópia de um snapshot criptografado é sempre criptografado** ✅
- E. Um snapshot de um volume criptografado pode ser criptografado ou não-criptografado

**Resposta: A, D**

**Explicação:**
- A: "Encryption by default" é uma configuração no nível de **região** — ao ativar, todos os novos volumes e snapshots nessa região são criptografados e não é possível desabilitar para volumes individuais.
- D: você não pode remover criptografia de um volume ou snapshot criptografado — restaurar de um snapshot criptografado sempre resulta em um volume criptografado.

- C está errada: não existe forma direta de criptografar um volume não-criptografado existente. Você deve criar um snapshot e copiá-lo com criptografia habilitada.
- E está errada: um snapshot de volume criptografado é **sempre** criptografado.
- B está errada: é configuração por região, não por AZ.

---

## Pergunta 37 · Domínio: Security

Uma aplicação de fotos usa EC2 atrás de um ALB com CloudFront na frente. A equipe quer desacoplar o processo de autenticação com mínimo esforço de desenvolvimento.

**Qual solução você recomendaria?**

- A. Usar Cognito Authentication via Cognito Identity Pools para o ALB
- B. Usar Cognito Authentication via Cognito User Pools para a distribuição CloudFront
- C. Usar Cognito Authentication via Cognito Identity Pools para a distribuição CloudFront
- D. **Usar Cognito Authentication via Cognito User Pools para o Application Load Balancer** ✅

**Resposta: D**

**Explicação:**
O ALB suporta nativamente autenticação via Cognito User Pools — você cria uma authenticate action em um listener HTTPS e o ALB gerencia o fluxo de autenticação, liberando as instâncias EC2 para focar na lógica de negócios.

- A está errada: Cognito Identity Pools fornecem credenciais AWS temporárias — não autenticação de usuário.
- B está errada: integrar Cognito User Pools com CloudFront requer Lambda@Edge — mais esforço de desenvolvimento.
- C está errada: Identity Pools não gerenciam autenticação de usuários.

---

## Pergunta 38 · Domínio: Deployment

Você está construindo um pipeline CI/CD com CodePipeline e CodeBuild para fazer push de imagens Docker para o ECR. O último passo falha com um erro de autorização.

**Qual é a causa mais provável?**

- A. O CodeBuild não consegue se comunicar com o ECR por problemas de security group
- B. O repositório ECR está desatualizado e precisa ser deletado e recriado
- C. As instâncias ECS estão mal configuradas e precisam de dados adicionais em `/etc/ecs/ecs.config`
- D. **As permissões IAM estão incorretas para o serviço CodeBuild** ✅

**Resposta: D**

**Explicação:**
Para fazer push de imagens para o ECR, os usuários/roles precisam de permissão `ecr:GetAuthorizationToken` e das permissões de push do ECR. O CodeBuild precisa dessas permissões em sua service role para autenticar e fazer push das imagens.

- A está errada: security groups controlam tráfego de rede — não autenticação de push de imagens.
- B está errada: repositórios ECR não ficam "desatualizados".
- C está errada: a configuração do ECS não afeta a capacidade do CodeBuild de autenticar no ECR.

---

## Pergunta 39 · Domínio: Troubleshooting and Optimization

Uma organização com alta carga de trabalho migrou para DynamoDB, mas alguns meses depois as tabelas começam a registrar alta latência.

**Quais ações você sugeriria para reduzir a latência?** (Selecione duas)

- A. Usar DAX para workloads com muita escrita
- B. Reduzir connection pooling
- C. **Considerar usar Global Tables se a aplicação é acessada por usuários globalmente distribuídos** ✅
- D. Aumentar o request timeout para que o cliente tenha tempo suficiente
- E. **Usar leituras eventualmente consistentes em vez de fortemente consistentes sempre que possível** ✅

**Resposta: C, E**

**Explicação:**
- C: Global Tables replica dados nas regiões escolhidas — reduzindo a distância entre o cliente e o endpoint DynamoDB.
- E: leituras eventualmente consistentes consomem metade das RCUs das fortemente consistentes e têm menor probabilidade de alta latência.

- D está errada: você deve **reduzir** o request timeout (não aumentar) para que o cliente descarte requisições lentas e tente novamente — a segunda tentativa geralmente é mais rápida.
- A está errada: DAX é um cache in-memory para workloads de **leitura** — não de escrita.
- B está errada: connection pooling **mantém** conexões ativas, o que melhora a performance — você não deve reduzi-lo.

---

## Pergunta 40 · Domínio: Troubleshooting and Optimization

Uma aplicação de streaming de vídeo usa CloudFront com origin failover para alta disponibilidade.

**Quais afirmações são corretas sobre o Origin Groups do CloudFront?** (Selecione duas)

- A. Quando há cache hit, o CloudFront roteia a requisição para a origin primária
- B. **O CloudFront roteia todas as requisições para a origin primária, mesmo quando uma requisição anterior fez failover para a secundária** ✅
- C. Todas as origins do Origin Group são definidas como primárias para failover automático
- D. Para configurar origin failover, você precisa de uma distribuição com pelo menos 3 origins
- E. **O CloudFront faz failover para a origin secundária apenas quando o método HTTP é GET, HEAD ou OPTIONS** ✅

**Resposta: B, E**

**Explicação:**
- B: o CloudFront sempre tenta a origin primária primeiro — independentemente de requisições anteriores terem feito failover.
- E: o failover para a origin secundária ocorre apenas para métodos de leitura (GET, HEAD, OPTIONS). Para outros métodos (POST, PUT, etc.), o CloudFront não faz failover.

- A está errada: quando há cache hit, o CloudFront retorna o objeto cacheado — não roteia para nenhuma origin.
- D está errada: você precisa de pelo menos **2** origins para configurar failover.
- C está errada: apenas **uma** origin pode ser definida como primária em um Origin Group.

---

## Pergunta 41 · Domínio: Development with AWS Services

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

## Pergunta 42 · Domínio: Troubleshooting and Optimization

Uma equipe herdou uma aplicação web com ALB em 3 AZs. O load balancer continua roteando tráfego para uma instância EC2 que crashou.

**O que a equipe deve fazer para minimizar o problema?**

- A. Habilitar Multi-AZ deployments
- B. Habilitar SSL
- C. **Habilitar Health Checks** ✅
- D. Habilitar Stickiness

**Resposta: C**

**Explicação:**
Health checks permitem ao load balancer detectar instâncias não saudáveis. Instâncias que falham no health check são marcadas como `OutOfService` e o load balancer para de rotear tráfego para elas.

- A está errada: Multi-AZ melhora resiliência, mas sem health checks o load balancer ainda enviaria tráfego para instâncias com falha.
- D está errada: stickiness vincula sessões a instâncias específicas — não detecta falhas.
- B está errada: SSL criptografa dados em trânsito — não tem relação com disponibilidade de instâncias.

---

## Pergunta 43 · Domínio: Deployment

A equipe quer rodar um serviço serverless de data store com dois containers Docker que compartilham recursos.

**Qual configuração ECS você usaria?**

- A. Colocar os dois containers em uma única task definition com EC2 Launch Type
- B. **Colocar os dois containers em uma única task definition com Fargate Launch Type** ✅
- C. Colocar os dois containers em duas task definitions separadas com Fargate Launch Type
- D. Colocar os dois containers em duas task definitions separadas com EC2 Launch Type

**Resposta: B**

**Explicação:**
Para um serviço serverless, use o Fargate Launch Type. Colocando os dois containers na **mesma task definition**, eles compartilham recursos (CPU, memória, rede e volumes). Containers em task definitions separadas não compartilham recursos diretamente.

- C está errada: task definitions separadas não permitem compartilhamento de recursos entre containers.
- A e D estão erradas: EC2 Launch Type não é serverless — exige gerenciamento das instâncias EC2 do cluster.

---

## Pergunta 44 · Domínio: Troubleshooting and Optimization

Uma empresa usa infraestrutura de microserviços com API Gateway. Usuários relatam receber código de erro 501.

**Qual serviço você escolheria para fazer o troubleshooting?**

- A. Usar o API Gateway
- B. Usar o CloudTrail
- C. Usar o CloudWatch
- D. **Usar o X-Ray** ✅

**Resposta: D**

**Explicação:**
O X-Ray ajuda a analisar e debugar aplicações distribuídas como microserviços. Fornece uma visão end-to-end das requisições enquanto percorrem a aplicação, mostra um mapa dos componentes subjacentes, latências médias e taxas de falha — ideal para identificar qual microserviço está causando o erro 501.

- B está errada: o CloudTrail registra chamadas de API — não fornece análise de fluxo entre microserviços.
- A está errada: o console do API Gateway não permite drill-down no fluxo entre serviços.
- C está errada: o CloudWatch monitora métricas e responde a eventos — não fornece rastreamento de requisições entre serviços.

---

## Pergunta 45 · Domínio: Troubleshooting and Optimization

Um CodePipeline foi disparado por EventBridge. O pipeline falhou e o Team Lead notou que a source foi alterada de CodeCommit para S3. O Team Lead quer saber quem fez a mudança.

**Qual serviço vai ajudar?**

- A. Amazon CloudWatch
- B. Amazon Inspector
- C. AWS X-Ray
- D. **AWS CloudTrail** ✅

**Resposta: D**

**Explicação:**
O CloudTrail registra toda atividade de API na conta AWS — incluindo quem fez a mudança, de qual IP e quando. Para rastrear alterações de configuração no CodePipeline, procure pelos eventos de API relevantes (ex.: `UpdatePipeline`) no CloudTrail.

- A está errada: o CloudWatch monitora métricas e eventos — não rastreia atividade de usuário.
- C está errada: o X-Ray rastreia fluxo de requisições em aplicações distribuídas — não atividade de usuário no console.
- B está errada: o Inspector é um serviço de avaliação de segurança para EC2 — não rastreia atividade de conta.

---

## Pergunta 46 · Domínio: Development with AWS Services

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

## Pergunta 47 · Domínio: Troubleshooting and Optimization

Um developer desligou uma instância EC2 que não era necessária, mas outra instância do mesmo tipo foi automaticamente lançada na conta.

**Qual opção explica essa sequência de ações?**

- A. **A instância pode ser parte de um Auto Scaling group e por isso uma instância similar foi relançada** ✅
- B. O usuário não tinha permissões para desligar a instância — precisa de permissões root
- C. A instância poderia ser parte de um ALB e por isso foi automaticamente iniciada
- D. A instância poderia ser parte de um NLB e por isso foi automaticamente iniciada

**Resposta: A**

**Explicação:**
Auto Scaling groups mantêm o número desejado de instâncias. Se uma instância for terminada, o ASG automaticamente lança uma nova para manter o desired count. Para terminar uma instância de um ASG sem substituição, você deve reduzir o desired count do grupo primeiro.

- B está errada: se o usuário não tivesse permissão, a ação estaria indisponível.
- C e D estão erradas: ALB e NLB não têm a capacidade de lançar instâncias por conta própria — isso é responsabilidade do Auto Scaling group.

---

## Pergunta 48 · Domínio: Deployment

Você substituiu o CI/CD Jenkins pelo CodeBuild e quer definir os passos do build programaticamente.

**Qual opção você deve escolher?**

- A. Definir um arquivo `buildspec.yml` no diretório `codebuild/`
- B. **Definir um arquivo `buildspec.yml` no diretório raiz** ✅
- C. Definir um arquivo `appspec.yml` no diretório `codebuild/`
- D. Definir um arquivo `appspec.yml` no diretório raiz

**Resposta: B**

**Explicação:**
Um buildspec é uma coleção de comandos de build em formato YAML que o CodeBuild usa para executar um build. Por padrão, o CodeBuild procura o arquivo `buildspec.yml` no **diretório raiz** do código-fonte.

- D e C estão erradas: `appspec.yml` é usado pelo CodeDeploy — não pelo CodeBuild.
- A está errada: o buildspec deve estar no diretório raiz, não em `codebuild/`.

---

## Pergunta 49 · Domínio: Troubleshooting and Optimization

Uma aplicação de mídia usa CloudFront com S3 como origin. Algumas regiões experimentam latência em cache misses. Você quer redirecionar requisições em cache miss para o bucket S3 mais próximo do usuário com base no header `CloudFront-Viewer-Country`.

**Qual solução você recomendaria?**

- A. Criar uma Lambda@Edge associada ao evento de viewer request
- B. Criar uma CloudFront Function associada ao evento de viewer request
- C. Criar uma CloudFront Function associada ao evento de origin request
- D. **Criar uma Lambda@Edge associada ao evento de origin request** ✅

**Resposta: D**

**Explicação:**
- **Origin request event**: disparado apenas quando há cache miss (CloudFront encaminha a requisição para a origin) — exatamente quando queremos redirecionar para o S3 mais próximo.
- **Lambda@Edge**: suporta origin request events; pode modificar a URL de destino da origin com base no `CloudFront-Viewer-Country` header.

- A está errada: o viewer request event é disparado em **todas** as requisições (incluindo cache hits) — ineficiente para o caso de uso.
- B e C estão erradas: CloudFront Functions suportam apenas viewer request e viewer response — não origin request ou origin response.

---

## Pergunta 50 · Domínio: Troubleshooting and Optimization

Uma equipe percebeu que uma instância EC2 tem o atributo `DeleteOnTermination` definido como `True` para seu volume EBS raiz, enquanto a instância ainda está rodando.

**Como desabilitar esse flag com a instância rodando?**

- A. Definir o atributo `DisableApiTermination` via API
- B. Atualizar o atributo via console AWS desmarcando o checkbox "Delete On Termination" para o volume EBS raiz
- C. **Definir o atributo `DeleteOnTermination` como False usando a linha de comando** ✅
- D. O atributo não pode ser atualizado com a instância rodando

**Resposta: C**

**Explicação:**
Você pode alterar o atributo `DeleteOnTermination` de uma instância em execução usando o comando AWS CLI `aws ec2 modify-instance-attribute --instance-id <id> --block-device-mappings "[...]"`.

- B está errada: você pode definir `DeleteOnTermination` ao lançar uma nova instância, mas não é possível alterar esse atributo de uma instância rodando via console.
- A está errada: `DisableApiTermination` controla se a instância pode ser terminada via console/CLI/API — não afeta o comportamento do EBS ao terminar.
- D está errada: é possível atualizar via linha de comando.

---

## Pergunta 51 · Domínio: Deployment

Um developer está criando uma API RESTful com API Gateway + Lambda e quer suportar diferentes versões da API para testes.

**Qual é a melhor forma de fazer isso?**

- A. Configurar uma resource policy no API Gateway para identificar versões e fornecer contexto à Lambda
- B. **Implantar as versões da API como stages únicos com endpoints únicos e usar stage variables para fornecer contexto sobre a versão** ✅
- C. Usar um Lambda Authorizer para rotear clientes para a versão correta da API
- D. Usar um header `X-Version` para identificar a versão e passá-lo à Lambda

**Resposta: B**

**Explicação:**
Com stages do API Gateway, você pode gerenciar múltiplas versões de release (alpha, beta, prod). Stage variables atuam como variáveis de ambiente — você pode configurar uma stage variable com o nome da função Lambda por versão, e o API Gateway invoca a função correta por stage.

- A está errada: resource policies controlam acesso à API por principal — não versões.
- C está errada: Lambda Authorizers são para autenticação/autorização — não roteamento de versões.
- D está errada: headers customizados como `X-Version` não são suportados nativamente pelo API Gateway para seleção de versão.

---

## Pergunta 52 · Domínio: Troubleshooting and Optimization

Uma equipe configurou um Kinesis Data Stream com 1 shard. Quando os limites de capacidade são excedidos pelo produtor, o que acontece?

**O que acontece quando os limites de capacidade são excedidos?**

- A. Dados são perdidos a menos que a partition key seja alterada para escrever em um shard diferente
- B. As chamadas de put serão rejeitadas com `AccessDeniedException`
- C. Contate o suporte AWS para aumentar o número de shards
- D. **As chamadas de put serão rejeitadas com `ProvisionedThroughputExceeded`** ✅

**Resposta: D**

**Explicação:**
Quando os limites de capacidade de um Kinesis Data Stream são excedidos (throughput de dados ou número de registros PUT), as chamadas falham com `ProvisionedThroughputExceededException`. Para picos temporários, implemente retry com backoff. Para aumentos sustentados, aumente o número de shards.

- B está errada: `AccessDeniedException` indica falta de permissão — os dados já estavam sendo ingeridos com sucesso.
- A está errada: a partition key distribui dados entre shards existentes — não cria shards adicionais.
- C está errada: você pode aumentar shards via console/API — não precisa de intervenção do suporte.

---

## Pergunta 53 · Domínio: Development with AWS Services

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

## Pergunta 54 · Domínio: Development with AWS Services

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

## Pergunta 55 · Domínio: Development with AWS Services

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

## Pergunta 56 · Domínio: Security

Uma frota de servidores web EC2 tem alta utilização de CPU devido ao tráfego HTTPS. A equipe quer transferir a carga de SSL dos servidores.

**Quais passos podem reduzir a carga de CPU?** (Selecione duas)

- A. **Configurar um certificado SSL/TLS no ALB via AWS Certificate Manager (ACM)** ✅
- B. Criar um HTTP listener no ALB com SSL termination
- C. **Criar um HTTPS listener no ALB com SSL termination** ✅
- D. Criar um HTTP listener no ALB com SSL pass-through
- E. Criar um HTTPS listener no ALB com SSL pass-through

**Resposta: A, C**

**Explicação:**
- A: o ACM gerencia o certificado SSL no ALB.
- C: com SSL termination no ALB (HTTPS listener), o load balancer descriptografa as conexões SSL dos clientes e envia requisições HTTP não-criptografadas para as instâncias EC2 — eliminando a carga de SSL das instâncias.

- E está errada: com SSL pass-through, as instâncias EC2 ainda precisam descriptografar o tráfego — mantendo a carga de CPU.
- B e D estão erradas: HTTP listeners não suportam SSL termination ou SSL pass-through.

---

## Pergunta 57 · Domínio: Development with AWS Services

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

## Pergunta 58 · Domínio: Troubleshooting and Optimization

Um developer acabou de configurar um ALB para instâncias EC2 mas não atribuiu nenhum target group ao ALB.

**Qual código de erro ele deve esperar nos logs?**

- A. **HTTP 503** ✅
- B. HTTP 403
- C. HTTP 500
- D. HTTP 504

**Resposta: A**

**Explicação:**
O ALB retorna HTTP 503 "Service Unavailable" quando o target group não tem nenhum target registrado.

- HTTP 500: erro interno do servidor (ex.: múltiplos certificados SSL para o mesmo domínio no mesmo listener HTTPS).
- HTTP 504: gateway timeout (o target não respondeu no tempo limite).
- HTTP 403: forbidden — disparado pelo AWS WAF quando uma requisição é bloqueada.

---

## Pergunta 59 · Domínio: Security

Uma empresa armazena dados confidenciais no S3. Novas diretrizes exigem SSE com AES-256 e a empresa **não quer gerenciar as chaves de criptografia do S3**.

**Qual opção você usaria?**

- A. SSE-KMS
- B. SSE-C
- C. **SSE-S3** ✅
- D. Client-Side Encryption

**Resposta: C**

**Explicação:**
SSE-S3 usa AES-256 e o próprio S3 gerencia todas as chaves de criptografia — a empresa não precisa gerenciar nenhuma chave.

- A está errada: SSE-KMS usa chaves gerenciadas pelo KMS — a empresa gerencia (ou pelo menos audita) as chaves.
- B está errada: SSE-C exige que o cliente forneça as chaves de criptografia em cada requisição.
- D está errada: Client-Side Encryption exige que o cliente gerencie todo o processo de criptografia antes do upload.

---

## Pergunta 60 · Domínio: Troubleshooting and Optimization

Um developer está configurando redirect actions para um ALB e quer usar uma condição de query string no AWS CLI.

**Qual snippet representa um exemplo de condição de query string?**

- A. JSON de redirect action com `RedirectConfig`
- B. JSON com `PathPatternConfig`
- C. JSON com `StringHeaderConfig`
- D. **JSON com `QueryStringConfig` contendo pares key-value** ✅

**Resposta: D**

**Explicação:**
A configuração correta para uma condição de query string usa `QueryStringConfig` com uma lista de `Values` — cada item pode conter um par `Key`/`Value` (ex.: `"version"/"v1"`) ou apenas um `Value` com wildcard (ex.: `"*example*"`).

```json
[
  {
    "Field": "query-string",
    "QueryStringConfig": {
      "Values": [
        {"Key": "version", "Value": "v1"},
        {"Value": "*example*"}
      ]
    }
  }
]
```

- A está errada: é uma redirect action, não uma query string condition.
- B está errada: `PathPatternConfig` é para condições de path pattern, não query string.
- C está errada: `StringHeaderConfig` é para condições de HTTP header, não query string.

---

## Pergunta 61 · Domínio: Development with AWS Services

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

## Pergunta 62 · Domínio: Troubleshooting and Optimization

Um developer configurou host-based routing em um ALB. A rule `*.sample.com` foi configurada.

**Qual hostname essa rule corresponde?**

- A. **test.sample.com** ✅
- B. sample.com
- C. SAMPLE.COM
- D. sample.test.com

**Resposta: A**

**Explicação:**
O wildcard `*` corresponde a 0 ou mais caracteres, mas não ao `.`. Portanto `*.sample.com` corresponde a `test.sample.com` (um subdomínio direto) mas **não** a `sample.com` (sem subdomínio) nem a `sample.test.com` (hierarquia invertida). A correspondência não diferencia maiúsculas/minúsculas, portanto `SAMPLE.COM` sem o subdomínio não se encaixa.

---

## Pergunta 63 · Domínio: Troubleshooting and Optimization

Uma aplicação de encoding de vídeo leva em média 20 segundos por arquivo. A fila SQS tem VisibilityTimeout de 30 segundos. Quando o processamento demora mais que o esperado, a mesma mensagem pode ser processada por múltiplos consumers.

**Qual solução você recomendaria?**

- A. Usar a action `DelaySeconds` para atrasar o visibility timeout
- B. **Usar a action `ChangeMessageVisibility` para estender o visibility timeout** ✅
- C. Usar `WaitTimeSeconds` com long poll para estender o visibility timeout
- D. Usar `WaitTimeSeconds` com short poll para estender o visibility timeout

**Resposta: B**

**Explicação:**
`ChangeMessageVisibility` permite estender o visibility timeout de uma mensagem enquanto ela está sendo processada. A aplicação pode definir um timeout inicial e continuamente estendê-lo via `ChangeMessageVisibility` conforme o processamento avança, evitando que outros consumers recebam a mesma mensagem.

- A está errada: `DelaySeconds` adia a entrega de **novas** mensagens — não estende o visibility timeout de mensagens em processamento.
- C e D estão erradas: `WaitTimeSeconds` controla o tempo de espera para receber mensagens (long/short polling) — não influencia o visibility timeout.

---

## Pergunta 64 · Domínio: Security

Uma empresa de analytics usa Kinesis Data Streams com múltiplos consumer applications. Os engenheiros notaram lag na entrega de dados entre producers e consumers.

**Qual opção você sugeriria para melhorar a performance?**

- A. Substituir Kinesis Data Streams por Kinesis Data Firehose
- B. Substituir Kinesis Data Streams por filas SQS FIFO
- C. Substituir Kinesis Data Streams por filas SQS Standard
- D. **Usar o recurso Enhanced Fan-Out do Kinesis Data Streams** ✅

**Resposta: D**

**Explicação:**
Por padrão, o output de 2 MB/segundo/shard é compartilhado entre todos os consumers. Com Enhanced Fan-Out, cada consumer registrado recebe seu próprio pipe de 2 MB/segundo/shard — o throughput escala automaticamente com o número de shards e consumers.

- A está errada: o Kinesis Data Firehose escreve apenas para S3, Redshift, Elasticsearch ou Splunk — não suporta consumers customizados.
- B e C estão erradas: SQS não suporta múltiplos consumers consumindo o mesmo stream de dados concorrentemente da mesma forma que o Kinesis.

---

## Pergunta 65 · Domínio: Development with AWS Services

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

---