# Simulado Marek - Deployment

## Parte 1: Provas 01, 02, 03

> **34 questoes** agrupadas por dominio -- Fonte: Provas Marek 01, 02, 03

---

## Pergunta 3 [P01] · Domínio: Deployment

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

## Pergunta 11 [P01] · Domínio: Deployment

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

## Pergunta 12 [P01] · Domínio: Deployment

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

## Pergunta 17 [P01] · Domínio: Deployment

Qual representa a **ordem correta de etapas** para criar uma app usando AWS CDK?

- A. CloudFormation template → Adicionar código → Build → Synthesize → Deploy
- B. **CDK template → Adicionar código → Build (opcional) → Synthesize → Deploy** ✅
- C. CloudFormation template → Adicionar código → Synthesize → Deploy → Build
- D. CDK template → Adicionar código → Synthesize → Deploy → Build

**Resposta: B**

**Explicação:**
Workflow: `cdk init` → adicionar código → build opcional → `cdk synth` → `cdk deploy`.

---

## Pergunta 28 [P01] · Domínio: Deployment

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

## Pergunta 29 [P01] · Domínio: Deployment

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

## Pergunta 31 [P01] · Domínio: Deployment

Rolling deployment: 2 batches com sucesso, o restante falhou. As instâncias do deploy com falha foram terminadas.

**O que acontece com as instâncias com falha após a terminação?**

- A. **O Elastic Beanstalk as substitui com instâncias rodando a versão do deploy mais recente com sucesso** ✅
- B. Substituir pela versão mais antiga de deploy com sucesso
- C. O Elastic Beanstalk não vai substituir as instâncias com falha
- D. Seleção manual pelo AWS Console é necessária

**Resposta: A**

---

## Pergunta 35 [P01] · Domínio: Deployment

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

## Pergunta 36 [P01] · Domínio: Deployment

Um developer quer focar **apenas em escrever código**, sem se preocupar com provisionamento, configuração e deploy de servidores no EC2.

**Qual serviço AWS você recomendaria?**

- A. **Elastic Beanstalk** ✅
- B. CloudFormation
- C. Serverless Application Model
- D. CodeDeploy

**Resposta: A**

---

## Pergunta 38 [P01] · Domínio: Deployment

Qual seção de um CloudFormation template **NÃO pode** ser associada a uma Condition?

- A. Resources
- B. Conditions
- C. Outputs
- D. **Parameters** ✅

**Resposta: D**

**Explicação:**
Conditions só podem ser associadas a **Resources** e **Outputs**. A seção Parameters não suporta associação com Conditions.

---

## Pergunta 40 [P01] · Domínio: Deployment

O manager quer que os scripts CloudFormation exibam o **número da conta** de cada account.

**Qual Pseudo parâmetro você usaria?**

- A. AWS::Region
- B. AWS::NoValue
- C. **AWS::AccountId** ✅
- D. AWS::StackName

**Resposta: C**

---

## Pergunta 42 [P01] · Domínio: Deployment

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

## Pergunta 46 [P01] · Domínio: Deployment

Dois stacks em regiões diferentes criaram CloudFormation exports com o mesmo nome `ELBDNSName`. O deploy em us-east-2 falhou.

**Qual é a causa do erro?**

- A. Exported Output Values devem ter nomes únicos em todas as Regions
- B. Output Values devem ter nomes únicos dentro de uma única Region
- C. **Exported Output Values devem ter nomes únicos dentro de uma única Region** ✅
- D. Output Values devem ter nomes únicos em todas as Regions

**Resposta: C**

---

## Pergunta 50 [P01] · Domínio: Deployment

Qual tipo de credencial **NÃO é suportado** pelo IAM para CodeCommit?

- A. **Usuário e senha IAM** ✅
- B. SSH Keys
- C. AWS Access Keys
- D. Git credentials

**Resposta: A**

**Explicação:**
Usuário/senha do IAM não podem acessar CodeCommit. Métodos suportados: Git credentials (HTTPS), SSH Keys, AWS Access Keys + credential helper.

---

## Pergunta 53 [P01] · Domínio: Deployment

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

## Pergunta 58 [P01] · Domínio: Deployment

Qual **NÃO é** um tipo de recurso SAM válido?

- A. AWS::Serverless::Api
- B. **AWS::Serverless::UserPool** ✅
- C. AWS::Serverless::Function
- D. AWS::Serverless::SimpleTable

**Resposta: B**

**Explicação:**
`UserPool` pertence ao Cognito, não é um tipo SAM. Tipos válidos: `Function`, `Api`, `HttpApi`, `SimpleTable`, `Application`, `LayerVersion`, `StateMachine`.

---

## Pergunta 62 [P01] · Domínio: Deployment

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

## Pergunta 14 [P02] · Domínio: Deployment

