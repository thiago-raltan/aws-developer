# Simulado Marek - Security

## Parte 2: Provas 04, 05, 06

> **38 questoes** agrupadas por dominio -- Fonte: Provas Marek 04, 05, 06

---

## Pergunta 6 [P04] · Domínio: Security

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

## Pergunta 9 [P04] · Domínio: Security

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

## Pergunta 11 [P04] · Domínio: Security

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

## Pergunta 12 [P04] · Domínio: Security

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

## Pergunta 14 [P04] · Domínio: Security

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

## Pergunta 21 [P04] · Domínio: Security

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

## Pergunta 23 [P04] · Domínio: Security

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

## Pergunta 27 [P04] · Domínio: Security

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

## Pergunta 29 [P04] · Domínio: Security

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

## Pergunta 33 [P04] · Domínio: Security

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

## Pergunta 36 [P04] · Domínio: Security

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

## Pergunta 41 [P04] · Domínio: Security

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

## Pergunta 50 [P04] · Domínio: Security

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

## Pergunta 53 [P04] · Domínio: Security

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

## Pergunta 60 [P04] · Domínio: Security

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

## Pergunta 62 [P04] · Domínio: Security

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

## Pergunta 65 [P04] · Domínio: Security

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

## Pergunta 1 [P05] · Domínio: Security

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

## Pergunta 12 [P05] · Domínio: Security

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

## Pergunta 15 [P05] · Domínio: Security

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

## Pergunta 24 [P05] · Domínio: Security

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

## Pergunta 26 [P05] · Domínio: Security

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

## Pergunta 30 [P05] · Domínio: Security

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

## Pergunta 35 [P05] · Domínio: Security

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

## Pergunta 36 [P05] · Domínio: Security

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

## Pergunta 46 [P05] · Domínio: Security

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

## Pergunta 49 [P05] · Domínio: Security

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

## Pergunta 52 [P05] · Domínio: Security

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

## Pergunta 57 [P05] · Domínio: Security

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

## Pergunta 61 [P05] · Domínio: Security

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

## Pergunta 20 [P06] · Domínio: Security

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

## Pergunta 26 [P06] · Domínio: Security

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

## Pergunta 28 [P06] · Domínio: Security

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

## Pergunta 36 [P06] · Domínio: Security

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

## Pergunta 37 [P06] · Domínio: Security

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

## Pergunta 56 [P06] · Domínio: Security

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

## Pergunta 59 [P06] · Domínio: Security

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

## Pergunta 64 [P06] · Domínio: Security

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
