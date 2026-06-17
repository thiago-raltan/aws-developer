# Simulado Marek - Troubleshooting

## Parte 1: Provas 01, 02, 03

> **50 questoes** agrupadas por dominio -- Fonte: Provas Marek 01, 02, 03

---

## Pergunta 1 [P01] · Domínio: Troubleshooting and Optimization

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

## Pergunta 8 [P01] · Domínio: Troubleshooting and Optimization

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

## Pergunta 16 [P01] · Domínio: Troubleshooting and Optimization

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

## Pergunta 18 [P01] · Domínio: Troubleshooting and Optimization

Quais são **verdadeiras** sobre a configuração de **user data** do EC2? (Selecione duas)

- A. Com a instância em execução, é possível atualizar user data com credenciais root
- B. Por padrão, user data executa a cada reinicialização
- C. Por padrão, scripts de user data não têm privilégios root
- D. **Por padrão, scripts de user data são executados com privilégios root** ✅
- E. **Por padrão, user data executa apenas no primeiro boot** ✅

**Resposta: D, E**

---

## Pergunta 21 [P01] · Domínio: Troubleshooting and Optimization

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

## Pergunta 27 [P01] · Domínio: Troubleshooting and Optimization

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

## Pergunta 34 [P01] · Domínio: Troubleshooting and Optimization

A equipe de auditoria precisa de um relatório de **quando e quem realizou chamadas de API contra o SSM Parameter Store**.

**Qual opção pode ser usada?**

- A. **Usar AWS CloudTrail** ✅
- B. Usar o recurso List do SSM Parameter Store
- C. Usar SSM Parameter Store Access Logs no CloudWatch Logs
- D. Usar SSM Parameter Store Access Logs no S3

**Resposta: A**

---

## Pergunta 39 [P01] · Domínio: Troubleshooting and Optimization

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

## Pergunta 45 [P01] · Domínio: Troubleshooting and Optimization

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

## Pergunta 51 [P01] · Domínio: Troubleshooting and Optimization

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

## Pergunta 61 [P01] · Domínio: Troubleshooting and Optimization

Uma função Lambda requer **alta utilização de CPU**. Como reduzir o tempo médio de execução?

- A. Fazer deploy usando Lambda layers
- B. Fazer deploy em múltiplas AWS Regions
- C. **Fazer deploy com alocação de memória no valor máximo** ✅
- D. Fazer deploy com alocação de CPU no valor máximo

**Resposta: C**

**Explicação:**
Lambda aloca CPU em proporção à memória. Para maximizar CPU → maximizar memória (até 10.240 MB). Não existe parâmetro direto de CPU.

---

## Pergunta 65 [P01] · Domínio: Troubleshooting and Optimization

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

---

## Pergunta 1 [P02] · Domínio: Troubleshooting and Optimization

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

## Pergunta 3 [P02] · Domínio: Troubleshooting and Optimization

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

## Pergunta 4 [P02] · Domínio: Troubleshooting and Optimization

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

## Pergunta 5 [P02] · Domínio: Troubleshooting and Optimization

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

## Pergunta 6 [P02] · Domínio: Troubleshooting and Optimization

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

## Pergunta 8 [P02] · Domínio: Troubleshooting and Optimization

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

## Pergunta 11 [P02] · Domínio: Troubleshooting and Optimization

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

## Pergunta 12 [P02] · Domínio: Troubleshooting and Optimization

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

## Pergunta 18 [P02] · Domínio: Troubleshooting and Optimization

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

## Pergunta 21 [P02] · Domínio: Troubleshooting and Optimization

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

## Pergunta 24 [P02] · Domínio: Troubleshooting and Optimization

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

## Pergunta 28 [P02] · Domínio: Troubleshooting and Optimization

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

## Pergunta 34 [P02] · Domínio: Troubleshooting and Optimization

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

## Pergunta 38 [P02] · Domínio: Troubleshooting and Optimization

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

## Pergunta 39 [P02] · Domínio: Troubleshooting and Optimization

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

## Pergunta 40 [P02] · Domínio: Troubleshooting and Optimization

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

## Pergunta 45 [P02] · Domínio: Troubleshooting and Optimization

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

## Pergunta 49 [P02] · Domínio: Troubleshooting and Optimization

Qual é o número máximo de mensagens que podem ser armazenadas em uma SQS queue?

- A. 10.000.000
- B. 100.000
- C. 10.000
- D. **Sem limite** ✅

**Resposta: D**

**Explicação:**
Não há limite de mensagens para armazenamento em SQS. No entanto, mensagens "in-flight" (recebidas por um consumidor mas ainda não deletadas) têm um limite de aproximadamente 120.000. Lembre-se sempre de deletar as mensagens após processá-las.

---

## Pergunta 51 [P02] · Domínio: Troubleshooting and Optimization

Ao especificar parâmetros no CloudFormation, qual dos seguintes NÃO é um tipo de parâmetro válido?

- A. **DependentParameter** ✅
- B. CommaDelimitedList
- C. AWS::EC2::KeyPair::KeyName
- D. String

**Resposta: A**

**Explicação:**
`DependentParameter` não existe no CloudFormation. No CloudFormation, parâmetros são independentes entre si. Tipos válidos incluem: String, Number, List\<Number\>, CommaDelimitedList, AWS::EC2::KeyPair::KeyName, AWS::EC2::SecurityGroup::Id, AWS::EC2::Subnet::Id, AWS::EC2::VPC::Id, entre outros.

---

## Pergunta 54 [P02] · Domínio: Troubleshooting and Optimization

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

## Pergunta 55 [P02] · Domínio: Troubleshooting and Optimization

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

## Pergunta 65 [P02] · Domínio: Troubleshooting and Optimization

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

---

## Pergunta 6 [P03] · Domínio: Troubleshooting and Optimization

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

## Pergunta 7 [P03] · Domínio: Troubleshooting and Optimization

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

## Pergunta 8 [P03] · Domínio: Troubleshooting and Optimization

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

## Pergunta 12 [P03] · Domínio: Troubleshooting and Optimization

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

## Pergunta 17 [P03] · Domínio: Troubleshooting and Optimization

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

## Pergunta 19 [P03] · Domínio: Troubleshooting and Optimization

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

## Pergunta 20 [P03] · Domínio: Troubleshooting and Optimization

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

## Pergunta 25 [P03] · Domínio: Troubleshooting and Optimization

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

## Pergunta 26 [P03] · Domínio: Troubleshooting and Optimization

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

## Pergunta 27 [P03] · Domínio: Troubleshooting and Optimization

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

## Pergunta 30 [P03] · Domínio: Troubleshooting and Optimization

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

## Pergunta 36 [P03] · Domínio: Troubleshooting and Optimization

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

## Pergunta 39 [P03] · Domínio: Troubleshooting and Optimization

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

## Pergunta 48 [P03] · Domínio: Troubleshooting and Optimization

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

## Pergunta 50 [P03] · Domínio: Troubleshooting and Optimization

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

## Pergunta 61 [P03] · Domínio: Troubleshooting and Optimization

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