Uma empresa quer arquitetura de microservices com containers Docker. A arquitetura deve suportar mapeamento dinâmico de portas e múltiplas tasks de um mesmo serviço na mesma instância de container. Todos os serviços devem rodar na mesma instância EC2.

**Qual solução é a mais adequada?**

- A. **Application Load Balancer + ECS** ✅
- B. Classic Load Balancer + ECS
- C. Application Load Balancer + Elastic Beanstalk
- D. Classic Load Balancer + Elastic Beanstalk

**Resposta: A**

**Explicação:**
O ALB com ECS permite mapeamento dinâmico de portas, suportando múltiplas tasks de um mesmo serviço na mesma instância. O ECS gerencia automaticamente o registro e cancelamento de registro de containers no target group usando o instance ID e porta de cada container.

- B e D estão erradas: o Classic Load Balancer não permite múltiplas cópias de uma task na mesma instância — requer mapeamento estático de portas.
- C está errada: Elastic Beanstalk oferece controle menos granular que o ECS.

---

## Pergunta 16 [P02] · Domínio: Deployment

Uma empresa precisa de um sistema de controle de versão para seu ciclo de desenvolvimento ágil com mudanças incrementais, controle de versão e suporte às ferramentas Git existentes.

**Qual serviço AWS atende a esses requisitos?**

- A. AWS CodeBuild
- B. **AWS CodeCommit** ✅
- C. Amazon Versioned S3 Bucket
- D. AWS CodePipeline

**Resposta: B**

**Explicação:**
AWS CodeCommit é um serviço de Source Control totalmente gerenciado que hospeda repositórios Git seguros. Suporta todos os comandos Git, pull requests, branching e merging, e permite transferir mudanças incrementais.

- C está errada: S3 com versionamento não suporta mudanças em lote entre múltiplos arquivos ou branching.
- D está errada: CodePipeline é um serviço de continuous delivery, não de controle de versão.
- A está errada: CodeBuild é um serviço de integração contínua para compilar e testar código.

---

## Pergunta 17 [P02] · Domínio: Deployment

Além da seção Resources, qual das seguintes seções em um SAM Template é obrigatória?

- A. Globals
- B. **Transform** ✅
- C. Mappings
- D. Parameters

**Resposta: B**

**Explicação:**
Em um SAM template, `Transform` e `Resources` são as únicas seções obrigatórias. A seção `Transform: 'AWS::Serverless-2016-10-31'` é uma macro que transforma o template SAM em um CloudFormation template válido.

- A, C e D estão erradas: Globals, Mappings e Parameters são opcionais.

---

## Pergunta 19 [P02] · Domínio: Deployment

Uma empresa de e-commerce gerencia microservices que recebem pedidos de vários parceiros via API customizada no API Gateway. Os pedidos são processados por uma Lambda function compartilhada. A empresa quer notificar cada parceiro sobre o status de seus pedidos de forma eficiente e escalável para novos parceiros com mínimas mudanças de código.

**Qual solução você recomendaria?**

- A. Configurar uma API Gateway separada por parceiro
- B. Criar uma Lambda function separada por parceiro + um SNS topic + filter policy
- C. **Criar um SNS topic, inscrever cada parceiro e modificar a Lambda para publicar mensagens com atributos específicos com filter policy por assinatura** ✅
- D. Criar um SNS topic separado por parceiro
- E. Criar um SNS topic separado por parceiro e publicar mensagens diretamente

**Resposta: C**

**Explicação:**
Um único SNS topic com filter policies distintas por parceiro é suficiente. A Lambda function compartilhada publica mensagens com atributos específicos e cada parceiro recebe apenas as mensagens filtradas para ele. Para novos parceiros, basta configurar uma nova filter policy.

- B, D e E estão erradas: criar SNS topics ou Lambda functions separadas por parceiro é uma solução ineficiente e difícil de escalar.

---

## Pergunta 20 [P02] · Domínio: Deployment

A equipe de desenvolvimento completou o último deploy para sua aplicação com capacidade reduzida devido à política de deploy. A aplicação sofreu impacto de performance por um pico de tráfego durante uma promoção.

**Qual política de deploy garante capacidade TOTAL e impacto MÍNIMO em caso de falha?**

- A. Rolling with additional batch
- B. All at once
- C. **Immutable** ✅
- D. Rolling

**Resposta: C**

**Explicação:**
O deploy Immutable garante que a nova versão sempre seja implantada em novas instâncias. Um segundo Auto Scaling group é criado com as novas instâncias servindo tráfego junto com as antigas até passar nos health checks. Em caso de falha, as novas instâncias são terminadas imediatamente — rollback rápido e sem impacto.

- A está errada: Rolling with additional batch mantém capacidade total, mas rollback é manual (redeploy).
- D está errada: Rolling reduz capacidade temporariamente durante o deploy.
- B está errada: All at once causa downtime temporário.

