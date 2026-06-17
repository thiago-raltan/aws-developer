# Prova Marek 04 — AWS Certified Developer Associate

> **65 questões** | Domínios: Development with AWS Services · Security · Deployment · Troubleshooting and Optimization

---

## Pergunta 1 · Domínio: Development with AWS Services

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

## Pergunta 2 · Domínio: Troubleshooting and Optimization

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

## Pergunta 3 · Domínio: Troubleshooting and Optimization

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

## Pergunta 4 · Domínio: Troubleshooting and Optimization

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

## Pergunta 5 · Domínio: Development with AWS Services

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

## Pergunta 6 · Domínio: Security

Uma equipe de desenvolvimento usa o AWS SDK for Java para fazer upload de objetos para buckets S3 usando SSE-KMS. Os developers recebem erros de permissão ao tentar fazer push via HTTP.

**Qual header devem incluir na requisição?**

- A. `'x-amz-server-side-encryption': 'SSE-S3'`
- B. **`'x-amz-server-side-encryption': 'aws:kms'`** ✅
- C. `'x-amz-server-side-encryption': 'SSE-KMS'`
- D. `'x-amz-server-side-encryption': 'AES256'`

**Resposta: B**

**Explicação:**
Para SSE-KMS, o header correto é `'x-amz-server-side-encryption': 'aws:kms'`. Se a requisição não incluir esse header quando a bucket policy exige SSE-KMS, ela é negada.

- A e C estão erradas: `SSE-S3` e `SSE-KMS` não são valores válidos para esse header.
- D está errada: `AES256` é o valor correto para SSE-S3, não SSE-KMS.

---

## Pergunta 7 · Domínio: Development with AWS Services

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

## Pergunta 8 · Domínio: Development with AWS Services

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

## Pergunta 9 · Domínio: Security

Uma aplicação web em EC2 usa credenciais IAM hardcoded no código para acessar serviços AWS. A equipe de segurança quer uma solução mais segura com credenciais temporárias.

**Qual opção resolve o caso de uso?**

- A. **Usar uma IAM Instance Role** ✅
- B. Usar variáveis de ambiente
- C. Usar o SSM Parameter Store
- D. Hardcode as credenciais no código da aplicação

**Resposta: A**

**Explicação:**
Uma IAM Instance Role (instance profile) permite que o AWS SDK use o EC2 metadata service para obter credenciais temporárias automaticamente. É a solução mais segura e comum para aplicações em EC2.

- B está errada: variáveis de ambiente com access key/secret não são temporárias e exigem atualização manual em cada instância.
- C está errada: o Parameter Store requer o SDK para ser acessado, e sem credenciais você não consegue autenticar.
- D está errada: hardcoding é explicitamente uma má prática de segurança.

---

## Pergunta 10 · Domínio: Deployment

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

## Pergunta 11 · Domínio: Security

Novos objetos enviados ao S3 devem ser criptografados usando SSE-S3 no momento do upload.

**Qual header os desenvolvedores devem adicionar à requisição?**

- A. `'x-amz-server-side-encryption': 'SSE-KMS'`
- B. **`'x-amz-server-side-encryption': 'AES256'`** ✅
- C. `'x-amz-server-side-encryption': 'SSE-S3'`
- D. `'x-amz-server-side-encryption': 'aws:kms'`

**Resposta: B**

**Explicação:**
Para SSE-S3 (Server-Side Encryption com chaves gerenciadas pelo S3), o valor correto do header é `AES256` — referindo-se ao algoritmo AES-256 usado pelo S3.

- A e C estão erradas: `SSE-KMS` e `SSE-S3` não são valores válidos para o header.
- D está errada: `aws:kms` é o valor correto para SSE-KMS.

---

## Pergunta 12 · Domínio: Security

Uma organização precisa armazenar strings secretas criptografadas usadas em uma aplicação, garantindo que eventos de descriptografia sejam auditados e as chamadas de API sejam simples.

**Como isso pode ser alcançado?** (Selecione duas)

- A. **Armazenar o segredo como SecureString no SSM Parameter Store** ✅
- B. **Auditar usando CloudTrail** ✅
- C. Armazenar o segredo como PlainText no SSM Parameter Store
- D. Auditar usando SSM Audit Trail
- E. Criptografar primeiro com KMS e depois armazenar no SSM Parameter Store

