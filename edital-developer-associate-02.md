# AWS Certified Developer - Associate (DVA-C02)

> Guia do Exame — Versão 2.1 (Dezembro/2024)

---

## Introdução

O exame valida proficiência em: **desenvolvimento, teste, implantação e depuração** de aplicações na nuvem AWS.

**O candidato deve ser capaz de:**
- Desenvolver e otimizar aplicações na AWS
- Usar fluxos CI/CD para empacotar e implantar
- Proteger código e dados da aplicação
- Identificar e resolver problemas da aplicação

---

## Perfil do Candidato

**Experiência:** 1+ ano em desenvolvimento e manutenção de aplicações com serviços AWS.

**Conhecimento geral de TI:**
- Proficiência em pelo menos uma linguagem de alto nível
- Gerenciamento do ciclo de vida da aplicação
- Desenvolvimento de aplicações focadas na nuvem
- Uso de ferramentas de desenvolvimento

**Fora do escopo do candidato:**
- Criação de arquiteturas (sistemas distribuídos, microsserviços, esquemas de banco de dados)
- Projeto e criação de pipelines de CI/CD
- Administração de usuários/grupos do IAM
- Administração de servidores e sistemas operacionais
- Design de infraestrutura de rede AWS (VPC, Direct Connect)

---

## Formato do Exame

| Item | Detalhe |
|------|---------|
| Tipos de questão | Múltipla escolha e múltipla resposta |
| Perguntas pontuadas | 50 |
| Perguntas não avaliadas | 15 (não identificadas) |
| Pontuação | 100 a 1.000 |
| Mínimo para aprovação | **720** |

---

## Domínios e Pesos

| Domínio | Peso |
|---------|------|
| 1 — Desenvolvimento com serviços da AWS | 32% |
| 2 — Segurança | 26% |
| 3 — Implantação | 24% |
| 4 — Solução de problemas e otimização | 18% |

---

## Domínio 1 — Desenvolvimento com Serviços da AWS (32%)

