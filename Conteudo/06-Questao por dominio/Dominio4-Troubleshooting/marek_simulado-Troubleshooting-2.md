# Simulado Marek - Troubleshooting

## Parte 2: Provas 04, 05, 06

> **56 questoes** agrupadas por dominio -- Fonte: Provas Marek 04, 05, 06

---

## Pergunta 2 [P04] · Domínio: Troubleshooting and Optimization

Sua empresa gerencia centenas de instâncias EC2 com Linux. Seu gerente solicitou coletar métricas de memória do sistema em todas as instâncias EC2 via script.

**Qual solução vai ajudar a coletar esses dados?**

- A. Extrair estatísticas de RAM das métricas padrão do CloudWatch para instâncias EC2
- B. Extrair estatísticas de RAM usando X-Ray
- C. Extrair estatísticas de RAM usando o instance metadata
- D. **Usar um cron job nas instâncias que envia estatísticas de RAM do EC2 como custom metric para o CloudWatch** ✅

**Resposta: D**

**Explicação:**
As métricas padrão do CloudWatch para EC2 não incluem utilização de memória. Os scripts de monitoramento do CloudWatch para instâncias Linux permitem publicar custom metrics de memória, swap e disco. Um cron schedule pode configurar o envio a cada X minutos.

- A está errada: métricas padrão do CloudWatch não incluem detalhes de memória.
- B está errada: X-Ray é para rastreamento de aplicações distribuídas, não para coleta de métricas de hardware.
- C está errada: o instance metadata fornece apenas o ID do RAM disk especificado no launch — não estatísticas de uso.

---

## Pergunta 3 [P04] · Domínio: Troubleshooting and Optimization

Uma empresa quer adicionar capacidades geoespaciais à camada de cache, junto com query capabilities e escalabilidade horizontal. A empresa usa Amazon RDS como tier de banco de dados.

**Qual solução é ótima para esse caso de uso?**

- A. **Usar as capacidades do ElastiCache para Redis com cluster mode habilitado** ✅
- B. Usar as capacidades do ElastiCache para Redis com cluster mode desabilitado
- C. Migrar para DynamoDB para usar o DAX integrado automaticamente com query capabilities
- D. Usar caching do CloudFront para atender às demandas de workloads crescentes

**Resposta: A**

**Explicação:**
Redis adicionou capacidades geoespaciais poderosas em versões mais recentes. O ElastiCache para Redis com cluster mode habilitado permite escalabilidade horizontal (adicionar/remover shards com impacto quase zero), suportando até 90 shards e centenas de terabytes de armazenamento.

- B está errada: cluster mode desabilitado permite apenas escalabilidade vertical — o caso de uso exige escalabilidade horizontal.
- C está errada: migração de banco de dados é um esforço muito maior do que otimizar a camada de cache.
- D está errada: CloudFront é CDN, não cache in-memory para performance de aplicação.

---

## Pergunta 4 [P04] · Domínio: Troubleshooting and Optimization

Um sistema de votação foi migrado de on-premises para AWS. Quando o estado de um recurso AWS muda, é gerado um evento que precisa acionar o Lambda. O recurso AWS que muda de estado não tem integração direta com o Lambda.

**Qual método pode ser usado para acionar o Lambda?**

- A. AWS Lambda Custom Sources
- B. Abrir um ticket de suporte com a AWS
- C. **Amazon EventBridge rules com AWS Lambda** ✅
- D. Cron jobs para acionar o Lambda verificar o estado do serviço

**Resposta: C**

**Explicação:**
O EventBridge permite criar rules para executar Lambda em um agendamento fixo, expressão Cron, ou em resposta a mudanças de estado de serviços AWS — mesmo sem integração direta.

- A está errada: "Lambda Custom Sources" é uma opção inventada.
- D está errada: cron jobs exigem um servidor adicional; EventBridge é a solução nativa.

---

## Pergunta 28 [P04] · Domínio: Troubleshooting and Optimization

Uma função Lambda Python estabelece uma conexão com banco de dados RDS MySQL dentro do handler. Na primeira execução leva 2s, nas execuções seguintes leva 1.9s.

**O que pode ser feito para melhorar o tempo de execução?**

- A. Atualizar o tipo de instância do MySQL
- B. Aumentar a RAM da função Lambda
- C. Mudar o runtime para Node.js
- D. **Mover a conexão de banco de dados para fora do handler** ✅

**Resposta: D**

**Explicação:**
A cada execução, a conexão é criada e depois fechada — operações custosas em tempo. Movendo `mysql = mysqlclient.connect()` para fora do handler (escopo do módulo), a conexão é criada uma vez e reutilizada entre invocações (enquanto o execution context estiver ativo).