**Resposta: A, B**

**Explicação:**
- A: SecureString no SSM Parameter Store usa KMS para criptografia. Uma única chamada de API recupera o valor descriptografado.
- B: CloudTrail registra todas as chamadas de API ao SSM e KMS, permitindo auditoria dos eventos de descriptografia.
- C está errada: PlainText não é seguro para armazenar segredos.
- D está errada: "SSM Audit Trail" não existe — é uma opção inventada.
- E está errada: criptografar com KMS e depois armazenar exigiria duas chamadas de API para recuperar o valor descriptografado.

---

## Pergunta 13 · Domínio: Deployment

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

## Pergunta 14 · Domínio: Security

Uma aplicação em instâncias EC2 precisa fazer upload de arquivos para o S3 e gerar S3 Signed URLs para enviar PDFs por email.

**Qual opção concede as permissões corretas para as instâncias EC2?**

- A. Executar `aws configure` na instância EC2
- B. EC2 User Data
- C. CloudFormation
- D. **Criar uma IAM Role para EC2** ✅

**Resposta: D**

**Explicação:**
Uma IAM Role para EC2 (instance profile) permite que as instâncias façam chamadas seguras de API sem precisar distribuir credenciais AWS. A role fornece credenciais temporárias automaticamente via EC2 metadata service.

- A está errada: `aws configure` requereria armazenar access key/secret na instância — não ideal.
- B está errada: User Data é usado para inicializar a instância, não é adequado para armazenar credenciais.
- C está errada: CloudFormation é para provisionamento de infraestrutura, não para gerenciar credenciais de aplicação.

---

## Pergunta 15 · Domínio: Development with AWS Services

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

## Pergunta 16 · Domínio: Deployment

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

## Pergunta 17 · Domínio: Deployment

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

## Pergunta 18 · Domínio: Development with AWS Services

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

## Pergunta 19 · Domínio: Development with AWS Services

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

## Pergunta 20 · Domínio: Development with AWS Services

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

## Pergunta 21 · Domínio: Security

Uma empresa quer migrar código de um repositório GitHub para o AWS CodeCommit via HTTPS.

**O que você recomendaria para autenticação?**

- A. Usar secret access key e access key ID de um usuário IAM
- B. Usar IAM Multi-Factor Authentication
- C. Usar autenticação com GitHub secure tokens
- D. **Usar credenciais Git geradas pelo IAM** ✅

**Resposta: D**

**Explicação:**
A forma mais simples de configurar conexões HTTPS com repositórios CodeCommit é configurar credenciais Git para CodeCommit no console IAM. Essas credenciais estáticas (usuário/senha) funcionam com qualquer ferramenta que suporte autenticação HTTPS.

- A está errada: access keys são para autenticação programática ao AWS CLI/API, não para Git.
- B está errada: MFA não é um mecanismo de autenticação Git.
- C está errada: tokens do GitHub são específicos do GitHub.

---

## Pergunta 22 · Domínio: Deployment

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

## Pergunta 23 · Domínio: Security

Uma equipe de desenvolvimento armazena dados sensíveis de clientes no S3 com criptografia em repouso. As encryption keys devem ser rotacionadas pelo menos anualmente.

**Qual é a forma mais fácil de implementar isso?**

- A. Criptografar os dados antes de enviá-los ao S3
- B. Importar uma custom key no KMS e automatizar a rotação anual com uma função Lambda
- C. **Usar AWS KMS com rotação automática de chaves** ✅
- D. Usar SSE-C com rotação automática de chaves

**Resposta: C**

**Explicação:**
Ao usar SSE-KMS, você pode habilitar a rotação automática de chaves a cada ano no KMS. O AWS KMS cuida da rotação automaticamente para CMKs geradas dentro do HSM do KMS.

- B está errada: chaves importadas não suportam rotação automática; automatizar via Lambda é mais complexo.
- D está errada: SSE-C não tem rotação automática — você é responsável por gerenciar e rotacionar as chaves manualmente.
- A está errada: client-side encryption exige que você gerencie o processo de rotação de chaves manualmente.

---

## Pergunta 24 · Domínio: Development with AWS Services

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

