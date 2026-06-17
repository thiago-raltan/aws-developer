# Simulado Marek - Deployment

## Parte 2: Provas 04, 05, 06

> **33 questoes** agrupadas por dominio -- Fonte: Provas Marek 04, 05, 06

---

## Pergunta 10 [P04] · Domínio: Deployment

Você configurou um ambiente Elastic Beanstalk de produção com rolling deployment para evitar downtime. Para os ambientes de desenvolvimento e teste, você quer implantar rapidamente e não se preocupa com downtime.

**Qual política de deployment atende às necessidades de dev/test?**

- A. **All at once** ✅
- B. Rolling
- C. Rolling with additional batches
- D. Immutable

**Resposta: A**

**Explicação:**
"All at once" é o método mais rápido — implanta a nova versão em todas as instâncias simultaneamente. Adequado quando uma curta indisponibilidade é aceitável, como em ambientes de desenvolvimento e teste.

- B e C estão erradas: Rolling e Rolling with additional batches são mais lentos — não são os mais rápidos.
- D está errada: Immutable é o método mais lento, criando novas instâncias para cada deploy.

---

## Pergunta 13 [P04] · Domínio: Deployment

Você configurou um workflow de CI/CD com CodePipeline, CodeCommit e CodeBuild. Você está configurando `ProjectArtifacts` no estágio de build.

**O que você deve fazer?**

- A. Dar ao CodeCommit permissões para fazer upload do build output para o bucket S3
- B. **Dar ao CodeBuild permissões para fazer upload do build output para o bucket S3** ✅
- C. Contatar o suporte AWS para permitir que o CodePipeline gerencie os build outputs
- D. Configurar o CodeBuild para armazenar os artefatos em servidores EC2

**Resposta: B**

**Explicação:**
Quando `ProjectArtifacts` tem o tipo S3, o CodeBuild armazena o build output no S3. Portanto, é o CodeBuild que precisa de permissões para fazer upload.

- A está errada: CodeCommit é o repositório de código-fonte, não tem controle sobre a compilação.
- D está errada: servidores EC2 não são um destino válido para artefatos do CodeBuild.

---

## Pergunta 16 [P04] · Domínio: Deployment

O CodeDeploy tem flexibilidade para deployment incremental em instâncias EC2 existentes e também suporta uso de Auto Scaling group.

**Quais opções de deployment permitem isso?** (Selecione duas)

- A. **In-place Deployment** ✅
- B. **Blue/green Deployment** ✅
- C. Cattle Deployment
- D. Warm Standby Deployment
- E. Pilot Light Deployment

**Resposta: A, B**

**Explicação:**
- In-place: a aplicação em cada instância é parada, a nova revisão é instalada e validada. As instâncias podem ser desregistradas de um load balancer durante o processo.
- Blue/green: um novo conjunto de instâncias recebe a nova versão. O load balancer redireciona o tráfego das instâncias antigas para as novas. As antigas podem ser terminadas depois.
- C, D e E estão erradas: Cattle, Warm Standby e Pilot Light não são estratégias do CodeDeploy.

---

## Pergunta 17 [P04] · Domínio: Deployment

Você criou um CloudFormation template em YAML que usa uma função Lambda para puxar arquivos HTML do GitHub e colocá-los em um bucket S3.

**Quais AWS CLI commands você pode usar para fazer upload das funções Lambda e templates CloudFormation para a AWS?**

- A. **`cloudformation package` e `cloudformation deploy`** ✅
- B. `cloudformation zip` e `cloudformation upload`
- C. `cloudformation zip` e `cloudformation deploy`
- D. `cloudformation package` e `cloudformation upload`

**Resposta: A**

**Explicação:**
- `cloudformation package`: empacota artefatos locais (como código Lambda) e faz upload para S3.
- `cloudformation deploy`: implanta o template especificado criando e executando um changeset.
- Os outros comandos (`zip`, `upload`) não existem no AWS CLI.

---

## Pergunta 22 [P04] · Domínio: Deployment