---

## Pergunta 27 [P02] · Domínio: Deployment

Um developer quer empacotar código e dependências de funções Lambda como container images no Amazon ECR.

**Quais afirmações estão corretas?** (Selecione duas)

- A. Lambda suporta container images baseadas em Windows e Linux
- B. **O serviço AWS Lambda não suporta funções que usam container images multi-architecture** ✅
- C. Você pode testar os containers localmente usando o Lambda Runtime API
- D. **Para implantar um container image no Lambda, a image deve implementar o Lambda Runtime API** ✅
- E. Você pode implantar uma função Lambda como container image com tamanho máximo de 15 GB

**Resposta: B, D**

**Explicação:**
- D está correta: o container image deve implementar o Lambda Runtime API para ser compatível com Lambda.
- B está correta: o Lambda fornece base images multi-architecture, mas a image que você cria deve ser para uma única arquitetura.
- A está errada: Lambda suporta apenas container images baseadas em Linux.
- C está errada: containers são testados localmente com o Lambda Runtime Interface Emulator, não com o Runtime API.
- E está errada: o tamanho máximo de container image para Lambda é 10 GB.

---

## Pergunta 31 [P02] · Domínio: Deployment

Um novo líder de equipe será responsável pelo deploy de código em instâncias EC2 via CodeCommit e CodeDeploy. O processo deve alterar permissões dos arquivos implantados e verificar o sucesso do deploy.

**Qual ação o novo desenvolvedor deve tomar?**

- A. Definir um arquivo `buildspec.yml` no diretório raiz
- B. Definir um arquivo `appspec.yml` no diretório `codebuild/`
- C. Definir um arquivo `buildspec.yml` no diretório `codebuild/`
- D. **Definir um arquivo `appspec.yml` no diretório raiz** ✅

**Resposta: D**

**Explicação:**
O arquivo AppSpec (`appspec.yml`) deve ser formatado em YAML e colocado na raiz da estrutura de diretórios do código-fonte. Ele é usado para mapear arquivos, especificar permissões customizadas e definir scripts a serem executados em cada etapa do deploy.

- A e C estão erradas: `buildspec.yml` é usado pelo CodeBuild, não pelo CodeDeploy.
- B está errada: `appspec.yml` deve estar no diretório raiz, não em `codebuild/`.

---

## Pergunta 53 [P02] · Domínio: Deployment

Um developer precisa automatizar o deploy de pacotes de software tanto para instâncias EC2 quanto para servidores on-premises como parte de CI/CD.

**Qual serviço AWS deve ser usado?**

- A. **AWS CodeDeploy** ✅
- B. AWS Elastic Beanstalk
- C. AWS CodePipeline
- D. AWS CodeBuild

**Resposta: A**

**Explicação:**
CodeDeploy é um serviço de deploy totalmente gerenciado que automatiza deploys para EC2, Fargate, Lambda e servidores on-premises.

- C está errada: CodePipeline é um serviço de continuous delivery, não de deploy direto.
- D está errada: CodeBuild é um serviço de integração contínua para compilar e testar código.
- B está errada: Elastic Beanstalk gerencia apenas aplicações web em infraestrutura AWS.

---

## Pergunta 59 [P02] · Domínio: Deployment

Você está desenvolvendo uma aplicação Java no Elastic Beanstalk e quer um mecanismo de configuração que aplique settings automaticamente sem precisar acessar as instâncias via SSH.

**Qual opção você usaria?**

- A. Usar SSM parameter store como input para as configurações do Elastic Beanstalk
- B. Fazer deploy de um CloudFormation wrapper
- C. Usar um hook AWS Lambda
- D. **Incluir arquivos de configuração em `.ebextensions/` na raiz do source code** ✅

**Resposta: D**

**Explicação:**
A seção `option_settings` em arquivos de configuração `.ebextensions/*.config` define valores para opções de configuração do ambiente Elastic Beanstalk, AWS resources e software da aplicação — aplicadas automaticamente durante o deploy.

- A está errada: SSM Parameter Store não é suportado diretamente como input para configurações do Elastic Beanstalk.
- B está errada: não existe um "CloudFormation wrapper" para Beanstalk.
- C está errada: Lambda hooks exigem esforço de desenvolvimento significativo.

---

## Pergunta 3 [P03] · Domínio: Deployment

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

## Pergunta 13 [P03] · Domínio: Deployment

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

## Pergunta 14 [P03] · Domínio: Deployment

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

## Pergunta 37 [P03] · Domínio: Deployment

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

## Pergunta 46 [P03] · Domínio: Deployment

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

## Pergunta 49 [P03] · Domínio: Deployment

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

## Pergunta 51 [P03] · Domínio: Deployment

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

## Pergunta 59 [P03] · Domínio: Deployment

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
