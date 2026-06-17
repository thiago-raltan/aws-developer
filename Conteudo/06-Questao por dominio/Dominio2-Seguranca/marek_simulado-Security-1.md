# Simulado Marek - Security

## Parte 1: Provas 01, 02, 03

> **38 questoes** agrupadas por dominio -- Fonte: Provas Marek 01, 02, 03

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
