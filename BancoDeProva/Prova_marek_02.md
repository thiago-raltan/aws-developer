# Prova Marek 02 — AWS Certified Developer Associate

> **65 questões** | Domínios: Development with AWS Services · Security · Deployment · Troubleshooting and Optimization

---

## Pergunta 1 · Domínio: Troubleshooting and Optimization

Após uma revisão de código, um developer foi solicitado a tornar seus buckets S3 publicamente acessíveis em privados e habilitar o acesso a objetos com restrição de tempo.

**Qual das seguintes opções resolve esse caso de uso?**

- A. Não é possível implementar restrições de tempo no acesso ao Amazon S3 Bucket
- B. Usar Routing policies para redirecionar acessos não autorizados
- C. **Compartilhar pre-signed URLs com os recursos que precisam de acesso** ✅
- D. Usar Bucket policy para bloquear acessos não autorizados

**Resposta: C**

**Explicação:**
Pre-signed URLs incluem informações adicionais como data e hora de expiração, concedendo permissão com tempo limitado para download. Por padrão, todos os objetos são privados — o proprietário pode compartilhá-los criando uma pre-signed URL usando suas credenciais de segurança.

- A está errada: é possível, sim, dar acesso com limite de tempo via pre-signed URL.
- B está errada: Routing policies não existem diretamente no S3.
- D está errada: Bucket policy pode bloquear acessos, mas não implementa acesso baseado em tempo.

---

## Pergunta 2 · Domínio: Development with AWS Services

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

## Pergunta 3 · Domínio: Troubleshooting and Optimization