**Qual é a ordem correta de execução dos hooks para in-place deployments usando CodeDeploy?**

- A. BeforeInstall → ValidateService → DownloadBundle → ApplicationStart
- B. BeforeInstall → ApplicationStop → ApplicationStart → ValidateService
- C. ApplicationStop → BeforeInstall → ValidateService → ApplicationStart
- D. **ApplicationStop → BeforeInstall → ApplicationStart → ValidateService** ✅

**Resposta: D**

**Explicação:**
A ordem correta dos hooks no ciclo de vida de um deploy in-place EC2 no CodeDeploy é:
`ApplicationStop → DownloadBundle → BeforeInstall → Install → AfterInstall → ApplicationStart → ValidateService`

Dentre as opções, D é a única que mantém a sequência correta: ApplicationStop antes de BeforeInstall, e ValidateService por último.

---

## Pergunta 25 [P04] · Domínio: Deployment

Uma empresa configurou rollbacks automáticos no CodeDeploy. Um deploy de uma nova versão da aplicação falha.

**O que acontece?**

- A. **Um novo deployment da última versão funcional é executado com um novo deployment ID** ✅
- B. O CodePipeline promove o deployment com status SUCCEEDED para produção
- C. O último deployment funcional é restaurado automaticamente usando um snapshot no S3
- D. O CodeDeploy alterna os records do Route 53 de volta ao green deployment

**Resposta: A**

**Explicação:**
O CodeDeploy realiza rollbacks reimplantando uma revisão anterior como um novo deployment. Rollbacks são tecnicamente novos deployments com novos deployment IDs — não são restaurações de versões anteriores.

- C está errada: CodeDeploy não usa snapshots em S3 para rollback.
- B e D estão erradas: o enunciado não menciona CodePipeline nem blue/green deployment.

---

## Pergunta 26 [P04] · Domínio: Deployment

Um developer quer retornar facilmente a versões anteriores de uma função Lambda implantada, com o menor overhead operacional.

**Qual solução você escolheria?**

- A. **Usar um Lambda function alias que pode apontar para diferentes versões** ✅
- B. Usar Lambda function layers que podem apontar para diferentes versões
- C. Usar uma Route 53 weighted policy que aponta para diferentes versões da Lambda
- D. Usar CodeDeploy para configurar blue/green deployments para diferentes versões

**Resposta: A**

**Explicação:**
Um Lambda alias é como um ponteiro para uma versão específica. Você pode atualizar um alias para apontar para versões diferentes com mínimo esforço operacional. Cada alias tem um ARN único.

- D está errada: uma vez implantado via CodeDeploy, não é possível voltar para versões anteriores da função.
- C está errada: Route 53 não pode apontar para versões Lambda.
- B está errada: Lambda layers são para dependências e bibliotecas, não para gerenciar versões de funções.

---

## Pergunta 32 [P04] · Domínio: Deployment

Um CloudFormation template provisiona uma VPC e uma subnet. O valor de saída (output) dessa subnet precisa ser usado em outro stack.

**Qual opção você sugeriria?**

- A. Usar o campo `Expose` na seção Output do template
- B. **Usar o campo `Export` na seção Output do template** ✅
- C. Usar `Fn::ImportValue`
- D. Usar `Fn::Transform`

**Resposta: B**

**Explicação:**
Para compartilhar informações entre stacks, use o campo `Export` na seção `Outputs` do stack exportador. Outros stacks na mesma conta e região podem importar esses valores usando `Fn::ImportValue`.

- A está errada: `Expose` é uma opção inventada.
- C está errada: `Fn::ImportValue` é usado no stack que **importa** o valor, não no que exporta.
- D está errada: `Fn::Transform` especifica uma macro para processamento customizado de templates.

---

## Pergunta 34 [P04] · Domínio: Deployment

Uma equipe .NET usa instâncias EC2 com IIS e precisa que múltiplas versões da aplicação rodem no Elastic Beanstalk: uma para desenvolvimento/teste e outra para load testing.

