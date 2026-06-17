# Simulado Marek - Security

> **76 questoes** de todas as 6 provas (P01-P06) agrupadas por dominio

---

## Pergunta 2 [P01] · Domínio: Security

Qual das alternativas melhor descreve como a criptografia do KMS funciona?

- A. O KMS gera uma nova CMK para cada chamada Encrypt e criptografa os dados com ela
- B. O KMS recebe a CMK do cliente a cada chamada Encrypt e criptografa os dados com ela
- C. **O KMS armazena a CMK e recebe os dados dos clientes, que ele criptografa e retorna** ✅
- D. O KMS envia a CMK ao cliente, que realiza a criptografia e depois a deleta

**Resposta: C**

**Explicação:**
O KMS armazena a CMK (Customer Master Key) e realiza a criptografia internamente. O cliente envia os dados ao KMS, que os criptografa e devolve o resultado.

- A está errada: KMS não gera uma CMK nova a cada chamada.
- B está errada: CMKs importadas são configuradas uma vez, não enviadas em cada chamada.
- D está errada: KMS nunca envia a CMK ao cliente.

---

## Pergunta 4 [P01] · Domínio: Security

A equipe de desenvolvimento usa Lambda via API Gateway, acessível por qualquer pessoa. O líder da equipe quer controle de acesso usando um **mecanismo de autorização de terceiros**.

**Qual opção você recomendaria?**

- A. API Gateway User Pools
- B. Cognito User Pools
- C. **Lambda Authorizer** ✅
- D. Permissões IAM com sigv4

**Resposta: C**

**Explicação:**
Um Lambda Authorizer é uma função Lambda que controla acesso à API, suportando bearer token (OAuth, SAML) — ideal para mecanismos de terceiros.

- A está errada: "API Gateway User Pools" não existe.
- B está errada: Cognito é gerenciado pela AWS, não é autenticação de terceiros.
- D está errada: sigv4 é autenticação nativa AWS.

---

## Pergunta 7 [P01] · Domínio: Security

O manager quer acesso a pastas específicas por usuário em S3 (`bucket-a/user/user-x/`) com **uma única policy genérica** para todos.

**Qual recurso IAM você recomendaria?**

- A. IAM policy resource
- B. **IAM policy variables** ✅
- C. IAM policy condition
- D. IAM policy principal

**Resposta: B**

**Explicação:**
Policy variables (como `${aws:username}`) são substituídas dinamicamente na avaliação da policy, permitindo uma única policy para todos os usuários.

---

## Pergunta 13 [P01] · Domínio: Security

Um bucket S3 foi acidentalmente tornado público. O developer quer identificar **problemas similares com mínimo esforço**.

**Qual recurso/serviço vai ajudar?**

- A. S3 Analytics
- B. **IAM Access Analyzer** ✅
- C. Access Advisor no IAM console
- D. S3 Object Lock

**Resposta: B**

**Explicação:**
IAM Access Analyzer identifica recursos compartilhados com entidades externas à zona de confiança, gerando findings ativos para acessos não intencionais.

---

## Pergunta 15 [P01] · Domínio: Security

O líder da equipe quer enviar **apenas uma parte do tráfego** para uma nova versão do Lambda com **mínimo downtime** em caso de rollback.

**Qual opção você recomendaria?**

- A. Alias → nova versão com 100% do tráfego
- B. Deploy direto; rollback pelo ARN da versão
- C. Múltiplos aliases — novo alias aponta para alias atual
- D. **Alias → nova versão com 10% do tráfego; rollback = 100% para versão atual** ✅

**Resposta: D**

**Explicação:**
A configuração de Lambda alias routing divide tráfego entre duas versões. Rollback imediato sem downtime — basta redirecionar o alias.

- A e B estão erradas: enviam 100% para a nova versão.
- C está errada: alias não pode apontar para outro alias.

---

## Pergunta 20 [P01] · Domínio: Security

