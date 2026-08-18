# Domínio 1 – Development with AWS Services

> Questões classificadas do exame **AWS Certified Developer – Associate (DVA-C02)**
> Total: 45 questões

---

## Questão 2

Uma empresa está executando instâncias do Amazon EC2 em várias contas da AWS. Um desenvolvedor precisa implementar um aplicativo que coleta todos os eventos do ciclo de vida das instâncias EC2. O aplicativo precisa armazenar o ciclo de vida eventos em uma única fila do Amazon Simple Queue Service (Amazon SQS) na conta AWS principal da empresa para processamento adicional.
Qual solução atenderá a esses requisitos?

- A.Configure o Amazon EC2 para entregar os eventos do ciclo de vida da instância do EC2 de todas as contas para a Amazon
Barramento de eventos EventBridge da conta principal. Adicione uma regra do EventBridge ao barramento de eventos da conta principal que
corresponde a todos os eventos do ciclo de vida da instância do EC2. Adicione a fila SQS como destino da regra.
- B. Use as políticas de recursos da fila SQS na conta principal para conceder a cada conta permissões para gravação
aquela fila SQS. Adicione ao barramento de eventos do Amazon EventBridge de cada conta uma regra do EventBridge que corresponda
todos os eventos do ciclo de vida da instância do EC2. Adicione a fila SQS na conta principal como alvo da regra.
- C.Escreva uma função AWS Lambda que verifica todas as instâncias do EC2 nas contas da empresa para detectar o EC2
mudanças no ciclo de vida da instância. Configure a função Lambda para gravar uma mensagem de notificação na fila SQS em
a conta principal se a função detectar uma alteração no ciclo de vida da instância do EC2. Adicionar um Amazon EventBridge
regra agendada que invoca a função Lambda a cada minuto.
- D.Configure as permissões no barramento de eventos da conta principal para receber eventos de todas as contas. Crie um
Regra do Amazon EventBridge em cada conta para enviar todos os eventos do ciclo de vida da instância do EC2 para a conta principal
ônibus do evento. Adicione uma regra do EventBridge ao barramento de eventos da conta principal que corresponda a todo o ciclo de vida da instância do EC2
eventos. Defina a fila SQS como destino para a regra.

**Resposta: D**

**Explicação:**

Aqui está uma justificativa detalhada de por que a opção D é a melhor solução, juntamente com informações de apoio e
links:
A opção D utiliza o Amazon EventBridge, projetado para arquiteturas orientadas a eventos e entre contas
entrega de eventos, tornando-o ideal para este cenário. Primeiro, ele configura as permissões na conta principal
Barramento de eventos EventBridge para receber eventos de outras contas AWS. Este é um passo crucial para permitir que o
conta central para coletar eventos de todas as outras contas. Em seguida, ele configura cada conta individual da AWS
para enviar eventos de ciclo de vida da instância do EC2 para o barramento de eventos da conta central. Isto garante que todas as informações relevantes os eventos do ciclo de vida são capturados e roteados para a conta central. Finalmente, dentro do barramento de eventos da conta principal, cria uma regra para corresponder a todos os eventos de ciclo de vida da instância do EC2 recebidos e direciona a fila SQS. Isso efetivamente captura os eventos enviados de outras contas e os coloca na fila SQS para processamento posterior.

Veja por que as outras opções são menos adequadas:
Opção A: embora centralize os eventos no EventBridge da conta principal, ele depende exclusivamente do EC2 para
entregar eventos para o EventBridge central. Este mecanismo é menos robusto para cenários entre contas
em comparação com a configuração explícita do envio de eventos por meio de regras do EventBridge em cada conta de origem.
Opção B: conceder diretamente permissões entre contas para a fila SQS pode se tornar um gerenciamento de segurança
desafio à medida que o número de contas cresce. Gerenciando políticas de recursos para acesso direto de gravação ao SQS
a fila de várias contas externas é menos escalonável e pode apresentar riscos de segurança. Também ignora
Os poderosos recursos de roteamento e filtragem do EventBridge.
Opção C: Esta solução envolve pesquisar todas as instâncias do EC2 usando uma função Lambda, que é ineficiente, cara e
e propenso a eventos perdidos. Isso ocorre porque a pesquisa em um intervalo específico (por exemplo, a cada minuto) pode não capturar
todos os eventos do ciclo de vida, especialmente os de curta duração. Abordagens orientadas a eventos usando EventBridge são significativamente
mais eficaz para capturar eventos em tempo real.
Por que a opção D é a melhor:
A opção D aproveita o caso de uso pretendido do Amazon EventBridge para entrega de eventos entre contas, que
oferece uma solução desacoplada, escalonável e confiável. Ao enviar eventos de contas individuais para a conta principal
EventBridge da conta, evita o acesso direto à fila SQS, mantendo melhor controle de segurança.
Além disso, o EventBridge permite filtragem e roteamento flexíveis, garantindo que apenas ciclo de vida relevante do EC2
os eventos são capturados e entregues na fila SQS. Isto é essencial para uma arquitetura limpa e eficiente
processamento de eventos.
Links de apoio:
Eventos entre contas do Amazon EventBridge:
https://docs.aws.amazon.com/eventbridge/latest/userguide/eventbridge-cross-account-event-delivery.html
Políticas de recursos do Amazon SQS:
https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-writing-an-sqs-
política.html
Conceitos do Amazon EventBridge: https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-what-is.html

---

## Questão 4

Uma empresa está criando uma solução escalável de gerenciamento de dados usando serviços da AWS para melhorar a velocidade e
agilidade de desenvolvimento. A solução consumirá grandes volumes de dados de diversas fontes e processará esses
dados por meio de múltiplas regras e transformações de negócios.
A solução exige que as regras de negócios sejam executadas em sequência e lidem com o reprocessamento de dados se ocorrerem erros quando o
as regras de negócios são executadas. A empresa precisa que a solução seja escalável e exija o mínimo de manutenção possível.
Qual serviço AWS a empresa deve usar para gerenciar e automatizar a orquestração dos fluxos de dados para atender
esses requisitos?

- A. AWS Batch
- B. AWS Step Functions
- C. AWS Glue
- D. AWS Lambda

**Resposta: B**

**Explicação:**

A resposta correta é B. AWS Step Functions. Aqui está o porquê:
O AWS Step Functions foi projetado especificamente para orquestrar aplicativos e microsserviços distribuídos usando
fluxos de trabalho visuais. Permite definir uma série de etapas (tarefas) em uma definição de máquina de estados que podem ser
executado em uma ordem específica. Isso aborda diretamente o requisito de que as regras de negócios sejam executadas em sequência.
O Step Functions inclui mecanismos integrados de tratamento de erros e novas tentativas, que são cruciais para gerenciar
reprocessamento de dados quando ocorrem erros durante a execução de regras de negócios. Você pode definir diferentes políticas de repetição
e capturar exceções para lidar com falhas normalmente, garantindo que o processamento de dados continue mesmo diante de
erros. Essa tolerância a falhas integrada reduz significativamente a sobrecarga operacional.
O serviço é altamente escalável. Step Functions pode lidar com um grande número de execuções simultâneas, tornando-o
adequado para processar grandes volumes de dados ingeridos de diversas fontes. A escalabilidade é inerente ao
arquitetura do serviço, liberando a empresa do gerenciamento da infraestrutura subjacente.
Step Functions é um serviço totalmente gerenciado. A AWS cuida da infraestrutura subjacente e do dimensionamento. Isto
reduz bastante a manutenção operacional necessária, permitindo que a empresa se concentre no desenvolvimento e
implantar regras de negócios em vez de gerenciar infraestrutura.
Embora o AWS Batch (A) seja projetado para trabalhos de processamento em lote, ele não fornece inerentemente a orquestração
e recursos de sequenciamento de Step Functions. AWS Glue (C) é principalmente um ETL (Extrair, Transformar, Carregar)
serviço focado na catalogação e transformação de dados, mas carece de orquestração e estado robustos
recursos de gerenciamento para regras de negócios complexas e sequenciadas. AWS Lambda (D) pode ser usado na Etapa
Funções, mas por si só não fornece recursos de gerenciamento de fluxo de trabalho.
Portanto, Step Functions aborda diretamente os requisitos de execução sequencial, tratamento de erros,
escalabilidade e manutenção mínima, tornando-o o serviço mais adequado às necessidades da empresa.
Links de apoio:
Documentação do AWS Step Functions
Orquestrando microsserviços com AWS Step Functions

---

## Questão 5

Um desenvolvedor criou uma função AWS Lambda escrita em Python. A função Lambda lê dados de
objetos no Amazon S3 e grava dados em uma tabela do Amazon DynamoDB. A função é invocada com sucesso a partir de um
Notificação de eventos S3 quando um objeto é criado. No entanto, a função falha quando tenta gravar no
Tabela DynamoDB.
Qual é a causa MAIS provável deste problema?

- A.O limite de simultaneidade da função Lambda foi excedido.
- B.A tabela DynamoDB requer um índice secundário global (GSI) para suportar gravações.
- C.A função Lambda não tem permissões do IAM para gravar no DynamoDB.
- D.A tabela DynamoDB não está em execução na mesma zona de disponibilidade que a função Lambda.

**Resposta: C**

**Explicação:**

O motivo mais provável pelo qual a função Lambda não consegue gravar na tabela do DynamoDB, apesar de ter sucesso
sendo invocado pela notificação de evento S3 é devido a permissões insuficientes do IAM. Funções Lambda, por
padrão, não tem permissões para acessar outros serviços da AWS, como DynamoDB. O acesso a estes serviços deve
ser explicitamente concedido por meio de uma função IAM. A opção A, com o limite de simultaneidade sendo excedido, provavelmente se manifestaria em
erros de limitação, mas a pergunta indica que a função falha ao gravar, implicando um problema de permissão em vez de
contenção de recursos. A opção B, que precisa de um GSI, é irrelevante porque o problema é a incapacidade de escrever,
não escrever de forma eficiente ou consultar de forma eficaz. GSIs são usados para otimizar consultas de leitura com base em atributos
diferente da chave primária. A opção D, a zona de disponibilidade, também está incorreta. DynamoDB é um servidor regional
serviço e replica dados em várias AZs dentro de uma região, de modo que a latência da rede ou a indisponibilidade de um
AZ específica normalmente não impediria completamente as operações de gravação. A função Lambda será capaz de escrever
para qualquer tabela do DynamoDB, independentemente da configuração AZ, desde que sua configuração esteja na mesma região
como o DynamoDB. O erro mais provável é que a função IAM anexada à função Lambda não tenha o
permissões necessárias para executar operações PutItem na tabela DynamoDB. A função IAM precisará
permissões para dynamodb:PutItem no ARN específico da tabela do DynamoDB ou um curinga para permitir a gravação em todos
tabelas. Para corrigir isso, o desenvolvedor deve configurar a função de execução da função Lambda para incluir uma política IAM
que concede a permissão dynamodb:PutItem na tabela de destino do DynamoDB. Isso garante que a função tenha o
autorização para realizar operações de gravação. Sem esta política IAM, o DynamoDB negará a função Lambda
escrever solicitações, levando à falha observada.
Links relevantes:
Permissões do AWS Lambda: https://docs.aws.amazon.com/lambda/latest/dg/lambda-intro-execution-role.html
Políticas IAM para DynamoDB: https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/security-
iam-id-based-policy-examples.html

---

## Questão 11

Uma empresa está migrando aplicativos internos legados para a AWS. Liderança quer reescrever o funcionário interno
diretório para usar serviços nativos da AWS. Um desenvolvedor precisa criar uma solução para armazenar detalhes de contato de funcionários
e fotos de alta resolução para uso com o novo aplicativo.
Qual solução permitirá a busca e recuperação de dados individuais de cada funcionário e em alta resolução
fotos usando APIs da AWS?

- A.Codifique as informações de contato e fotos de cada funcionário usando Base64. Armazene as informações em uma Amazon
Tabela do DynamoDB usando uma chave de classificação.
- B. Armazenar as informações de contato de cada funcionário em uma tabela do Amazon DynamoDB junto com as chaves de objeto para o
fotos armazenadas no Amazon S3.
- C.Use grupos de usuários do Amazon Cognito para implementar o diretório de funcionários em um software como um software totalmente gerenciado.
método de serviço (SaaS).
- D. Armazenar informações de contato de funcionários em uma instância de banco de dados Amazon RDS com as fotos armazenadas no Amazon Elastic
Sistema de arquivos (Amazon EFS).

**Resposta: B**

**Explicação:**

A solução correta envolve aproveitar os pontos fortes do Amazon DynamoDB e do Amazon S3.
DynamoDB, um banco de dados NoSQL, é ideal para armazenar dados estruturados, como informações de contato de funcionários, devido a
seu rápido desempenho de leitura e gravação e escalabilidade. O Amazon S3, por outro lado, foi projetado para armazenar
objetos, tornando-o perfeito para armazenar fotos de alta resolução.
A opção B propõe armazenar as informações de contato dos funcionários no DynamoDB e armazenar as fotos no S3, com o
Entrada do DynamoDB incluindo a chave do objeto S3 para cada foto. Esta abordagem permite a recuperação eficiente de
detalhes de contato e fotos associadas. A entrada do DynamoDB atua como um ponteiro para o objeto S3, permitindo
aplicativos para localizar e recuperar rapidamente a foto usando a API S3. Esta arquitetura separa estruturas
dados (dados de contato) de dados não estruturados (fotos), otimizando armazenamento e recuperação para cada tipo de dados.
A opção A é menos eficiente porque codificar fotos em Base64 e armazená-las diretamente no DynamoDB aumenta
o banco de dados e impacta negativamente o desempenho. O DynamoDB não está otimizado para armazenar arquivos binários grandes
dentro das entradas da tabela.
A opção C, usando grupos de usuários do Amazon Cognito, serve principalmente para autenticação e autorização, não para armazenamento
informações de contato e fotos dos funcionários. Embora o Cognito possa gerenciar identidades de usuários, não é uma solução adequada
solução de banco de dados para este cenário.
A opção D, usando Amazon RDS e Amazon EFS, é menos econômica e mais complexa do que usar DynamoDB
e S3. RDS é um serviço de banco de dados relacional adequado para dados estruturados, mas armazena dados de funcionários
pode não se beneficiar significativamente dos recursos relacionais em comparação com a estrutura de valores-chave do DynamoDB. Enquanto
O EFS poderia armazenar as fotos, introduzindo complexidade adicional para recuperação em comparação com o armazenamento de objetos do S3
modelo.
Portanto, a Opção B fornece a solução mais escalável, de melhor desempenho e econômica para armazenamento e
recuperando detalhes de contato de funcionários e fotos de alta resolução usando APIs da AWS.
Links relevantes:
Amazon DynamoDB: https://aws.amazon.com/dynamodb/
Amazon S3: https://aws.amazon.com/s3/

---

## Questão 12

Um desenvolvedor está criando um aplicativo que dará aos usuários a capacidade de armazenar fotos de seus celulares no
nuvem. O aplicativo precisa oferecer suporte a dezenas de milhares de usuários. O aplicativo usa um Amazon API Gateway
API REST integrada às funções do AWS Lambda para processar as fotos. O aplicativo armazena detalhes
sobre as fotos no Amazon DynamoDB.
Os usuários precisam criar uma conta para acessar o aplicativo. No aplicativo, os usuários devem poder fazer upload de fotos
e recuperar fotos enviadas anteriormente. As fotos terão tamanho de 300 KB a 5 MB.
Qual solução atenderá a esses requisitos com a MENOS sobrecarga operacional?

- A.Use grupos de usuários do Amazon Cognito para gerenciar contas de usuários. Crie um autorizador de grupo de usuários do Amazon Cognito em
API Gateway para controlar o acesso à API. Use a função Lambda para armazenar as fotos e detalhes no
Tabela DynamoDB. Recupere fotos carregadas anteriormente diretamente da tabela do DynamoDB.
- B.Use grupos de usuários do Amazon Cognito para gerenciar contas de usuários. Crie um autorizador de grupo de usuários do Amazon Cognito em
API Gateway para controlar o acesso à API. Use a função Lambda para armazenar as fotos no Amazon S3. Armazene o
chave S3 do objeto como parte dos detalhes da foto na tabela do DynamoDB. Recuperar fotos enviadas anteriormente por
consultando o DynamoDB para obter a chave S3.
- C.Crie um usuário IAM para cada usuário do aplicativo durante o processo de inscrição. Use a autenticação IAM para
acessar a API do API Gateway. Use a função Lambda para armazenar as fotos no Amazon S3. Armazene o S3 do objeto
key como parte dos detalhes da foto na tabela do DynamoDB. Recuperar fotos enviadas anteriormente consultando
DynamoDB para a chave S3.
- D.Crie uma tabela de usuários no DynamoDB. Use a tabela para gerenciar contas de usuário. Crie um autorizador Lambda que
valida as credenciais do usuário na tabela de usuários. Integre o autorizador Lambda ao API Gateway para controlar
acesso à API. Use a função Lambda para armazenar as fotos no Amazon S3. Armazene a chave S3 do objeto como par
dos detalhes da foto na tabela do DynamoDB. Recupere fotos carregadas anteriormente consultando o DynamoDB para
a chave S3.

**Resposta: B**

**Explicação:**

Aqui está uma justificativa detalhada de por que a opção B é a melhor solução, juntamente com conceitos e links de apoio:
A opção B fornece a solução mais eficiente e escalável com o mínimo de sobrecarga operacional porque
aproveita serviços gerenciados da AWS projetados especificamente para autenticação de usuário, autorização, armazenamento de objetos,
e recuperação de dados.
Grupos de usuários do Amazon Cognito: o Cognito lida com registro, autenticação e autorização de usuários. Isto
elimina a carga operacional de gerenciamento de contas de usuário, senhas e segurança do desenvolvedor. Isso
é dimensionado automaticamente para lidar com dezenas de milhares de usuários. https://aws.amazon.com/cognito/
Autorizador de pool de usuários Cognito no API Gateway: este autorizador controla o acesso à sua API com base no usuário
identidade gerenciada pelo Cognito. O API Gateway cuida da autenticação e autorização, aliviando o Lambda
funções dessas tarefas, o que melhora seu desempenho.
https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-integrate-with-cognito.html
Armazenamento de fotos no Amazon S3: o S3 foi projetado para armazenamento de objetos econômico e escalável. Armazenando fotos
diretamente no S3 lida com arquivos grandes com eficiência, aliviando o gerenciamento de armazenamento do Lambda
função e evitando possíveis problemas de tempo limite do Lambda. https://aws.amazon.com/s3/
DynamoDB para metadados: o DynamoDB armazena os metadados sobre as fotos, incluindo a chave S3. Isto
fornece uma maneira rápida e eficiente de consultar e recuperar a chave S3 de uma foto específica com base nos critérios do usuário.
https://aws.amazon.com/dynamodb/
Recuperando fotos consultando o DynamoDB para chave S3: essa abordagem permite que o aplicativo
identifique a localização da foto no S3 e recupere-a. A função Lambda só precisa buscar o objeto S3
usando a chave em vez de gerenciar o armazenamento de arquivos diretamente.
Por que outras opções não são ideais:
R: Armazenar fotos diretamente no DynamoDB não é ideal para grandes dados binários. O DynamoDB é otimizado para
dados estruturados. Armazenar fotos grandes no DynamoDB pode ser caro e ineficiente.
C: A criação de usuários IAM para cada usuário do aplicativo não é escalonável ou gerenciável. IAM foi projetado para AWS
administradores, não usuários finais do aplicativo. Esta abordagem criaria um grande encargo administrativo.
D: O gerenciamento de contas de usuário em uma tabela personalizada do DynamoDB requer o desenvolvimento e a manutenção do
lógica de autenticação e autorização. Isso é menos eficiente do que usar o Cognito e apresenta riscos de segurança.
Em resumo, a opção B oferece uma combinação de serviços gerenciados projetados para requisitos específicos,
resultando em menor sobrecarga operacional e melhor escalabilidade. Ele delega o gerenciamento de usuários ao Cognito,
transfere o armazenamento para o S3 e usa o DynamoDB de forma eficiente para metadados, tornando-o a solução mais adequada.