```python
mysql = mysqlclient.connect()

def handler(event, context):
    data = event['data']
    mysql.execute(f"INSERT INTO foo (bar) VALUES ({data});")
    return
```

- A está errada: o gargalo é a criação do objeto de conexão, não o MySQL em si.
- C está errada: mudar o runtime não melhorará a performance.
- B está errada: aumentar RAM pode ajudar em problemas de CPU/memória, mas não no tempo de criação de conexão.

---

## Pergunta 35 [P04] · Domínio: Troubleshooting and Optimization

Um site serve conteúdo estático de um bucket S3 e conteúdo dinâmico de um ALB. A base de usuários é global e a latência deve ser minimizada.

**Qual tecnologia/serviço pode ajudar com latência baixa para conteúdo estático e dinâmico?**

- A. Usar Global Accelerator para alternar transparentemente entre S3 e load balancer
- B. **Configurar CloudFront com múltiplas origins para servir conteúdo estático e dinâmico com baixa latência** ✅
- C. Usar CloudFront Origin Groups para agrupar requisições estáticas e dinâmicas
- D. Usar Lambda@Edge do CloudFront para servir dados do S3 e load balancer

**Resposta: B**

**Explicação:**
Uma única distribuição CloudFront pode ser configurada com múltiplas origins (S3 para conteúdo estático e ALB para dinâmico), servindo ambos via edge locations globais com baixa latência.

- A está errada: Global Accelerator melhora o caminho de rede, mas não faz cache de conteúdo — menos eficiente para conteúdo estático.
- C está errada: Origin Groups são para failover de origin, não para roteamento de tipos de conteúdo.
- D está errada: Lambda@Edge é para computação no edge, não para servir diretamente dados de S3/ALB.

---

## Pergunta 38 [P04] · Domínio: Troubleshooting and Optimization

Uma empresa armazena informações sobre times esportivos em uma tabela DynamoDB com 10 milhões de registros. Todos os registros devem ser deletados e recarregados às 2:00 AM diariamente.

**Qual opção é eficiente com custo mínimo?**

- A. Scan e chamar DeleteItem
- B. **Deletar e recriar a tabela** ✅
- C. Chamar PurgeTable
- D. Scan e chamar BatchDeleteItem

**Resposta: B**

**Explicação:**
`DeleteTable` é o método mais eficiente — deleta a tabela e todos os seus itens em uma única operação. Scan + DeleteItem ou Scan + BatchDeleteItem seriam muito lentos para 10 milhões de itens.

- C está errada: `PurgeTable` não existe no DynamoDB.
- A e D estão erradas: Scan em 10 milhões de itens é uma operação lenta e cara.

---

## Pergunta 45 [P04] · Domínio: Troubleshooting and Optimization

Um projeto tem mais de 100 dependências Java. Toda vez que o CodeBuild executa um build, ele precisa resolver dependências de repositórios externos, o que demora muito.

**O que vai ajudar a acelerar esse processo com o mínimo de esforço?**

- A. Reduzir o número de dependências
- B. **Fazer cache das dependências no S3** ✅
- C. Usar instâncias EC2 de Instance Store para facilitar cache interno de dependências
- D. Incluir todas as dependências como parte do código-fonte

**Resposta: B**

**Explicação:**
O CodeBuild suporta cache de dependências em S3. Como dependências raramente mudam entre builds, armazená-las em cache reduz significativamente o tempo de download.

- A está errada: pode não ser possível controlar o número de dependências.
- D está errada: incluir dependências no código aumenta o tamanho do repositório e não é uma boa prática.
- C está errada: Instance Store é armazenamento temporário de bloco — não pode ser usado para cache de dependências do CodeBuild.

---

## Pergunta 47 [P04] · Domínio: Troubleshooting and Optimization

Um usuário tem uma IAM policy que concede `ReceiveMessage` na `example_queue` e uma SQS policy que concede `SendMessage` na mesma queue.

**Quais afirmações estão corretas?** (Selecione duas)

- A. **O usuário pode enviar uma requisição ReceiveMessage para example_queue — a IAM policy permite essa ação** ✅
- B. Adicionar apenas uma IAM policy de deny não é suficiente — a SQS policy também deve negar explicitamente
- C. Se o usuário enviar uma requisição SendMessage, a IAM policy negará essa ação
- D. Apenas IAM policies ou SQS policies devem ser usadas — não ambas juntas
- E. **Se você adicionar uma policy que nega acesso a todas as ações na queue, essa policy vai sobrescrever as outras duas e o usuário não terá acesso** ✅

**Resposta: A, E**