Uma IAM policy para Billing foi configurada, mas os usuários ainda **não conseguem ver o serviço no console**.

**Qual poderia ser o motivo?**

- A. O IAM user deve ser criado sob o Billing
- B. Somente root user tem acesso ao Billing console
- C. **É necessário ativar o acesso IAM ao Billing and Cost Management console** ✅
- D. Os usuários podem ter outra policy restritiva

**Resposta: C**

**Explicação:**
Por padrão, usuários IAM não têm acesso ao Billing. É necessário **ativar o acesso IAM** nas configurações da conta root antes que as policies tenham efeito.

---

## Pergunta 47 [P01] · Domínio: Security

Security Group e NACL configurados com inbound para as portas necessárias, mas **não conseguem conectar ao serviço** na EC2.

**O que você recomendaria?**

- A. NACLs são stateful; Security Groups são stateless
- B. Regras de NACLs não devem ser modificadas via CLI
- C. IAM Role no Security Group difere do da NACL
- D. **Security Groups são stateful; NACLs são stateless — deve-se permitir tanto inbound quanto outbound** ✅

**Resposta: D**

**Explicação:**
NACLs são stateless: é necessário permitir inbound (porta do serviço) E outbound (portas efêmeras 1024-65535 para tráfego de retorno).

---

## Pergunta 49 [P01] · Domínio: Security

Uma empresa de mídia quer que **usuários brasileiros** sejam atendidos apenas pelos servidores brasileiros.

**Qual política de roteamento do Route 53 atende a esse requisito?**

- A. Failover
- B. Latency
- C. Weighted
- D. **Geolocation** ✅

**Resposta: D**

**Explicação:**
Geolocation routing roteia com base na localização geográfica da query DNS, permitindo restringir acesso por país.

---

## Pergunta 52 [P01] · Domínio: Security

O líder da equipe quer identificar **IAM roles não utilizadas** para aplicar o princípio do menor privilégio.

**Qual serviço vai ajudar?**

- A. AWS Security Hub
- B. **IAM Access Analyzer** ✅
- C. Amazon Inspector
- D. AWS Trusted Advisor

**Resposta: B**

**Explicação:**
IAM Access Analyzer gera findings para roles não utilizadas, access keys inativas e senhas de usuários inativas.

---

## Pergunta 54 [P01] · Domínio: Security

Bucket policy que **nega uploads sem SSE-KMS encryption**.

**Qual policy é a mais adequada?**

- A. `StringEquals` + `aws:kms`
- B. `StringNotEquals` + `false`
- C. Action `s3:GetObject` + `AES256`
- D. **`StringNotEquals` + `aws:kms` em `s3:PutObject`** ✅

```json
{
  "Effect": "Deny",
  "Action": "s3:PutObject",
  "Condition": {
    "StringNotEquals": {
      "s3:x-amz-server-side-encryption": "aws:kms"
    }
  }
}
```

**Resposta: D**

**Explicação:**
`StringNotEquals` + `aws:kms` nega qualquer PutObject que não inclua o header SSE-KMS correto.

---

## Pergunta 55 [P01] · Domínio: Security

Uma empresa de cybersecurity precisa de **hardware single-tenant** — opção mais econômica.

**Qual opção EC2?**

- A. Dedicated Hosts
- B. **Dedicated Instances** ✅
- C. Spot Instances
- D. On-Demand Instances

**Resposta: B**

**Explicação:**
Dedicated Instances rodam em hardware single-tenant e são mais baratas que Dedicated Hosts. Podem compartilhar hardware com outras instâncias da mesma conta que não sejam Dedicated.

---

## Pergunta 56 [P01] · Domínio: Security

Uma web app .NET precisa de autenticação que **retorne JWT (JSON Web Token)**.

**Qual serviço AWS vai ajudar?**

- A. API Gateway
- B. **Cognito User Pools** ✅
- C. Cognito Identity Pools
- D. Cognito Sync