### Tarefa 1: Desenvolver código para aplicações hospedadas na AWS
- 1.1.1: Padrões arquitetônicos (orientado a eventos, microsserviços, monolítico, coreografia, orquestração, fanout)
- 1.1.2: Stateful vs. stateless
- 1.1.3: Acoplamento rígido vs. acoplamento flexível
- 1.1.4: Padrões síncronos vs. assíncronos
- 1.1.5: Criar aplicações com tolerância a falhas (Java, C#, Python, JavaScript, TypeScript, Go)
- 1.1.6: Criar, estender e manter APIs (transformações de resposta/solicitação, validação, códigos de status)
- 1.1.7: Escrever e executar testes de unidade (ex: AWS SAM)
- 1.1.8: Escrever código para serviços de mensagens
- 1.1.9: Interagir com serviços AWS via APIs e SDKs
- 1.1.10: Gerenciar dados de streaming
- 1.1.11: Usar o **Amazon Q Developer** no desenvolvimento
- 1.1.12: Usar o **Amazon EventBridge** para padrões orientados a eventos
- 1.1.13: Código resiliente para integrações de terceiros (lógica de nova tentativa, disjuntores, gerenciamento de erros)

### Tarefa 2: Desenvolver código para o AWS Lambda
- 1.2.1: Acesso a recursos privados em VPCs via Lambda
- 1.2.2: Configurar funções Lambda (memória, simultaneidade, timeout, runtime, handler, camadas, extensões, gatilhos, destinos)
- 1.2.3: Ciclo de vida de eventos e erros (destinos do Lambda, filas de mensagens mortas)
- 1.2.4: Escrever e executar código de teste com ferramentas AWS
- 1.2.5: Integrar funções Lambda a serviços AWS
- 1.2.6: Ajustar funções Lambda para desempenho ideal
- 1.2.7: Processar e transformar dados quase em tempo real com Lambda

### Tarefa 3: Usar armazenamentos de dados no desenvolvimento
- 1.3.1: Chaves de partição de alta cardinalidade para acesso balanceado
- 1.3.2: Modelos de consistência (altamente consistente, eventualmente consistente)
- 1.3.3: Operações de consulta vs. varredura
- 1.3.4: Chaves e indexação no Amazon DynamoDB
- 1.3.5: Serializar e desserializar dados para persistência
- 1.3.6: Usar, gerenciar e manter armazenamentos de dados
- 1.3.7: Gerenciar ciclos de vida dos dados
- 1.3.8: Serviços de armazenamento em cache de dados
- 1.3.9: Armazenamentos especializados por padrão de acesso (ex: Amazon OpenSearch Service)

---

## Domínio 2 — Segurança (26%)

### Tarefa 1: Autenticação e/ou Autorização
- 2.1.1: Acesso federado com provedor de identidade (Amazon Cognito, IAM)
- 2.1.2: Proteger aplicações com tokens de portador
- 2.1.3: Configurar acesso programático à AWS
- 2.1.4: Fazer chamadas autenticadas a serviços AWS
- 2.1.5: Assumir um perfil do IAM
- 2.1.6: Definir permissões para entidades principais do IAM
- 2.1.7: Autorização no nível da aplicação para controle de acesso refinado
- 2.1.8: Autenticação entre serviços em arquiteturas de microsserviços

### Tarefa 2: Criptografia
- 2.2.1: Criptografia em repouso e em trânsito
- 2.2.2: Gerenciamento de certificados (CA Privada da AWS)
- 2.2.3: Criptografia do lado do cliente vs. lado do servidor
- 2.2.4: Usar chaves de criptografia para criptografar/descriptografar dados
- 2.2.5: Gerar certificados e chaves SSH para desenvolvimento
- 2.2.6: Criptografia além dos limites da conta
- 2.2.7: Ativar e desativar a alternância de chaves

### Tarefa 3: Gerenciar dados sensíveis
- 2.3.1: Classificação de dados (PII, PHI)
- 2.3.2: Criptografar variáveis de ambiente com dados sensíveis
- 2.3.3: Serviços de gerenciamento de segredos
- 2.3.4: Limpar dados sensíveis
- 2.3.5: Limpeza e mascaramento de dados no nível da aplicação
- 2.3.6: Padrões de acesso a dados para aplicações multi-tenant

---

## Domínio 3 — Implantação (24%)

### Tarefa 1: Preparar artefatos para implantação
- 3.1.1: Gerenciar dependências (variáveis de ambiente, arquivos de configuração, imagens de contêiner)
- 3.1.2: Organizar arquivos e estrutura de diretórios para implantação
- 3.1.3: Usar repositórios de código em ambientes de implantação
- 3.1.4: Aplicar requisitos de recursos (memória, núcleos)
- 3.1.5: Preparar configurações para ambientes específicos (ex: AWS AppConfig)

### Tarefa 2: Testar aplicações em ambientes de desenvolvimento
- 3.2.1: Testar código implantado com ferramentas e serviços AWS
- 3.2.2: Escrever testes de integração e simular APIs para dependências externas
- 3.2.3: Testar usando endpoints de desenvolvimento (estágios no API Gateway)
- 3.2.4: Implantar atualizações de pilha em ambientes existentes (ex: AWS SAM em staging)
- 3.2.5: Testar aplicações orientadas a eventos

### Tarefa 3: Automatizar testes de implantação
- 3.3.1: Criar eventos de teste (payloads JSON para Lambda, API Gateway, AWS SAM)
- 3.3.2: Implantar recursos de API em múltiplos ambientes
- 3.3.3: Criar ambientes com versões aprovadas para testes de integração (aliases Lambda, tags de imagem, Amplify, Copilot)
- 3.3.4: Implementar modelos IaC (AWS SAM, CloudFormation)
- 3.3.5: Gerenciar ambientes em serviços individuais (dev, teste, produção no API Gateway)
- 3.3.6: Usar o **Amazon Q Developer** para gerar testes automatizados

### Tarefa 4: Implantar código com CI/CD
- 3.4.1: Opções de pacotes de implantação do Lambda
- 3.4.2: Estágios do API Gateway e domínios personalizados
- 3.4.3: Atualizar modelos IaC existentes (AWS SAM, CloudFormation)
- 3.4.4: Gerenciar ambientes de aplicação com serviços AWS
- 3.4.5: Implantar usando estratégias de implantação
- 3.4.6: Confirmar código em repositório para acionar compilação, teste e implantação
- 3.4.7: Usar fluxos orquestrados para implantar em diferentes ambientes
- 3.4.8: Realizar reversões de aplicações com estratégias existentes
- 3.4.9: Usar rótulos e ramificações para gerenciamento de versões
- 3.4.10: Usar configurações de runtime para implantações dinâmicas (variáveis de staging do API Gateway em Lambda)
- 3.4.11: Configurar estratégias de implantação (azul/verde, canário, contínua)

---

## Domínio 4 — Solução de Problemas e Otimização (18%)

### Tarefa 1: Análise da causa raiz
- 4.1.1: Depurar código para identificar defeitos
- 4.1.2: Interpretar métricas, logs e rastreamentos
- 4.1.3: Consultar logs para encontrar dados relevantes
- 4.1.4: Implementar métricas personalizadas (CloudWatch EMF)
- 4.1.5: Revisar integridade da aplicação via painéis
- 4.1.6: Solucionar falhas de implantação usando logs de saída
- 4.1.7: Depurar problemas de integração entre serviços

### Tarefa 2: Instrumentar código para observabilidade
- 4.2.1: Diferenças entre registro em log, monitoramento e observabilidade
- 4.2.2: Estratégia eficaz de registro em log
- 4.2.3: Emitir métricas personalizadas
- 4.2.4: Adicionar anotações para rastreamento
- 4.2.5: Alertas de notificação para ações específicas (limites de cota, conclusões de implantação)
- 4.2.6: Rastreamento com ferramentas e serviços AWS
- 4.2.7: Registro em log estruturado para eventos e ações de usuários
- 4.2.8: Sondas de prontidão e verificações de integridade da aplicação

### Tarefa 3: Otimizar aplicações
- 4.3.1: Definir concorrência
- 4.3.2: Definir desempenho da aplicação
- 4.3.3: Determinar memória mínima e poder computacional
- 4.3.4: Usar políticas de filtro de assinatura para otimizar mensagens
- 4.3.5: Armazenar conteúdo em cache com base em cabeçalhos de solicitação
- 4.3.6: Armazenamento em cache no nível da aplicação
- 4.3.7: Otimizar uso de recursos da aplicação
- 4.3.8: Analisar problemas de desempenho
- 4.3.9: Usar logs para identificar gargalos de desempenho

---

## Serviços AWS — Dentro do Escopo

### Analytics
- Amazon Athena
- Amazon Kinesis
- Amazon OpenSearch Service

### Integração de Aplicações
- AWS AppSync
- Amazon EventBridge
- Amazon SNS
- Amazon SQS
- AWS Step Functions

### Computação
- Amazon EC2
- AWS Elastic Beanstalk
- AWS Lambda

### Contêineres
- Amazon ECR
- Amazon ECS
- Amazon EKS

### Banco de Dados
- Amazon Aurora
- Amazon DynamoDB
- Amazon ElastiCache
- Amazon RDS

### Ferramentas do Desenvolvedor
- AWS Amplify
- AWS CloudShell
- AWS CodeArtifact
- AWS CodeBuild
- AWS CodeDeploy
- AWS CodePipeline
- AWS X-Ray
- Amazon Q Developer

### Gerenciamento e Governança
- AWS AppConfig
- AWS CDK
- AWS CloudFormation
- AWS CloudTrail
- Amazon CloudWatch
- AWS CLI
- AWS Systems Manager

### Redes e Entrega de Conteúdo
- Amazon API Gateway
- Amazon CloudFront
- Elastic Load Balancing
- Amazon Route 53
- Amazon VPC

### Segurança, Identidade e Conformidade
- Amazon Cognito
- AWS IAM
- AWS KMS
- AWS Secrets Manager
- AWS STS
- AWS WAF

### Armazenamento
- Amazon EBS
- Amazon EFS
- Amazon S3

---

## Serviços AWS — Fora do Escopo

| Categoria | Serviços |
|-----------|---------|
| Analytics | Amazon EMR, AWS Glue, Amazon Redshift |
| Aplicações empresariais | Amazon Connect, Amazon SES |
| Computação | AWS Batch, Amazon Lightsail, AWS Outposts |
| Banco de dados | Amazon DocumentDB, Amazon Neptune, Amazon QLDB |
| Computação de usuário final | Amazon AppStream 2.0, Amazon WorkSpaces |
| IoT | AWS IoT Core, AWS IoT Greengrass |
| Machine Learning | Amazon Comprehend, Forecast, Lex, Polly, Rekognition, SageMaker, Textract, Transcribe, Translate |
| Gerenciamento e Governança | AWS Config, Control Tower, License Manager, Organizations, Service Catalog, Trusted Advisor |
| Serviços de mídia | Amazon Elastic Transcoder, Kinesis Video Streams |
| Migração e transferência | AWS DMS, DataSync, Migration Hub, Snow Family, Transfer Family |
| Redes | App Mesh, Cloud Map, Direct Connect, Global Accelerator, PrivateLink, Transit Gateway |
| Robótica | AWS RoboMaker |
| Satélite | AWS Ground Station |
| Armazenamento | AWS Backup, Amazon FSx, AWS Storage Gateway |

---

## Revisões — v2.1 (Dezembro/2024)

### Habilidades alteradas
| v2.1 | v2.0 |
|------|------|
| 3.2.2: Escrever testes de integração e simular APIs | Realizar integração simulada para APIs |
| 3.4.11: Configurar estratégias de implantação (azul/verde, canário, contínua) | Conhecimento sobre estratégias de implantação |
| 4.2.7: Registro em log estruturado para eventos e ações | Conhecimento sobre registro em log estruturado |

### Novas habilidades adicionadas
- 1.1.11: Amazon Q Developer no desenvolvimento
- 1.1.12: Amazon EventBridge para padrões orientados a eventos
- 1.1.13: Código resiliente para integrações de terceiros
- 1.2.7: Lambda para processamento e transformação em tempo real
- 1.3.9: Armazenamentos especializados (Amazon OpenSearch Service)
- 2.1.7: Autorização no nível da aplicação
- 2.1.8: Autenticação entre serviços em microsserviços
- 2.3.5: Limpeza e mascaramento de dados na aplicação
- 2.3.6: Padrões de acesso para aplicações multi-tenant
- 3.1.5: Configurações para ambientes específicos (AWS AppConfig)
- 3.2.5: Testar aplicações orientadas a eventos
- 3.3.6: Amazon Q Developer para testes automatizados
- 4.1.7: Depurar problemas de integração entre serviços
- 4.2.8: Sondas de prontidão e verificações de integridade
- 4.3.6 a 4.3.9: Otimização de cache, recursos, desempenho e gargalos

### Alterações nos serviços
| | Serviços |
|-|---------|
| **Adicionados ao escopo** | Amazon Q Developer |
| **Removidos do escopo** | AWS Copilot, Amazon CodeGuru |
| **Removidos de fora do escopo** | AWS Device Farm, Amazon Lex, AWS Service Catalog, AWS DMS |