**Explicação:**
- A: a IAM policy concede `ReceiveMessage` — o usuário pode realizar essa ação.
- E: um Explicit Deny sempre sobrescreve qualquer Allow, independentemente de qual policy (IAM ou SQS) concede a permissão.
- B está errada: um Explicit Deny em **qualquer** uma das policies é suficiente para bloquear o acesso.
- C está errada: se o usuário enviar `SendMessage`, a SQS policy permite — a IAM policy não tem deny explícito, então não interfere.
- D está errada: IAM policies e SQS policies podem ser usadas em conjunto.

---

## Pergunta 48 [P04] · Domínio: Troubleshooting and Optimization

Uma empresa tem instâncias EC2 Linux que geram vários arquivos de log para análise. Quer usar Kinesis Data Streams (KDS) para analisar esses dados.

**Qual é a forma mais otimizada de enviar dados de log das instâncias para o KDS?**

- A. Usar KPL (Kinesis Producer Library) para coletar e ingerir dados de cada instância EC2
- B. Executar cron job em cada instância para coletar logs e enviar ao KDS
- C. Instalar o AWS SDK em cada instância e configurá-lo para enviar arquivos ao KDS
- D. **Instalar e configurar o Kinesis Agent em cada instância** ✅

**Resposta: D**

**Explicação:**
O Kinesis Agent é uma aplicação Java standalone que monitora continuamente arquivos especificados e envia novos dados ao KDS. Gerencia automaticamente rotação de arquivos, checkpointing e retentativas em caso de falha — sem código customizado.

- B e C estão erradas: exigem código customizado para rastrear alterações em arquivos e lidar com falhas.
- A está errada: KPL é uma biblioteca para envio de dados, não projetada especificamente para monitorar arquivos de log.

---

## Pergunta 51 [P04] · Domínio: Troubleshooting and Optimization

Um gerente solicitou que todo o código de funções Lambda para controle de salas seja monitorado para taxas de erro com possibilidade de criar alarmes.

**Quais opções devem ser escolhidas?** (Selecione duas)

- A. **CloudWatch Metrics** ✅
- B. CloudTrail
- C. X-Ray
- D. **CloudWatch Alarms** ✅
- E. SSM

**Resposta: A, D**

**Explicação:**
- CloudWatch Metrics: coleta métricas das funções Lambda (invocações, erros, duração, throttles). Dados retidos por até 15 meses.
- CloudWatch Alarms: monitora uma métrica ao longo do tempo e realiza ações (notificação SNS, scaling) quando um threshold é excedido.
- B está errada: CloudTrail registra chamadas de API (auditoria), não métricas de performance.
- C está errada: X-Ray é para rastreamento distributed (latência, análise de microsserviços), não para métricas de error rate simples.
- E está errada: SSM (Systems Manager) é para gerenciamento de infraestrutura, não para métricas de aplicação.

---

## Pergunta 54 [P04] · Domínio: Troubleshooting and Optimization

Uma empresa usa blue/green deployment — um novo ALB é provisionado para cada nova versão da aplicação. Os usuários precisam fazer login novamente após cada deploy.

**O que você recomendaria para resolver esse problema?**

- A. Usar multicast para replicar informações de sessão
- B. **Usar ElastiCache para manter sessões de usuários** ✅
- C. Habilitar sticky sessions no ALB
- D. Usar rolling updates em vez de blue/green deployment

**Resposta: B**

**Explicação:**
Armazenar as sessões em um cache externo como ElastiCache (Redis ou Memcached) desacopla as sessões das instâncias EC2. Assim, qualquer instância (nova ou antiga) pode acessar a sessão de qualquer usuário.

- C está errada: como o próprio ALB é substituído em cada deploy blue/green, sticky sessions no ALB não funcionam.
- D está errada: rolling updates também podem causar interrupção de sessão quando instâncias são removidas do batch.
- A está errada: multicast não é uma solução prática no AWS.

---

## Pergunta 56 [P04] · Domínio: Troubleshooting and Optimization

Após revisar a fatura mensal, você percebe que o custo do SQS aumentou substancialmente. As queues têm pouco tráfego e os clientes estão recebendo respostas vazias.

**Qual ação você deve tomar?**

- A. Aumentar o VisibilityTimeout
- B. Usar uma FIFO queue
- C. **Usar LongPolling** ✅
- D. Diminuir DelaySeconds

**Resposta: C**

**Explicação:**
Long polling faz com que o SQS envie uma resposta somente depois de coletar pelo menos uma mensagem disponível, ou quando o tempo de espera expira. Isso elimina respostas vazias (short polling envia resposta imediatamente mesmo sem mensagens) — reduzindo custos.