**Resposta: B**

**Explicação:**
Cognito User Pools retorna tokens JWT (ID token, Access token, Refresh token) seguindo OpenID Connect após autenticação.

- C está errada: Identity Pools concedem credenciais temporárias AWS, não JWTs.

---

## Pergunta 60 [P01] · Domínio: Security

RDS connection strings estão hardcoded. A empresa quer **armazenar segredos com segurança e rotacionar credenciais automaticamente**.

**Qual serviço AWS resolve isso?**

- A. **Secrets Manager** ✅
- B. SSM Parameter Store
- C. KMS
- D. Systems Manager

**Resposta: A**

**Explicação:**
Secrets Manager foi projetado para armazenar, rotacionar e recuperar segredos com integração nativa com RDS, Redshift e DocumentDB.

- B está errada: SSM Parameter Store não rotaciona credenciais automaticamente.

---

## Pergunta 63 [P01] · Domínio: Security

O developer deve garantir que **PutObject requests sem SSE-S3 encryption** não sejam processadas.

**Qual solução garante isso?**

- A. Definir encryption key no HTTP header
- B. Header `x-amz-server-side-encryption: sse:s3`
- C. **Header `x-amz-server-side-encryption: AES256` + bucket policy `StringNotEquals`** ✅
- D. Header `x-amz-server-side-encryption: aws:kms`

**Resposta: C**

**Explicação:**
Para SSE-S3, o header correto é `AES256`. A bucket policy com `StringNotEquals` nega uploads sem o header correto.

---

## Pergunta 64 [P01] · Domínio: Security

Quais entidades AWS podem ser usadas para fazer **deploy de certificados de servidor SSL/TLS**? (Selecione duas)

- A. AWS CloudFormation
- B. AWS Secrets Manager
- C. **AWS Certificate Manager** ✅
- D. **IAM** ✅
- E. AWS Systems Manager

**Resposta: C, D**

**Explicação:**
- ACM: ferramenta preferida — gratuita com renovação automática.
- IAM: para regiões não suportadas pelo ACM, com certificados de provedores externos.

---

## Pergunta 9 [P02] · Domínio: Security

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

## Pergunta 13 [P02] · Domínio: Security

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

## Pergunta 23 [P02] · Domínio: Security

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

## Pergunta 25 [P02] · Domínio: Security

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

## Pergunta 30 [P02] · Domínio: Security

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

## Pergunta 46 [P02] · Domínio: Security

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

## Pergunta 48 [P02] · Domínio: Security

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

## Pergunta 62 [P02] · Domínio: Security

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

## Pergunta 5 [P03] · Domínio: Security

Um app mobile de saúde usa algoritmos proprietários de Machine Learning. A equipe quer um sistema escalável de gerenciamento de usuários com login/cadastro e suporte a MFA com o **mínimo de esforço de desenvolvimento**.

**Quais opções você usaria?** (Selecione duas)

- A. Usar Amazon SNS para enviar código MFA via SMS
- B. Usar Lambda functions + DynamoDB para criar uma solução customizada
- C. **Usar Amazon Cognito para gerenciamento de usuários e o processo de login/cadastro** ✅
- D. **Usar Amazon Cognito para habilitar Multi-Factor Authentication (MFA) no login** ✅
- E. Usar Lambda functions + RDS para criar uma solução customizada

**Resposta: C, D**

**Explicação:**
O Amazon Cognito oferece sign-up, sign-in e controle de acesso de forma totalmente gerenciada, escalando para milhões de usuários. Os Cognito User Pools suportam nativmente MFA — sem código adicional.

- B e E estão erradas: criar soluções customizadas com Lambda + DynamoDB ou RDS exige muito mais esforço de desenvolvimento.
- A está errada: o Amazon SNS não pode enviar códigos MFA para aplicações (essa funcionalidade é apenas para usuários IAM e está sendo descontinuada).

---

## Pergunta 15 [P03] · Domínio: Security