Uma empresa de contabilidade usa volumes Amazon EBS para armazenamento persistente de dados. Os volumes são criptografados com KMS. O gerente encontrou o seguinte snippet de policy:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Allow for use of this Key",
            "Effect": "Allow",
            "Principal": {"AWS": "arn:aws:iam::111122223333:role/UserRole"},
            "Action": ["kms:GenerateDataKeyWithoutPlaintext", "kms:Decrypt"],
            "Resource": "*"
        },
        {
            "Sid": "Allow for EC2 Use",
            "Effect": "Allow",
            "Principal": {"AWS": "arn:aws:iam::111122223333:role/UserRole"},
            "Action": ["kms:CreateGrant", "kms:ListGrants", "kms:RevokeGrant"],
            "Resource": "*",
            "Condition": {"StringEquals": {"kms:ViaService": "ec2.us-west-2.amazonaws.com"}}
        }
    ]
}
```

**Qual das seguintes afirmações está correta sobre essa policy?**

- A. **O primeiro statement concede ao IAM principal especificado a capacidade de gerar uma data key e descriptografá-la da CMK quando necessário** ✅
- B. O segundo statement indica que todos os recursos do primeiro statement podem assumir a role para criar, listar e revogar grants para o EC2
- C. O primeiro statement concede ao security group a capacidade de gerar e descriptografar a data key da CMK
- D. O segundo statement concede ao security group do primeiro statement a capacidade de criar, listar e revogar grants para o EC2

**Resposta: A**

**Explicação:**
O primeiro statement concede ao IAM principal especificado a capacidade de gerar uma data key (`kms:GenerateDataKeyWithoutPlaintext`) e descriptografá-la (`kms:Decrypt`) — necessário para criptografar volumes EBS enquanto estão anexados a instâncias EC2. O segundo statement concede ao mesmo IAM principal a capacidade de criar, listar e revogar grants para o EC2 — usado para re-anexar volumes criptografados após desconexões.

- C e D estão erradas: o principal é uma IAM role, não um security group.
- B está errada: o segundo statement não permite assumir roles.

---

## Pergunta 4 · Domínio: Troubleshooting and Optimization

Você é líder de desenvolvimento configurando permissões para outros usuários IAM com permissões limitadas. Você quer testar se um usuário não consegue encerrar instâncias EC2.

**Qual das seguintes opções você executaria?**

- A. Recuperar a policy usando o EC2 metadata service e usar o IAM policy simulator
- B. **Usar a opção `--dry-run` do AWS CLI** ✅
- C. Criar uma EC2 dummy via CLI e deletá-la com outra chamada CLI
- D. Usar a opção `--test` do AWS CLI

**Resposta: B**

**Explicação:**
A opção `--dry-run` verifica se você tem as permissões necessárias para a ação sem realmente executar a requisição. Se tiver permissão, retorna `DryRunOperation`; caso contrário, retorna `UnauthorizedOperation`.

- D está errada: `--test` não existe no AWS CLI.
- A está errada: o EC2 metadata service recupera informações de instância, não verifica permissões IAM.
- C está errada: não é a forma mais elegante e eficiente de testar permissões.

---

## Pergunta 5 · Domínio: Troubleshooting and Optimization

Um developer configurou um novo security group para permitir tráfego HTTP de entrada de `0.0.0.0/0` e manteve as regras padrão de saída. Um NACL customizado está configurado para permitir tráfego HTTP de entrada de `0.0.0.0/0` e manteve as regras padrão de saída.

**Qual solução você sugeriria para que a instância EC2 aceite e responda a requisições da internet?**

- A. Regras de saída precisam ser configuradas tanto no security group quanto no NACL para enviar respostas ao Internet Gateway
- B. A configuração está completa para aceitar e responder a requisições
- C. **Uma regra de saída deve ser adicionada ao NACL para permitir que a resposta seja enviada ao cliente na faixa de portas efêmeras** ✅
- D. Uma regra de saída no security group precisa ser configurada para permitir a resposta ao cliente na porta HTTP

**Resposta: C**

**Explicação:**
Security groups são stateful — permitir tráfego de entrada habilita a conexão automaticamente (resposta permitida). NACLs são stateless — é necessário permitir tanto entrada quanto saída. Para respostas, o NACL precisa de uma regra de saída para as portas efêmeras (1024-65535), pois o cliente usa uma porta aleatória nessa faixa como porta de retorno.

- B está errada: o NACL padrão bloqueará o tráfego de retorno sem regra de saída.
- D está errada: security groups são stateful, não precisam de regra de saída explícita.
- A está errada: apenas o NACL precisa de regra de saída; o security group é stateful.

---

## Pergunta 6 · Domínio: Troubleshooting and Optimization

Uma empresa usa AWS CodeDeploy para implantar aplicações do GitHub em instâncias EC2. O processo usa um arquivo `appspec.yml`. Um evento final de ciclo de vida deve ser especificado para verificar o sucesso da implantação.

**Qual hook event deve ser usado para verificar o sucesso do deploy?**

- A. AllowTraffic
- B. **ValidateService** ✅
- C. AfterInstall
- D. ApplicationStart

**Resposta: B**

**Explicação:**
`ValidateService` é o último evento do ciclo de vida de implantação — usado para verificar se o deploy foi concluído com sucesso.

- C está errada: `AfterInstall` é usado para configurar a aplicação ou alterar permissões de arquivos.
- D está errada: `ApplicationStart` é usado para reiniciar serviços parados durante `ApplicationStop`.
- A está errada: `AllowTraffic` é reservado para o agente CodeDeploy e não pode executar scripts.

---

## Pergunta 7 · Domínio: Development with AWS Services

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

## Pergunta 8 · Domínio: Troubleshooting and Optimization

Um developer está configurando um Auto Scaling group para escalar dinamicamente com Target Tracking Scaling Policy.

**Qual métrica abaixo NÃO faz parte da Target Tracking Scaling Policy?**

- A. ASGAverageCPUUtilization
- B. **ApproximateNumberOfMessagesVisible** ✅
- C. ASGAverageNetworkOut
- D. ALBRequestCountPerTarget

**Resposta: B**

**Explicação:**
`ApproximateNumberOfMessagesVisible` é uma métrica do CloudWatch para SQS queues. O número de mensagens em uma fila não muda proporcionalmente ao tamanho do Auto Scaling group, portanto não funciona para target tracking.

- A: métrica predefinida — CPU média do Auto Scaling group.
- C: métrica predefinida — bytes médios enviados por todas as interfaces de rede.
- D: métrica predefinida — número de requisições por target no ALB.

---

## Pergunta 9 · Domínio: Security

Após perder alguns private keys de SSH key pairs, uma empresa decidiu reutilizar seus SSH key pairs nas diferentes instâncias em múltiplas AWS Regions.

**Como developer associate, o que você recomendaria?**

- A. Armazenar o par de chaves SSH no AWS Trusted Advisor e acessar de qualquer Region
- B. Criptografar a private key SSH e armazenar em um bucket S3 para acessar de qualquer Region
- C. Não é possível reutilizar SSH key pairs entre AWS Regions
- D. **Gerar a public SSH key a partir da private SSH key e importar a chave em cada AWS Region desejada** ✅

**Resposta: D**

**Explicação:**
O processo correto: gerar o arquivo `.pub` (public key) a partir do arquivo `.pem` (private key) → configurar a AWS Region desejada → importar a public SSH key na nova Region.

- C está errada: é possível com importação manual.
- A está errada: Trusted Advisor não armazena credenciais de key pairs.
- B está errada: armazenar no S3 não torna a chave acessível para outras Regions diretamente.

---

## Pergunta 10 · Domínio: Development with AWS Services

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

## Pergunta 11 · Domínio: Troubleshooting and Optimization

Uma empresa usa Amazon SES para enviar emails. Intermitentemente, o serviço retorna o erro: `Throttling – Maximum sending rate exceeded`.

**Como developer associate, o que você recomendaria para resolver esse problema?**

- A. Configurar mecanismo de timeout para cada requisição ao SES
- B. Abrir uma solicitação de serviço para aumentar o limite de throttling da API SES
- C. Implementar mecanismo de retry para todos os erros 4xx
- D. **Usar a técnica de Exponential Backoff para introduzir delay antes de tentar a operação novamente** ✅

**Resposta: D**

**Explicação:**
O erro `Throttling – Maximum sending rate exceeded` é retriável. Em vez de tentar novamente imediatamente de forma agressiva, o Exponential Backoff faz o cliente aguardar um tempo crescente entre as tentativas, permitindo que o serviço se recupere. A vantagem é que a aplicação se auto-ajusta próxima à taxa máxima permitida.

- C está errada: erros 4xx são erros do cliente (credenciais inválidas, parâmetros ausentes) — throttling é um erro de servidor.
- A está errada: timeout não reduz a taxa de envio ao SES.
- B está errada: o erro é intermitente, indicando picos; aumentar o limite seria desnecessário.

---

## Pergunta 12 · Domínio: Troubleshooting and Optimization

Uma empresa de análise de dados processa dados IoT em tempo real via Kinesis Producer Library (KPL) enviando para uma aplicação em Kinesis Data Streams. A aplicação parou de processar por causa de uma exceção `ProvisionedThroughputExceededException`.

**Quais ações ajudariam a resolver esse problema?** (Selecione duas)

- A. **Configurar o data producer para retry com exponential backoff** ✅
- B. Usar Amazon Kinesis Agent em vez do KPL para enviar dados
- C. Usar Amazon SQS em vez do Kinesis Data Streams
- D. **Aumentar o número de shards dentro do data stream para fornecer capacidade suficiente** ✅
- E. Usar Kinesis enhanced fan-out para o Kinesis Data Streams

**Resposta: A, D**

**Explicação:**
Os limites de capacidade do Kinesis Data Streams são definidos pelo número de shards. Quando excedidos, a chamada de `PutRecords` é rejeitada com `ProvisionedThroughputExceededException`.

- Se o aumento for temporário → retry com exponential backoff eventualmente completará as requisições.
- Se o aumento for sustentado → aumentar o número de shards é necessário.
- B e C estão erradas: mudar de KPL para Kinesis Agent ou usar SQS não resolve a capacidade do stream.
- E está errada: enhanced fan-out beneficia consumidores (leitores), não produtores.

---

## Pergunta 13 · Domínio: Security

Uma empresa farmacêutica precisa compartilhar um novo artigo científico com uma equipe de pesquisa espalhada pelo mundo, sem comprometer a segurança do conteúdo.

**Qual solução mais otimizada você recomendaria?**

- A. Usar CloudFront Field-Level Encryption para proteger dados sensíveis
- B. **Usar o recurso de CloudFront signed URL para controlar o acesso ao arquivo** ✅
- C. Usar o recurso de CloudFront signed cookies para controlar o acesso ao arquivo
- D. Configurar AWS WAF para monitorar as requisições HTTP/HTTPS encaminhadas ao CloudFront

**Resposta: B**

**Explicação:**
Uma signed URL inclui informações adicionais como data/hora de expiração, dando mais controle sobre o acesso ao conteúdo. Como é um único arquivo a ser compartilhado, signed URL é a solução mais otimizada.

- C está errada: signed cookies são melhores quando se quer dar acesso a múltiplos arquivos (área de assinantes). Para um arquivo único, signed URL é mais adequada.
- A está errada: Field-Level Encryption protege campos específicos em formulários POST, não acesso a arquivos.
- D está errada: WAF controla requisições HTTP em geral, não restringe acesso a um arquivo específico.

---

## Pergunta 14 · Domínio: Deployment

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

## Pergunta 15 · Domínio: Development with AWS Services

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

## Pergunta 16 · Domínio: Deployment

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

## Pergunta 17 · Domínio: Deployment

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

## Pergunta 18 · Domínio: Troubleshooting and Optimization

A equipe de desenvolvimento de um varejista se prepara para a Black Friday e quer garantir que o backend serverless via Lambda não tenha gargalos de latência devido ao pico de tráfego.

**Qual solução você recomendaria?**

- A. Não é necessário nenhuma provisão especial, pois Lambda escala automaticamente por ser serverless
- B. Adicionar um Application Load Balancer na frente das funções Lambda
- C. Configurar Application Auto Scaling para gerenciar Lambda reserved concurrency por agendamento
- D. **Configurar Application Auto Scaling para gerenciar Lambda provisioned concurrency por agendamento** ✅

**Resposta: D**

**Explicação:**
O provisioned concurrency inicializa instâncias de execução previamente para que estejam prontas para responder imediatamente. Configurar Application Auto Scaling para gerenciar provisioned concurrency em antecipação ao pico elimina a latência de cold start durante o aumento de tráfego.

- C está errada: não é possível configurar Application Auto Scaling para gerenciar reserved concurrency por agendamento.
- B está errada: apenas adicionar um ALB não resolve o problema de cold start.
- A está errada: Lambda pode atingir limites de concorrência mesmo sendo serverless.

---

## Pergunta 19 · Domínio: Deployment

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

## Pergunta 20 · Domínio: Deployment

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

## Pergunta 21 · Domínio: Troubleshooting and Optimization

Um negócio hospeda seu site em instâncias EC2 com Auto Scaling. Usuários globais relatam tempos de carregamento lentos para conteúdo estático mesmo fora dos períodos de pico.

**Quais duas ações devem ser tomadas para melhorar a latência?** (Selecione duas)

- A. Migrar a aplicação para AWS Lambda
- B. Atualizar CPU e RAM disponíveis nas instâncias EC2
- C. **Configurar uma distribuição Amazon CloudFront para fazer cache do conteúdo estático com Amazon S3 como origin** ✅
- D. **Transferir o conteúdo estático das instâncias EC2 para Amazon S3** ✅
- E. Dobrar a desired capacity do Auto Scaling group

**Resposta: C, D**

**Explicação:**
Mover o conteúdo estático para S3 e distribuí-lo via CloudFront edge locations reduz a latência global, pois o conteúdo é entregue do edge mais próximo do usuário.

- B e E estão erradas: o problema ocorre mesmo fora dos picos — a causa raiz é latência de rede, não hardware ou capacidade.
- A está errada: conteúdo estático não pode ser armazenado no Lambda.

---

## Pergunta 22 · Domínio: Development with AWS Services

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

## Pergunta 23 · Domínio: Security

Funções Lambda em Java precisam receber e criptografar/descriptografar em runtime mais de 1MB de dados.

**Qual método é mais adequado?**

- A. Usar Envelope Encryption e armazenar como environment variable
- B. **Usar Envelope Encryption e referenciar os dados como arquivo dentro do código** ✅
- C. Usar KMS Encryption e armazenar como environment variable
- D. Usar KMS direct encryption e armazenar como arquivo

**Resposta: B**

**Explicação:**
O KMS direto aceita no máximo 4KB de dados. Lambda environment variables também têm limite de 4KB. Para criptografar 1MB, é necessário usar Envelope Encryption com o Encryption SDK, empacotando o arquivo criptografado com a função Lambda.

- A e C estão erradas: environment variables têm limite de 4KB.
- D está errada: KMS direct encryption aceita no máximo 4KB.

---

## Pergunta 24 · Domínio: Troubleshooting and Optimization

Uma aplicação serverless processa pedidos 24/7 via Lambda e se comunica com uma API HTTP externa para processamento de pagamentos. A equipe quer notificar o time de suporte em tempo quase real via SNS topic somente quando a taxa de erros da API externa exceder 5% das transações por hora.

**Qual opção é a mais eficiente?**

- A. Logar resultados no CloudWatch → usar CloudWatch Logs Insights → Lambda por agendamento para verificar e notificar
- B. Logar resultados no CloudWatch → usar CloudWatch Metric Filter → Lambda por agendamento para verificar e notificar
- C. Configurar CloudWatch metrics com detailed monitoring para as chamadas de API externas + CloudWatch alarm + SNS
- D. **Configurar e enviar custom metrics de alta resolução ao CloudWatch registrando falhas da API externa + CloudWatch alarm + SNS topic** ✅

**Resposta: D**

**Explicação:**
Custom metrics de alta resolução (até 1 segundo de granularidade) permitem monitoramento quase em tempo real. Um CloudWatch alarm pode monitorar a taxa de erros e acionar o SNS topic automaticamente quando o threshold for excedido.

- C está errada: detailed monitoring é para métricas padrão AWS, não para APIs externas.
- A e B estão erradas: Lambda por agendamento não monitora em tempo real e exige código customizado para calcular a taxa de erros.

---

## Pergunta 25 · Domínio: Security

Uma empresa quer compartilhar informações com um terceiro via API HTTP. Possui a API key necessária e a integração não deve impactar a performance da aplicação.

**Qual é a abordagem mais segura?**

- A. Manter as credenciais em uma variável local no código e usá-las em runtime
- B. Manter as credenciais em um arquivo criptografado no S3 e recuperar em runtime via AWS SDK
- C. Manter as credenciais em uma tabela criptografada no MySQL RDS e recuperar em runtime via AWS SDK
- D. **Manter as credenciais no AWS Secrets Manager e recuperar em runtime via AWS SDK** ✅

**Resposta: D**

**Explicação:**
Secrets Manager permite substituir credenciais hardcoded por chamadas de API para recuperar o segredo programaticamente. Também pode ser configurado para rotacionar automaticamente os segredos em um agendamento definido.

- A, B e C estão erradas: armazenar credenciais sensíveis no código, banco de dados ou arquivo flat é uma má prática de segurança.

---

## Pergunta 26 · Domínio: Development with AWS Services

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

## Pergunta 27 · Domínio: Deployment

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

## Pergunta 28 · Domínio: Troubleshooting and Optimization

O AWS X-Ray SDK foi incluído nas funções Lambda para registrar chamadas de saída. Ao verificar o console X-Ray, nenhum dado está disponível.

**Qual é a razão mais provável?**

- A. Alterar as regras do security group
- B. **Corrigir a IAM Role** ✅
- C. Habilitar X-Ray sampling
- D. X-Ray só funciona com Lambda aliases

**Resposta: B**

**Explicação:**
Para usar o X-Ray, a função Lambda precisa de permissões de escrita na IAM role: `xray:PutTraceSegments`, `xray:PutTelemetryRecords`, etc. A primeira coisa a verificar é se as permissões estão configuradas corretamente.

- C está errada: sampling controla a quantidade de dados registrados, mas se as permissões estiverem incorretas, sampling não ajudará.
- D está errada: X-Ray funciona com funções Lambda diretamente, não apenas com aliases.
- A está errada: permissões são concedidas via IAM role, não via security groups.

---

## Pergunta 29 · Domínio: Development with AWS Services

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

## Pergunta 30 · Domínio: Security

Um developer está analisando mecanismos de autenticação para um API Gateway conectado a uma função Lambda.

**Qual mecanismo NÃO pode ser usado para autenticação no API Gateway?**

- A. Lambda Authorizer
- B. Cognito User Pools
- C. **AWS Security Token Service (STS)** ✅
- D. Permissões e roles IAM padrão

**Resposta: C**

**Explicação:**
AWS STS gera credenciais temporárias para usuários IAM ou federados, mas não é um mecanismo de autenticação diretamente suportado pelo API Gateway. Os mecanismos suportados são: IAM roles e policies, Lambda Authorizers e Cognito User Pools.

---

## Pergunta 31 · Domínio: Deployment

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

## Pergunta 32 · Domínio: Development with AWS Services

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

## Pergunta 33 · Domínio: Development with AWS Services

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

## Pergunta 34 · Domínio: Troubleshooting and Optimization

Um bucket S3 tem access logging habilitado. O tamanho do bucket cresceu substancialmente, mas nenhum arquivo novo foi adicionado.

**Por que isso aconteceu?**

- A. Bucket policies errôneas para uploads em lote podem causar crescimento exponencial do bucket
- B. Object Encryption foi habilitado e cada objeto é armazenado duas vezes
- C. **O access logging do S3 está apontando para o mesmo bucket, causando o crescimento** ✅
- D. Um ataque DDoS no bucket pode ter aumentado o tamanho dos dados

**Resposta: C**

**Explicação:**
Quando o bucket de origem e o bucket de destino dos logs são o mesmo, logs adicionais são criados para os logs que estão sendo escritos. Isso cria um loop que aumenta drasticamente o tamanho do bucket.

---

## Pergunta 35 · Domínio: Development with AWS Services

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

## Pergunta 36 · Domínio: Development with AWS Services

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

## Pergunta 37 · Domínio: Development with AWS Services

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

## Pergunta 38 · Domínio: Troubleshooting and Optimization

Uma aplicação em instâncias EC2 processa mensagens de uma SQS queue. Às vezes, as mensagens não são processadas e resultam em erros. Essas mensagens precisam ser isoladas para processamento e troubleshooting adicionais.

**Qual opção vai ajudar?**

- A. Reduzir o VisibilityTimeout
- B. Aumentar o VisibilityTimeout
- C. Usar DeleteMessage
- D. **Implementar uma Dead-Letter Queue (DLQ)** ✅

**Resposta: D**

**Explicação:**
DLQs são usadas como destino para mensagens que não podem ser processadas com sucesso. Permitem isolar mensagens problemáticas para determinar por que o processamento não está funcionando.

- B está errada: aumentar VisibilityTimeout apenas previne que outros consumidores leiam a mensagem enquanto ela está sendo processada — não isola as mensagens com erro.
- C está errada: DeleteMessage remove a mensagem permanentemente, sem possibilidade de análise.
- A está errada: reduzir VisibilityTimeout fará com que mais consumidores recebam a mesma mensagem com falha.

---

## Pergunta 39 · Domínio: Troubleshooting and Optimization

Um Auto Scaling group está configurado com minimum=5, maximum=20 e desired=10. Uma das 10 instâncias foi reportada como unhealthy.

**Qual ação será tomada?**

- A. O ASG formatará o drive EBS raiz e executará o User Data novamente
- B. **O ASG terminará a instância EC2** ✅
- C. O ASG desanexará a instância do grupo e a deixará em execução
- D. O ASG manterá a instância em execução e reiniciará a aplicação

**Resposta: B**

**Explicação:**
O Auto Scaling realiza verificações periódicas de saúde nas instâncias. Quando encontra uma instância unhealthy, a termina e lança uma nova para manter o desired capacity.

---

## Pergunta 40 · Domínio: Troubleshooting and Optimization

Como developer associate, você foi contratado para criar uma REST API usando arquitetura serverless.

**Qual solução você escolheria?**

- A. Fargate com Lambda na frente
- B. Route 53 com EC2 como backend
- C. **API Gateway expondo funcionalidade Lambda** ✅
- D. ALB público com ECS em Amazon EC2

**Resposta: C**

**Explicação:**
API Gateway com Lambda são ambos serverless. O API Gateway pode expor a funcionalidade Lambda através de APIs RESTful — combinação perfeita para arquitetura serverless.

- A está errada: Lambda não manipula diretamente requisições REST; é o API Gateway que faz essa função.
- B e D estão erradas: EC2 e ECS em EC2 não são serverless.

---

## Pergunta 41 · Domínio: Development with AWS Services

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

## Pergunta 42 · Domínio: Development with AWS Services

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

## Pergunta 43 · Domínio: Development with AWS Services

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

## Pergunta 44 · Domínio: Development with AWS Services

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

## Pergunta 45 · Domínio: Troubleshooting and Optimization

Clientes de um CRM hospedado em EC2 com DynamoDB levantaram preocupações de privacidade sobre envio de dados pela internet pública.

**Qual solução otimizada você recomendaria para comunicação entre EC2 e DynamoDB sem usar a internet pública?**

- A. Criar um NAT Gateway para fornecer o canal de comunicação
- B. **Configurar VPC endpoints para DynamoDB para acesso interno sem usar a internet pública** ✅
- C. Criar um Internet Gateway para fornecer o canal de comunicação
- D. Usar uma VPN para rotear todo o tráfego DynamoDB pela infraestrutura corporativa

**Resposta: B**

**Explicação:**
VPC endpoints para DynamoDB roteia as requisições para um endpoint DynamoDB privado dentro da rede Amazon, sem acessar a internet pública. O nome do endpoint permanece o mesmo e nenhuma modificação nas aplicações é necessária.

- D está errada: usar VPN pode introduzir desafios de bandwidth e disponibilidade.
- A está errada: NAT Gateway é para conexão à internet de subnets privadas, não para comunicação interna AWS.
- C está errada: Internet Gateway implica uso da internet pública.

---

## Pergunta 46 · Domínio: Security

Um developer está definindo signers para criar signed URLs para distribuições Amazon CloudFront.

**Quais afirmações o developer deve considerar?** (Selecione duas)

- A. Tanto trusted key groups quanto CloudFront key pairs podem ser gerenciados usando CloudFront APIs
- B. É possível usar policies IAM para restringir o que o root user pode fazer com CloudFront key pairs
- C. **Quando você cria um signer, a public key fica com CloudFront e a private key é usada para assinar a URL** ✅
- D. CloudFront key pairs podem ser criados com qualquer conta que tenha permissões administrativas
- E. **Quando o root user gerencia CloudFront key pairs, você pode ter no máximo dois CloudFront key pairs ativos por conta AWS** ✅

**Resposta: C, E**

**Explicação:**
- C: cada signer usa sua private key para assinar a URL/cookie, e o CloudFront usa a public key para verificar a assinatura.
- E: com root user para CloudFront key pairs, o limite é 2 pares ativos por conta. Com CloudFront key groups, o limite é mais alto (até 4 grupos, com até 5 keys por grupo).
- B está errada: não é possível aplicar policies IAM ao root user.
- D está errada: CloudFront key pairs só podem ser criados pelo root user.
- A está errada: apenas trusted key groups podem ser gerenciados via CloudFront APIs; key pairs de root user requerem o Console.

---

## Pergunta 47 · Domínio: Development with AWS Services

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

## Pergunta 48 · Domínio: Security

Um app mobile de fotos permite que usuários criem conta, façam upload e recuperem fotos (500KB a 5MB) com menor overhead operacional.

**Como você projetaria a aplicação?**

- A. Cognito identity pools para criar IAM user por usuário + IAM auth no API Gateway + Lambda armazenando imagens em S3 com metadados no DynamoDB
- B. Cognito user pools + authorizer no API Gateway + Lambda armazenando imagens E metadados no DynamoDB
- C. Cognito identity pools + authorizer no API Gateway + Lambda armazenando imagens em S3 com S3 key no DynamoDB
- D. **Cognito user pools para gerenciar contas + authorizer Cognito User Pool no API Gateway + Lambda armazenando imagens em S3 com S3 key no DynamoDB** ✅

**Resposta: D**

**Explicação:**
Cognito User Pools gerencia autenticação e diretório de usuários. O authorizer Cognito User Pool no API Gateway controla o acesso. As imagens devem ser armazenadas no S3 (não no DynamoDB, que tem limite de 400KB por item) e os metadados + S3 keys no DynamoDB.

- A e C estão erradas: Identity Pools não são para gerenciar usuários nem para criar IAM users.
- B está errada: DynamoDB não pode armazenar imagens de 500KB a 5MB (limite de 400KB por item).

---

## Pergunta 49 · Domínio: Troubleshooting and Optimization

Qual é o número máximo de mensagens que podem ser armazenadas em uma SQS queue?

- A. 10.000.000
- B. 100.000
- C. 10.000
- D. **Sem limite** ✅

**Resposta: D**

**Explicação:**
Não há limite de mensagens para armazenamento em SQS. No entanto, mensagens "in-flight" (recebidas por um consumidor mas ainda não deletadas) têm um limite de aproximadamente 120.000. Lembre-se sempre de deletar as mensagens após processá-las.

---

## Pergunta 50 · Domínio: Development with AWS Services

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

## Pergunta 51 · Domínio: Troubleshooting and Optimization

Ao especificar parâmetros no CloudFormation, qual dos seguintes NÃO é um tipo de parâmetro válido?

- A. **DependentParameter** ✅
- B. CommaDelimitedList
- C. AWS::EC2::KeyPair::KeyName
- D. String

**Resposta: A**

**Explicação:**
`DependentParameter` não existe no CloudFormation. No CloudFormation, parâmetros são independentes entre si. Tipos válidos incluem: String, Number, List\<Number\>, CommaDelimitedList, AWS::EC2::KeyPair::KeyName, AWS::EC2::SecurityGroup::Id, AWS::EC2::Subnet::Id, AWS::EC2::VPC::Id, entre outros.

---

## Pergunta 52 · Domínio: Development with AWS Services

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

## Pergunta 53 · Domínio: Deployment

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

## Pergunta 54 · Domínio: Troubleshooting and Optimization

A equipe de desenvolvimento consegue acessar uma instância EC2 na subnet A, mas não consegue acessar uma instância na subnet B na mesma VPC.

**Quais logs podem ser usados para verificar se o tráfego está chegando à subnet B?**

- A. BGP logs
- B. VPN logs
- C. Subnet logs
- D. **VPC Flow Logs** ✅

**Resposta: D**

**Explicação:**
VPC Flow Logs captura informações sobre o tráfego IP para e de interfaces de rede na VPC. Os dados podem ser publicados no CloudWatch Logs ou S3 e permitem verificar se o tráfego está chegando a uma subnet ou interface específica.

- A, B e C estão erradas: não existem logs específicos de BGP, VPN ou subnet com esse nível de detalhe no contexto desta questão.

---

## Pergunta 55 · Domínio: Troubleshooting and Optimization

Ao fazer troubleshooting, um developer percebeu que uma instância EC2 não consegue se conectar à internet via Internet Gateway.

**Quais condições devem ser atendidas para a conectividade de internet?** (Selecione duas)

- A. A subnet foi configurada como pública e não tem acesso à internet
- B. A subnet da instância não está associada a nenhuma route table
- C. **A route table da subnet da instância deve ter uma rota para o Internet Gateway** ✅
- D. **Os NACLs associados à subnet devem ter regras para permitir tráfego de entrada e saída** ✅
- E. A subnet da instância está associada a múltiplas route tables com configurações conflitantes

**Resposta: C, D**

**Explicação:**
- C: a route table deve ter uma rota definida para o Internet Gateway para que o tráfego de internet seja roteado corretamente.
- D: NACLs são stateless — devem ter regras de entrada e saída (porta 80/443 para HTTP/HTTPS) para permitir o tráfego.
- B está errada: se não associada explicitamente, a subnet usa a route table principal do VPC.
- E está errada: uma subnet pode ser associada a apenas uma route table por vez.

---

## Pergunta 56 · Domínio: Development with AWS Services

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

## Pergunta 57 · Domínio: Development with AWS Services

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

## Pergunta 58 · Domínio: Development with AWS Services

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

## Pergunta 59 · Domínio: Deployment

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

## Pergunta 60 · Domínio: Development with AWS Services

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

## Pergunta 61 · Domínio: Development with AWS Services

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

## Pergunta 62 · Domínio: Security

Um developer quer armazenar e recuperar variáveis de forma segura (autenticação de API remota, URL e credenciais) em diferentes ambientes de uma aplicação implantada no ECS, com mínimas modificações no código.

**Qual seria a melhor abordagem?**

- A. Buscar variáveis de cada ambiente definindo autenticação e URL na task definition do ECS durante o processo de implantação
- B. Buscar variáveis do AWS KMS armazenando URL e credenciais como chaves únicas no KMS
- C. Buscar variáveis de um arquivo criptografado armazenado com a aplicação
- D. **Buscar variáveis e credenciais do AWS Systems Manager Parameter Store usando hierarquias de caminhos únicas por variável e por ambiente** ✅

**Resposta: D**

**Explicação:**
O SSM Parameter Store oferece armazenamento hierárquico seguro para dados de configuração e segredos. Caminhos hierárquicos (com `/`) permitem organizar parâmetros por ambiente (ex: `/prod/api/url`, `/dev/api/url`).

- A está errada: variáveis em task definitions são visíveis para qualquer usuário com acesso a `DescribeTaskDefinition` — não é seguro para credenciais.
- B está errada: KMS é um serviço de criptografia de chaves, não de armazenamento de chave-valor.
- C está errada: armazenar credenciais em arquivo com a aplicação não é uma boa prática de segurança.

---

## Pergunta 63 · Domínio: Development with AWS Services

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

## Pergunta 64 · Domínio: Development with AWS Services

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

## Pergunta 65 · Domínio: Troubleshooting and Optimization

A equipe de desenvolvimento de um app mobile de jogos sociais quer simplificar o processo de cadastro de usuários com uma solução totalmente gerenciada e escalável.

**Qual solução exigiria o MENOR esforço de desenvolvimento?**

- A. Criar uma solução customizada com EC2 e DynamoDB
- B. Usar Cognito Identity Pools para cadastro e gerenciamento de usuários
- C. Criar uma solução customizada com Lambda e DynamoDB
- D. **Usar Cognito User Pools para cadastro e gerenciamento de usuários** ✅

**Resposta: D**

**Explicação:**
Cognito User Pools é um diretório de usuários totalmente gerenciado pela AWS que fornece autenticação, autorização e gerenciamento de usuários out-of-the-box. Suporta sign-up/sign-in, MFA, verificação de email/telefone e integração com provedores de identidade de terceiros.

- B está errada: Cognito Identity Pools concedem credenciais temporárias AWS para acessar serviços, não gerenciam usuários.
- A e C estão erradas: soluções customizadas com EC2/Lambda + DynamoDB exigem muito mais esforço de desenvolvimento.