- A está errada: VisibilityTimeout evita que outros consumidores leiam uma mensagem já recebida — não ajuda com respostas vazias.
- B está errada: FIFO queues são mais caras que standard queues e não resolvem o problema de respostas vazias.
- D está errada: DelaySeconds atrasa a entrega de novas mensagens — não reduz respostas vazias.

---

## Pergunta 57 [P04] · Domínio: Troubleshooting and Optimization

Uma aplicação usa Scan operations em uma tabela DynamoDB de 25 GB. Não é possível criar indexes para recuperar os itens de forma previsível. Os desenvolvedores querem os resultados o mais rápido possível.

**Qual opção pode melhorar a performance do Scan?**

- A. Usar FilterExpression
- B. **Usar parallel scans** ✅
- C. Usar ProjectionExpression
- D. Usar Query

**Resposta: B**

**Explicação:**
Parallel scans permitem dividir logicamente uma tabela ou índice em múltiplos segmentos, com vários workers escaneando em paralelo. Isso reduz drasticamente o tempo de Scan para tabelas grandes.

- A está errada: FilterExpression filtra os resultados **após** o Scan — consome a mesma capacidade de leitura.
- C está errada: ProjectionExpression especifica quais atributos retornar, reduzindo o payload mas não a velocidade do Scan.
- D está errada: o enunciado diz que não é possível criar indexes — Query requer um index.

---

## Pergunta 61 [P04] · Domínio: Troubleshooting and Optimization

Um sistema de gerenciamento de pedidos usa um cron job para verificar novos pedidos e envia-os como mensagens para filas de mensagens para processamento downstream. A empresa quer migrar para AWS cloud com solução mais otimizada.

**Qual é a solução mais otimizada?**

- A. Usar SNS para enviar notificações e funções Lambda para processar as informações
- B. **Usar SNS para enviar notificações quando um pedido é criado. Configurar diferentes SQS queues para receber essas mensagens para processamento downstream** ✅
- C. Configurar diferentes SQS queues para fazer poll de novos pedidos
- D. Usar SNS para enviar notificações para streams do Kinesis Data Firehose

**Resposta: B**

**Explicação:**
O padrão SNS + SQS (fan-out): SNS distribui a mensagem simultaneamente para múltiplas SQS queues (cada uma para um serviço de processamento diferente). SQS armazena as mensagens para processamento assíncrono e confiável, com suporte a DLQ.

- C está errada: SQS não pode fazer poll de pedidos — as mensagens precisam ser enviadas para a fila.
- A está errada: Lambda não tem capacidade de armazenar mensagens para reprocessamento posterior.
- D está errada: Kinesis Firehose é para ingestão de grandes volumes de dados em tempo real — SQS é mais adequado para desacoplamento.

---

## Pergunta 2 [P05] · Domínio: Troubleshooting and Optimization

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

## Pergunta 9 [P05] · Domínio: Troubleshooting and Optimization

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

## Pergunta 11 [P05] · Domínio: Troubleshooting and Optimization

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

## Pergunta 14 [P05] · Domínio: Troubleshooting and Optimization

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

## Pergunta 17 [P05] · Domínio: Troubleshooting and Optimization

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

## Pergunta 19 [P05] · Domínio: Troubleshooting and Optimization

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

## Pergunta 20 [P05] · Domínio: Troubleshooting and Optimization

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

## Pergunta 22 [P05] · Domínio: Troubleshooting and Optimization

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

## Pergunta 25 [P05] · Domínio: Troubleshooting and Optimization

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

## Pergunta 28 [P05] · Domínio: Troubleshooting and Optimization

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

## Pergunta 29 [P05] · Domínio: Troubleshooting and Optimization

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

## Pergunta 41 [P05] · Domínio: Troubleshooting and Optimization

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

## Pergunta 43 [P05] · Domínio: Troubleshooting and Optimization

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

## Pergunta 45 [P05] · Domínio: Troubleshooting and Optimization

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

## Pergunta 55 [P05] · Domínio: Troubleshooting and Optimization

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

## Pergunta 59 [P05] · Domínio: Troubleshooting and Optimization

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

## Pergunta 60 [P05] · Domínio: Troubleshooting and Optimization

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

## Pergunta 63 [P05] · Domínio: Troubleshooting and Optimization

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

## Pergunta 1 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 6 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 8 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 9 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 16 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 21 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 22 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 29 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 31 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 32 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 35 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 39 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 40 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 42 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 44 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 45 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 47 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 49 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 50 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 52 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 58 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 60 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 62 [P06] · Domínio: Troubleshooting and Optimization

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

## Pergunta 63 [P06] · Domínio: Troubleshooting and Optimization

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