---

## Questão 13

Uma empresa recebe pedidos de alimentos de vários parceiros. A empresa possui uma aplicação de microsserviços que utiliza
APIs do Amazon API Gateway com integração AWS Lambda. Cada parceiro envia pedidos chamando uma API personalizada
que é exposto por meio do API Gateway. A chamada da API invoca uma função Lambda compartilhada para processar os pedidos.
Os parceiros precisam ser notificados depois que a função Lambda processar os pedidos. Cada parceiro deve receber atualizações
apenas para pedidos do próprio parceiro. A empresa quer adicionar novos parceiros no futuro com o menor número de códigos
mudanças possíveis.
Qual solução atenderá a esses requisitos da maneira MAIS escalonável?

- A.Crie um tópico diferente do Amazon Simple Notification Service (Amazon SNS) para cada parceiro. Configurar o
Função Lambda para publicar mensagens de cada parceiro no tópico SNS do parceiro.
- B.Crie uma função Lambda diferente para cada parceiro. Configure a função Lambda para notificar cada parceiro
ponto final de serviço diretamente.
- C.Crie um tópico do Amazon Simple Notification Service (Amazon SNS). Configure a função Lambda para publicar
mensagens com atributos específicos para o tópico SNS. Inscreva cada parceiro no tópico SNS. Aplique o
política de filtro apropriada para as assinaturas de tópicos.
- D.Crie um tópico do Amazon Simple Notification Service (Amazon SNS). Inscreva todos os parceiros no tópico SNS.

**Resposta: C**

**Explicação:**

A solução mais escalável é a opção C, que aproveita um único tópico SNS com filtragem de mensagens baseada em
atributos. Aqui está o porquê:
Escalabilidade: o SNS foi projetado para alto rendimento e distribuição de mensagens. Usar um único tópico evita
gerir e manter numerosos tópicos do SNS, simplificando a gestão da infra-estrutura e reduzindo o
despesas operacionais à medida que o número de parceiros cresce.
Flexibilidade: a Opção C permite fácil integração de novos parceiros. A empresa só precisa adicionar o novo
assinatura do parceiro para o tópico SNS existente com a política de filtro apropriada. Nenhuma alteração de código é necessária em
a função Lambda.
Eficiência de custos: Gerenciar um tópico SNS é mais econômico do que gerenciar vários tópicos, conforme necessário
menos recursos.
Filtragem de mensagens: as políticas de filtro SNS permitem que os assinantes (os parceiros) recebam apenas mensagens que correspondam
atributos específicos. Neste cenário, a função Lambda publica mensagens com um atributo que indica o
ID do parceiro. Cada parceiro assina o tópico SNS e usa uma política de filtro para receber apenas mensagens onde
o ID do parceiro corresponde ao seu. Isso garante que cada parceiro receba apenas atualizações relevantes para seus
ordens.
Alterações de código reduzidas: esta solução minimiza alterações de código na função Lambda. Só precisa
publicar mensagens com o atributo ID do parceiro. Nenhuma alteração é necessária na função Lambda ao adicionar
novos parceiros, mantendo o código sustentável.
A opção A cria um tópico SNS para cada parceiro. Isto pode tornar-se difícil de gerir, uma vez que o número de
parceiros cresce. É menos escalável.
A opção B envolve a criação de uma função Lambda diferente para cada parceiro, que duplica o código e aumenta
sobrecarga de manutenção. Notificar diretamente cada parceiro da função Lambda complica a lógica e
reduz a flexibilidade. Além disso, as funções do Lambda não se destinam principalmente a notificações diretas.
A opção D não fornece filtragem de mensagens, fazendo com que todos os parceiros recebam todas as atualizações de pedidos, violando a
exigência de que cada parceiro receba apenas atualizações para seus próprios pedidos.
Concluindo, a opção C oferece a solução mais escalonável e gerenciável, aproveitando as políticas de filtro do SNS,
minimizando alterações de código e encaminhando mensagens com eficiência para os parceiros corretos.
Links de apoio:
Filtragem de mensagens do Amazon SNS
Perguntas frequentes sobre Amazon SNS

---

## Questão 14

Uma empresa financeira deve armazenar registros originais de clientes por 10 anos por motivos legais. Um registro completo
contém informações de identificação pessoal (PII). De acordo com os regulamentos locais, as PII estão disponíveis apenas para determinados
pessoas da empresa e não devem ser compartilhadas com terceiros. A empresa precisa fazer os registros
disponível para organizações terceirizadas para análise estatística sem compartilhar as PII.
Um desenvolvedor deseja armazenar o registro imutável original no Amazon S3. Dependendo de quem acessa o S3
documento, o documento deve ser devolvido como está ou com todas as PII removidas. O desenvolvedor escreveu um AWS
Função Lambda para remover PII do documento. A função é chamada removePii.
O que o desenvolvedor deve fazer para que a empresa possa atender aos requisitos de PII mantendo apenas uma cópia
do documento?

- A. Configure uma notificação de evento S3 que invoca a função removePii quando uma solicitação GET do S3 é feita. Ligar
Amazon S3 usando uma solicitação GET para acessar o objeto sem PII.
- B. Configurar uma notificação de evento S3 que invoca a função removePii quando uma solicitação PUT do S3 é feita. Ligar
Amazon S3 usando uma solicitação PUT para acessar o objeto sem PII.
- C.Crie um ponto de acesso S3 Object Lambda no console S3. Selecione a função removePii. Usar acesso S3
Aponta para acessar o objeto sem PII.
- D.Crie um ponto de acesso S3 no console S3. Use o nome do ponto de acesso para chamar GetObjectLegalHold
Função API S3. Passe o nome da função removePii para acessar o objeto sem PII.

**Resposta: C**

**Explicação:**

A resposta correta é C. Crie um ponto de acesso S3 Object Lambda no console S3. Selecione o
função removePii. Use pontos de acesso S3 para acessar o objeto sem PII.
Aqui está o porquê:
O S3 Object Lambda permite adicionar seu próprio código às solicitações GET do S3 para modificar e processar dados como estão
sendo recuperado do S3. Isso atende perfeitamente ao requisito de remoção condicional de PII com base no acesso
contexto sem armazenar múltiplas cópias dos dados. https://aws.amazon.com/s3/features/object-lambda/
Ao criar um ponto de acesso S3 Object Lambda e configurá-lo para invocar a função removePii Lambda, o
A função será acionada automaticamente sempre que uma solicitação GET for feita através desse ponto de acesso específico.
A função Lambda removerá então as PII do objeto antes de devolvê-las ao solicitante. Para
usuários autorizados acessando o bucket S3 diretamente ou por meio de um ponto de acesso diferente, eles receberão o
registro original e inalterado. Para acesso de terceiros por meio do ponto de acesso Object Lambda, as PII serão removidas.
Os pontos de acesso S3 ajudam você a gerenciar o acesso aos seus dados em grande escala. Um ponto de acesso é um endpoint de rede nomeado
anexado a um bucket que você pode usar para executar operações de objeto do S3, como GetObject e
ColocarObjeto. Object Lambda é um recurso dos pontos de acesso S3.
Por que outras opções estão incorretas:
A e B: notificações de eventos do S3 acionam funções do Lambda com base em eventos como solicitações PUT ou GET, mas elas
não modifique inerentemente o conteúdo retornado pela solicitação GET. Eles exigiriam que você armazenasse um arquivo modificado
cópia dos dados em algum lugar, o que viola o requisito de manter apenas uma cópia. Além disso, acionar em
uma solicitação GET (opção A) é tarde demais porque os dados já estão sendo enviados ao solicitante.
D: GetObjectLegalHold é uma função da API S3 para gerenciar retenção de objetos, não para modificar dinamicamente
conteúdo do objeto com base no acesso. É irrelevante para o problema.

---

## Questão 19

Uma empresa está oferecendo APIs como um serviço pela Internet para fornecer acesso de leitura não autenticado a estatísticas
informações atualizadas diariamente. A empresa usa Amazon API Gateway e AWS Lambda para desenvolver as APIs.
O serviço se popularizou e a empresa quer melhorar a capacidade de resposta das APIs.
Qual ação pode ajudar a empresa a atingir esse objetivo?

- A. Habilitar cache de API no API Gateway.
- B.Configure o API Gateway para usar um endpoint VPC de interface.
- C.Habilitar o compartilhamento de recursos entre origens (CORS) para as APIs.
- D.Configurar planos de uso e chaves de API no API Gateway.

**Resposta: A**

**Explicação:**

A resposta correta é A: Habilitar cache de API no API Gateway.
Aqui está uma justificativa detalhada:
O objetivo principal é melhorar a capacidade de resposta da API para acesso de leitura não autenticado para atualizações frequentes, mas
não mudando continuamente, dados estatísticos. O cache da API aborda isso diretamente, armazenando as respostas da API em
API Gateway por um tempo especificado (TTL). Solicitações subsequentes para os mesmos dados dentro do TTL são atendidas por
o cache, reduzindo significativamente a latência e a carga nas funções de back-end do Lambda. Isso evita
executar repetidamente a função Lambda e consultar fontes de dados para obter as mesmas informações.
A opção B, configurar o API Gateway para usar um VPC endpoint de interface, é mais relevante para APIs privadas
acessado em uma VPC e não em APIs públicas expostas pela Internet. Embora melhore a segurança e a segurança interna
desempenho da rede, não melhora a capacidade de resposta para solicitações públicas voltadas para a Internet.
A opção C, habilitando o CORS, é crucial para aplicativos baseados em navegador que fazem solicitações de origem cruzada para as APIs.
No entanto, o CORS aborda principalmente questões de segurança relacionadas ao JavaScript fazendo solicitações de diferentes
domínios e não melhora diretamente os tempos de resposta da API. O serviço já é oferecido pela internet e
tornando-se popular, o que implica que a empresa provavelmente já configurou o CORS adequadamente.
A opção D, configuração de planos de uso e chaves de API, é usada principalmente para gerenciar o acesso à API, limitação de taxa e
monetização. Embora seja útil para controlar o acesso e prevenir abusos, não melhora inerentemente a
velocidade com que as solicitações de API são atendidas. É mais relevante para acesso autenticado a APIs onde o uso é
controlado.
O cache é ideal para cargas de trabalho com muita leitura, onde os dados subjacentes mudam periodicamente, assim como o
caso aqui (atualizações diárias). O cache do API Gateway é simples de implementar e pode fornecer uma dramática
melhoria no desempenho e capacidade de resposta, pois descarrega as funções Lambda, melhora o usuário final
experiência e reduz a latência.
Consulte a seguinte documentação da AWS para obter mais detalhes sobre o cache do API Gateway:
Armazenamento em cache de respostas de API no Amazon API Gateway
Preços do Amazon API Gateway – Cache

---

## Questão 20

Um desenvolvedor deseja armazenar informações sobre filmes. Cada filme tem título, ano de lançamento e gênero. O filme
as informações também podem incluir propriedades adicionais sobre o elenco e a equipe de produção. Esta informação adicional
é inconsistente entre os filmes. Por exemplo, um filme pode ter um assistente de direção e outro filme pode
tenha um treinador de animais.
O desenvolvedor precisa implementar uma solução para dar suporte aos seguintes casos de uso:
Para um determinado título e ano de lançamento, obtenha todos os detalhes sobre o filme que tem esse título e ano de lançamento.
Para um determinado título, obtenha todos os detalhes sobre todos os filmes que possuem esse título.
Para um determinado gênero, obtenha todos os detalhes sobre todos os filmes desse gênero.
Qual configuração de armazenamento de dados atenderá a esses requisitos?

- A.Crie uma tabela do Amazon DynamoDB. Configure a tabela com uma chave primária que consiste no título como o
chave de partição e o ano de lançamento como chave de classificação. Crie um índice secundário global que use o gênero como
chave de partição e o título como chave de classificação.
- B.Crie uma tabela do Amazon DynamoDB. Configure a tabela com uma chave primária que consiste no gênero como o
chave de partição e o ano de lançamento como chave de classificação. Crie um índice secundário global que use o título como
chave de partição.
- C.Em uma instância de banco de dados do Amazon RDS, crie uma tabela que contenha colunas para título, ano de lançamento e gênero.
Configure o título como chave primária.
- D.Em uma instância de banco de dados Amazon RDS, crie uma tabela em que a chave primária seja o título e todos os outros dados sejam codificados
no formato JSON como uma coluna adicional.

**Resposta: A**

**Explicação:**

A configuração de armazenamento de dados mais apropriada é a opção A, utilizando Amazon DynamoDB com uma chave específica
design e um índice secundário global (GSI). O DynamoDB é adequado para lidar com esquemas flexíveis, que
alinha-se com as propriedades adicionais inconsistentes sobre o elenco e a equipe de produção.
A configuração da chave primária, com título como chave de partição e ano de lançamento como chave de classificação, de forma eficiente
suporta o primeiro caso de uso: recuperar detalhes do filme por título e ano de lançamento. A chave de partição permite rápida
localização de dados na arquitetura distribuída do DynamoDB e a chave de classificação permite consultas eficientes
dentro dessa partição com base no ano de lançamento.
O GSI, usando gênero como chave de partição e título como chave de classificação, permite consultas eficientes para todos os filmes
dentro de um gênero específico (o terceiro caso de uso). Este índice copia o atributo gênero e o organiza para rápida
recuperação de filmes pertencentes a esse gênero. O título como chave de classificação permite retornar dados em determinada ordem.
Finalmente, o segundo caso de uso – recuperar todos os filmes com um título específico – é inerentemente suportado pelo
estrutura de chave primária, já que todos os filmes com o mesmo título residirão na mesma partição. Enquanto um filtro
pode ser necessária para filtrar valores de anos diferentes, ela ainda é eficiente, dada a alta eficiência do DynamoDB.
capacidades de desempenho.
A opção B está incorreta porque prioriza pesquisas baseadas em gênero em vez de pesquisas baseadas em títulos, tornando o principal
consulta ineficiente. As opções C e D, que sugerem o uso do Amazon RDS, são menos adequadas para lidar com um ambiente flexível.
esquema e exigiria gerenciamento de esquema mais complexo ou análise JSON, impactando o desempenho e
aumentando a sobrecarga de desenvolvimento. Capacidade nativa do DynamoDB de armazenar esquemas flexíveis e consultar com eficiência
torna a escolha mais apropriada aqui.
Links autorizados:
Amazon DynamoDB – Design principal
Amazon DynamoDB – Índices secundários globais

---

## Questão 21

Um desenvolvedor mantém uma API REST do Amazon API Gateway. Os clientes usam a API por meio de uma interface de usuário frontend e
Autenticação do Amazon Cognito.
O desenvolvedor tem uma nova versão da API que contém novos endpoints e interface incompatível com versões anteriores
mudanças. O desenvolvedor precisa fornecer acesso beta a outros desenvolvedores da equipe sem afetar
clientes.
Qual solução atenderá a esses requisitos com a MENOS sobrecarga operacional?

- A.Definir um estágio de desenvolvimento na API API Gateway. Instrua os outros desenvolvedores a apontar os endpoints para
a fase de desenvolvimento.
- B.Definir uma nova API do API Gateway que aponte para o novo código do aplicativo API. Instrua os outros desenvolvedores a
aponte os endpoints para a nova API.
- C.Implementar um parâmetro de consulta no código da aplicação API que determine qual versão do código chamar.
- D.Especifique novos endpoints do API Gateway para os endpoints da API que o desenvolvedor deseja adicionar.

**Resposta: A**

**Explicação:**

A opção A, definir um estágio de desenvolvimento no API Gateway, é a abordagem mais adequada porque aproveita
Recursos integrados do API Gateway para gerenciar várias versões de uma API. Os estágios do API Gateway são
ambientes independentes que permitem aos desenvolvedores implantar e testar alterações de API sem impactar o
ambiente de produção. Este recurso simplifica os testes beta, permitindo que usuários específicos (neste caso, outros
desenvolvedores da equipe) para acessar a nova versão da API por meio do endpoint do estágio de desenvolvimento.
A opção B, criar uma nova API do API Gateway, exigiria a replicação de toda a configuração da API, aumentando
sobrecarga operacional. Duplica recursos e adiciona complexidade ao gerenciamento.
A opção C, usando um parâmetro de consulta no código do aplicativo, introduz lógica no aplicativo para lidar com
versionamento. Isso pode se tornar complexo e difícil de manter, acoplando fortemente o código do aplicativo à API
esquema de versionamento. Ele também ignora os recursos do API Gateway para gerenciamento de estágios e controle de tráfego.
A opção D, definir novos endpoints do API Gateway para novos recursos, levaria a uma estrutura de API inconsistente.
Esta opção é adequada para adicionar novos recursos que não quebrem a compatibilidade com versões anteriores, no entanto, neste
caso haja alterações de interface incompatíveis com versões anteriores, isso não resolverá totalmente o problema.
Portanto, a opção A oferece uma solução mais limpa e gerenciável com o mínimo de sobrecarga operacional,
utilizando os recursos de teste integrados do API Gateway. Essa abordagem garante que os clientes não sejam afetados enquanto
permitindo que os desenvolvedores testem a versão beta da API.
https://docs.aws.amazon.com/apigateway/latest/developerguide/using-apigateway-
estágios.htmlhttps://aws.amazon.com/api-gateway/

---

## Questão 23

Uma empresa possui um aplicativo legado do Windows com vários nós executado no local. O aplicativo usa uma rede
pasta compartilhada como um repositório de configuração centralizado para armazenar arquivos de configuração no formato .xml. A empresa é
migrar o aplicativo para instâncias do Amazon EC2. Como parte da migração para a AWS, um desenvolvedor deve identificar um
solução que fornece alta disponibilidade para o repositório.
Qual solução atenderá a esse requisito de maneira MAIS econômica?

- A. Monte um volume do Amazon Elastic Block Store (Amazon EBS) em uma das instâncias do EC2. Implantar um arquivo
sistema no volume EBS. Use o sistema operacional host para compartilhar uma pasta. Atualize o código do aplicativo para
ler e gravar arquivos de configuração da pasta compartilhada.
- B.Implantar uma microinstância EC2 com um volume de armazenamento de instâncias. Use o sistema operacional host para compartilhar uma pasta.
Atualize o código do aplicativo para ler e gravar arquivos de configuração da pasta compartilhada.
- C.Crie um bucket Amazon S3 para hospedar o repositório. Migre os arquivos .xml existentes para o bucket S3. Atualizar
o código do aplicativo para usar o AWS SDK para ler e gravar arquivos de configuração do Amazon S3.
- D.Crie um bucket do Amazon S3 para hospedar o repositório. Migre os arquivos .xml existentes para o bucket S3. Montar
o bucket S3 para as instâncias EC2 como um volume local. Atualize o código do aplicativo para leitura e gravação
arquivos de configuração do disco.

**Resposta: C**

**Explicação:**

