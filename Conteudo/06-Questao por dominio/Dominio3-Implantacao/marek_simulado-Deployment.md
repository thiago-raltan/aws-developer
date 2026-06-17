# Simulado Marek - Deployment

> **67 questoes** de todas as 6 provas (P01-P06) agrupadas por dominio

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