Uma aplicação usa Cognito user pools e Identity pools para acesso seguro ao S3. O developer quer garantir que apenas usuários autorizados acessem seus próprios arquivos.

**Qual é a solução mais eficiente?**

- A. **Usar uma IAM policy com o prefixo de identidade do Amazon Cognito para permitir acesso apenas aos próprios objetos no S3** ✅
- B. Integrar API Gateway com Lambda para validar uploads/downloads
- C. Usar S3 Event Notifications para acionar Lambda de validação
- D. Usar CloudFront Lambda@Edge para validar uploads/downloads

**Resposta: A**

**Explicação:**
Você pode criar uma IAM policy baseada em identidade que permite acesso apenas a objetos cujo nome inclui o ID federado do usuário (via variável `${cognito-identity.amazonaws.com:sub}`). Isso garante que cada usuário só acesse sua própria pasta — sem código adicional.

- C e B estão erradas: embora seja possível construir essas soluções, elas não impedem um upload inválido para a pasta de outro usuário.
- D está errada: a solução assume uma distribuição CloudFront — adiciona custo e latência desnecessários.

---

## Pergunta 22 [P03] · Domínio: Security

Duas policies são aplicadas a um usuário IAM. A primeira **nega explicitamente** todo acesso ao EC2. A segunda **permite** a action `EC2:Describe`.

**O que acontecerá quando o usuário tentar usar a action `Describe`?**

- A. O usuário IAM fica em estado inválido por causa de policies conflitantes
- B. A ordem das policies importa: se a 1ª vem antes da 2ª, o acesso é negado; se a 2ª vem antes, é permitido
- C. **O usuário será negado porque uma das policies tem um explicit deny** ✅
- D. O usuário terá acesso porque tem um explicit allow

**Resposta: C**

**Explicação:**
No IAM, qualquer **explicit deny sempre prevalece** sobre qualquer allow. Quando um explicit deny está presente, o acesso é sempre negado — independentemente da ordem das policies ou de outros allows.

- A está errada: contas IAM não ficam "inválidas" por causa de policies conflitantes — as regras de avaliação são claras.
- D está errada: o explicit allow é sobrescrito pelo explicit deny.
- B está errada: a ordem das policies não importa no IAM — o explicit deny sempre ganha.

---

## Pergunta 31 [P03] · Domínio: Security

Uma empresa financeira quer manter dados no S3 sempre criptografados, com uma solução AWS gerenciada que permita **criar, rotacionar e remover as chaves de criptografia**.

**Qual opção você recomendaria?**

- A. SSE-C (Server-Side Encryption with Customer-Provided Keys)
- B. **SSE-KMS (Server-Side Encryption with CMKs stored in AWS KMS)** ✅
- C. SSE-S3 (Server-Side Encryption with Amazon S3-Managed Keys)
- D. Server-Side Encryption with Secrets Manager

**Resposta: B**

**Explicação:**
O SSE-KMS usa Customer Master Keys (CMKs) gerenciadas no AWS KMS. Com CMKs **customer-managed**, você pode criar, rotacionar, desabilitar e definir políticas de acesso — mantendo controle total sobre as chaves, com auditoria via CloudTrail.

- C está errada: o SSE-S3 rotaciona chaves automaticamente, mas você não tem controle sobre criação/remoção das chaves.
- A está errada: o SSE-C exige que você gerencie todo o ciclo de vida das chaves e as forneça em cada requisição — sem a gestão facilitada pelo KMS.
- D está errada: o Secrets Manager não fornece criptografia de objetos S3.

---

## Pergunta 34 [P03] · Domínio: Security

O departamento Financeiro quer dar acesso ao bucket S3 de dados para o departamento de RH em outra conta AWS.

**Qual das opções abaixo NÃO é viável para acesso cross-account de objetos S3?**