**Qual método você recomenda?**

- A. Usar apenas um ambiente Beanstalk e realizar mudanças de configuração via Ansible
- B. Criar um ALB para roteamento por hostname e um arquivo em `.ebextensions/` para gerenciar o tráfego
- C. **Definir um ambiente dev com instância única e um ambiente de 'load test' com configurações próximas à produção** ✅
- D. Não é possível ter múltiplos ambientes de desenvolvimento no Elastic Beanstalk

**Resposta: C**

**Explicação:**
O Elastic Beanstalk permite criar e gerenciar ambientes separados (desenvolvimento, teste, produção) para a mesma aplicação. Você pode implantar qualquer versão em qualquer ambiente.

- D está errada: é totalmente possível ter múltiplos ambientes no Beanstalk.
- A está errada: Beanstalk já gerencia múltiplos ambientes nativamente — Ansible seria mais complexo.
- B está errada: usar ALB + `.ebextensions/` para load testing causaria conflito de recursos entre as versões.

---

## Pergunta 37 [P04] · Domínio: Deployment

**Qual opção lista a ordem correta dos lifecycle events no AppSpec file do CodeDeploy?**

- A. BeforeInstall → ValidateService → DownloadBundle → ApplicationStart
- B. ValidateService → BeforeInstall → DownloadBundle → ApplicationStart
- C. **DownloadBundle → BeforeInstall → ApplicationStart → ValidateService** ✅
- D. BeforeInstall → ApplicationStart → DownloadBundle → ValidateService

**Resposta: C**

**Explicação:**
A ordem correta dos lifecycle events no CodeDeploy para deploy em EC2:
`ApplicationStop → DownloadBundle → BeforeInstall → Install → AfterInstall → ApplicationStart → ValidateService`

Dentre as opções, C é a única que mantém DownloadBundle antes de BeforeInstall e ValidateService por último.

---

## Pergunta 40 [P04] · Domínio: Deployment

Uma empresa quer disparar um deploy via CodePipeline assim que houver qualquer mudança no código-fonte.

**Quais opções aciona o pipeline?** (Selecione duas)

- A. **Manter o código em um bucket Amazon S3 e iniciar o CodePipeline quando um arquivo no bucket for atualizado** ✅
- B. Manter o código em um volume Amazon EBS e iniciar o CodePipeline quando houver atualizações
- C. **Manter o código em um repositório AWS CodeCommit e iniciar o CodePipeline quando uma mudança for feita** ✅
- D. Manter o código em um bucket Amazon S3 e configurar o CodePipeline para rodar a cada 15 minutos
- E. Manter o código no Amazon EFS e iniciar o CodePipeline quando um arquivo for atualizado

**Resposta: A, C**

**Explicação:**
CodePipeline suporta CodeCommit e S3 como source providers com change detection via EventBridge. Quando você usa o console para criar um pipeline com CodeCommit ou S3 como source, o CodePipeline cria automaticamente uma EventBridge rule para iniciar o pipeline quando a source muda.

- B e E estão erradas: EBS e EFS não são source providers suportados pelo CodePipeline.
- D está errada: polling a cada 15 minutos não é o recomendado — change detection via eventos é mais eficiente.

---

## Pergunta 44 [P04] · Domínio: Deployment

Uma equipe está considerando ElastiCache for Redis como solução de cache in-memory para seu banco de dados relacional.

**Quais opções estão corretas ao configurar o ElastiCache?** (Selecione duas)

- A. Você pode escalar a capacidade de escrita do Redis adicionando nós réplica
- B. **Todos os nós de um cluster Redis devem residir na mesma região** ✅
- C. Com cluster mode habilitado, a replicação é síncrona; com cluster mode desabilitado, é assíncrona
- D. **Com cluster mode habilitado, você não pode promover manualmente nenhum nó réplica para primary** ✅
- E. Se não houver réplicas e um nó falhar, não há perda de dados com cluster mode habilitado

**Resposta: B, D**