## Pergunta 25 · Domínio: Deployment

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

## Pergunta 26 · Domínio: Deployment

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

## Pergunta 27 · Domínio: Security

Para garantir que todas as comunicações com o S3 sejam criptografadas, qual mecanismo de criptografia **rejeitará** a requisição se a conexão não usar HTTPS?

- A. SSE-KMS
- B. SSE-S3
- C. Client Side Encryption
- D. **SSE-C** ✅

**Resposta: D**

**Explicação:**
Com SSE-C (Server-Side Encryption with Customer-Provided Keys), o Amazon S3 rejeita qualquer requisição feita via HTTP. Como você fornece a chave na requisição, o S3 exige HTTPS para proteger essa chave em trânsito.

- A e B estão erradas: SSE-KMS e SSE-S3 não exigem HTTPS obrigatoriamente.
- C está errada: Client-Side Encryption também não exige HTTPS (a criptografia já foi feita antes do envio).

---

## Pergunta 28 · Domínio: Troubleshooting and Optimization

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

## Pergunta 29 · Domínio: Security

Developers estão recebendo o erro: `You are not authorized to perform this operation. Encoded authorization failure message: 6h34Gt...`

**Qual das seguintes ações vai ajudar a decodificar a mensagem?**

- A. `AWS IAM decode-authorization-message`
- B. **`AWS STS decode-authorization-message`** ✅
- C. Usar `KMS decode-authorization-message`
- D. AWS Cognito Decoder

**Resposta: B**

**Explicação:**
`aws sts decode-authorization-message` decodifica a mensagem de status de autorização codificada. O usuário precisa ter permissão `sts:DecodeAuthorizationMessage` via IAM policy.

- A, C e D estão erradas: IAM, KMS e Cognito não possuem esse comando — são opções inventadas.

---

## Pergunta 30 · Domínio: Development with AWS Services

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

## Pergunta 31 · Domínio: Development with AWS Services

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

## Pergunta 32 · Domínio: Deployment

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

## Pergunta 33 · Domínio: Security

Seu site armazena conteúdo estático em um bucket S3 separado dos vídeos em outro bucket. Os usuários conseguem visualizar os vídeos acessando as URLs diretamente, mas não conseguem reproduzir os vídeos ao visitar o site principal.

**Qual é a causa raiz?**

- A. Desabilitar Server-Side Encryption
- B. **Habilitar CORS** ✅
- C. Alterar a IAM policy
- D. Alterar a bucket policy

**Resposta: B**

**Explicação:**
Cross-Origin Resource Sharing (CORS) permite que aplicações web carregadas em um domínio interajam com recursos em um domínio diferente. O site principal (bucket A) tentando reproduzir vídeos do bucket B é uma requisição cross-origin — que é bloqueada sem configuração de CORS.

- A está errada: o vídeo é acessível diretamente via URL, então a criptografia não é o problema.
- C e D estão erradas: o problema é de política cross-origin, não de permissões IAM ou bucket policy.

---

## Pergunta 34 · Domínio: Deployment

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

## Pergunta 35 · Domínio: Troubleshooting and Optimization

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

## Pergunta 36 · Domínio: Security

Um provedor de educação global executa um LMS em instâncias EC2 atrás de um ALB, com domínio no Route 53. A aplicação depende muito de assets estáticos. O provedor quer melhorar a performance global com o mínimo de overhead operacional.

**Qual solução melhora a performance global com o menor esforço?**

- A. Habilitar S3 Transfer Acceleration e mover assets estáticos para o S3; atualizar a aplicação
- B. **Criar uma distribuição Amazon CloudFront com o ALB como origin e apontar o Route 53 alias para o domínio CloudFront** ✅
- C. Implantar a aplicação em múltiplas Regions e usar Route 53 latency-based routing
- D. Colocar AWS Global Accelerator na frente do ALB e atualizar o Route 53

**Resposta: B**

**Explicação:**
CloudFront coloca um CDN na frente do ALB, servindo conteúdo das edge locations mais próximas dos usuários. Suporta nativamente ALB como origin e é projetado para acelerar tanto conteúdo estático quanto dinâmico globalmente — com baixo overhead operacional.