- A. Usar Cross-account IAM roles para acesso programático e via console
- B. **Usar IAM roles e resource-based policies para delegar acesso cross-account entre partições AWS diferentes** ✅
- C. Usar Access Control List (ACL) e IAM policies para acesso somente programático
- D. Usar Resource-based policies e IAM policies para acesso somente programático

**Resposta: B**

**Explicação:**
IAM roles e resource-based policies delegam acesso cross-account apenas **dentro de uma única partição AWS**. Por exemplo, você não pode usar uma S3 resource-based policy em uma conta na China (aws-cn) para permitir acesso de usuários na partição padrão (aws).

- A está errada (é válida): cross-account IAM roles são suportadas para acesso programático e via console.
- D e C estão erradas (são válidas): resource-based policies + IAM policies e ACLs + IAM policies são mecanismos válidos.

---

## Pergunta 35 [P03] · Domínio: Security

Uma equipe quer configurar IAM Database Authentication para seus bancos de dados RDS.

**Quais engines do RDS suportam IAM Database Authentication?** (Selecione duas)

- A. RDS SQL Server
- B. **RDS MySQL** ✅
- C. **RDS PostgreSQL** ✅
- D. RDS Oracle
- E. RDS Db2

**Resposta: B, C**

**Explicação:**
A autenticação de banco de dados IAM funciona com **MySQL, MariaDB e PostgreSQL** (tanto para RDS quanto para Aurora). Com esse método, você usa um token de autenticação gerado pelo IAM em vez de senha — o token tem duração de 15 minutos.

- A e D estão erradas: SQL Server e Oracle não suportam IAM database authentication.
- E está errada: o RDS não suporta o engine Db2 da IBM.

---

## Pergunta 43 [P03] · Domínio: Security

Uma empresa de trading quer minimizar os custos de uso do SQS ao migrar seus sistemas de mensageria.

**Qual opção você recomendaria?**

- A. Usar SQS short polling
- B. Usar SQS visibility timeout
- C. Usar SQS message timer
- D. **Usar SQS long polling** ✅

**Resposta: D**

**Explicação:**
O SQS long polling reduz custos eliminando respostas vazias (quando não há mensagens) e respostas falsas vazias. Com long polling, o SQS só retorna resposta quando pelo menos uma mensagem está disponível (ou o tempo de espera expirar). O tempo máximo de espera é 20 segundos.

- A está errada: short polling responde imediatamente mesmo sem mensagens — gerando muitas respostas vazias pagas.
- B e C estão erradas: visibility timeout e message timer não são mecanismos de recuperação de mensagens — são distratores.

---

## Pergunta 44 [P03] · Domínio: Security

O site de uma empresa de marketing digital é hospedado no bucket S3 **A**. As web fonts hospedadas no bucket S3 **B** não carregam no site.

**Qual solução resolve o problema?**

- A. Configurar CORS no bucket A para permitir qualquer origem
- B. Atualizar bucket policies em ambos os buckets
- C. **Configurar CORS no bucket B para permitir a origem do bucket A** ✅
- D. Habilitar versioning em ambos os buckets

**Resposta: C**

**Explicação:**
CORS (Cross-Origin Resource Sharing) define como aplicações web carregadas em um domínio podem interagir com recursos em outro domínio. O bucket **B** (que serve as fonts) precisa de uma CORS rule que permita requisições da origem do site no bucket **A**.

- A está errada: a configuração CORS deve estar no bucket **B** (a fonte dos recursos requisitados) — não no bucket A.
- B está errada: bucket policies controlam acesso, mas o problema é CORS — não permissões de acesso.
- D está errada: versioning não resolve problemas de carregamento cross-origin.

---

## Pergunta 47 [P03] · Domínio: Security

Uma empresa precisa de 14.000 IOPS consistentes para dados duráveis e seguros. Os padrões de conformidade exigem que os dados sejam seguros em todos os estágios de seu ciclo de vida nos volumes EBS.

**Qual afirmação é verdadeira sobre segurança de dados no EBS?**