A resposta correta é C, usando Amazon S3 para hospedar o repositório de configuração. Aqui está o porquê:
A opção A, usar EBS e compartilhar uma pasta de uma instância EC2, cria um ponto único de falha. Se esse EC2
falha, o repositório de configuração fica indisponível. Os volumes EBS, embora duráveis, estão vinculados a um
zona de disponibilidade específica, dificultando a alta disponibilidade em várias AZs.
A opção B, utilizando uma microinstância EC2 com armazenamento de instâncias, é ainda menos confiável. Os volumes de armazenamento de instâncias são
efêmero, o que significa que eles são perdidos quando a instância é interrompida ou encerrada. Isto faz com que seja inteiramente
inadequado para um repositório de configuração crítica.
A opção D, usando S3 com um volume local montado, introduz complexidade e desempenho desnecessários
gargalos. Embora teoricamente seja possível com soluções como s3fs, não é um recurso nativo da AWS e adiciona
sobrecarga, anulando algumas das vantagens de desempenho do S3. Montar o S3 como uma unidade local também pode apresentar
latência em comparação com o acesso ao S3 diretamente por meio do AWS SDK. Além disso, possíveis problemas de compatibilidade podem
surgem, e a visualização do sistema de arquivos "local" não fornece consistência atômica verdadeira.
A opção C, que aproveita diretamente o Amazon S3, oferece a melhor combinação de alta disponibilidade, custo-benefício
eficácia e escalabilidade. S3 foi projetado para durabilidade de 99,999999999% e é inerentemente altamente disponível
em várias zonas de disponibilidade. A atualização do código do aplicativo para usar o AWS SDK for S3 permite
e interação eficiente com os arquivos de configuração. S3 oferece uma solução de armazenamento econômica, especialmente para
arquivos de configuração acessados com pouca frequência. Não há necessidade de gerenciar servidores de arquivos ou se preocupar com replicação,
já que o S3 lida com isso automaticamente. Os AWS SDKs são bem documentados e fornecem recursos robustos para
ler e escrever objetos (arquivos de configuração). Esta abordagem simplifica a arquitetura e minimiza
sobrecarga operacional.
Leitura adicional:
Amazon S3: https://aws.amazon.com/s3/
SDKs da AWS: https://aws.amazon.com/developer/tools/

---

## Questão 25

Uma empresa está migrando um banco de dados local para o Amazon RDS for MySQL. A empresa tem muita leitura
cargas de trabalho. A empresa deseja refatorar o código para obter desempenho ideal de leitura para consultas.
Qual solução atenderá a esse requisito com MENOS esforço atual e futuro?

- A.Use uma implantação multi-AZ do Amazon RDS. Aumente o número de conexões que o código faz com o
banco de dados ou aumentar o tamanho do pool de conexões se um pool de conexões estiver em uso.
- B.Use uma implantação multi-AZ do Amazon RDS. Modifique o código para que as consultas acessem o RDS secundário
instância.
- C.Deploy Amazon RDS com uma ou mais réplicas de leitura. Modifique o código do aplicativo para que as consultas usem a URL
para as réplicas de leitura.
- D.Use software de replicação de código aberto para criar uma cópia do banco de dados MySQL em uma instância do Amazon EC2.
Modifique o código do aplicativo para que as consultas usem o endereço IP da instância do EC2.

**Resposta: C**

**Explicação:**

A resposta correta é C porque aborda diretamente o requisito de obter leitura ideal
desempenho para cargas de trabalho de leitura intensa com esforço mínimo. As réplicas de leitura do Amazon RDS são especificamente
projetado para dimensionar operações de leitura, e a mudança necessária no aplicativo é simplesmente apontar consultas de leitura
para o endpoint da réplica.
A opção A está incorreta porque uma implantação multi-AZ fornece principalmente alta disponibilidade e failover
capacidades, não especificamente escala de leitura. Aumentando o número de conexões ou o tamanho do pool de conexões
pode ajudar até certo ponto, mas não é a solução ideal para escalonamento de leitura e pode sobrecarregar potencialmente o
banco de dados primário.
A opção B é problemática, pois a consulta direta da instância secundária em uma configuração multi-AZ não é uma opção suportada ou
prática recomendada. A instância secundária é para failover e tentar usá-la para tráfego de leitura pode
leva à instabilidade durante failovers e não garante o fornecimento de dados consistentes. Documentação da AWS
desaconselha esta abordagem.
A opção D é uma solução excessivamente complexa. Requer configuração e gerenciamento manual do software de replicação em
uma instância EC2, que aumenta a sobrecarga operacional e a complexidade de gerenciamento. Leitura do Amazon RDS
As réplicas são um serviço gerenciado, o que significa que a AWS cuida do processo de replicação, aplicação de patches e outros
tarefas administrativas, reduzindo a carga da empresa. A escolha de um serviço gerenciado está alinhada com o objetivo
de minimizar o esforço atual e futuro. Além disso, a replicação manual pode não ter o mesmo desempenho ou
confiável quanto as réplicas de leitura RDS gerenciadas.
O uso de réplicas de leitura fornece uma solução gerenciada, escalável e desenvolvida especificamente para lidar com leitura pesada
cargas de trabalho no Amazon RDS. É a abordagem de menor esforço, pois utiliza um serviço projetado diretamente para o
caso de uso especificado, abstraindo as complexidades do gerenciamento manual da infraestrutura de replicação.
Links autorizados:
Réplicas de leitura do Amazon RDS:
https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ReadRepl.html
Implantações Multi-AZ do Amazon RDS:
https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.MultiAZ.html

---

## Questão 26

Um desenvolvedor está criando um aplicativo que será implantado em dispositivos IoT. O aplicativo enviará dados para um
API RESTful implantada como uma função AWS Lambda. O aplicativo atribuirá a cada solicitação de API um nome exclusivo
identificador. O volume de solicitações de API do aplicativo pode aumentar aleatoriamente a qualquer hora do dia.
Durante períodos de limitação de solicitações, o aplicativo pode precisar tentar novamente as solicitações. A API deve ser capaz de lidar
solicitações duplicadas sem inconsistências ou perda de dados.
Qual solução atenderá a esses requisitos?

- A.Criar uma instância de banco de dados Amazon RDS para MySQL. Armazene o identificador exclusivo para cada solicitação em um banco de dados
mesa. Modifique a função Lambda para verificar o identificador na tabela antes de processar a solicitação.
- B.Crie uma tabela do Amazon DynamoDB. Armazene o identificador exclusivo de cada solicitação na tabela. Modifique o
Função Lambda para verificar o identificador da tabela antes de processar a solicitação.
- C.Crie uma tabela Amazon DynamoDB. Armazene o identificador exclusivo de cada solicitação na tabela. Modifique o
Função Lambda para retornar uma resposta de erro do cliente quando a função recebe uma solicitação duplicada.
- D.Crie uma instância do Amazon ElastiCache for Memcached. Armazene o identificador exclusivo de cada solicitação no
cache. Modifique a função Lambda para verificar o cache do identificador antes de processar a solicitação.

**Resposta: B**

**Explicação:**