- C está errada: operar uma aplicação multi-região tem overhead operacional muito maior.
- D está errada: Global Accelerator não faz cache — menos eficiente para conteúdo estático.
- A está errada: Transfer Acceleration acelera uploads/downloads para S3, mas não acelera respostas dinâmicas do ALB.

---

## Pergunta 37 · Domínio: Deployment

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

## Pergunta 38 · Domínio: Troubleshooting and Optimization

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

## Pergunta 39 · Domínio: Development with AWS Services

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

## Pergunta 40 · Domínio: Deployment

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

## Pergunta 41 · Domínio: Security

Você quer garantir conexões end-to-end usando HTTPS no CloudFront para proteger o conteúdo.

**Qual opção está disponível para HTTPS no CloudFront?**

- A. Nem entre clientes/CloudFront nem entre CloudFront/backend
- B. Apenas entre clientes e CloudFront
- C. **Entre clientes e CloudFront, assim como entre CloudFront e backend** ✅
- D. Apenas entre CloudFront e backend

**Resposta: C**

**Explicação:**
O CloudFront suporta HTTPS em ambas as direções: você pode exigir HTTPS entre viewers (clientes) e o CloudFront, e também entre o CloudFront e sua origin (custom origin ou S3).

---

## Pergunta 42 · Domínio: Development with AWS Services

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

## Pergunta 43 · Domínio: Development with AWS Services

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

## Pergunta 44 · Domínio: Deployment

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

## Pergunta 45 · Domínio: Troubleshooting and Optimization

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

## Pergunta 46 · Domínio: Development with AWS Services

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

## Pergunta 47 · Domínio: Troubleshooting and Optimization

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

## Pergunta 48 · Domínio: Troubleshooting and Optimization

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

## Pergunta 49 · Domínio: Deployment

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

## Pergunta 50 · Domínio: Security

Uma aplicação web em EC2 precisa de acesso de leitura a uma tabela DynamoDB.

**Qual é a solução de melhor prática?**

- A. Criar um novo IAM user com access keys, política inline de leitura no DynamoDB e colocar as chaves no código
- B. **Criar uma IAM role com a policy `AmazonDynamoDBReadOnlyAccess` e aplicá-la ao EC2 instance profile** ✅
- C. Criar um IAM user com acesso Administrator e configurar as credenciais AWS nessa instância EC2
- D. Executar o código da aplicação com credenciais do root user da conta AWS

**Resposta: B**

**Explicação:**
Como melhor prática de segurança, não crie IAM users e distribua credenciais para aplicações. Em vez disso, crie uma IAM role e anexe-a à instância EC2 como instance profile. A aplicação recebe credenciais temporárias automaticamente.

- A, C e D estão erradas: armazenar ou usar credenciais de longo prazo (especialmente admin ou root) é perigoso e viola as melhores práticas de segurança.

---

## Pergunta 51 · Domínio: Troubleshooting and Optimization

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

## Pergunta 52 · Domínio: Development with AWS Services

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

## Pergunta 53 · Domínio: Security

Uma empresa criou um log group no CloudWatch Logs há 3 meses. Agora precisa criptografar os dados de log usando uma CMK do KMS, para que dados futuros sejam criptografados.

**Como a empresa deve resolver isso?**

- A. Usar o AWS CLI `create-log-group` e especificar o ARN da KMS key
- B. Usar o AWS CLI `describe-log-groups` e especificar o ARN da KMS key
- C. **Usar o AWS CLI `associate-kms-key` e especificar o ARN da KMS key** ✅
- D. Habilitar o recurso de encrypt no log group via console do CloudWatch Logs

**Resposta: C**

**Explicação:**
Para associar uma CMK a um log group **existente**, use o comando `associate-kms-key`. Após a associação, todos os dados recém-ingeridos nesse log group serão criptografados com a CMK.

- A está errada: `create-log-group` cria um novo log group — o grupo já existe.
- B está errada: `describe-log-groups` é para verificar se um log group já tem uma CMK associada.
- D está errada: o console do CloudWatch Logs não tem opção para habilitar criptografia em log groups existentes.

---

## Pergunta 54 · Domínio: Troubleshooting and Optimization

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

## Pergunta 55 · Domínio: Development with AWS Services

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

## Pergunta 56 · Domínio: Troubleshooting and Optimization

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