- A. Volumes EBS suportam criptografia em trânsito mas não em repouso
- B. Volumes EBS não suportam criptografia em trânsito mas suportam criptografia em repouso com KMS
- C. **Volumes EBS suportam criptografia em trânsito e em repouso com KMS** ✅
- D. Volumes EBS não suportam nenhum tipo de criptografia

**Resposta: C**

**Explicação:**
O Amazon EBS com AWS KMS criptografa:
- Dados em repouso dentro do volume
- Todos os dados em trânsito entre o volume e a instância EC2
- Todos os snapshots criados do volume
- Todos os volumes criados a partir desses snapshots

As operações de criptografia ocorrem nos servidores que hospedam as instâncias EC2.

---

## Pergunta 55 [P03] · Domínio: Security

Uma empresa de telecomunicações armazena dados críticos de clientes no S3.

**Quais mecanismos podem ser usados para controlar acesso a dados no S3?** (Selecione duas)

- A. Permissions boundaries, IAM policies
- B. IAM database authentication, Bucket policies
- C. **Query String Authentication, Access Control Lists (ACLs)** ✅
- D. Query String Authentication, Permissions boundaries
- E. **Bucket policies, IAM policies** ✅

**Resposta: C, E**

**Explicação:**
O S3 suporta **quatro mecanismos** de controle de acesso:
1. **IAM policies**: controle granular por usuário/role
2. **Bucket policies**: regras amplas para o bucket inteiro
3. **ACLs**: permissões específicas (READ, WRITE, FULL_CONTROL) por conta/grupo
4. **Query String Authentication (pre-signed URLs)**: acesso temporário com expiração

- A está errada: Permissions boundaries são um recurso IAM avançado — não são um mecanismo direto de acesso ao S3.
- B está errada: IAM database authentication é para autenticação em bancos de dados RDS — não para S3.
- D está errada: combina Query String Auth (válido) com Permissions boundaries (não é mecanismo S3).

---

## Pergunta 58 [P03] · Domínio: Security

Uma aplicação em EC2 precisa autenticar e enviar mensagens via uma chat API quando detecta transações inválidas. O access token deve ser criptografado em repouso e em trânsito, com **acesso cross-account** possível e **mínimo overhead de gerenciamento**.

**Qual é a solução mais eficiente?**

- A. Usar Parameter Store com KMS CMK, configurar resource-based policy para acesso cross-account
- B. **Usar AWS Secrets Manager com KMS CMK, configurar resource-based policy no secret para acesso cross-account; atualizar a IAM role das instâncias EC2 para acessar o Secrets Manager** ✅
- C. Usar SSE-KMS para armazenar o token como objeto criptografado no S3 com resource-based policy
- D. Armazenar o token criptografado com KMS em uma tabela DynamoDB com resource-based policy

**Resposta: B**

**Explicação:**
O AWS Secrets Manager foi projetado especificamente para armazenar segredos de aplicações (access tokens, credenciais). Suporta:
- Criptografia via KMS
- Resource-based policies (permite acesso cross-account)
- Rotação automática de segredos

- A está errada: o SSM Parameter Store **não suporta resource-based policies** — apenas parameter policies para controle de ciclo de vida.
- D está errada: o DynamoDB **não suporta resource-based policies** e é má prática armazenar credenciais em banco de dados.
- C está errada: armazenar credenciais em S3 é uma má prática de segurança.

---

## Pergunta 62 [P03] · Domínio: Security

Uma aplicação em EC2 processa pedidos à noite e precisa acessar pedidos armazenados no S3.

**Como você recomendaria que a instância EC2 acesse os pedidos de forma segura?**

- A. Criar uma bucket policy que autorize acesso público
- B. **Usar uma IAM role** ✅
- C. Criar um usuário IAM programático e armazenar as chaves em `~/.aws/credentials` na instância EC2
- D. Usar EC2 User Data

**Resposta: B**