**Explicação:**
- B: todos os nós de um cluster Redis (mode habilitado ou desabilitado) devem estar na mesma região.
- D: com cluster mode habilitado, não é possível promover manualmente réplicas para primary; Multi-AZ é obrigatório.
- A está errada: nós réplica aumentam capacidade de **leitura**, não de escrita.
- C está errada: a replicação é **assíncrona** em ambos os modos (habilitado e desabilitado).
- E está errada: sem réplicas e com falha de nó, **há perda de dados** (dos dados daquele shard).

---

## Pergunta 49 [P04] · Domínio: Deployment

A equipe de desenvolvimento quer que um CloudFormation template se auto-popule com a variável de Region enquanto é implantado.

**Qual é a forma mais operacionalmente eficiente?**

- A. Configurar um mapping com todos os valores de Region e ter o template selecionando automaticamente
- B. **Usar o pseudo parameter `AWS::Region`** ✅
- C. Criar um parâmetro CloudFormation para Region e populá-lo no momento do deploy
- D. Criar um Lambda-backed custom resource para Region

**Resposta: B**

**Explicação:**
`AWS::Region` é um pseudo parameter predefinido pelo CloudFormation. Retorna uma string representando a região onde o recurso está sendo criado (ex.: `us-west-2`). Não precisa ser declarado — basta referenciar com `!Ref "AWS::Region"`.

- C está errada: usar um parâmetro explícito requer preenchimento manual no deploy — não é operacionalmente eficiente.
- A está errada: o template não pode "auto-selecionar" automaticamente do Mappings sem lógica adicional.
- D está errada: um Lambda custom resource para recuperar a Region é desnecessariamente complexo.

---

## Pergunta 63 [P04] · Domínio: Deployment

Um deploy via CodeDeploy em instâncias T2 foi bem-sucedido. A nova revisão faz chamadas de API ao S3, mas a aplicação não está funcionando corretamente devido a exceções de autorização.

**O que você deve fazer?**

- A. Tornar o bucket S3 público
- B. **Corrigir as permissões IAM da EC2 instance role** ✅
- C. Corrigir as permissões IAM da CodeDeploy service role
- D. Habilitar CodeDeploy Proxy

**Resposta: B**

**Explicação:**
O CodeDeploy implantou com sucesso (sem problema de permissões entre CodeDeploy e EC2). O erro de autorização ocorre na comunicação entre as instâncias EC2 e o S3 — portanto, a IAM role da instância EC2 não tem permissão para acessar o S3.

- A está errada: tornar o bucket público viola princípios de least privilege.
- C está errada: o deploy foi bem-sucedido, então não há problema nas permissões do CodeDeploy.
- D está errada: não existe "CodeDeploy Proxy".

---

## Pergunta 6 [P05] · Domínio: Deployment

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

## Pergunta 7 [P05] · Domínio: Deployment

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

## Pergunta 10 [P05] · Domínio: Deployment

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

## Pergunta 16 [P05] · Domínio: Deployment

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

## Pergunta 21 [P05] · Domínio: Deployment

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

## Pergunta 34 [P05] · Domínio: Deployment

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

## Pergunta 53 [P05] · Domínio: Deployment

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

## Pergunta 58 [P05] · Domínio: Deployment

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

## Pergunta 62 [P05] · Domínio: Deployment

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

## Pergunta 4 [P06] · Domínio: Deployment

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

## Pergunta 15 [P06] · Domínio: Deployment

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

## Pergunta 17 [P06] · Domínio: Deployment

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

## Pergunta 18 [P06] · Domínio: Deployment

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

## Pergunta 25 [P06] · Domínio: Deployment

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

## Pergunta 33 [P06] · Domínio: Deployment

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

## Pergunta 38 [P06] · Domínio: Deployment

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

## Pergunta 43 [P06] · Domínio: Deployment

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

## Pergunta 48 [P06] · Domínio: Deployment

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

## Pergunta 51 [P06] · Domínio: Deployment

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