## Pergunta 57 · Domínio: Troubleshooting and Optimization

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

## Pergunta 58 · Domínio: Development with AWS Services

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

## Pergunta 59 · Domínio: Development with AWS Services

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

## Pergunta 60 · Domínio: Security

Uma empresa começou a usar CodeCommit. A equipe de compliance quer garantir que o código-fonte seja criptografado em trânsito e em repouso.

**Como a organização garante isso?**

- A. Usar um git hook para criptografar o código do lado do cliente
- B. Usar Lambda como hook para criptografar o código
- C. Habilitar KMS encryption
- D. **Repositórios são automaticamente criptografados em repouso** ✅

**Resposta: D**

**Explicação:**
Os dados nos repositórios CodeCommit são criptografados em trânsito e em repouso automaticamente. Quando dados são enviados via `git push`, o CodeCommit criptografa os dados recebidos conforme são armazenados. O CodeCommit cria automaticamente uma AWS-managed KMS key na primeira vez que você cria um repositório em uma nova região.

- C está errada: não é necessário habilitar manualmente — já está habilitado.
- A e B estão erradas: não é necessário hooks customizados.

---

## Pergunta 61 · Domínio: Troubleshooting and Optimization

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

## Pergunta 62 · Domínio: Security

A Conta A tem uma SQS queue e a Conta B precisa ter acesso a essa queue.

**Quais opções precisam ser combinadas para permitir esse acesso cross-account?** (Selecione três)

- A. O administrador da Conta A delega a permissão para assumir a role para usuários da Conta A
- B. **O administrador da Conta A cria uma IAM role e anexa uma permissions policy** ✅
- C. **O administrador da Conta B delega a permissão para assumir a role para usuários da Conta B** ✅
- D. **O administrador da Conta A anexa uma trust policy à role identificando a Conta B como o principal que pode assumir a role** ✅
- E. O administrador da Conta B cria uma IAM role e anexa uma trust policy com Conta B como principal
- F. O administrador da Conta A anexa uma trust policy identificando a Conta B como AWS service principal

**Resposta: B, C, D**

**Explicação:**
O processo de cross-account access:
1. Conta A: cria IAM role com permissions policy para acesso à SQS.
2. Conta A: anexa trust policy à role identificando a **Conta B** como trusted entity (principal).
3. Conta B: delega a permissão `sts:AssumeRole` aos seus usuários para assumir a role da Conta A.

- A está errada: é a Conta B (não A) que precisa delegar a permissão de assumir a role.
- E está errada: é a Conta A (não B) que cria a IAM role com a permissions policy.
- F está errada: AWS service principal é usado quando um serviço AWS precisa assumir a role — não outra conta.

---

## Pergunta 63 · Domínio: Deployment

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

## Pergunta 64 · Domínio: Development with AWS Services

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

## Pergunta 65 · Domínio: Security

Considere a seguinte IAM policy:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::EXAMPLE-BUCKET/private*"
    },
    {
      "Effect": "Allow",
      "Action": ["s3:PutObject", "s3:GetObject"],
      "Resource": "arn:aws:s3:::EXAMPLE-BUCKET/*"
    }
  ]
}
```

**Qual afirmação está correta de acordo com essa policy?**

- A. **A policy concede acesso PutObject e GetObject a todos os objetos no EXAMPLE-BUCKET exceto objetos que começam com "private"** ✅
- B. A policy concede PutObject e GetObject a todos os objetos no EXAMPLE-BUCKET e também acesso a todas as ações S3 em objetos começando com "private"
- C. A policy nega PutObject e GetObject a todos os buckets exceto EXAMPLE-BUCKET/private
- D. A policy concede PutObject e GetObject a todos os buckets exceto EXAMPLE-BUCKET/private

**Resposta: A**

**Explicação:**
- Primeiro statement: **Deny** para `s3:*` em `EXAMPLE-BUCKET/private*` — bloqueia todas as ações em objetos cujo nome começa com "private".
- Segundo statement: **Allow** para `PutObject` e `GetObject` em `EXAMPLE-BUCKET/*` — permite para todos os objetos.
- Efeito líquido: Deny sobrescreve Allow — portanto, PutObject e GetObject são permitidos em **todos os objetos exceto** aqueles que começam com "private".

---