**Explicação:**
IAM roles para EC2 fornecem credenciais temporárias automaticamente via instance profile — sem necessidade de gerenciar access keys. A aplicação usa o SDK da AWS que busca as credenciais automaticamente do metadata service.

- C está errada: armazenar access key e secret key em `~/.aws/credentials` na instância é uma prática insegura — qualquer pessoa com acesso à instância pode roubar as credenciais.
- A está errada: acesso público violaria a segurança dos pedidos.
- D está errada: EC2 User Data é para scripts de inicialização — não para configurar acesso seguro ao S3.

---

## Pergunta 63 [P03] · Domínio: Security

Uma empresa de e-commerce tem um workflow de processamento de pedidos com **tarefas em paralelo e decision steps**, todos implementados via funções Lambda.

**Qual é a MELHOR solução?**

- A. Usar AWS Glue para orquestrar o workflow
- B. Usar AWS Batch para orquestrar o workflow
- C. Usar AWS Step Functions activities para orquestrar o workflow
- D. **Usar AWS Step Functions state machines para orquestrar o workflow** ✅

**Resposta: D**

**Explicação:**
O AWS Step Functions permite definir state machines usando a Amazon States Language (JSON). States podem tomar decisões com base no input, executar ações em paralelo e passar output para outros states — ideal para workflows com múltiplos caminhos e execução paralela.

- C está errada: activities do Step Functions associam código externo (ex.: em EC2) a tasks específicas — não orquestram o workflow em si.
- A e B estão erradas: AWS Glue (ETL) e AWS Batch (computação em lote) não orquestram workflows com lógica de decisão.

---

## Pergunta 64 [P03] · Domínio: Security

Sua aplicação é implantada com Elastic Beanstalk. Arquivos de configuração YAML são atualizados frequentemente. A equipe **não quer reimplantar a aplicação a cada mudança de configuração** — preferem gerenciar as configurações externamente, de forma segura, e carregá-las dinamicamente em runtime.

**Qual opção permite isso?**

- A. **Usar SSM Parameter Store** ✅
- B. Usar S3
- C. Usar Stage Variables
- D. Usar Environment variables

**Resposta: A**

**Explicação:**
O AWS Systems Manager Parameter Store fornece armazenamento seguro e hierárquico para dados de configuração e segredos. A aplicação pode buscar parâmetros dinamicamente em runtime sem reimplantação. Os parâmetros SecureString são criptografados com KMS.

- D está errada: variáveis de ambiente não são criptografadas em repouso e ficam visíveis em texto claro no console AWS e em respostas da API do Elastic Beanstalk.
- C está errada: Stage Variables são para gerenciar releases da API no API Gateway — não para configuração de aplicações Beanstalk.
- B está errada: embora o S3 seja possível, o Parameter Store é mais seguro, integrado e gerenciado — sem necessidade de configuração adicional de criptografia e controle de acesso.

---

## Pergunta 65 [P03] · Domínio: Security

Sua API pública no API Gateway, acessada por clientes de outro domínio, mais que dobrou de uso. Os custos aumentaram e você quer **impedir que domínios não autorizados acessem sua API**.

**Qual ação você deve tomar?**

- A. Usar Mapping Templates
- B. Usar Account-level throttling
- C. Atribuir um Security Group ao API Gateway
- D. **Restringir o acesso usando CORS** ✅

**Resposta: D**

**Explicação:**
O CORS (Cross-Origin Resource Sharing) controla quais origens (domínios) podem fazer requisições à sua API. Ao configurar CORS no API Gateway para permitir apenas origens específicas, você bloqueia requisições de domínios não autorizados.

- B está errada: throttling limita o **número de requisições por segundo** — não restringe origens.
- A está errada: Mapping Templates transformam payloads — não controlam acesso.
- C está errada: o API Gateway não usa Security Groups — usa resource policies. Além disso, Security Groups são para tráfego de rede, não para controle de origens.

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