A solução mais adequada é usar o DynamoDB para lidar com solicitações de API potencialmente duplicadas da IoT
dispositivos roteados por meio de uma função Lambda. Aqui está o porquê:
O DynamoDB é excelente no tratamento de cargas de trabalho intermitentes e de alto volume, alinhando-se perfeitamente com as necessidades do aplicativo.
requisito para lidar com picos aleatórios em solicitações de API. Sua escalabilidade e velocidade o tornam adequado para cenários
onde o volume de solicitações pode flutuar significativamente, o que é comum em aplicativos de dispositivos IoT.
(https://aws.amazon.com/dynamodb/)
O principal requisito é lidar com solicitações duplicadas de forma idempotente, evitando inconsistências e perda de dados.
Ao armazenar um identificador exclusivo para cada solicitação no DynamoDB, a função Lambda pode verificar com eficiência se um
a solicitação já foi processada antes de executar a lógica principal. Se o identificador existir no DynamoDB
tabela, a função Lambda sabe que é uma duplicata e pode tomar as medidas apropriadas (por exemplo, retornar um arquivo armazenado em cache
resposta ou simplesmente confirmar a solicitação sem reprocessar).
(https://aws.amazon.com/blogs/database/implementing-application-idempotency-on-aws/)
A opção A (RDS MySQL) é menos ideal. O RDS, embora confiável, é um banco de dados relacional, é mais adequado para
dados estruturados consistentes, podem não escalar e ter um desempenho tão eficaz quanto o DynamoDB para gravações de alto volume
e leituras necessárias neste cenário, especialmente durante picos de carga. Além disso, a sobrecarga de gerenciamento de um RDS
instância é maior do que gerenciar uma tabela do DynamoDB.
A opção C (DynamoDB com erro do cliente) não consegue lidar com o requisito de nova tentativa de maneira eficaz. Devolvendo um cliente
erro em solicitações duplicadas forçaria os dispositivos IoT a tentar novamente indefinidamente, agravando potencialmente
problemas de estrangulamento. O objetivo é processar a solicitação, mesmo que seja duplicada, em vez de rejeitá-la.
A opção D (ElastiCache Memcached) não é ideal para armazenamento persistente de dados. Memcached é um recurso na memória
serviço de armazenamento em cache e os dados poderão ser perdidos se o cache for limpo ou se a instância falhar. Para idempotência, você precisa de um
loja durável. A verificação persistente necessária para evitar execuções duplicadas requer um armazenamento durável.
Em resumo, a escalabilidade, a baixa latência e a persistência do DynamoDB fazem dele a melhor escolha para implementação
idempotência em um aplicativo API sem servidor com alto potencial para solicitações duplicadas.

---

## Questão 28

Uma empresa hospeda um aplicativo Web do lado do cliente para uma de suas subsidiárias no Amazon S3. A aplicação web pode
ser acessado por meio do Amazon CloudFront em https://www.example.com. Após uma implementação bem-sucedida, a empresa
deseja hospedar mais três aplicativos Web do lado do cliente para suas subsidiárias restantes em três buckets S3 separados.
Para atingir esse objetivo, um desenvolvedor move todos os arquivos JavaScript e fontes da web comuns para um bucket central do S3 que
atende as aplicações web. Porém, durante os testes, o desenvolvedor percebe que o navegador bloqueia o JavaScript
arquivos e fontes da web.
O que o desenvolvedor deve fazer para evitar que o navegador bloqueie os arquivos JavaScript e as fontes da web?

- A.Crie quatro pontos de acesso que permitam acesso ao bucket S3 central. Atribua um ponto de acesso a cada web
balde de aplicativos.
- B.Crie uma política de bucket que permita acesso ao bucket S3 central. Anexe a política de bucket ao S3 central
balde
- C.Criar uma configuração de compartilhamento de recursos de origem cruzada (CORS) que permita acesso ao bucket S3 central. Adicionar
a configuração do CORS para o bucket S3 central.
- D.Crie um cabeçalho Content-MD5 que forneça uma verificação de integridade da mensagem para o bucket S3 central. Insira o
Cabeçalho Content-MD5 para cada solicitação de aplicativo da web.

**Resposta: C**

**Explicação:**

O problema surge porque os arquivos JavaScript e as fontes da web agora estão sendo servidos de uma origem diferente
(o bucket S3 central) do que os próprios aplicativos da web (os buckets S3 individuais para cada subsidiária).
Isso viola a Política de Mesma Origem do navegador, que impede que páginas da web façam solicitações para um endereço diferente.
domínio diferente daquele que serviu a página web. Os navegadores implementam esse recurso de segurança para evitar
scripts maliciosos acessem dados confidenciais de outros sites.
Para superar isso, a solução correta é configurar o Cross-Origin Resource Sharing (CORS) no S3 central
balde. CORS é um mecanismo que usa cabeçalhos HTTP para instruir os navegadores a fornecer uma aplicação web em execução em
uma origem, acesso a recursos selecionados de uma origem diferente. Ao adicionar uma configuração CORS ao centro
Bucket S3, o desenvolvedor concede explicitamente permissão para os aplicativos da web hospedados em outros buckets S3
(ou example.com via CloudFront) para acessar os arquivos JavaScript e fontes da web. Isso informa ao navegador que é
seguro para permitir solicitações de origem cruzada.
A opção A está incorreta porque os pontos de acesso S3 servem principalmente para gerenciar o controle de acesso de uma forma mais granular.
nível dentro do intervalo, não para resolver problemas de origem cruzada. Eles não lidam diretamente com o CORS.
A opção B não é suficiente. Uma política de bucket controla quais contas da AWS e principais do IAM podem acessar o S3
balde. Embora uma política de bucket seja essencial para a segurança geral, ela não aborda a política de mesma origem
imposta por navegadores da web. O navegador verifica os cabeçalhos CORS, não a política do bucket, para determinar se um
solicitação de origem cruzada é permitida.
A opção D está incorreta porque o cabeçalho Content-MD5 serve para verificar a integridade dos dados, não para endereçar CORS
questões. Verifica se os dados recebidos são iguais aos dados que foram enviados e não têm nada a ver com o
política de segurança do navegador para solicitações de origem cruzada.
Portanto, a configuração do CORS no bucket S3 central é o método apropriado e padrão para resolver este problema.
problema específico. Permite ao navegador entender que as aplicações web estão autorizadas a acessar o
recursos no bucket central, evitando assim o bloqueio de arquivos JavaScript e fontes da web.
Pesquisa adicional:
CORS na AWS
Política de Mesma Origem
CORS

---

## Questão 29

Um aplicativo está processando dados de clickstream usando o Amazon Kinesis. O feed de dados de clickstream no Kinesis
experimenta picos periódicos. A chamada da API PutRecords falha ocasionalmente e os logs mostram que a chamada com falha
retorna a resposta mostrada abaixo:
Quais técnicas ajudarão a mitigar essa exceção? (Escolha dois.)

- A.Implementar novas tentativas com espera exponencial.
- B.Use uma API PutRecord em vez de PutRecords.
- C.Reduzir a frequência e/ou tamanho das solicitações.
- D.Use Amazon SNS em vez de Kinesis.
E.Reduzir o número de consumidores KCL.

**Resposta: AC**

**Explicação:**

AC conforme AWS: Exceção de taxa de transferência provisionada excedida A taxa de solicitação para o fluxo é muito alta ou
os dados solicitados são muito grandes para o rendimento disponível. Reduza a frequência ou o tamanho de suas solicitações.
Para obter mais informações, consulte Limites de streams no Guia do desenvolvedor do Amazon Kinesis Data Streams e Erro
Novas tentativas e recuo exponencial na AWS no AWS Geral
Referência.
https://docs.aws.amazon.com/kinesis/latest/APIReference/API_PutRecords.html

---

## Questão 30

Uma empresa tem um aplicativo que usa grupos de usuários do Amazon Cognito como provedor de identidade. A empresa deve
acesso seguro aos registros do usuário. A empresa configurou a autenticação multifator (MFA). A empresa também quer
para enviar uma notificação de atividade de login por e-mail sempre que um usuário fizer login.
Qual é a solução operacionalmente MAIS eficiente que atende a esse requisito?

- A.Crie uma função AWS Lambda que use Amazon Simple Email Service (Amazon SES) para enviar o email
notificação. Adicione uma API do Amazon API Gateway para invocar a função. Chame a API do lado do cliente quando
a confirmação de login é recebida.
- B.Crie uma função AWS Lambda que use Amazon Simple Email Service (Amazon SES) para enviar o email
notificação. Adicione um gatilho Lambda pós-autenticação do Amazon Cognito para a função.
- C.Crie uma função AWS Lambda que use Amazon Simple Email Service (Amazon SES) para enviar o email
notificação. Crie um filtro de assinatura de log do Amazon CloudWatch Logs para invocar a função com base no
status de login.
- D.Configure o Amazon Cognito para transmitir todos os logs para o Amazon Kinesis Data Firehose. Crie um AWS Lambda
função para processar os logs transmitidos e enviar a notificação por e-mail com base no status de login de cada usuário.

**Resposta: B**

**Explicação:**

A resposta correta é B. Aqui está uma justificativa detalhada:
A opção B é a solução operacionalmente mais eficiente porque aproveita a integração integrada entre
Amazon Cognito e AWS Lambda por meio de gatilhos Cognito. Especificamente, o gatilho "Pós-autenticação" é
projetado para executar uma função Lambda após a autenticação bem-sucedida de um usuário. Isso significa que o Lambda
função recebe automaticamente os dados do evento relacionados ao login, incluindo detalhes do usuário e autenticação
contexto, facilitando a extração das informações necessárias para a notificação por e-mail. Isto elimina o
necessidade de qualquer pesquisa personalizada, chamadas de API ou análise de log complexa.
Usar um gatilho Cognito simplifica a implementação e manutenção. Cognito lida com a invocação do Lambda
função no ponto apropriado no fluxo de autenticação. Isso reduz a sobrecarga operacional, pois você
não precisa gerenciar a lógica de invocação sozinho. Além disso, o mecanismo de disparo é confiável e dimensionável
automaticamente com o serviço Cognito.
Veja por que outras opções são menos eficientes:
R: Chamar um endpoint do API Gateway do lado do cliente apresenta complexidade e possível falta de confiabilidade. O
o código do lado do cliente precisaria lidar com novas tentativas e cenários de erro. Além disso, depende do cliente para
acionar a notificação, tornando-a menos confiável do que um acionador do lado do servidor. Também introduz custos desnecessários
e sobrecarga operacional por meio do API Gateway.
C: O uso do CloudWatch Logs e de um filtro de assinatura de log requer a análise de dados de log para determinar eventos de login.
Isso adiciona complexidade à função Lambda e pode ser menos confiável que os gatilhos diretos. Além disso,
depender de logs para eventos em tempo real pode ser mais lento devido à agregação de logs e à latência de processamento.
D: O streaming de logs para o Kinesis Data Firehose e o processamento deles com o Lambda adicionam
complexidade. Envolve configurar e gerenciar o Kinesis Data Firehose, lidar com possíveis entregas de dados
problemas e análise de dados de log complexos. Essa abordagem é excessivamente complexa para uma simples notificação de login. Isso
introduz custos e complexidade operacional que não são justificados.
Portanto, aproveitar o gatilho Lambda "Pós-autenticação" no Cognito (opção B) fornece o máximo
solução simplificada, eficiente e confiável para enviar notificações de atividades de login.
Links de apoio:
Acionadores Lambda do Amazon Cognito: https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-
pools de identidade de usuário trabalhando com aws-lambda-triggers.html
Amazon SES: https://aws.amazon.com/ses/

---

## Questão 35

Um desenvolvedor deseja inserir um registro em uma tabela do Amazon DynamoDB assim que um novo arquivo for adicionado a uma tabela do Amazon
Balde S3.
Qual conjunto de etapas seria necessário para conseguir isso?

- A.Crie um evento com o Amazon EventBridge que monitorará o bucket S3 e, em seguida, inserirá os registros no
DynamoDB.
- B.Configurar um evento S3 para invocar uma função AWS Lambda que insere registros no DynamoDB.
- C.Crie uma função AWS Lambda que pesquisará o bucket S3 e, em seguida, inserirá os registros no DynamoDB.
- D.Crie um cron job que será executado em um horário agendado e insira os registros no DynamoDB.

**Resposta: B**

**Explicação:**

A melhor abordagem para inserir registros automaticamente em uma tabela DynamoDB ao adicionar um novo arquivo a um S3
bucket é a opção B: configure um evento S3 para invocar uma função AWS Lambda que insere registros em
DynamoDB.
Eis o porquê: os eventos S3 permitem que você acione ações automaticamente quando eventos específicos ocorrem em seu S3
bucket, como criação de objeto (adicionar um novo arquivo). Ao configurar uma notificação de evento para s3:ObjectCreated:*,
você pode garantir que sempre que um novo objeto for carregado, o evento será acionado.
O AWS Lambda fornece computação sem servidor, permitindo executar código sem provisionar ou gerenciar
servidores. Você pode criar uma função Lambda que receba os dados de eventos do S3 (que incluem informações sobre
o arquivo recém-adicionado, como nome, tamanho e intervalo) e, em seguida, extrair informações relevantes para construir um
registro para a tabela do DynamoDB. A função Lambda pode então usar o AWS SDK para inserir esse registro no
Tabela DynamoDB.
Essa abordagem é eficiente, escalonável e econômica porque o Lambda só é executado quando acionado pelo S3
evento e você paga apenas pelo tempo de computação usado. É uma arquitetura totalmente gerenciada e orientada a eventos, que é
ideal para este cenário.
A opção A (Amazon EventBridge) é menos direta. Embora o EventBridge possa monitorar o S3, ele adiciona uma camada desnecessária
de complexidade em comparação com notificações de eventos S3. O EventBridge é mais adequado para roteamento de eventos complexos e
cenários de transformação, que não são necessários aqui.
A opção C (sondagem Lambda S3) é altamente ineficiente. A votação envolve a verificação repetida de novos arquivos, o que
desperdiça recursos de computação e introduz latência. Abordagens orientadas a eventos são sempre preferidas às pesquisas
em tais cenários.
A opção D (Cron job) também é inadequada porque depende de um cronograma fixo, o que significa que o registro
a inserção pode ser adiada até a próxima execução agendada. Isto anula a exigência de inserir o
grave assim que um novo arquivo for adicionado.
Portanto, configurar diretamente um evento S3 para acionar uma função Lambda é a maneira mais eficiente, responsiva e
solução econômica para este caso de uso.
Mais pesquisas podem ser feitas sobre:
Notificações de eventos S3: https://docs.aws.amazon.com/AmazonS3/latest/userguide/EventNotifications.html
AWS Lambda: https://aws.amazon.com/lambda/
DynamoDB: https://aws.amazon.com/dynamodb/

---

## Questão 36

Uma equipe de desenvolvimento mantém um aplicativo web usando um único modelo do AWS CloudFormation. O modelo
define servidores web e um banco de dados Amazon RDS. A equipe usa o modelo Cloud Formation para implantar o
Pilha de Cloud Formation para diferentes ambientes.
Durante uma implantação recente de aplicativo, um desenvolvedor fez com que o banco de dados de desenvolvimento primário fosse descartado e
recriado. O resultado deste incidente foi uma perda de dados. A equipe precisa evitar a exclusão acidental do banco de dados em
o futuro.
Quais soluções atenderão a esses requisitos? (Escolha dois.)

- A.Adicionar um atributo de política de exclusão do CloudFormation com o valor Retain ao recurso de banco de dados.
- B.Atualizar a política de pilha do CloudFormation para evitar atualizações no banco de dados.
- C.Modificar o banco de dados para usar uma implantação Multi-AZ.
- D.Criar um conjunto de pilhas CloudFormation para implantações de aplicativos da web e bancos de dados.
E.Adicione um atributo DeletionPolicy do Cloud Formation com o valor Retain à pilha.

**Resposta: AB**

**Explicação:**

As respostas corretas são A e B. Eis o porquê:
A. Adicione um atributo CloudFormation DeletionPolicy com o valor Retain ao recurso de banco de dados.
O atributo DeletionPolicy no CloudFormation controla o que acontece com um recurso quando sua pilha é excluída
ou atualizado de uma forma que remova o recurso. Configurando DeletionPolicy: Reter o recurso de banco de dados
garante que se a pilha do CloudFormation for excluída ou se o recurso do banco de dados for removido do modelo
durante uma atualização, o próprio banco de dados não é excluído. Em vez disso, ele é mantido como está, fora do CloudFormation
controle. Isso evita exclusão acidental e perda de dados.
Conceito: gerenciamento do ciclo de vida de recursos do CloudFormation.
Benefício: Durabilidade dos dados, evitando a remoção acidental do banco de dados pelo CloudFormation.
Link relevante: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-
deletionpolicy.html
B. Atualize a política de pilha do CloudFormation para evitar atualizações no banco de dados.
Uma política de pilha do CloudFormation é um documento JSON que define as ações de atualização que podem ser executadas em
recursos específicos em uma pilha. Criando uma política de pilha que nega explicitamente atualizações no banco de dados
recurso, a equipe pode evitar quaisquer modificações acidentais ou não intencionais no esquema do banco de dados, configurações e
ou exclusão por meio de atualizações do CloudFormation. Isto fornece uma forte salvaguarda contra modificações do
banco de dados via CloudFormation.
Conceito: Governança e controle baseados em políticas de pilha do CloudFormation.
Benefício: evita modificações acidentais no banco de dados por meio de atualizações de pilha.
Link relevante: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/protect-stack-
recursos.html
Por que as outras opções estão incorretas:
C. Modifique o banco de dados para usar uma implantação Multi-AZ. A implantação Multi-AZ aumenta a disponibilidade do banco de dados
fornecendo uma réplica em espera em uma zona de disponibilidade diferente. Não evita banco de dados acidental
exclusão, que é a questão central.
D. Crie um conjunto de pilhas do CloudFormation para implantações de aplicativos da web e de banco de dados. Conjuntos de pilhas
facilitar a implantação de pilhas do CloudFormation em várias contas e regiões da AWS. Embora útil para
organização e consistência, não impede inerentemente a exclusão acidental do banco de dados dentro de uma pilha.
E. Adicione um atributo DeletionPolicy do Cloud Formation com o valor Retain à pilha. A política de exclusão
aplica-se aos recursos dentro de uma pilha, não à pilha em si. Adicionar DeletionPolicy à pilha em si não
proteger o recurso do banco de dados.

---

## Questão 40

Uma empresa implantou infraestrutura na AWS. Uma equipe de desenvolvimento deseja criar uma função AWS Lambda
que recuperará dados de um banco de dados Amazon Aurora. O banco de dados Amazon Aurora está em uma sub-rede privada em
VPC da empresa. A VPC é denominada VPC1. Os dados são de natureza relacional. A função Lambda precisa acessar o
dados com segurança.
Qual solução atenderá a esses requisitos?

- A.Crie a função Lambda. Configure o acesso VPC1 para a função. Anexe um grupo de segurança chamado SG1 ao
tanto a função Lambda quanto o banco de dados. Configure as regras de entrada e saída do grupo de segurança para permitir
Tráfego TCP na porta 3306.
- B.Criar e iniciar uma função Lambda em uma nova sub-rede pública que esteja em uma nova VPC chamada VPC2. Crie um
conexão de peering entre VPC1 e VPC2.
- C.Crie a função Lambda. Configure o acesso VPC1 para a função. Atribua um grupo de segurança chamado SG1 para
a função Lambda. Atribua um segundo grupo de segurança denominado SG2 ao banco de dados. Adicione uma regra de entrada ao SG1
para permitir o tráfego TCP da porta 3306.
- D.Exportar os dados do banco de dados Aurora para Amazon S3. Crie e inicie uma função Lambda em VPC1.
Configure a função Lambda para consultar os dados do Amazon S3.

**Resposta: A**

**Explicação:**

Aqui está uma justificativa detalhada de por que a opção A é a solução mais adequada, juntamente com explicações do porquê
as outras opções são menos ideais:
Por que a opção A é a melhor escolha:
A opção A fornece um método seguro e eficiente para uma função Lambda acessar um banco de dados Aurora em um
VPC:
1. Integração VPC: Colocando a função Lambda na mesma VPC (VPC1) do banco de dados Aurora
permite que ele se comunique diretamente sem atravessar a Internet ou exigir endereços IP públicos.
Isto aumenta significativamente a segurança, mantendo o tráfego dentro da rede privada.
2. Grupos de segurança: os grupos de segurança atuam como firewalls virtuais, controlando o tráfego de entrada e saída em
o nível da instância. Ao anexar um grupo de segurança (SG1) à função Lambda e ao Aurora
banco de dados, você pode controlar com precisão o tráfego permitido entre eles.
3. Porta 3306 (porta padrão MySQL/Aurora): configurando o grupo de segurança para permitir tráfego TCP em
a porta 3306 (a porta padrão para MySQL e Aurora) permite que a função Lambda se conecte ao
servidor de banco de dados.
4. Mínimo Privilégio: Esta solução permite restringir o acesso apenas à porta necessária (3306) e apenas
entre a função Lambda e o banco de dados. Isto segue o princípio do menor privilégio,
minimizando a superfície de ataque.
5. Evitando complexidade desnecessária: Esta solução evita configurações de rede desnecessárias (peering
conexões na Opção B) ou movimentação de dados (exportando dados para S3 na Opção D).
Em resumo, a Opção A aproveita a integração de VPC e grupos de segurança para estabelecer um ambiente seguro e direto
conexão entre a função Lambda e o banco de dados Aurora, aderindo às melhores práticas de segurança
e projeto de rede.
Por que outras opções são menos adequadas:
Opção B (peering e sub-rede pública): criar uma nova VPC (VPC2) com uma sub-rede pública e depois fazer peering
com VPC1 adiciona complexidade desnecessária e riscos potenciais à segurança. As sub-redes públicas expõem as instâncias ao
internet, o que é indesejável para acesso ao banco de dados. O peering introduz sobrecarga de configuração adicional.
Opção C (regra de entrada somente no Lambda SG1): A opção C tem falha crítica de segurança. Você não deve configurar
regras de entrada no SG1. As regras de entrada são para conexões que chegam ao recurso, e as regras de saída são para
tráfego iniciado a partir do recurso. Portanto, o banco de dados SG2 precisa ter a regra de entrada que aceite
tráfego na porta 3306 do SG1 do lambda.
Opção D (Exportar para S3): Exportar os dados para S3 introduz complexidade, latência e custos desnecessários. Isso
também prejudica a natureza em tempo real dos dados relacionais. A leitura do S3 é geralmente mais lenta e menos eficiente
do que consultar um banco de dados diretamente para cenários de dados relacionais. Muda o tipo de carga de trabalho para lote,
que não atende ao requisito da função Lambda recuperando dados do banco de dados Aurora.
Documentação de apoio:
Configuração AWS Lambda VPC: https://docs.aws.amazon.com/lambda/latest/dg/services-vpc.html
Grupos de segurança da Amazon VPC: https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html
Conectando Lambda ao RDS: https://aws.amazon.com/blogs/compute/connecting-aws-lambda-functions-to-
amazon-rds-using-data-api/ (embora este exemplo use API de dados, os princípios de VPC e grupo de segurança
configuração é a mesma.)

---

## Questão 44

Um desenvolvedor está projetando um aplicativo sem servidor com duas funções AWS Lambda para processar fotos. Um lambda
A função armazena objetos em um bucket do Amazon S3 e armazena os metadados associados em um Amazon DynamoDB
mesa. A outra função Lambda busca os objetos do bucket S3 usando os metadados do
Tabela DynamoDB. Ambas as funções Lambda usam a mesma biblioteca Python para realizar cálculos complexos e são
aproximando-se da cota para o tamanho máximo de pacotes de implantação compactados.
O que o desenvolvedor deve fazer para reduzir o tamanho dos pacotes de implantação do Lambda com o MENOS operacional
sobrecarga?

- A. Empacote cada biblioteca Python em seu próprio arquivo .zip. Implante cada função do Lambda com sua própria cópia do
biblioteca.
- B.Crie uma camada Lambda com a biblioteca Python necessária. Use a camada Lambda em ambas as funções Lambda.
- C.Combine as duas funções Lambda em uma função Lambda. Implante a função Lambda como um único arquivo .zip
arquivo.
- D. Baixe a biblioteca Python para um bucket S3. Programe as funções do Lambda para fazer referência aos URLs dos objetos.

**Resposta: B**

**Explicação:**

A resposta correta é B: Crie uma camada Lambda com a biblioteca Python necessária. Use a camada Lambda em ambos
Funções lambda.
Aqui está uma justificativa detalhada:
Camadas Lambda são um mecanismo para empacotar dependências, como bibliotecas, separadamente do Lambda
código de função. Isto resolve o problema de exceder os limites de tamanho do pacote de implantação, que é precisamente
o cenário descrito. As funções Lambda são limitadas no tamanho de seus pacotes de implantação e
tamanho descompactado após a implantação. Quando várias funções do Lambda compartilham a mesma dependência (neste
caso, a biblioteca Python), empacotar essa dependência separadamente como uma camada evita duplicação redundante de
a biblioteca no pacote de implantação de cada função.
A opção B proporciona a menor sobrecarga operacional por vários motivos. Ao contrário da opção A, evita manter
cópias separadas da biblioteca. A opção C, combinando as funções Lambda, pode não ser viável ou desejável se
as funções servem a propósitos distintos ou precisam ser dimensionadas de forma independente. Também muda a arquitetura
substancialmente. A opção D introduz sobrecarga operacional e complexidade significativas porque o Lambda
funções precisariam baixar a biblioteca do S3 sempre que fossem invocadas. Isso adiciona latência e
aumenta o risco de falha se o bucket S3 não estiver disponível. Além disso, isso cria
custos de entrada/saída para S3 em cada invocação. As camadas lambda, por outro lado, estão prontamente disponíveis para
Funções Lambda e não adiciona sobrecarga ao tempo de execução de cada invocação, uma vez implantada.
O uso de camadas Lambda oferece vários benefícios, incluindo tamanhos reduzidos de pacotes de implantação, implantação mais rápida
vezes, capacidade de reutilização de código e gerenciamento simplificado de dependências. As camadas são versionadas, o que permite que você
atualize bibliotecas e reverta facilmente para versões anteriores, se necessário. Isso fornece controle e resiliência em seu
implantações de aplicativos sem servidor. A sobrecarga operacional é mínima, pois a AWS gerencia a camada
disponibilidade e integridade. Ao aproveitar as camadas Lambda, o desenvolvedor pode lidar com eficiência com o tamanho
restrições, mantendo uma arquitetura limpa e sustentável.
Para pesquisas adicionais, consulte a documentação do AWS Lambda:
Camadas AWS Lambda: https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html

---

## Questão 45

Um desenvolvedor está escrevendo uma função AWS Lambda. O desenvolvedor deseja registrar os principais eventos que ocorrem enquanto o
A função Lambda é executada. O desenvolvedor deseja incluir um identificador exclusivo para associar os eventos a um determinado
invocação de função. O desenvolvedor adiciona o seguinte código à função Lambda:
Qual solução atenderá a esse requisito?

- A. Obtenha o identificador de solicitação do campo ID de solicitação da AWS no objeto de contexto. Configure o aplicativo para
gravar logs na saída padrão.
- B. Obtenha o identificador de solicitação no campo ID de solicitação da AWS no objeto de evento. Configure o aplicativo para
gravar logs em um arquivo.
- C.Obtenha o identificador da solicitação no campo ID da solicitação da AWS no objeto de evento. Configure o aplicativo para
gravar logs na saída padrão.
- D.Obtenha o identificador da solicitação no campo ID da solicitação da AWS no objeto de contexto. Configure o aplicativo para
gravar logs em um arquivo.

**Resposta: A**

**Explicação:**

Ahttps://docs.aws.amazon.com/lambda/latest/dg/nodejs-
context.htmlhttps://docs.aws.amazon.com/lambda/latest/dg/nodejs-logging.htmlNão há nenhum explícito
informações para o tempo de execução, o código é escrito em Node.js.
Tanto A quanto D poderiam funcionar aqui, pois ambos dependem do objeto de contexto para obter acesso ao ID de execução
https://docs.aws.amazon.com/us_en/lambda/latest/dg/python-context.html Enquanto A usa stoud para enviar log para
Cloud Watch Log, D grava em um arquivo. D é menos específico (onde o arquivo está armazenado? Um único arquivo para cada
execução?) e parece mais complexo (gerenciar arquivo(s), gerenciar acesso simultâneo ao arquivo.), então irei para
Um

---

## Questão 46

Um desenvolvedor está trabalhando em um aplicativo sem servidor que precisa processar quaisquer alterações em um Amazon DynamoDB
tabela com uma função AWS Lambda.
Como o desenvolvedor deve configurar a função Lambda para detectar alterações na tabela do DynamoDB?

- A.Crie um fluxo de dados do Amazon Kinesis e anexe-o à tabela do DynamoDB. Crie um gatilho para conectar o
fluxo de dados para a função Lambda.
- B.Crie uma regra do Amazon EventBridge para invocar a função Lambda regularmente. Convidado para o
Tabela DynamoDB da função Lambda para detectar alterações.
- C.Habilitar fluxos do DynamoDB na mesa. Crie um gatilho para conectar o stream do DynamoDB ao Lambda
função.
- D.Crie um fluxo de entrega do Amazon Kinesis Data Firehose e anexe-o à tabela DynamoDB. Configurar o
destino do fluxo de entrega como a função Lambda.

**Resposta: C**

**Explicação:**

A resposta correta é C porque utiliza DynamoDB Streams, que é o mecanismo direto e pretendido
para capturar alterações em uma tabela do DynamoDB e acionar uma função Lambda. DynamoDB Streams registra todos
modificações de dados (inserções, atualizações, exclusões) em uma tabela do DynamoDB quase em tempo real e na ordem em que
ocorreu. A ativação do DynamoDB Streams captura automaticamente esses eventos.
Uma função Lambda pode então ser configurada como um gatilho para o stream do DynamoDB. Quando ocorre uma mudança
tabela do DynamoDB, o stream recebe o evento e o gatilho invoca a função Lambda, passando o
dados do evento como entrada. Isso permite que a função Lambda processe as alterações de forma assíncrona e em
resposta a atualizações em tempo real.
A opção A está incorreta porque o uso do Kinesis Data Streams não é o método padrão para capturar o DynamoDB
mudanças. Embora seja tecnicamente possível, exigiria configurações mais complexas e personalizadas, como escrever em
o fluxo do Kinesis do código do aplicativo e não é o caso de uso pretendido. O DynamoDB Streams fornece um
solução gerenciada e integrada, muito mais simples e eficiente.
A opção B está incorreta porque a pesquisa da tabela DynamoDB da função Lambda em uma programação é
ineficiente, caro e não em tempo real. Isso consumiria unidades de capacidade de leitura desnecessárias e poderia perder
muda se o intervalo de pesquisa for muito longo. O EventBridge geralmente é usado para eventos baseados em agendamento e eventos.
invocações de outros serviços e aplicativos da AWS, mas não é uma forma direta de capturar alterações do DynamoDB.
A opção D está incorreta porque o Kinesis Data Firehose foi projetado principalmente para carregar dados de streaming em dados
lagos, data warehouses e serviços de análise, como Amazon S3, Amazon Redshift e Splunk. Não é
destinado ao processamento em tempo real de alterações do DynamoDB por funções Lambda. Data Firehose se concentra em
entrega em lote de dados e não aciona funções inerentemente para cada alteração individual.
Em resumo, o uso de Streams do DynamoDB e um gatilho Lambda fornece a solução mais eficiente, econômica e
método em tempo real para processar alterações do DynamoDB com uma função Lambda sem servidor.
Links autorizados:
Fluxos do DynamoDB: https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Streams.html
Usando AWS Lambda com DynamoDB: https://docs.aws.amazon.com/lambda/latest/dg/with-ddb.html

---

## Questão 48

Um desenvolvedor está criando uma função AWS Lambda que precisa de credenciais para se conectar a um Amazon RDS for MySQL
banco de dados. Atualmente, um bucket do Amazon S3 armazena as credenciais. O desenvolvedor precisa melhorar o existente
solução implementando rotação de credenciais e armazenamento seguro. O desenvolvedor também precisa fornecer integração
com a função Lambda.
Qual solução o desenvolvedor deve usar para armazenar e recuperar as credenciais com o MENOS gerenciamento
sobrecarga?

- A. Armazene as credenciais no AWS Systems Manager Parameter Store. Selecione o banco de dados que o parâmetro irá
acesso. Use a chave padrão do AWS Key Management Service (AWS KMS) para criptografar o parâmetro. Habilitar
rotação automática para o parâmetro. Use o parâmetro do Parameter Store na função Lambda para
conectar-se ao banco de dados.
- B. Criptografar as credenciais com a chave padrão do AWS Key Management Service (AWS KMS). Armazene o
credenciais como variáveis de ambiente para a função Lambda. Crie uma segunda função Lambda para gerar
novas credenciais e alterná-las atualizando as variáveis de ambiente do primeiro Lambda
função. Invoque a segunda função do Lambda usando uma regra do Amazon EventBridge executada de acordo com uma programação.
Atualize o banco de dados para usar as novas credenciais. Na primeira função do Lambda, recupere as credenciais do
variáveis de ambiente. Descriptografe as credenciais usando AWS KMS, conecte-se ao banco de dados.
- C. Armazene as credenciais no AWS Secrets Manager. Defina o tipo de segredo como Credenciais para banco de dados Amazon RDS.
Selecione o banco de dados que o segredo acessará. Use a chave padrão do AWS Key Management Service (AWS KMS)
para criptografar o segredo. Ative a rotação automática para o segredo. Use o segredo do Secrets Manager na página
Função Lambda para conectar-se ao banco de dados.
- D.Criptografar as credenciais usando o AWS Key Management Service (AWS KMS). Armazene as credenciais em um
Tabela do Amazon DynamoDB. Crie uma segunda função Lambda para alternar as credenciais. Invoque o segundo
Função Lambda usando uma regra do Amazon EventBridge executada de acordo com uma programação. Atualize a tabela do DynamoDB.
Atualize o banco de dados para usar as credenciais geradas. Recupere as credenciais do DynamoDB com o primeiro
Função lambda. Conecte-se ao banco de dados.

**Resposta: C**

**Explicação:**

Aqui está uma justificativa detalhada de por que a opção C é a melhor solução e por que as outras opções são menos ideais,
considerando os requisitos de armazenamento seguro, rotação de credenciais, sobrecarga mínima de gerenciamento e fácil
integração com uma função Lambda:
Por que a opção C (AWS Secrets Manager) é a melhor solução:
Desenvolvido especificamente para credenciais: o AWS Secrets Manager foi projetado especificamente para armazenar e
gerenciar informações confidenciais, como credenciais de banco de dados. Oferece recursos integrados que simplificam o processo
em comparação com soluções de armazenamento genéricas.
Rotação automática: o Secrets Manager permite a rotação automatizada de credenciais de banco de dados sem exigir
código personalizado. Isso reduz drasticamente a sobrecarga de gerenciamento e melhora a postura de segurança ao
alterando credenciais.
Fácil integração: Secrets Manager possui integração direta com funções Lambda. Você pode recuperar segredos
com uma simples chamada de API, que reduz a complexidade do código e melhora a segurança centralizando credenciais
gestão.
Criptografia: o Secrets Manager criptografa segredos em repouso e em trânsito usando o AWS KMS. Isto fornece um
camada adicional de segurança. A chave KMS padrão simplifica a configuração, mas você pode usar sua própria CMK para obter mais informações
controle.
Integração RDS: o Secrets Manager possui um tipo de segredo específico "Credenciais para banco de dados Amazon RDS", que
simplifica a configuração e o gerenciamento de credenciais RDS, tornando a integração perfeita.
Por que outras opções não são ideais:
Opção A (Systems Manager Parameter Store): O Parameter Store é um bom armazenamento de uso geral, mas não
especializado em gerenciamento ou rotação de credenciais. Embora as strings seguras possam ser criptografadas, a rotação automática
requer scripts e gerenciamento personalizados, o que aumenta a sobrecarga.
Opção B (função Lambda com KMS e variáveis de ambiente): armazenar credenciais como ambiente
variáveis é geralmente desencorajado devido à exposição potencial através de registros ou introspecção de função. Criando
uma função Lambda separada para rotação adiciona complexidade desnecessária.
Opção D (função Lambda com KMS e DynamoDB): semelhante à opção B, esta abordagem envolve mais
configuração manual e código para rotação e recuperação. O gerenciamento de credenciais no DynamoDB também não possui o
recursos específicos de segurança e rotação oferecidos pelo Secrets Manager.
Em resumo: o AWS Secrets Manager oferece uma solução completa e integrada para armazenar, recuperar e
credenciais de banco de dados rotativas, com sobrecarga mínima de gerenciamento. Isso o torna a melhor escolha para determinado
cenário.
Links autorizados:
Gerenciador de segredos da AWS: https://aws.amazon.com/secrets-manager/
Rotação de segredos do AWS Secrets Manager:
https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotating-secrets.html
Acessando segredos do AWS Secrets Manager do AWS Lambda:
https://aws.amazon.com/blogs/security/access-secrets-stored-in-aws-secrets-manager-from-aws-lambda/

---

## Questão 49

Um desenvolvedor escreveu a seguinte política do IAM para fornecer acesso a um bucket do Amazon S3:
Qual acesso a política permite em relação às ações s3:GetObject e s3:PutObject?

- A. Acesso em todos os buckets, exceto o bucket “DOC-EXAMPLE-BUCKET”
- B.Acesso em todos os buckets que começam com “DOC-EXAMPLE-BUCKET” exceto o “DOC-EXAMPLE-
BALDE/segredos” balde
- C.Acesso a todos os objetos no bucket “DOC-EXAMPLE-BUCKET” junto com acesso a todas as ações S3 para objetos
no intervalo “DOC-EXAMPLE-BUCKET” que começa com “segredos”
- D.Acesso a todos os objetos no bucket “DOC-EXAMPLE-BUCKET”, exceto em objetos que começam com “segredos”

**Resposta: D**

**Explicação:**

Acesso em todos os objetos no bucket “DOC-EXAMPLE-BUCKET”, exceto em objetos que começam com “segredos”
Referência:
https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-with-s3-actions.html

---

## Questão 50

Um desenvolvedor está criando um aplicativo móvel que chama um serviço de back-end usando uma API REST do Amazon API Gateway. Para
testes de integração durante a fase de desenvolvimento, o desenvolvedor deseja simular diferentes respostas de back-end
sem invocar o serviço de back-end.
Qual solução atenderá a esses requisitos com a MENOS sobrecarga operacional?

- A.Crie uma função AWS Lambda. Use a integração de proxy do API Gateway para retornar respostas HTTP constantes.
- B. Criar uma instância do Amazon EC2 que sirva a API REST de back-end usando um AWS CloudFormation
modelo.
- C.Personalize o estágio API Gateway para selecionar um tipo de resposta com base na solicitação.
- D.Use um modelo de mapeamento de solicitação para selecionar a resposta de integração simulada.

**Resposta: D**

**Explicação:**

A solução mais eficiente é utilizar os modelos de mapeamento de solicitações do API Gateway para gerar simulações
respostas de integração (Opção D). Os modelos de mapeamento de solicitação permitem transformar a solicitação recebida
e construir uma resposta estática diretamente no API Gateway, ignorando totalmente o serviço de back-end. Isto
evita a sobrecarga operacional associada ao gerenciamento de uma função Lambda (Opção A) ou de um EC2 completo
instância (Opção B) apenas para fins de simulação. Personalizar o estágio API Gateway (Opção C) não é o
abordagem correta. Os estágios destinam-se a gerenciar diferentes ambientes de implantação e não a simular respostas.
Os modelos de mapeamento de solicitações não têm servidor e são fáceis de configurar. Você define a resposta HTTP desejada
código, cabeçalhos e corpo diretamente no modelo. O API Gateway cuida do fornecimento da resposta com base no
mapeamento, sem invocar qualquer serviço downstream. Isso reduz significativamente a latência em comparação ao proxy
até mesmo uma função Lambda simples. Além disso, esta solução é mais económica porque elimina
Custos de execução do Lambda ou custos de instância do EC2 incorridos pelas opções A e B, respectivamente. É uma configuração-
abordagem orientada, tornando mais fácil gerenciar e atualizar as respostas simuladas conforme necessário durante o teste. O
a curva de aprendizado para modelos de mapeamento é relativamente baixa e pode ser reutilizada para várias chamadas de API, tornando-a a
solução superior. Como a opção D fornece os meios para elaborar diretamente uma resposta definida de acordo com o
necessidades de teste do desenvolvedor, sem serviços de back-end adicionais, mantém a menor sobrecarga operacional.
Para pesquisas adicionais, consulte a documentação oficial da AWS:
Modelos de mapeamento de gateway de API
Tipos de integração de API Gateway

---

## Questão 51

Um desenvolvedor tem um aplicativo legado hospedado localmente. Outros aplicativos hospedados na AWS dependem do
aplicativo local para funcionamento adequado. Em caso de erros de aplicação, o desenvolvedor deseja poder
use o Amazon CloudWatch para monitorar e solucionar problemas de todos os aplicativos em um só lugar.
Como o desenvolvedor pode fazer isso?

- A.Instale um AWS SDK no servidor local para enviar logs automaticamente ao CloudWatch.
- B. Baixe o agente CloudWatch para o servidor local. Configure o agente para usar credenciais de usuário do IAM
com permissões para CloudWatch.
- C. Faça upload dos arquivos de log do servidor local para o Amazon S3 e faça com que o CloudWatch leia os arquivos.
- D. Faça upload de arquivos de log do servidor local para uma instância do Amazon EC2 e faça com que a instância encaminhe o
registra no CloudWatch.

**Resposta: B**

**Explicação:**

A resposta correta é B porque fornece a maneira mais direta e eficiente de enviar logs de um local
servidor local para o CloudWatch. O agente CloudWatch foi projetado especificamente para essa finalidade, permitindo
coleta de dados de log de várias fontes, incluindo servidores locais, e streaming para o CloudWatch
Registros.
A opção B sugere fazer download do agente CloudWatch no servidor local. Este agente, uma vez
configurado, monitora os arquivos de log especificados e transmite os dados para o CloudWatch Logs. O agente
A configuração envolve a configuração de credenciais de usuário do IAM com permissões para gravar no CloudWatch. Isso fornece
uma maneira segura de autenticar e autorizar o servidor local a enviar dados de log para a AWS.
A opção A está incorreta porque, embora os AWS SDKs possam interagir com o CloudWatch, eles são mais comumente usados
para interações em nível de aplicativo, em vez de encaminhamento de log em nível de sistema. Configurando um SDK para ativar ativamente
monitorar e enviar logs exigiria scripts e desenvolvimento personalizados, o que é menos eficiente do que usar o
agente CloudWatch dedicado.
A opção C não é ideal porque fazer upload de arquivos de log para o Amazon S3 e depois fazer com que o CloudWatch os leia
introduz complexidade e atrasos desnecessários. Requer escrever código para fazer upload periódico de logs para o S3 e
configurando o CloudWatch para pesquisar o S3. Isso exige menos tempo real e consome mais recursos do que usar o
Agente CloudWatch.
A opção D é menos eficiente que a opção B, porque requer a ativação de uma instância EC2 simplesmente para atuar como um
intermediário para encaminhamento de logs. Isso aumenta a sobrecarga operacional e o custo em comparação com o uso do
Agente CloudWatch diretamente no servidor local.
A solução de agente CloudWatch atende com eficiência à necessidade de monitoramento centralizado, trazendo
logs de instalações na AWS. Isso elimina a necessidade de gerenciar e carregar arquivos manualmente e fornece um único
painel de controle para monitorar aplicativos locais e baseados em nuvem, auxiliando na solução proativa de problemas
identificação e resolução.
Para obter mais informações, consulte a documentação oficial da AWS:
Agente CloudWatch: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Install-
Agente CloudWatch.html

---

## Questão 52

Um fluxo de entrega do Amazon Kinesis Data Firehose está recebendo dados do cliente que contêm informações pessoalmente identificáveis
informação. Um desenvolvedor precisa remover identificadores de clientes baseados em padrões dos dados e armazenar os dados modificados.
dados em um bucket do Amazon S3.
O que o desenvolvedor deve fazer para atender a esses requisitos?

- A.Implementar a transformação de dados do Kinesis Data Firehose como uma função AWS Lambda. Configure a função para
remova os identificadores do cliente. Defina um bucket do Amazon S3 como destino do fluxo de entrega.
- B.Iniciar uma instância do Amazon EC2. Defina a instância do EC2 como destino do fluxo de entrega. Execute um
aplicativo na instância EC2 para remover os identificadores do cliente. Armazene os dados transformados em uma Amazon
Balde S3.
- C.Crie uma instância do Amazon OpenSearch Service. Defina a instância do OpenSearch Service como destino de
o fluxo de entrega. Use pesquisar e substituir para remover os identificadores do cliente. Exporte os dados para uma Amazon
Balde S3.
- D.Crie um fluxo de trabalho do AWS Step Functions para remover os identificadores do cliente. Como última etapa do fluxo de trabalho,
armazene os dados transformados em um bucket do Amazon S3. Defina o fluxo de trabalho como destino do fluxo de entrega.

**Resposta: A**

**Explicação:**

A resposta correta é A porque ela aproveita os recursos integrados de transformação de dados do Kinesis Data Firehose
usando o AWS Lambda, fornecendo uma solução eficiente e econômica para remover PII antes que os dados cheguem ao S3.
O Kinesis Data Firehose permite a transformação de dados em tempo real usando funções Lambda, permitindo que o
limpeza de informações confidenciais, como identificadores de clientes, diretamente no fluxo de dados.
A opção A aborda diretamente o problema integrando a transformação de dados na entrega do Firehose
gasoduto. A função Lambda pode ser configurada para usar expressões regulares ou outras combinações de padrões.
técnicas para identificar e remover as informações de identificação pessoal (PII) antes que os dados sejam entregues ao
S3. Ao fazer isso, o PII nunca persiste no S3, atendendo ao requisito.
A opção B, usando uma instância EC2, introduz complexidade desnecessária e sobrecarga operacional. Gerenciando um
A instância EC2 para transformação de dados requer o gerenciamento da própria instância, do aplicativo em execução nela e
garantindo sua disponibilidade e escalabilidade. Essa abordagem é mais cara e menos eficiente do que usar o Lambda.
A opção C, usando o OpenSearch Service, não é ideal para este cenário. O OpenSearch Service foi projetado para pesquisa
e análises, não principalmente para transformação de dados. Embora pudesse ser utilizado para este fim, seria um
solução superprojetada. Além disso, exportar dados do OpenSearch para S3 adiciona uma etapa extra e potencial
latência.
A opção D, usando AWS Step Functions, também é uma solução com excesso de engenharia. Step Functions são projetadas para
orquestrar fluxos de trabalho complexos, mas neste caso, a transformação de dados é relativamente simples e pode ser
gerenciado com mais eficiência por uma função Lambda no pipeline do Kinesis Data Firehose. Usando funções de etapa
introduziria complexidade e custos desnecessários.
Portanto, usar uma função Lambda no Kinesis Data Firehose, conforme descrito na opção A, é o mais eficiente,
solução econômica e escalonável para remover PII dos dados antes de armazená-los no S3. Isto se alinha com o
melhores práticas para segurança e privacidade de dados na computação em nuvem.
Pesquisa adicional:
Transformação de dados do AWS Kinesis Data Firehose: https://docs.aws.amazon.com/firehose/latest/dev/data-
transformação.html
AWS Lambda: https://aws.amazon.com/lambda/

---

## Questão 53

Um desenvolvedor está usando uma função AWS Lambda para gerar avatares para imagens de perfil que são carregadas em um
Balde Amazon S3. A função Lambda é invocada automaticamente para imagens de perfil salvas no
/original/ Prefixo S3. O desenvolvedor percebe que algumas imagens fazem com que a função Lambda expire. O
o desenvolvedor deseja implementar um mecanismo substituto usando outra função Lambda que redimensiona o perfil
foto.
Qual solução atenderá a esses requisitos com o MENOS esforço de desenvolvimento?

- A. Defina a função Lambda de redimensionamento de imagem como destino da função Lambda do gerador de avatar para o
eventos que falham no processamento.
- B.Criar uma fila do Amazon Simple Queue Service (Amazon SQS). Defina a fila SQS como destino com um ativado
condição de falha para a função Lambda do gerador de avatar. Configure a função Lambda de redimensionamento de imagem para sondar
da fila SQS.
- C.Crie uma máquina de estado AWS Step Functions que invoque a função Lambda do gerador de avatar e use
a função Lambda de redimensionamento de imagem como um substituto. Crie uma regra do Amazon EventBridge que corresponda a eventos de
o bucket S3 para invocar a máquina de estado.
- D.Crie um tópico do Amazon Simple Notification Service (Amazon SNS). Defina o tópico SNS como destino com um
em condição de falha para a função Lambda do gerador de avatar. Assine a função Lambda de redimensionamento de imagem para
o tema SNS.

**Resposta: A**

**Explicação:**

A melhor solução é A: Definir a função Lambda de redimensionamento de imagem como destino do gerador de avatar Lambda
função para eventos que falham no processamento.
Aqui está o porquê:
Integração direta e menor esforço: os destinos Lambda fornecem uma integração direta entre funções. Se o
A função Lambda do gerador de avatar falha (expira o tempo limite ou gera um erro), a função de destino (redimensionador de imagem)
é invocado automaticamente. Isto minimiza o esforço de desenvolvimento, pois evita o gerenciamento de filas ou máquinas de estado.
Mecanismo de nova tentativa integrado: os destinos Lambda incluem um mecanismo de nova tentativa integrado que pode ser configurado,
dando à função geradora de avatar chances adicionais de sucesso antes de invocar o substituto.
Tratamento automático de erros: os destinos Lambda fornecem um mecanismo simplificado de tratamento de erros. Você não
precisa escrever código personalizado para detectar falhas e acionar o substituto, pois o Lambda lida com isso automaticamente.
Sem sobrecarga de pesquisa: a opção B requer a função de redimensionamento de imagem para pesquisar continuamente uma fila SQS, adicionando
sobrecarga e latência potencial.
Evitar complexidade: a opção C introduz uma máquina de estado Step Functions, adicionando complexidade desnecessária
para um cenário de fallback simples. Embora Step Functions sejam poderosas, elas são um exagero para este específico
exigência.
Prevenção de Fanout SNS: A Opção D utiliza SNS, que introduz um padrão de fanout desnecessário para isso
cenário. O SNS é mais adequado para transmitir mensagens para vários assinantes, e não para um único substituto
função.
Lambda Destinations on Failure fornece a abordagem mais direta, eficiente e com menor esforço para
implementar um mecanismo de fallback para falhas de função Lambda.
Links relevantes:
Destinos AWS Lambda: https://docs.aws.amazon.com/lambda/latest/dg/invocation-async.html#dlq
Tratamento de erros do AWS Lambda: https://docs.aws.amazon.com/lambda/latest/dg/services-sns.html

---

## Questão 54

Um desenvolvedor precisa migrar um aplicativo de varejo on-line para a AWS para lidar com um aumento previsto no tráfego. O
O aplicativo atualmente é executado em dois servidores: um servidor para o aplicativo da web e outro servidor para o banco de dados.
O servidor web renderiza páginas web e gerencia o estado da sessão na memória. O servidor de banco de dados hospeda um MySQL
banco de dados que contém detalhes do pedido. Quando o tráfego para o aplicativo é intenso, o uso de memória do servidor web
aproxima-se de 100% e a aplicação fica consideravelmente mais lenta.
O desenvolvedor descobriu que a maior parte do aumento de memória e da diminuição de desempenho está relacionada à carga de
gerenciar sessões de usuário adicionais. Para a migração do servidor web, o desenvolvedor utilizará instâncias Amazon EC2
com um grupo de Auto Scaling por trás de um Application Load Balancer.
Que conjunto adicional de alterações o desenvolvedor deve fazer no aplicativo para melhorar o desempenho do aplicativo?
desempenho?

- A.Use uma instância EC2 para hospedar o banco de dados MySQL. Armazene os dados da sessão e os dados do aplicativo no
Banco de dados MySQL.
- B.Use o Amazon ElastiCache for Memcached para armazenar e gerenciar os dados da sessão. Use um Amazon RDS para
Instância de banco de dados MySQL para armazenar os dados do aplicativo.
- C.Use o Amazon ElastiCache for Memcached para armazenar e gerenciar os dados da sessão e os dados do aplicativo.
- D.Use o armazenamento de instâncias do EC2 para gerenciar os dados da sessão. Use uma instância de banco de dados do Amazon RDS for MySQL para armazenar
os dados do aplicativo.

**Resposta: B**

**Explicação:**

A resposta correta é B. Use o Amazon ElastiCache for Memcached para armazenar e gerenciar os dados da sessão.
Use uma instância de banco de dados Amazon RDS for MySQL para armazenar os dados do aplicativo.
Aqui está uma justificativa detalhada:
O problema destaca que o desempenho do servidor web diminui devido à pressão de memória causada por
gerenciamento de sessão. Armazenar dados de sessão na memória do servidor web (gerenciamento de sessão na memória)
não é dimensionado horizontalmente. Cada servidor web precisa de sua própria cópia dos dados da sessão, e as alterações em uma sessão são
não é propagado automaticamente entre servidores. Isso leva a experiências de usuário inconsistentes e ineficientes
utilização de recursos ao escalar com um grupo de Auto Scaling.
Transferir o gerenciamento de sessões para uma solução dedicada e escalável é crucial. Amazon ElastiCache para
Memcached foi projetado para armazenar em cache dados acessados com frequência, incluindo dados de sessão. Oferece alta
desempenho e baixa latência, aliviando a carga de memória nos servidores web. Ao usar o ElastiCache, o
servidores web no grupo Auto Scaling podem recuperar e atualizar rapidamente informações de sessão sem serem
restringido por limites de memória local. Esta arquitetura facilita a escalabilidade horizontal, permitindo que a aplicação
para lidar com o aumento do tráfego de forma eficaz.
Em relação aos dados do aplicativo (detalhes do pedido), usar o Amazon RDS for MySQL é uma prática recomendada. RDS fornece
serviços de banco de dados gerenciados com recursos como backups automatizados, aplicação de patches e escalabilidade. Ele garante o
os dados do aplicativo permanecem duráveis e prontamente disponíveis. Separando os dados do aplicativo dos dados da sessão
permite utilizar serviços otimizados para cada tipo de dados.
A opção A está incorreta porque o armazenamento dos dados da sessão no mesmo banco de dados MySQL que os dados do aplicativo seriam
provavelmente criarão gargalos de desempenho. O MySQL foi projetado para armazenamento persistente de dados e não para armazenamento de dados de baixo custo.
requisitos de latência do gerenciamento de sessão. Colocar ambas as cargas de trabalho na mesma instância de banco de dados
aumenta a carga de trabalho do banco de dados e pode causar problemas de desempenho. Além disso, usando um único EC2
instância para hospedar o banco de dados MySQL não oferece os benefícios de escalabilidade e disponibilidade do RDS.
A opção C está incorreta porque o Amazon ElastiCache for Memcached não é a escolha certa para dados persistentes.
O ElastiCache é otimizado para armazenamento em cache e não funcionaria bem como armazenamento de dados primário durável. É volátil; dados
pode ser perdido. Os detalhes do pedido devem ser armazenados em um banco de dados persistente como o RDS.
A opção D está incorreta porque o armazenamento de instâncias do EC2 é efêmero (não persistente). Se a instância EC2 falhar, o
os dados armazenados no armazenamento de instâncias são perdidos. Além disso, gerenciar dados de sessão localmente em cada instância, mesmo com o
armazenamento de instâncias, não é dimensionado de forma eficaz e nega o benefício do grupo Auto Scaling.
Portanto, a melhor abordagem é separar os dados da sessão dos dados da aplicação, usando um servidor dedicado e escalável.
serviço de cache (ElastiCache) para gerenciamento de sessões e um serviço de banco de dados persistente e gerenciado (RDS) para
dados do aplicativo. Esta estratégia aborda a pressão de memória nos servidores web e facilita a distribuição horizontal.
escalabilidade.
Links relevantes para pesquisas futuras:
Amazon ElastiCache: https://aws.amazon.com/elasticache/
Amazon RDS: https://aws.amazon.com/rds/
Balanceador de carga de aplicativo: https://aws.amazon.com/elasticloadbalancing/application-load-balancer/
Escalonamento automático: https://aws.amazon.com/autoscaling/

---

## Questão 55

Um aplicativo usa funções Lambda para extrair metadados de arquivos carregados em um bucket S3; os metadados são
armazenado no Amazon DynamoDB. O aplicativo começa a se comportar inesperadamente e o desenvolvedor deseja examinar
os logs do código da função Lambda em busca de erros.
Com base nesta configuração do sistema, onde o desenvolvedor encontraria os logs?

-A.Amazon S3
- B.AWS CloudTrail
-C.Amazon CloudWatch
-D.Amazon DynamoDB

**Resposta: C**

**Explicação:**

A resposta correta é C, Amazon CloudWatch. Funções Lambda integram-se automaticamente ao CloudWatch
Registros. Quando uma função Lambda é executada, ela transmite dados de log, incluindo quaisquer instruções de impressão ou erros
encontrados durante a execução, para um grupo do CloudWatch Logs associado à função Lambda.
Aqui está uma análise detalhada de por que as outras opções estão incorretas e por que o CloudWatch é a escolha correta:
A. Amazon S3: S3 é armazenamento de objetos. Embora os arquivos acionem a função Lambda, os logs gerados durante o
a execução da função não é armazenada no S3. O objetivo principal do S3 é armazenar dados, não capturar aplicativos
registros.
B. AWS CloudTrail: o CloudTrail rastreia chamadas de API feitas para serviços da AWS. Ele fornece trilhas de auditoria de quem fez o quê
e quando. Embora o CloudTrail possa registrar que uma função do Lambda foi invocada, ele não contém informações detalhadas
logs de aplicativos gerados pelo código da função Lambda, como instruções de impressão ou mensagens de erro.
D. Amazon DynamoDB: DynamoDB é um banco de dados NoSQL. É usado para armazenar os metadados extraídos neste
cenário. O DynamoDB não armazenaria logs gerados por uma função Lambda. O DynamoDB armazena dados estruturados,
não informações de log não estruturadas.
O CloudWatch Logs fornece registro centralizado para aplicativos e serviços. As funções Lambda são
configurado para enviar seus logs para o CloudWatch Logs por padrão, tornando-o o local ideal para examinar os erros
ou depurar mensagens da função Lambda. Os desenvolvedores podem acessar esses logs por meio do AWS
Console de gerenciamento, AWS CLI ou SDKs. CloudWatch oferece vários recursos para pesquisar, filtrar e analisar log
dados para ajudar a solucionar problemas de aplicativos.
Portanto, o desenvolvedor encontraria os logs da função Lambda no Amazon CloudWatch.
Recursos adicionais:
Registro em log do AWS Lambda
Usar AWS Lambda com Amazon CloudWatch Logs

---

## Questão 58

Um desenvolvedor está testando um novo aplicativo de armazenamento de arquivos que usa uma distribuição do Amazon CloudFront para fornecer conteúdo
de um bucket do Amazon S3. A distribuição acessa o bucket S3 usando uma identidade de acesso de origem (OAI). O
As permissões do bucket S3 negam explicitamente o acesso a todos os outros usuários.
O aplicativo solicita que os usuários se autentiquem em uma página de login e, em seguida, usa cookies assinados para permitir que os usuários
acessar seus diretórios de armazenamento pessoal. O desenvolvedor configurou a distribuição para usar seu cache padrão
comportamento com acesso restrito do visualizador e definiu a origem para apontar para o bucket S3. No entanto, quando o
O desenvolvedor tenta navegar para a página de login, o desenvolvedor recebe um erro 403 Forbidden.
O desenvolvedor precisa implementar uma solução para permitir acesso não autenticado à página de login. A solução também
deve manter todo o conteúdo privado seguro.
Qual solução atenderá a esses requisitos?

- A.Adicionar um segundo comportamento de cache à distribuição com a mesma origem do comportamento de cache padrão. Defina o
padrão de caminho para o segundo comportamento de cache para o caminho da página de login e torna o acesso do visualizador irrestrito.
Mantenha as configurações do comportamento de cache padrão inalteradas.
- B.Adicionar um segundo comportamento de cache à distribuição com a mesma origem do comportamento de cache padrão. Defina o
padrão de caminho para o segundo comportamento do cache para * e restringir o acesso do visualizador. Alterar o cache padrão
padrão de caminho do comportamento para o caminho da página de login e tornar o acesso do visualizador irrestrito.
- C.Adicionar uma segunda origem como origem de failover ao comportamento de cache padrão. Aponte a origem do failover para o S3
balde. Defina o padrão de caminho da origem primária como * e restrinja o acesso do visualizador. Defina o padrão do caminho
para a origem do failover para o caminho da página de login e torne o acesso do visualizador irrestrito.
- D.Adicione uma política de bucket ao bucket S3 para permitir acesso de leitura. Defina o recurso na política para a Amazon
Nome do recurso (ARN) do objeto da página de login no bucket S3. Adicionar uma função do CloudFront ao padrão
comportamento de cache para redirecionar solicitações não autorizadas para o URL S3 da página de login.

**Resposta: A**

**Explicação:**

A solução correta é A. Essa abordagem aproveita a funcionalidade de comportamento de cache do CloudFront para selecionar
permitir acesso não autenticado à página de login, mantendo acesso restrito a outros conteúdos.
Aqui está uma justificativa detalhada:
1. Problema: o comportamento padrão do cache restringe o acesso do visualizador, ou seja, todas as solicitações ao CloudFront
distribuição estão sujeitos à autenticação configurada (neste caso, cookies assinados). Isso inclui
a página de login, que precisa ser acessível publicamente para usuários não autenticados iniciarem o login
processo.
2. Comportamentos de cache do CloudFront: as distribuições do CloudFront podem ter vários comportamentos de cache, cada um
associado a um padrão de caminho específico. O padrão de caminho determina qual comportamento de cache é aplicado
a uma determinada solicitação.
https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-
geral.html#d0E940
3. Justificativa da solução: Adicionando um segundo comportamento de cache com o padrão de caminho e configuração da página de login
acesso do visualizador irrestrito, criamos uma exceção. Quando um usuário solicita a página de login,
O CloudFront usará esse novo comportamento de cache e exibirá a página diretamente do S3 sem exigir
biscoitos assinados. O comportamento padrão do cache, ainda em vigor, continua protegendo todos os outros conteúdos
por trás da autenticação de cookie assinada.
4. Por que outras opções estão incorretas:
B: Alterar o padrão de caminho do comportamento do cache padrão para a página de login exporia a página de login
mas ainda restrinja todos os outros recursos usando cookies assinados. Usando "*" para acesso restrito do visualizador no
novo comportamento está incorreto.
C: As origens do failover são para alta disponibilidade, não para controle de acesso. Não restringiria o conteúdo por trás
biscoitos assinados. A configuração de origem primária sempre tentará acesso com o OAI.
D: Modificar a política do bucket S3 para expor diretamente a página de login pode funcionar no nível S3, mas
ignoraria o CloudFront e, assim, anularia o propósito de usar o CloudFront para armazenamento em cache e segurança.
As funções do CloudFront que redirecionam solicitações não autorizadas para o URL S3 também ignorarão o CloudFront
proteção para todos os outros recursos. É melhor gerenciar o acesso no CloudFront.
5. Segurança: Mantendo o OAI e a política de bucket que só permite acesso do CloudFront
distribuição, o conteúdo privado permanece seguro. O acesso não autenticado é concedido apenas para o login
página através do comportamento de cache do CloudFront, não diretamente para o bucket S3.
6. Escalabilidade e desempenho: os recursos de cache do CloudFront garantem que a página de login seja veiculada
de forma rápida e eficiente, mesmo com um grande volume de solicitações.
Em resumo, adicionar um comportamento de cache específico para a página de login com acesso irrestrito permite
usuários não autenticados acessem o formulário de login, mantendo o conteúdo privado seguro por meio de cookies assinados
imposta pelo comportamento padrão do cache.

---

## Questão 60

Uma empresa de comércio eletrônico está usando uma função AWS Lambda por trás do Amazon API Gateway como camada de aplicativo. Para
processar pedidos durante a finalização da compra, o aplicativo chama uma API POST do frontend. A API POST invoca o
Função Lambda de forma assíncrona. Em raras situações, o aplicativo não processou pedidos. O Lambada
os logs do aplicativo não mostram erros ou falhas.
O que um desenvolvedor deve fazer para resolver esse problema?

- A.Inspecione os logs de front-end em busca de falhas de API. Chame a API POST manualmente usando as solicitações do arquivo de log.
- B.Criar e inspecionar a fila de mensagens mortas do Lambda. Solucione os problemas das funções com falha. Reprocesse os eventos.
- C.Inspecione os logs do Lambda no Amazon CloudWatch em busca de possíveis erros. Corrija os erros.
- D.Certifique-se de que o cache esteja desabilitado para a API POST no API Gateway.

**Resposta: B**

**Explicação:**

A resposta correta é B. Crie e inspecione a fila de mensagens mortas do Lambda. Solucionar problemas com falha
funções. Reprocesse os eventos. Aqui está o porquê:
Quando uma função Lambda é invocada de forma assíncrona, a AWS trata de novas tentativas se a função falhar. Porém, depois
exaustivas de novas tentativas, o evento pode ser enviado para uma fila de mensagens mortas (DLQ). A pergunta afirma que
Os logs do Lambda não mostram erros ou falhas. Isto sugere fortemente que a função inicialmente foi bem-sucedida, mas alguns
a operação downstream falha após o término do contexto de execução do Lambda, tornando o CloudWatch padrão
registros menos úteis. Essas falhas são tratadas pelo mecanismo de nova tentativa e, em seguida, pelo DLQ quando a nova tentativa falha
Um DLQ atua como um repositório para eventos que a função Lambda não conseguiu processar com sucesso, afinal
as novas tentativas estão esgotadas. A inspeção do DLQ permite que os desenvolvedores identifiquem os eventos específicos que falharam e
compreender os motivos de sua falha (por exemplo, dados incorretos, problemas de dependência, falhas downstream intermitentes).
Isto é crucial quando os logs padrão não mostram nada, pois o DLQ fornece um registro de eventos com falha que precisam ser
inspecionado
Ao analisar os eventos com falha no DLQ, o desenvolvedor pode solucionar a causa raiz do processamento
falhas. Depois que o problema for resolvido (por exemplo, corrigindo um bug na função Lambda ou corrigindo erros de dados), o
os eventos podem ser reprocessados para garantir que os pedidos sejam processados corretamente, resolvendo o problema inicial.
Veja por que as outras opções são menos ideais:
A. Inspecione os logs de front-end em busca de falhas de API. Chame a API POST manualmente usando as solicitações do log
arquivo: embora os logs de front-end possam ser úteis, a pergunta afirma que os logs do Lambda não mostram erros. Erros de front-end
pode sugerir que a chamada da API nunca aconteceu, mas isso não explica por que os eventos não estão sendo processados se
chegar ao Lambda.
C. Inspecione os logs do Lambda no Amazon CloudWatch em busca de possíveis erros. Corrija os erros: a pergunta afirma
que os logs do aplicativo Lambda não mostrem erros ou falhas. Isso torna a inspeção dos logs do CloudWatch menos
relevante.
D. Certifique-se de que o cache esteja desabilitado para a API POST no API Gateway: O cache no API Gateway pode causar
dados obsoletos, mas provavelmente resultaria no processamento de pedidos incorretos, e não no não processamento de pedidos.
Documentação Relevante:
Filas de mensagens mortas do AWS Lambda: https://docs.aws.amazon.com/lambda/latest/dg/services-sqs.html
Invocação assíncrona: https://docs.aws.amazon.com/lambda/latest/dg/invocation-async.html

---

## Questão 61

Uma empresa está construindo um aplicativo web na AWS. Quando um cliente envia uma solicitação, o aplicativo irá gerar
relatórios e, em seguida, disponibilizá-los ao cliente dentro de uma hora. Os relatórios devem estar acessíveis ao
cliente por 8 horas. Alguns relatórios têm mais de 1 MB. Cada relatório é exclusivo para o cliente. O aplicativo
deve excluir todos os relatórios com mais de dois dias.
Qual solução atenderá a esses requisitos com a MENOS sobrecarga operacional?

- A.Gere os relatórios e armazene-os como itens do Amazon DynamoDB que possuem um TTL especificado.
Gere um URL que recupere os relatórios do DynamoDB. Forneça o URL aos clientes pela web
aplicação.
- B.Gerar os relatórios e armazená-los em um bucket do Amazon S3 que usa criptografia no lado do servidor.
Anexe os relatórios a uma mensagem do Amazon Simple Notification Service (Amazon SNS). Assine o cliente
para enviar notificações por e-mail do Amazon SNS.
- C.Gere os relatórios e armazene-os em um bucket do Amazon S3 que usa criptografia no lado do servidor.
Gere um URL pré-assinado que contenha uma data de expiração Forneça o URL aos clientes através da web
aplicação. Adicione regras de configuração do S3 Lifecycle ao bucket do S3 para excluir relatórios antigos.
- D.Gere os relatórios e armazene-os em um banco de dados Amazon RDS com carimbo de data. Gere um
URL que recupera os relatórios do banco de dados RDS. Forneça o URL aos clientes pela web
aplicação. Agende uma função AWS Lambda de hora em hora para excluir registros de banco de dados com data de expiração
selos.

**Resposta: C**

**Explicação:**

A melhor solução é a opção C porque ela aproveita o Amazon S3, URLs pré-assinados e políticas de ciclo de vida para
gerencie com eficiência o armazenamento, o acesso e a exclusão de relatórios com sobrecarga operacional mínima.
Aqui está o porquê:
S3 para armazenamento: o S3 foi projetado para armazenar objetos (como relatórios) e oferece escalabilidade, durabilidade e custo-benefício.
eficácia. https://aws.amazon.com/s3/
Criptografia no lado do servidor: fornece segurança de dados em repouso, atendendo aos requisitos de segurança.
URLs pré-assinados: URLs pré-assinados concedem acesso temporário a objetos S3 sem exigir que os clientes tenham
Credenciais da AWS. Esta é uma forma segura e conveniente de fornecer acesso aos relatórios por tempo limitado (8
horas, conforme necessário).
https://docs.aws.amazon.com/AmazonS3/latest/userguide/PresignedUrlUploadObject.html
Políticas de ciclo de vida do S3: as políticas de ciclo de vida do S3 automatizam a exclusão de objetos com base na idade. Isto cumpre o
requisito para excluir relatórios com mais de 2 dias sem a necessidade de código personalizado ou intervenção manual.
https://docs.aws.amazon.com/AmazonS3/latest/userguide/lifecycle-configuration-examples.html
Por que outras opções são menos adequadas:
A (DynamoDB): DynamoDB é um banco de dados NoSQL adequado para valores-chave ou dados de documentos, não ideal para armazenar
relatórios grandes (especialmente > 1 MB) porque seu custo pode ser proibitivo para dados binários grandes. Além disso, DynamoDB TTL
(Time To Live) é mais adequado para limpeza eventual e não é tão preciso quanto as políticas de ciclo de vida do S3, e atende ao
arquivos por meio do DynamoDB é menos eficiente do que servi-los diretamente do S3.
B (SNS): SNS é um serviço de mensagens e anexar relatórios grandes diretamente às mensagens SNS é ineficiente e
potencialmente impraticável. O SNS foi projetado para notificações, não para distribuição de arquivos grandes.
D (RDS): RDS é um banco de dados relacional. Armazenar relatórios binários diretamente em um banco de dados RDS geralmente não é
recomendado para arquivos grandes. Isso pode afetar o desempenho do banco de dados e aumentar os custos de armazenamento. Além disso,
agendar uma função Lambda para excluir registros adiciona sobrecarga operacional em comparação com as políticas de ciclo de vida do S3.
Além disso, recuperar os relatórios de um banco de dados em vez do S3 é menos eficiente.

---

## Questão 64

Um desenvolvedor está migrando alguns recursos de um aplicativo monolítico legado para usar funções do AWS Lambda
em vez disso. Atualmente, o aplicativo armazena dados em um cluster de banco de dados Amazon Aurora executado em sub-redes privadas em uma VPC.
A conta AWS tem uma VPC implantada. As funções Lambda e o cluster de banco de dados são implantados no mesmo AWS
Região na mesma conta AWS.
O desenvolvedor precisa garantir que as funções do Lambda possam acessar com segurança o cluster de banco de dados sem cruzar o
internet pública.
Qual solução atenderá a esses requisitos?

- A.Configure a configuração de acesso público do cluster de banco de dados como Sim.
- B.Configurar um proxy de banco de dados Amazon RDS para as funções Lambda.
- C.Configurar um gateway NAT e um grupo de segurança para as funções Lambda.
- D.Configure a VPC, sub-redes e um grupo de segurança para as funções Lambda.

**Resposta: D**

**Explicação:**

A resposta correta é D: Configure a VPC, as sub-redes e um grupo de segurança para as funções Lambda.
Aqui está o porquê:
A integração de VPC é fundamental: as funções Lambda, por padrão, são executadas em uma VPC gerenciada pela AWS. Para acessar recursos em
sua VPC privada (onde reside o cluster de banco de dados Aurora), as funções do Lambda devem ser configuradas para conectar
para sua VPC. Isso estabelece um caminho de rede privado e seguro.
Sub-redes e grupos de segurança definem o acesso: implantando funções Lambda na mesma VPC que o Aurora
O cluster de banco de dados e a especificação de sub-redes nessa VPC permitem que as funções do Lambda obtenham endereços IP privados
dentro do bloco CIDR da VPC. Os grupos de segurança controlam então o tráfego de entrada e saída. Queremos permitir
tráfego do grupo de segurança da função Lambda para o grupo de segurança do cluster de banco de dados Aurora no local apropriado
porta (normalmente 3306 para MySQL/Aurora).
Evitando a Internet Pública: O requisito de evitar a Internet pública é atendido diretamente mantendo todos
comunicação dentro da VPC usando endereços IP privados. Isto é muito mais seguro do que expor o
banco de dados publicamente.
Por que outras opções estão erradas:
R: Definir a configuração de acesso público do cluster de banco de dados como Sim: isso é fundamentalmente incorreto porque
contradiz diretamente a exigência de não cruzar a Internet pública. Ele expõe o banco de dados para o exterior
mundo, o que constitui um grande risco para a segurança.
B: Configurando um proxy de banco de dados Amazon RDS para as funções Lambda: embora o RDS Proxy possa melhorar
gerenciamento de conexão e segurança, não resolve inerentemente o problema de rede do Lambda
funções sendo isoladas do VPC. Ele precisa primeiro de integração VPC. Além disso, embora útil, não é
estritamente necessário para cumprir o requisito básico de acesso privado seguro.
C: Configurando um gateway NAT e um grupo de segurança para as funções Lambda: o gateway NAT é necessário apenas
para tráfego de saída da Internet. Já que precisamos que as funções lambda se conectem diretamente ao banco de dados aurora
dentro da sub-rede privada, a função lambda precisará ser colocada dentro da sub-rede privada e não há necessidade de NAT
portal.
Links autorizados para pesquisas adicionais:
Configurar funções Lambda para acessar recursos em uma Amazon VPC:
https://docs.aws.amazon.com/lambda/latest/dg/configuration-vpc.html
Grupos de segurança: https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html
Proxy Amazon RDS: https://docs.aws.amazon.com/rds/proxy/latest/userguide/rds-proxy.html

---

## Questão 65

Um desenvolvedor está construindo um novo aplicativo na AWS. O aplicativo usa uma função AWS Lambda que recupera
informações de uma tabela do Amazon DynamoDB. O desenvolvedor codificou o nome da tabela do DynamoDB no arquivo
Código da função Lambda. O nome da tabela pode mudar com o tempo. O desenvolvedor não deseja modificar o
Código Lambda se o nome da tabela for alterado.
Qual solução atenderá a esses requisitos de forma MAIS eficiente?

- A.Crie uma variável de ambiente Lambda para armazenar o nome da tabela. Use o método padrão para o
linguagem de programação para recuperar a variável.
- B. Armazene o nome da tabela em um arquivo. Armazene o arquivo na pasta /tmp. Use o SDK da linguagem de programação para
recuperar o nome da tabela.
- C.Crie um arquivo para armazenar o nome da tabela. Compacte o arquivo e carregue-o na camada Lambda. Use o SDK para o
linguagem de programação para recuperar o nome da tabela.
- D.Crie uma variável global que esteja fora do manipulador na função Lambda para armazenar o nome da tabela.

**Resposta: A**

**Explicação:**

A solução mais eficiente é usar variáveis ​​de ambiente Lambda. Aqui está o porquê:
A opção A é a mais eficiente porque as variáveis de ambiente do Lambda são projetadas especificamente para armazenar
informações de configuração que precisam ser acessíveis às funções do Lambda sem serem codificadas no
código da função. Isso facilita a atualização do nome da tabela do DynamoDB sem reimplantar a função.
O Lambda se integra perfeitamente a essas variáveis, fornecendo uma maneira simples e direta de recuperá-las usando
métodos de linguagem de programação padrão.
A opção B é menos eficiente. Embora o armazenamento do nome da tabela em um arquivo no diretório /tmp funcione, ele adiciona
complexidade desnecessária. A função precisaria ler o arquivo toda vez que precisasse do nome da tabela,
introduzindo sobrecarga de E/S. Além disso, o diretório /tmp é efêmero e não é adequado para armazenamento persistente de
configuração.
A opção C, usando camadas Lambda, também é menos eficiente do que usar variáveis ​​de ambiente. Camadas são melhor usadas
para código ou dependências compartilhadas entre várias funções do Lambda, não para valores de configuração simples.
Criar uma camada para um único nome de tabela introduz sobrecarga desnecessária em termos de implantação e
manutenção. Embora camadas possam ser usadas, é um exagero para este cenário simples.
A opção D, usando uma variável global fora do manipulador, tem sérias desvantagens. A execução do Lambda
O ambiente pode ser reutilizado, portanto, o valor da variável global pode persistir nas invocações. Isto pode levar a
comportamento inesperado se a variável for modificada durante uma invocação e depois usada em uma invocação subsequente
invocação antes de ser redefinida. Além disso, esta abordagem ainda requer a modificação do código da função Lambda
se o nome da tabela mudar, anulando o propósito do requisito.
Concluindo, as variáveis de ambiente Lambda fornecem o método mais simples, eficiente e recomendado
abordagem para gerenciar dados de configuração, como nomes de tabelas do DynamoDB em funções Lambda. Eles são
projetados para esse propósito, evitam sobrecarga desnecessária e fornecem uma separação clara de código e
configuração.
Links relevantes:
Variáveis de ambiente AWS Lambda: https://docs.aws.amazon.com/lambda/latest/dg/configuration-
envvars.html

---

## Questão 66

Uma empresa possui um aplicativo crítico na AWS. O aplicativo expõe uma API HTTP usando o Amazon API Gateway.
A API está integrada a uma função AWS Lambda. O aplicativo armazena dados em um banco de dados Amazon RDS for MySQL
instância com 2 CPUs virtuais (vCPUs) e 64 GB de RAM.
Os clientes relataram que algumas das chamadas de API retornam respostas de erro interno do servidor HTTP 500. Amazônia
O CloudWatch Logs mostra erros para “muitas conexões”. Os erros ocorrem durante horários de pico de uso que são
imprevisível.
A empresa precisa tornar o aplicativo resiliente. O banco de dados não pode ficar inativo fora do programado
horas de manutenção.
Qual solução atenderá a esses requisitos?

- A.Diminuir o número de vCPUs para a instância de banco de dados. Aumente a configuração max_connections.
- B.Use o Amazon RDS Proxy para criar um proxy que se conecte à instância de banco de dados. Atualize a função Lambda para
conecte-se ao proxy.
- C.Adicionar um alarme CloudWatch que altera a classe da instância de banco de dados quando o número de conexões aumenta para
mais de 1.000.
- D.Adicione uma regra do Amazon EventBridge que aumente a configuração max_connections da instância de banco de dados quando a CPU
a utilização está acima de 75%.

**Resposta: B**

**Explicação:**

A melhor solução é B. Use o Amazon RDS Proxy para criar um proxy que se conecte à instância de banco de dados. Atualizar
a função Lambda para se conectar ao proxy.
Aqui está o porquê:
O problema são “muitas conexões” com o banco de dados RDS, levando a erros HTTP 500 durante o pico de uso.
O RDS Proxy foi projetado especificamente para gerenciar conexões de banco de dados e melhorar a escalabilidade e
resiliência em tais cenários. Ele fica entre o aplicativo (função Lambda) e o banco de dados RDS, agrupando
e compartilhamento de conexões de banco de dados. Isso reduz o número de conexões diretas com o banco de dados, evitando
fique sobrecarregado, mesmo durante horários de pico de uso imprevisíveis. https://aws.amazon.com/rds/proxy/
Ao atualizar a função Lambda para conectar-se ao endpoint do RDS Proxy, a função não é mais diretamente
estabelece conexões com o banco de dados. Em vez disso, ele usa o proxy como intermediário. O procurador então
gerencia o ciclo de vida da conexão, reutilizando conexões com eficiência e evitando o esgotamento da conexão.
https://docs.aws.amazon.com/rds/proxy/latest/userguide/what-is.html
Vamos examinar por que as outras opções são menos adequadas:
A. Diminua o número de vCPUs para a instância de banco de dados. Aumente a configuração max_connections: Diminuindo
As vCPUs provavelmente degradarão o desempenho. Simplesmente aumentar max_connections pode adiar o problema, mas
não resolve o problema subjacente do gerenciamento ineficiente de conexões e pode levar à perda de recursos
contenção.
C. Adicionar um alarme CloudWatch que altera a classe da instância de banco de dados quando o número de conexões aumenta
para mais de 1.000: aumentar a escala da classe de instância é uma medida reativa e leva tempo. Isso não impede o
O erro "muitas conexões" aconteça em primeiro lugar, levando a um tempo de inatividade temporário. Isto também é
menos eficiente e econômico do que o pooling de conexões. Além disso, alterar a classe da instância requer um
reinicialização do banco de dados, o que leva ao tempo de inatividade.
D. Adicione uma regra do Amazon EventBridge que aumente a configuração max_connections da instância de banco de dados quando
A utilização da CPU está acima de 75%: ajustar dinamicamente max_connections com base na utilização da CPU é complexo
e potencialmente arriscado. Regras configuradas incorretamente podem levar ao consumo excessivo de recursos ou à instabilidade.
Também não aborda a questão central do gerenciamento ineficiente de conexões. Semelhante à opção A, também
requer uma reinicialização do banco de dados.
O RDS Proxy fornece uma solução gerenciada e confiável projetada especificamente para lidar com "muitos
problema de conexões", tornando-o a escolha mais apropriada para garantir a resiliência do aplicativo sem
tempo de inatividade significativo.

---

## Questão 67

Uma empresa instalou medidores inteligentes em todas as localidades de seus clientes. Os medidores inteligentes medem o consumo de energia em 1-
intervalos de minutos e enviar as leituras de uso para um terminal remoto para coleta. A empresa precisa criar um
endpoint que receberá as leituras do medidor inteligente e armazenará as leituras em um banco de dados. A empresa quer
armazenar o ID do local e as informações de carimbo de data/hora.
A empresa deseja oferecer aos seus clientes acesso de baixa latência ao uso atual e ao histórico de uso em
demanda. A empresa espera que a demanda aumente significativamente. A solução não deve afetar o desempenho ou
inclua o tempo de inatividade durante o dimensionamento.
Qual solução atenderá a esses requisitos de maneira MAIS econômica?

- A. Armazene as leituras do medidor inteligente em um banco de dados Amazon RDS. Crie um índice no ID do local e
colunas de carimbo de data/hora. Use as colunas para filtrar os dados dos clientes.
- B. Armazene as leituras do medidor inteligente em uma tabela do Amazon DynamoDB. Crie uma chave composta usando o local
Colunas de ID e carimbo de data/hora. Use as colunas para filtrar os dados dos clientes.
- C. Armazene as leituras do medidor inteligente no Amazon ElastiCache for Redis. Crie uma chave SortedSet usando o
colunas de ID de localização e carimbo de data/hora. Use as colunas para filtrar os dados dos clientes.
- D. Armazene as leituras do medidor inteligente no Amazon S3. Particionar os dados usando o ID do local e o carimbo de data/hora
colunas. Use o Amazon Athena para filtrar os dados dos clientes.

**Resposta: B**

**Explicação:**

Aqui está uma justificativa detalhada de por que a opção B é a solução mais econômica para armazenamento e consulta
dados de medidores inteligentes, considerando os requisitos de acesso de baixa latência, escalabilidade e economia:
DynamoDB para escalabilidade e baixa latência: DynamoDB é um serviço de banco de dados NoSQL totalmente gerenciado
projetado especificamente para aplicações de alto desempenho que exigem um valor consistente de milissegundos de um dígito
latência em qualquer escala. A pergunta menciona a expectativa de aumento significativo da demanda, fazendo com que
A escalabilidade do DynamoDB é um fator crucial.
Design de chave composta: usando uma chave composta (chave de partição e chave de classificação) que consiste no ID do local e
timestamp é uma estratégia ideal para DynamoDB. O ID do local atua como chave de partição, distribuindo os dados
em múltiplas partições para escalabilidade horizontal. O carimbo de data/hora atua como chave de classificação, permitindo eficiência
consulta de dados dentro de cada partição com base em intervalos de tempo. Isto apoia diretamente a exigência de
acesso a dados históricos de uso.
Filtragem com chaves: o DynamoDB permite uma filtragem eficiente usando os atributos-chave. Os dados dos clientes podem ser
facilmente recuperado consultando com base em seu ID de localização (chave de partição) e intervalos de tempo específicos (usando o
chave de classificação de carimbo de data/hora). Isso atende ao requisito de acesso de baixa latência aos dados do cliente.
Economia: os modos de pagamento por solicitação e capacidade provisionada do DynamoDB oferecem otimização de custos
oportunidades. Dado o elevado volume de leituras de medidores recebidas, a análise dos padrões de utilização pode ajudar
determinar o modelo de faturamento mais econômico.
Desvantagens do RDS: Embora o RDS (opção A) possa lidar com dados estruturados, normalmente requer mais gerenciamento
sobrecarga e pode não escalar de forma tão simples e econômica quanto o DynamoDB para o alto volume esperado
de dados e solicitações. A indexação ajuda, mas pode não fornecer a mesma baixa latência em escala.
Desvantagens do ElastiCache: O ElastiCache (opção C) é um armazenamento de dados na memória usado principalmente para armazenamento em cache. Não é
projetado para armazenamento durável de grandes volumes de dados históricos, conforme exigido pela pergunta. Armazenando tudo
leituras no ElastiCache seriam caras e impraticáveis.
Desvantagens do S3/Athena: S3/Athena (opção D) é adequado para consultas analíticas em grandes conjuntos de dados, mas a consulta
a latência é significativamente maior em comparação com o DynamoDB, tornando-o inadequado para baixa latência sob demanda
acesso a dados de uso atuais e históricos. Os dados precisariam ser digitalizados, tornando o processo mais lento.
Em resumo, o DynamoDB oferece o melhor equilíbrio entre escalabilidade, baixa latência, economia e facilidade de
usar para os requisitos fornecidos. O design da chave composta permite a recuperação e filtragem eficiente de dados,
abordando diretamente a necessidade de acesso de baixa latência aos dados de uso atuais e históricos de cada cliente.
Links relevantes:
Amazon DynamoDB
Design de chave do DynamoDB
Escolhendo o banco de dados certo

---

## Questão 68

Uma empresa está construindo um aplicativo sem servidor que usa funções do AWS Lambda. A empresa precisa criar um
conjunto de eventos de teste para testar funções Lambda em um ambiente de desenvolvimento. Os eventos de teste serão criados uma vez
e será usado por todos os desenvolvedores em um grupo de desenvolvedores IAM. Os eventos de teste devem ser editáveis por qualquer um dos
os usuários do IAM no grupo de desenvolvedores do IAM.
Qual solução atenderá a esses requisitos?

- A.Criar e armazenar os eventos de teste no Amazon S3 como objetos JSON. Permitir acesso ao bucket S3 a todos os usuários do IAM.
- B.Crie os eventos de teste. Defina as configurações de compartilhamento de eventos para tornar os eventos de teste compartilháveis.
- C.Criar e armazenar os eventos de teste no Amazon DynamoDB. Permita o acesso ao DynamoDB usando funções do IAM.
- D.Crie os eventos de teste. Defina as configurações de compartilhamento de eventos para tornar os eventos de teste privados.

**Resposta: B**

**Explicação:**

A resposta correta é B. Eis o porquê:
O requisito é criar e compartilhar eventos de teste editáveis para funções Lambda entre desenvolvedores em um IAM
grupo.
Opção A: Embora armazenar eventos no S3 e conceder acesso possa parecer viável, isso envolve o gerenciamento de JSON
arquivos diretamente. Não é assim que o Lambda normalmente lida com eventos de teste. Lambda possui um mecanismo integrado para
gerenciá-los e compartilhá-los. O S3 também não é tão simplificado para gerenciar eventos de teste, dificultando
modificar e acionar no console do Lambda.
Opção B: Lambda oferece suporte ao compartilhamento de eventos de teste. Este é um recurso direto e integrado projetado exatamente para este
propósito. A configuração do compartilhamento de eventos torna os eventos acessíveis e editáveis por usuários autorizados (neste caso,
membros do grupo de desenvolvedores IAM). Isso permite que os desenvolvedores usem e modifiquem facilmente eventos de teste diretamente
no console do Lambda/AWS CLI.
Opção C: semelhante ao S3, o DynamoDB não é a forma pretendida de gerenciar eventos de teste do Lambda. Isso exigiria
lógica de aplicativo complexa para traduzir entradas do DynamoDB em eventos de teste utilizáveis no Lambda
ambiente.
Opção D: A criação de eventos de teste privados contradiz o requisito de que todos os desenvolvedores do grupo devem
ter acesso e poder editar os eventos.
Portanto, a opção B oferece a maneira mais simples, direta e intencional de atingir os requisitos declarados
usando a funcionalidade integrada de compartilhamento de eventos de teste do Lambda. Evita a complexidade do gerenciamento de dados de eventos em
armazenamento externo como S3 ou DynamoDB.
Documentação do evento de teste Lambda: https://docs.aws.amazon.com/lambda/latest/dg/testing-functions.html
(Embora este documento não mencione explicitamente "compartilhamento", ele discute implicitamente a criação/gerenciamento que
leva a configurações compartilhadas.)

---

## Questão 71

Um desenvolvedor está trabalhando em um aplicativo existente que usa o Amazon DynamoDB como armazenamento de dados. O DynamoDB
tabela tem os seguintes atributos: partNumber (chave de partição), fornecedor (chave de classificação), descrição, productFamily e
tipo de produto. Quando o desenvolvedor analisa os padrões de uso, ele percebe que há aplicativos
módulos que frequentemente procuram uma lista de produtos com base nos atributos productFamily e productType.
O desenvolvedor deseja fazer alterações no aplicativo para melhorar o desempenho das operações de consulta.
Qual solução atenderá a esses requisitos?

- A.Crie um índice secundário global (GSI) com productFamily como chave de partição e productType como classificação
chave.
- B.Crie um índice secundário local (LSI) com productFamily como chave de partição e productType como chave de classificação.
- C.Recriar a mesa. Adicione partNumber como chave de partição e vendor como chave de classificação. Durante a criação da tabela,
adicione um índice secundário local (LSI) com productFamily como chave de partição e productType como chave de classificação.
- D.Atualize as consultas para usar operações de digitalização com productFamily como chave de partição e productType como o
chave de classificação.

**Resposta: A**

**Explicação:**

Aqui está uma justificativa detalhada de por que a opção A é a solução correta:
O problema descreve um cenário onde consultas frequentes estão sendo feitas com base em productFamily e
atributos productType, mas a estrutura da tabela existente (chave de partição: partNumber, chave de classificação: fornecedor) não é
otimizado para essas consultas. Isso leva a verificações ineficientes. O objetivo é melhorar o desempenho da consulta com base
em productFamily e productType.
A opção A sugere a criação de um Índice Secundário Global (GSI) com productFamily como chave de partição e
productType como a chave de classificação. Essa é a melhor abordagem porque os GSIs permitem consultar a tabela do DynamoDB
usando atributos diferentes da chave primária da tabela. Usando productFamily e productType como chaves do GSI,
o aplicativo pode consultar com eficiência produtos pertencentes a uma família e tipo específico sem digitalizar o
mesa inteira. Os GSIs são “globais” porque podem ser criados e modificados a qualquer momento e não precisam
têm a mesma chave de partição da tabela base.
A opção B, criar um Índice Secundário Local (LSI), está incorreta porque os LSIs devem compartilhar a mesma chave de partição
como tabela base (neste caso, partNumber). A pergunta afirma especificamente a necessidade de consultar com base em
productFamily e productType, que são distintos da chave de partição da tabela base. Além disso, as instituições menos significativas são
limitado a 5 por tabela e são definidos na criação da tabela.
A opção C está incorreta, pois recriar a tabela é uma alteração invasiva e desnecessária. Reestruturação do primário
chave em torno de partNumber e vendor não resolve o problema de consulta em productFamily e productType.
Além disso, adicionar um LSI ainda requer o uso da chave de partição da tabela base, o que anula o propósito
de consulta eficiente sobre os atributos desejados.
A opção D, usando operações de varredura, é a solução menos eficiente. As varreduras leem toda a tabela, filtrando
productFamily e productType. Isso consome muitos recursos, é lento e caro, especialmente à medida que a mesa cresce.
O objetivo é evitar varreduras e, em vez disso, usar consultas direcionadas.
Em resumo, um GSI com productFamily como chave de partição e productType como chave de classificação fornece o máximo
maneira eficiente de consultar a tabela do DynamoDB com base nesses atributos, sem exigir recriação da tabela ou
verificações ineficientes.
Pesquisa adicional:
Índices do DynamoDB
Escolhendo o índice certo

---

## Questão 72

Um desenvolvedor cria uma VPC chamada VPC-A que possui sub-redes públicas e privadas. O desenvolvedor também cria um
Banco de dados Amazon RDS dentro da sub-rede privada da VPC-A. Para realizar algumas consultas, o desenvolvedor cria um
Função AWS Lambda na VPC padrão. A função Lambda possui código para acessar o banco de dados RDS. Quando o
A função Lambda é executada, uma mensagem de erro indica que a função não pode se conectar ao banco de dados RDS.
Como o desenvolvedor pode resolver esse problema?

- A.Modifique o grupo de segurança RDS. Adicione uma regra para permitir o tráfego de todas as portas do bloco CIDR da VPC.
- B.Reimplantar a função Lambda na mesma sub-rede da instância RDS. Certifique-se de que o grupo de segurança RDS
permite o tráfego da função Lambda.
- C.Crie um grupo de segurança para a função Lambda. Adicione uma nova regra no grupo de segurança RDS para permitir o tráfego
do novo grupo de segurança Lambda.
- D.Crie uma função IAM. Anexe uma política que permita acesso ao banco de dados RDS. Anexe a função ao Lambda
função.

**Resposta: B**

**Explicação:**

O problema é que a função Lambda, em execução na VPC padrão, não consegue se conectar ao banco de dados RDS em
Sub-rede privada da VPC-A. Isso ocorre porque as funções do Lambda em uma VPC padrão geralmente não possuem o necessário
configuração de rede para alcançar recursos em uma VPC separada e personalizada.
Opção B, reimplantar a função Lambda na mesma sub-rede da instância RDS e ajustar a
grupo de segurança, aborda diretamente esse problema. Colocando a função Lambda na mesma sub-rede privada
(ou outra sub-rede dentro da VPC-A), ele obtém acesso de rede ao banco de dados RDS por meio de endereços IP internos. O
o ajuste do grupo de segurança permite que a função Lambda (ou seu ENI associado) se comunique com o RDS
instância na porta do banco de dados (por exemplo, 3306 para MySQL, 5432 para PostgreSQL). Isto elimina a necessidade de
configurações complexas de peering ou roteamento de VPC. Funções Lambda implantadas automaticamente em uma VPC
herdar as configurações de rede da VPC.
A opção A não é ideal porque abrir todas as portas do bloco CIDR da VPC é um risco à segurança. Isso viola o
princípio do privilégio mínimo, concedendo acesso excessivamente amplo.
A opção C está parcialmente correta porque defende o uso de grupos de segurança para Lambda, uma prática recomendada.
No entanto, ele não aborda o problema fundamental de rede da função Lambda estar em um formato diferente.
VPC. Embora faça sentido ter um grupo de segurança associado à função Lambda, sem mover o
funcionar na VPC-A, a instância do RDS não estará acessível.
A opção D se concentra nas funções do IAM, que são cruciais para a autorização (quais ações a função Lambda pode
desempenho), mas não a conectividade de rede (como a função Lambda alcança o banco de dados RDS). O Lambada
A função já precisa de uma função IAM para interagir com os serviços da AWS, mas essa função não resolve o problema da rede
problema de conectividade. O IAM não pode substituir as limitações de rede impostas pelos limites da VPC.
Portanto, a solução mais direta e segura é colocar a função Lambda dentro do VPC-A e configurar
os grupos de segurança adequadamente, tornando a Opção B a resposta correta.
Pesquisa adicional:
Rede AWS Lambda VPC: https://docs.aws.amazon.com/lambda/latest/dg/services-vpc.html
Grupos de segurança da AWS: https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html

---

## Questão 74

Um desenvolvedor criou uma função AWS Lambda que acessa recursos em uma VPC. A função Lambda pesquisa um
Fila do Amazon Simple Queue Service (Amazon SQS) para novas mensagens por meio de um VPC endpoint. Então a função
calcula uma média contínua dos valores numéricos contidos nas mensagens. Após os testes iniciais do
Função Lambda, o desenvolvedor descobriu que o valor da média móvel retornada pela função não era
preciso.
Como o desenvolvedor pode garantir que a função calcule uma média móvel precisa?

- A.Defina a simultaneidade reservada da função como 1. Calcule a média móvel na função. Armazene o
média móvel calculada no Amazon ElastiCache.
- B.Modifique a função para armazenar os valores no Amazon ElastiCache. Quando a função for inicializada, use o anterior
valores do cache para calcular a média móvel.
- C.Defina a simultaneidade provisionada da função como 1. Calcule a média móvel na função. Armazene o
média móvel calculada no Amazon ElastiCache.
- D.Modifique a função para armazenar os valores nas camadas da função. Quando a função for inicializada, use o
valores armazenados anteriormente para calcular a média móvel.

**Resposta: B**

**Explicação:**

A resposta correta é B. A imprecisão no cálculo da média móvel sugere que múltiplos Lambda
invocações de função estão sendo executadas simultaneamente e interferindo no estado umas das outras se a média for
calculado e armazenado localmente no ambiente de execução da função.
A opção B aborda diretamente esse problema de simultaneidade. Ao usar o Amazon ElastiCache como um servidor externo e compartilhado
armazenamento para os valores médios móveis, cada invocação do Lambda pode acessar o estado mais atualizado do
média, independentemente de qual invocação a calculou. O ElastiCache garante atualizações consistentes e atômicas para
a média, evitando condições de corrida e garantindo precisão em execuções simultâneas. O Lambada
A função é inicializada buscando a última média calculada do ElastiCache e depois a usa para calcular
a nova média móvel com o novo valor da mensagem. Isso garante que cada invocação contribua corretamente
para o cálculo geral.
A opção A está parcialmente correta ao definir a simultaneidade reservada como 1, o que força a execução da função
sequencialmente. Isso evitaria problemas de simultaneidade. No entanto, armazenar a média móvel no ElastiCache após
cada cálculo ainda é benéfico para persistência e tolerância a falhas. Se a função Lambda falhar, o último
a média salva é mantida. A opção A também é menos eficiente; limitar a simultaneidade restringe o rendimento
desnecessariamente em muitos casos. O ElastiCache foi projetado para acesso a dados de baixa latência, tornando-o adequado para isso
tipo de gestão estatal.
A opção C usa simultaneidade provisionada em vez de simultaneidade reservada. Embora a simultaneidade provisionada ajude
com inicializações a frio, não garante a execução sequencial da mesma forma que a simultaneidade reservada definida como 1,
portanto, os mesmos problemas de simultaneidade persistem sem o gerenciamento de estado compartilhado do ElastiCache.
A opção D está incorreta porque as camadas Lambda são destinadas ao compartilhamento de código e dependências, não para persistência.
armazenamento de dados em invocações. Os dados armazenados no ambiente ou camadas de execução da função são perdidos quando o
O ambiente da função Lambda é reciclado ou uma nova instância é invocada. As camadas também são imutáveis e
projetado para acesso somente leitura durante a execução.
Portanto, a solução mais robusta é modificar a função para aproveitar o Amazon ElastiCache para armazenar e
recuperando os valores médios móveis, garantindo precisão e persistência mesmo com invocações simultâneas.
Essa abordagem permite que a função seja dimensionada com eficiência, mantendo a consistência dos dados.
Recursos relevantes:
Simultaneidade AWS Lambda: https://docs.aws.amazon.com/lambda/latest/dg/configuration-concurrency.html
Amazon ElastiCache: https://aws.amazon.com/elasticache/
Camadas AWS Lambda: https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html

---

## Questão 75

Um desenvolvedor está escrevendo testes unitários para um novo aplicativo que será implantado na AWS. O desenvolvedor quer
valide todas as solicitações pull com testes de unidade e mescle o código com a ramificação principal somente quando todos os testes forem aprovados.
O desenvolvedor armazena o código no AWS CodeCommit e configura o AWS CodeBuild para executar os testes de unidade. O
o desenvolvedor cria uma função AWS Lambda para iniciar a tarefa do CodeBuild. O desenvolvedor precisa identificar o
Eventos CodeCommit em um evento do Amazon EventBridge que pode invocar a função Lambda quando uma solicitação pull é
criado ou atualizado.
Qual evento do CodeCommit atenderá a esses requisitos?

- A. referenceCreated
- B. pullRequestMergeStateChanged
- C. pullRequestCreated e pullRequestSourceBranchUpdated
- D. codeCommitPRCreated e codeCommitPRUpdated

**Resposta: C**

**Explicação:**

C. Os eventos na resposta D não são reais. A e B estão claramente errados, pois dois eventos são necessários. O EventBridge precisa ouvir dois eventos do CodeCommit: pullRequestCreated (novo PR) e pullRequestSourceBranchUpdated (PR atualizado).

---

## Questão 76

Um desenvolvedor implantou um aplicativo em uma instância do Amazon EC2. A aplicação precisa conhecer o IPv4 público
endereço da instância.
Como o aplicativo pode encontrar essas informações?

- A.Consulte os metadados da instância em http://169.254.169.254/latest/meta-data/.
- B.Consulte os dados do usuário da instância em http://169.254.169.254/latest/user-data/.
- C.Consulte as informações da Amazon Machine Image (AMI) em http://169.254.169.254/latest/meta-data/ami/.
- D.Verifique o arquivo hosts do sistema operacional.

**Resposta: A**

**Explicação:**

A resposta correta é A porque os metadados da instância são projetados especificamente para fornecer informações sobre o
A própria instância do EC2, incluindo seu endereço IPv4 público, sem exigir nenhuma chamada ou configuração de API externa
arquivos. Essas informações podem ser acessadas de dentro da instância por meio de um endereço IP específico e não roteável
(169.254.169.254). Esse endereço é consistente em todas as regiões e tipos de instância da AWS, tornando-o um endereço confiável
e padronizada de acessar metadados de instância. Os metadados incluem detalhes como ID da instância, público
e endereços IP privados, grupos de segurança, função IAM e muito mais.
A opção B está incorreta porque os dados do usuário permitem passar scripts ou dados de configuração para a instância durante
lançamento. Não se destina à recuperação de informações dinâmicas de instância, como o endereço IP público. Enquanto você poderia
armazenar o IP público nos dados do usuário durante a criação da instância, essas informações não serão atualizadas se o IP mudar.
A opção C está incorreta porque tem como alvo informações da AMI. Embora a AMI usada para iniciar a instância faça parte do
os metadados, ele não fornece diretamente o endereço IP público. A AMI contém o sistema operacional básico
e configuração de software, não informações dinâmicas de tempo de execução.
A opção D está incorreta. O arquivo hosts mapeia nomes de host para endereços IP. Embora possa conter uma entrada para um
nome de host local, ele normalmente não contém o endereço IPv4 público atribuído pela AWS. Além disso, contando com
o arquivo hosts tornaria o aplicativo dependente da configuração manual, anulando o propósito de
recuperar essas informações programaticamente. Consultar o arquivo hosts também geralmente não é confiável em ambientes dinâmicos.
ambientes de nuvem.
Usar metadados de instância é a maneira mais eficiente, confiável e segura de uma instância do EC2 descobrir
informações sobre si mesmo no ambiente AWS.
Consulte estes links de documentação da AWS para obter mais informações:
Metadados da instância e dados do usuário
Acessando Metadados da Instância

---

## Questão 78

Uma empresa está planejando implantar um aplicativo na AWS por trás de um Elastic Load Balancer. O aplicativo usa um
Ouvinte HTTP/HTTPS e deve acessar os endereços IP do cliente.
Qual solução de balanceamento de carga atende a esses requisitos?

- A.Use um Application Load Balancer e os cabeçalhos X-Forwarded-For.
- B.Use um balanceador de carga de rede (NLB). Ative o suporte ao protocolo proxy no NLB e no aplicativo de destino.
- C.Use um balanceador de carga de aplicativo. Registre os destinos pelo ID da instância.
- D.Use um Network Load Balancer e os cabeçalhos X-Forwarded-For.

**Resposta: A**

**Explicação:**

A resposta correta é A: Use um Application Load Balancer e os cabeçalhos X-Forwarded-For.
Aqui está o porquê:
Application Load Balancer (ALB): Os ALBs operam na camada de aplicação (Camada 7) do modelo OSI, permitindo
para inspecionar os cabeçalhos HTTP. Esta capacidade é crucial para acessar o endereço IP do cliente em HTTP/HTTPS
tráfego.
Cabeçalho X-Forwarded-For: Quando um cliente se conecta a um ALB, o ALB adiciona um cabeçalho X-Forwarded-For ao
Solicitação HTTP. Este cabeçalho contém o endereço IP do cliente, permitindo que o aplicativo o recupere.
Ouvinte HTTP/HTTPS: A pergunta afirma explicitamente que o aplicativo usa um ouvinte HTTP/HTTPS,
tornando um ALB a escolha apropriada para lidar com esse tipo de tráfego.
Vamos examinar por que as outras opções estão incorretas:
B. Network Load Balancer (NLB) com protocolo proxy: os NLBs operam na camada de transporte (camada 4). Enquanto
eles podem encaminhar a conexão do cliente para o destino, usando o protocolo proxy exige que o back-end
o aplicativo deve ser capaz de interpretar o cabeçalho do protocolo proxy, aumentando a complexidade. X-Forwarded-For de um ALB
A abordagem do cabeçalho é mais simples e mais padrão para o tráfego HTTP/HTTPS.
C. Application Load Balancer com ID de instância: registrar destinos por ID de instância é uma configuração válida, mas
não aborda diretamente o acesso ao endereço IP do cliente. Afeta apenas como o ALB roteia o tráfego para o
instâncias.
D. Network Load Balancer com X-Forwarded-For: NLBs não adicionam ou processam X-Forwarded-For automaticamente
cabeçalhos. Eles encaminham a conexão TCP, deixando para o aplicativo back-end gerenciar os cabeçalhos.
Portanto, esta opção está incorreta.
Em resumo, a solução mais simples e apropriada para acessar endereços IP de clientes em um
O aplicativo HTTP/HTTPS por trás de um balanceador de carga na AWS é usar um Application Load Balancer e ler o
Cabeçalho X-Forwarded-For.
Documentação de apoio:
Application Load Balancers - Recuperando endereço IP do cliente:
Balanceadores de carga de rede - protocolo proxy:

---

## Questão 79

Um desenvolvedor deseja depurar um aplicativo pesquisando e filtrando dados de log. Os logs do aplicativo são armazenados em
Logs do Amazon CloudWatch. O desenvolvedor cria um novo filtro de métrica para contar exceções nos logs do aplicativo.
No entanto, nenhum resultado é retornado dos logs.
Qual é o motivo pelo qual nenhum resultado filtrado está sendo retornado?

- A.Uma configuração do endpoint VPC da interface do Amazon CloudWatch é necessária para filtrar o CloudWatch Logs em
o VPC.
- B.CloudWatch Logs publica apenas dados de métrica para eventos que acontecem após a criação do filtro.
- C. O grupo de logs do CloudWatch Logs deve ser transmitido primeiro para o Amazon OpenSearch Service antes da métrica
a filtragem retorna os resultados.
- D. Os pontos de dados de métrica para grupos de logs podem ser filtrados somente depois de serem exportados para um bucket do Amazon S3.

**Resposta: B**

**Explicação:**

A resposta correta é B: o CloudWatch Logs publica apenas dados de métricas para eventos que acontecem depois que o filtro é
criado.
Aqui está uma justificativa detalhada:
O CloudWatch Logs opera em tempo real e de forma prospectiva para filtros de métricas. Quando um filtro métrico é
criado no CloudWatch Logs, ele começa a monitorar eventos de log de entrada desse ponto em diante. Não
processar retroativamente os dados de log existentes. O filtro é aplicado aos logs recém-ingeridos. Esse comportamento é intencional
para garantir um processamento de log eficiente e escalonável.
Se um desenvolvedor criar um filtro de métrica e esperar ver imediatamente resultados de eventos de log anteriores, ele será
decepcionado. O filtro só começará a coletar dados quando novas entradas de log que correspondam aos critérios do filtro forem
gravado no grupo de logs.
A opção A está incorreta porque um VPC endpoint para CloudWatch Logs é relevante quando um aplicativo em um
A VPC precisa de acesso privado ao CloudWatch Logs, ignorando a Internet pública. Não afeta diretamente o
funcionalidade de filtros métricos.
A opção C está incorreta porque durante o streaming de logs para o Amazon OpenSearch Service (anteriormente Elasticsearch
Service) é uma forma válida de realizar análise e pesquisa de log, não é um pré-requisito para usar filtros de métrica dentro
O próprio CloudWatch Logs. Os filtros de métrica são um recurso integrado do CloudWatch Logs que opera independentemente de
Serviço OpenSearch.
A opção D está incorreta porque a exportação de grupos de logs para o Amazon S3 é principalmente para arquivamento de longo prazo e muito mais
processamento analítico complexo de dados de log. Embora os logs exportados pelo S3 possam ser analisados posteriormente, não é
necessário para que os filtros métricos funcionem. Os resultados do filtro de métrica são independentes da exportação de log para o S3. Métrica
os filtros operam diretamente nos logs armazenados no CloudWatch Logs.
Portanto, a ausência de resultados indica fortemente que o filtro de métrica recém-criado ainda não foi
encontrou quaisquer novos eventos de log que correspondam aos seus critérios desde a sua criação. A solução envolveria esperar
para que novos logs de exceção sejam gerados e, em seguida, verifique se o filtro de métrica os está processando corretamente.
Links autorizados:
Usando filtros de métrica – Amazon CloudWatch Logs (especificamente, observe como os filtros monitoram os logs de entrada).
Criar filtros de métricas a partir de grupos de logs - Amazon CloudWatch Logs

---
