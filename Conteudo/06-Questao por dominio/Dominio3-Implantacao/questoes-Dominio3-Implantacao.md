# Questões — Dominio3-Implantacao

> Formato: cada bloco separado por `---`. Campos `[ENUNCIADO]`, `[A]`..`[E]`, `[RESPOSTA]`, `[EXPLICACAO]`.
> Alternativas devem ocupar UMA linha. Enunciado e explicação podem ter múltiplas linhas.

---

## Q6

[ENUNCIADO]
Um desenvolvedor está criando um modelo AWS CloudFormation para implantar instâncias do Amazon EC2 em vários AWS contas. O desenvolvedor deve escolher as instâncias EC2 em uma lista de tipos de instância aprovados. Como o desenvolvedor pode incorporar a lista de tipos de instância aprovados no modelo CloudFormation?

[A] Crie um modelo CloudFormation separado para cada tipo de instância EC2 na lista.
[B] Na seção Recursos do modelo CloudFormation, crie recursos para cada tipo de instância EC2 no lista.
[C] No modelo CloudFormation, crie um parâmetro separado para cada tipo de instância EC2 na lista.
[D] No modelo CloudFormation, crie um parâmetro com a lista de tipos de instância EC2 como AllowedValues.

[RESPOSTA] D

[EXPLICACAO]
A maneira mais eficaz e gerenciável para um desenvolvedor incorporar uma lista de tipos de instâncias EC2 aprovados dentro de um modelo CloudFormation é utilizar a propriedade AllowedValues em uma declaração de parâmetro. Isto abordagem permite controle centralizado e validação da entrada do usuário. A opção D sugere a criação de um parâmetro dentro do modelo CloudFormation. Este parâmetro seria defina especificamente a lista de tipos de instância EC2 aprovados usando a propriedade AllowedValues. Quando um usuário implanta a pilha do CloudFormation, eles estão restritos a escolher apenas entre os tipos de instância listados no Valores permitidos. Se o usuário tentar fornecer um tipo de instância diferente, o CloudFormation rejeitará a entrada, impedindo a criação de uma instância EC2 não suportada. Este método é limpo, conciso e garante que apenas tipos de instância aprovados são iniciados. Promove a padronização e ajuda a evitar erros de configuração. As opções A, B e C são menos ideais porque são excessivamente complexas ou não fornecem as informações necessárias. validação. Criar modelos CloudFormation separados para cada tipo de instância (A) seria complicado e difícil de manter. Criar recursos para cada tipo de instância (B) também seria ineficiente e não permitir que o usuário escolha um tipo de instância. Criar parâmetros separados para cada tipo de instância (C) seria confuso para o usuário e não forneceria uma maneira de impor uma lista específica de tipos de instância aprovados. Por conseguinte, a opção D constitui a solução mais adequada e eficiente, proporcionando uma forma gerível de impor a lista de tipos de instância EC2 aprovados no modelo CloudFormation. Este método é consistente com os princípios da infraestrutura como código e ajuda a garantir que a infraestrutura implantada atende aos requisitos de segurança e conformidade. Outras pesquisas podem ser realizadas nos seguintes links: Parâmetros do AWS CloudFormation: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/parameters-section-structure.html Valores permitidos do AWS CloudFormation: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/parameters-section- estrutura.html#parameters-section-estrutura-propriedades

---

## Q15

[ENUNCIADO]
Um desenvolvedor está implantando uma função AWS Lambda O desenvolvedor deseja retornar para versões mais antigas do a função de forma rápida e perfeita. Como o desenvolvedor pode atingir esse objetivo com a MENOS sobrecarga operacional?

[A] Use o AWS OpsWorks para realizar implantações azuis/verdes.
[B] Use um alias de função com versões diferentes.
[C] Manter pacotes de implantação para versões mais antigas no Amazon S3.
[D] Use AWS CodePipeline para implantações e reversões.

[RESPOSTA] B

[EXPLICACAO]
A melhor abordagem para reversões rápidas e contínuas de funções do AWS Lambda com operação mínima sobrecarga está usando um alias de função com versões diferentes. Aqui está o porquê: As versões do Lambda são instantâneos imutáveis do código da função e da configuração. Criar versões é direto no Lambda. (https://docs.aws.amazon.com/lambda/latest/dg/configuration-versions.html) Os aliases atuam como ponteiros para versões específicas do Lambda. Ao direcionar um alias para uma versão anterior, você efetivamente reverter o código ativo da sua função. (https://docs.aws.amazon.com/lambda/latest/dg/configuration- aliases.html) Este mecanismo é significativamente menos complexo do que outras abordagens. OpsWorks (opção A) é um exagero para reversões simples e envolve configuração substancial. CodePipeline (opção D) introduz um pipeline CI/CD, que é adequado para cenários de implantação mais complexos, mas adiciona sobrecarga desnecessária para simples reversões. A manutenção de pacotes no S3 (opção C) requer processos de implantação manual, eliminando o requisito "contínuo" e aumento da carga operacional. Os aliases permitem que você alterne o tráfego entre versões gradualmente, permitindo implantações canário e testes A/B, se necessário, embora esse não seja o objetivo principal aqui. Reverter com aliases requer apenas a alteração do alias versão de destino, que é uma operação rápida e facilmente automatizada. Nenhuma nova implantação é necessária. O o código anterior da função já está implantado em seu formato versionado. Além disso, os aliases podem ser associados a diferentes variáveis ​​de ambiente. Isto permite uma reversão não apenas para o código anterior, mas também às configurações de ambiente anteriores. Esta abordagem alinha-se perfeitamente com o requisitos do problema de sobrecarga operacional mínima e, ao mesmo tempo, permitir reversões rápidas e diretas.

---

## Q17

[ENUNCIADO]
Para uma implantação usando o AWS Code Deploy, qual é a ordem de execução dos ganchos para implantações locais?

[A] BeforeInstall -> ApplicationStop -> ApplicationStart -> AfterInstall
[B] ApplicationStop -> BeforeInstall -> AfterInstall -> ApplicationStart
[C] BeforeInstall -> ApplicationStop -> ValidateService -> ApplicationStart
[D] ApplicationStop -> BeforeInstall -> ValidateService -> ApplicationStart

[RESPOSTA] B

[EXPLICACAO]
A resposta correta é B: ApplicationStop -> BeforeInstall -> AfterInstall -> ApplicationStart. As implantações locais do AWS CodeDeploy seguem uma sequência específica de eventos do ciclo de vida para gerenciar aplicativos atualizações em instâncias existentes. O gancho ApplicationStop é executado primeiro. Isto é crucial porque interrompe o versão atualmente em execução do aplicativo, evitando conflitos durante a atualização. Depois do existente aplicativo for interrompido, o gancho BeforeInstall será acionado. Isso permite tarefas como fazer backup do atual versão do aplicativo ou preparando o ambiente para a nova implantação. Em seguida, o gancho AfterInstall é executado. Este gancho facilita as ações necessárias imediatamente após o novo versão do aplicativo está instalada, como configurar permissões de arquivo ou configurar links simbólicos. Finalmente, o O gancho ApplicationStart inicia o aplicativo recém-implantado. Isso torna o aplicativo atualizado acessível para usuários. A opção A está incorreta porque coloca BeforeInstall antes de ApplicationStop, causando potencialmente conflitos se o a nova instalação interfere no aplicativo ainda em execução. As opções C e D incluem ValidateService, que é não é um gancho padrão para implantações locais. Embora você possa configurar ganchos personalizados, isso não substitui nem perturbar a ordem desses ganchos principais. A ordem prescrita garante uma transição suave do antigo versão do aplicativo para a nova, minimizando o tempo de inatividade e evitando erros. A ordem prioriza parar primeiro o aplicativo em execução, preparando-se para a nova versão, finalizando a instalação e, em seguida, iniciando o aplicativo atualizado. Essa abordagem é fundamental para implantações locais. Para obter mais informações, consulte a documentação do AWS CodeDeploy sobre ciclos de vida de implantação: https://docs.aws.amazon.com/codedeploy/latest/userguide/reference-appspec-file-structure-hooks.html e https://docs.aws.amazon.com/codedeploy/latest/userguide/deployments-lifecycle.html.

---

## Q24

[ENUNCIADO]
Uma empresa deseja implantar e manter sites estáticos na AWS. O código-fonte de cada site está hospedado em um dos vários sistemas de controle de versão, incluindo AWS CodeCommit, Bitbucket e GitHub. A empresa deseja implementar lançamentos em fases usando desenvolvimento, preparação, testes de aceitação do usuário e ambientes de produção na Nuvem AWS. As implantações em cada ambiente devem ser iniciadas por mesclagens de código em o branch Git relevante. A empresa deseja usar HTTPS para todas as trocas de dados. A empresa precisa de uma solução que não exige que os servidores funcionem continuamente. Qual solução atenderá a esses requisitos com a MENOS sobrecarga operacional?

[A] Hospedar cada site usando AWS Amplify com um back-end sem servidor. Conned as ramificações do repositório que correspondem a cada um dos ambientes desejados. Inicie as implantações mesclando as alterações de código em um desejado filial.
[B] Hospedar cada site no AWS Elastic Beanstalk com vários ambientes. Use o EB CLI para vincular cada ramificação do repositório. Integre o AWS CodePipeline para automatizar implantações de mesclagens de código de controle de versão.
[C] Hospedar cada site em diferentes buckets do Amazon S3 para cada ambiente. Configurar o AWS CodePipeline para extraia o código-fonte do controle de versão. Adicione um estágio do AWS CodeBuild para copiar o código-fonte para o Amazon S3.
[D] Hospedar cada site em sua própria instância do Amazon EC2. Escreva um script de implantação personalizado para agrupar cada um ativos estáticos do site. Copie os ativos para o Amazon EC2. Configure um fluxo de trabalho para executar o script quando o código for mesclado.

[RESPOSTA] A

[EXPLICACAO]
A resposta correta é A, usando AWS Amplify. Aqui está o porquê: O AWS Amplify foi projetado especificamente para hospedar sites estáticos e aplicativos de página única com suporte sem servidor. back-ends. Ele se integra diretamente com vários sistemas de controle de versão (CodeCommit, Bitbucket, GitHub) tornando conectar-se a ramificações do repositório é simples. O Amplify implanta alterações automaticamente quando o código é mesclado em um filial, permitindo o fluxo de trabalho de lançamento em fases desejado (desenvolvimento, preparação, UAT, produção). Amplificar fornece suporte HTTPS integrado, atendendo aos requisitos de segurança. Além disso, o Amplify é um servidor sem servidor plataforma, o que significa que a empresa não precisa gerenciar nenhum servidor subjacente, minimizando despesas gerais e os custos são incorridos apenas durante as implantações ou quando o site é acessado. É rápido de configurar usando o console do AWS Amplify. A opção B, usando o Elastic Beanstalk, é menos adequada porque o Elastic Beanstalk foi projetado para operações mais complexas. aplicativos e requer instâncias de servidores gerenciados, violando a regra "nenhum servidor em execução contínua" exigência. Embora o CodePipeline possa ser usado para implantações, ele adiciona complexidade em comparação ao Amplify integração integrada.A opção C, usando S3 e CodePipeline/CodeBuild, requer mais configuração manual. Você precisaria gerenciar políticas de bucket, configurar estágios do CodePipeline e configurar HTTPS manualmente por meio de CloudFront. Isso aumenta a sobrecarga operacional. S3 também requer configuração extra, como CloudFront, para tornar o site acessível via HTTPS, enquanto o Amplify faz isso por padrão. A opção D, usando EC2, requer gerenciamento constante de servidores e scripts de implantação manual. Isto contradiz o "menos operacional sobrecarga" e a necessidade de infraestrutura sem servidor. Em resumo, o AWS Amplify é a solução mais eficiente e direta para hospedar sites estáticos com integração de controle de versão, lançamentos em fases, HTTPS e sobrecarga operacional mínima. Links autorizados: AWS Amplify: https://aws.amazon.com/amplify/ AWS CodePipeline: https://aws.amazon.com/codepipeline/ Amazon S3: https://aws.amazon.com/s3/ AWS Elastic Beanstalk: https://aws.amazon.com/elasticbeanstalk/

---

## Q32

[ENUNCIADO]
Um desenvolvedor precisa realizar testes de carga geográfica de uma API. O desenvolvedor deve implantar recursos para vários Regiões da AWS para oferecer suporte ao teste de carga da API. Como o desenvolvedor pode atender a esses requisitos sem código de aplicativo adicional?

[A] Criar e implantar uma função AWS Lambda em cada região desejada. Configure a função Lambda para criar uma pilha de um modelo do AWS CloudFormation nessa região quando a função é invocada.
[B] Crie um modelo AWS CloudFormation que defina os recursos de teste de carga. Use a criação da AWS CLI Comando stack-set para criar um conjunto de pilhas nas regiões desejadas.
[C] Crie um documento do AWS Systems Manager que defina os recursos. Use o documento para criar o recursos nas regiões desejadas.
[D] Crie um modelo AWS CloudFormation que defina os recursos de teste de carga. Usar a implantação da AWS CLI comando para criar uma pilha a partir do modelo em cada região.

[RESPOSTA] B

[EXPLICACAO]
A resposta correta é B: Crie um modelo AWS CloudFormation que defina os recursos de teste de carga. Usar o comando create-stack-set da AWS CLI para criar um conjunto de pilhas nas regiões desejadas. Isso ocorre porque a AWS CloudFormation StackSets fornecem um mecanismo conveniente para provisionar pilhas (e, portanto, recursos) em várias regiões da AWS a partir de um único modelo do CloudFormation. Isso elimina a necessidade de escrever código personalizado ou scripts para lidar com a implantação em cada região. StackSets permitem gerenciar e atualizar pilhas em várias contas e regiões. Eles tratam um coleção de pilhas como uma única entidade. Isso simplifica o processo de implantação de recursos idênticos para diferentes regiões, alinhando-se perfeitamente com a exigência de testes de carga geográfica. A opção A está incorreta porque usar o Lambda para implantar pilhas do CloudFormation em várias regiões requer codificação extra para lidar com invocação do Lambda e implantações específicas de região. A opção C está incorreta, pois os Documentos do Gerenciador de Sistemas, embora capazes de gerenciar recursos, são mais orientado para tarefas de gerenciamento de configuração e automação dentro de um ambiente existente, não para o criação inicial de infraestrutura em múltiplas regiões. Não é a abordagem mais eficiente para implantação recursos para diferentes regiões, já que o escopo é mais voltado para operações específicas de instância. A opção D está incorreta porque o uso do comando de implantação da AWS CLI exigiria execução manual para cada região, tornando-o menos eficiente e sujeito a erros em comparação com StackSets. Além disso, isso não alavanca um maneira gerenciada de lidar com a infraestrutura em todas as regiões. Concluindo, StackSets (opção B) fornece a maneira mais eficiente e gerenciável de provisionar recursos em várias regiões da AWS sem código de aplicativo adicional, usando um único modelo em vários regiões. Links relevantes para pesquisas futuras: Conjuntos de pilhas do AWS CloudFormation: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-concepts.html Comando create-stack-set da AWS CLI: https://awscli.amazonaws.com/v2/documentation/api/latest/reference/cloudformation/create-stack-set.html

---

## Q34

[ENUNCIADO]
Um desenvolvedor está criando um modelo que usa o AWS CloudFormation para implantar um aplicativo. O aplicativo é sem servidor e usa Amazon API Gateway, Amazon DynamoDB e AWS Lambda. Qual serviço ou ferramenta da AWS o desenvolvedor deve usar para definir recursos sem servidor em YAML?

[A] CloudFormation (Funções intrínsecas sem servidor)
[B] AWS Elastic Beanstalk
[C] AWS SAM (Modelo de aplicativo sem servidor)
[D] AWS CDK (Kit de desenvolvimento em nuvem)

[RESPOSTA] C

[EXPLICACAO]
A resposta correta é C: AWS Serverless Application Model (AWS SAM). Aqui está uma justificativa detalhada: AWS SAM é uma estrutura desenvolvida com base no AWS CloudFormation, projetada especificamente para a construção de servidores sem servidor. aplicações. Simplifica o processo de definição e implantação de recursos sem servidor, como Lambda funções, API Gateways, tabelas DynamoDB e muito mais. O SAM consegue isso fornecendo uma sintaxe simplificada usando YAML ou JSON para descrever esses recursos. Ele usa declarações abreviadas que são então traduzidas em modelos CloudFormation totalmente expandidos durante a implantação. A opção A, funções intrínsecas do CloudFormation, são úteis para modelos gerais do CloudFormation, mas não fornecem definições simplificadas de recursos adaptadas especificamente para arquiteturas sem servidor que o SAM oferece. Funções intrínsecas são usadas em modelos do CloudFormation para executar tarefas como referenciar recursos atributos ou lógica condicional. Embora os modelos SAM usem funções intrínsecas do CloudFormation nos bastidores após o processamento do SAM, eles não são a principal ferramenta para definir recursos sem servidor de maneira concisa. A opção B, AWS Elastic Beanstalk, é uma oferta de plataforma como serviço (PaaS) que automatiza a implantação e gerenciamento de aplicativos e serviços da web. Embora o Elastic Beanstalk possa ser usado com alguns servidores sem servidor componentes, ele não foi projetado principalmente para definir e implantar uma arquitetura completa sem servidor como o aquele descrito na pergunta (API Gateway, Lambda, DynamoDB). A opção D, AWS Cloud Development Kit (CDK), é uma estrutura para definir infraestrutura de nuvem em código usando linguagens de programação familiares como Python, TypeScript ou Java. Embora o CDK possa definir recursos sem servidor, AWS SAM é uma maneira mais direta e concisa de criar modelos CloudFormation especificamente adaptados para aplicativos sem servidor expressos em YAML ou JSON. O CDK fornece um nível mais alto de abstração e mais flexibilidade, mas também pode introduzir mais complexidade do que o SAM para projetos sem servidor. SAM é muito mais opção leve. Portanto, como a pergunta pede especificamente um serviço ou ferramenta para definir recursos sem servidor em YAML, O AWS SAM é a escolha mais adequada devido ao seu foco na simplificação de implantações sem servidor por meio de modelos declarativos e abstrações de recursos sem servidor criados diretamente no CloudFormation. Aqui estão alguns links confiáveis para pesquisas futuras: AWS SAM: https://aws.amazon.com/serverless/sam/ AWS CloudFormation: https://aws.amazon.com/cloudformation/ AWSCDK: https://aws.amazon.com/cdk/

---

## Q42

[ENUNCIADO]
Uma equipe de desenvolvimento deseja construir um pipeline de integração/entrega contínua (CI/CD). A equipe está usando AWS CodePipeline para automatizar a construção e implantação de código. A equipe deseja armazenar o código do programa para se preparar para o pipeline de CI/CD. Qual serviço AWS a equipe deve usar para armazenar o código do programa? -AWS CodeDeploy

[B] AWS CodeArtifact
[C] AWS CodeCommit
[D] Amazon CodeGuru

[RESPOSTA] C

[EXPLICACAO]
A resposta correta é C, AWS CodeCommit. Eis o porquê: um pipeline de CI/CD começa com o repositório de código. AWS CodeCommit é uma fonte totalmente gerenciada serviço de controle que hospeda repositórios seguros baseados em Git. Ele permite que a equipe armazene e versione de forma privada seus código. O CodeCommit integra-se diretamente ao AWS CodePipeline, tornando-o uma escolha natural para armazenar o código do aplicativo neste cenário. O CodePipeline pode ser configurado para acionar automaticamente compilações e implantações sempre que as alterações são enviadas para o repositório do CodeCommit. AWS CodeDeploy (A) é um serviço de implantação, não um repositório de código. Ele automatiza a implantação de aplicativos para vários serviços de computação, mas não armazena o código em si. AWS CodeArtifact (B) é um serviço de repositório de pacotes usado para armazenar e compartilhar pacotes de software como dependências (por exemplo, Maven artefatos, pacotes npm). Embora esteja relacionado ao desenvolvimento, não é o local principal para armazenar o próprio código-fonte do aplicativo. Amazon CodeGuru (D) é um serviço de revisão de código e criação de perfil de desempenho; isso analisa o código existente, mas não o armazena. Portanto, o CodeCommit é a primeira etapa lógica na criação do pipeline de CI/CD usando o CodePipeline para automatizar a construção e implantação do código. Ele aborda o requisito de armazenar código de programa, servindo como fonte para o gasoduto. Pesquisa adicional: AWS CodeCommit: https://aws.amazon.com/codecommit/ AWS CodePipeline: https://aws.amazon.com/codepipeline/

---

## Q47

[ENUNCIADO]
Um aplicativo usa um grupo do Amazon EC2 Auto Scaling. Um desenvolvedor percebe que as instâncias do EC2 estão demorando muito tempo para ficar disponível durante eventos de expansão. O script UserData está demorando muito para ser executado. O desenvolvedor deve implementar uma solução para diminuir o tempo que decorre antes que uma instância do EC2 se torne disponível. A solução deve disponibilizar sempre a versão mais recente do aplicativo e deve ser aplicada todas as atualizações de segurança disponíveis. A solução também deve minimizar o número de imagens criadas. As imagens deve ser validado. Qual combinação de etapas o desenvolvedor deve seguir para atender a esses requisitos? (Escolha dois.)

[A] Use o EC2 Image Builder para criar uma Amazon Machine Image (AMI). Instale todos os patches e agentes que estão necessários para gerenciar e executar o aplicativo. Atualize a configuração de inicialização do grupo do Auto Scaling para usar a AMI.
[B] Use o EC2 Image Builder para criar uma Amazon Machine Image (AMI). Instale a versão mais recente do aplicativo e todos os patches e agentes necessários para gerenciar e executar o aplicativo. Atualizar o Auto Scaling configuração de inicialização de grupo para usar a AMI.
[C] Configure o AWS CodeDeploy para implantar a versão mais recente do aplicativo em tempo de execução.
[D] Configure o AWS CodePipeline para implantar a versão mais recente do aplicativo em tempo de execução.
[E] Remova quaisquer comandos que executem correção do sistema operacional do script UserData.

[RESPOSTA] A,E

[EXPLICACAO]
O problema é a disponibilidade lenta da instância do EC2 durante eventos de expansão de grupo do Auto Scaling devido a um longo período de tempo. Script UserData. O objetivo é minimizar o tempo de inicialização da instância, ter sempre a versão mais recente do aplicativo, aplicar atualizações de segurança, minimizar a criação de imagens e validar imagens. A opção A está correta porque o EC2 Image Builder automatiza a criação, aplicação de patches e testes de AMIs. Por pré- instalando todos os agentes e patches necessários, inicialização de instâncias pronta para implantação de aplicativos, significativamente reduzindo o tempo de execução do script UserData. Isso resolve diretamente o problema do tempo de inicialização lento. A opção E está correta porque complementa a opção A. Mover o patch do sistema operacional para fora do script UserData alinha com o objetivo de reduzir o tempo de execução do script. Em vez disso, a correção do sistema operacional é feita pelo EC2 Image Builder ao criar a AMI, garantindo que as instâncias iniciem com as atualizações de segurança mais recentes sem atrasar a inicialização processo. A opção B é semelhante a A, mas especifica a inclusão da versão mais recente do aplicativo na AMI. Embora aparentemente benéfico, incorporar o aplicativo na AMI aumenta a frequência de recriações da AMI para mantê-lo atualizado, violando o requisito de minimizar a criação de imagens. Também não aborda como a versão mais recente é determinado e incorporado ao processo de construção da AMI. A opção C (CodeDeploy) está incorreta porque, embora implemente a versão mais recente do aplicativo, ela é executada em tempo de execução (ou seja, após a inicialização da instância). Isso ainda contribui para o tempo total que uma instância leva para se tornar disponível, conflitando com o requisito de minimizar o tempo de inicialização da instância. A opção D (CodePipeline) está incorreta por motivos semelhantes a C. CodePipeline é um serviço CI/CD que pode automatizar implantação do aplicativo, mas ainda resultaria na implantação em tempo de execução, o que é mais lento do que ter o instâncias pré-configuradas com uma AMI atualizada. Portanto, usando o EC2 Image Builder para criar AMIs pré-preparadas com agentes, patches (A) e patches móveis fora do script UserData (E) resolve efetivamente o problema, minimizando o tempo de execução de UserData e garante instâncias validadas e seguras com criação mínima de imagens. Documentação Relevante: Construtor de imagens EC2: https://aws.amazon.com/image-builder/ Grupos de Auto Scaling: https://docs.aws.amazon.com/autoscaling/ec2/userguide/AutoScalingGroup.html

---

## Q57

[ENUNCIADO]
Uma empresa precisa proteger suas imagens de contêiner antes que elas estejam em estado de execução. A empresa O aplicativo usa o Amazon Elastic Container Registry (Amazon ECR) como registro de imagem. Amazon Elástico Serviço Kubernetes (Amazon EKS) para computação e um pipeline AWS CodePipeline que orquestra um fluxo contínuo fluxo de trabalho de integração e entrega contínua (CI/CD). O teste dinâmico de segurança de aplicativos ocorre no estágio final do pipeline, depois que uma nova imagem é implantada em um namespace de desenvolvimento no cluster EKS. Um desenvolvedor precisa colocar um estágio de análise antes desta implantação para analisar a imagem do contêiner anteriormente no pipeline de CI/CD. Qual solução atenderá a esses requisitos com MAIOR eficiência operacional?

[A] Construa a imagem do contêiner e execute o comando docker scan localmente. Mitigar quaisquer descobertas antes de pressionar alterações no repositório de código-fonte. Escreva um gancho de pré-confirmação que imponha o uso deste fluxo de trabalho antes cometer.
[B] Crie um novo estágio do CodePipeline que ocorre após a criação da imagem do contêiner. Configurar imagem básica do ECR digitalizando para digitalizar no envio de imagem. Use uma função AWS Lambda como provedor de ação. Configurar o Lambda função para verificar os resultados da verificação e falhar no pipeline se houver descobertas.
[C] Crie um novo estágio CodePipeline que ocorre após o código-fonte ter sido recuperado de seu repositório. Execute um scanner de segurança na última revisão do código-fonte. Falhe o pipeline se houver descobertas.
[D] Adicionar uma ação ao estágio de implantação do pipeline para que a ação ocorra antes da implantação no Aglomerado EKS. Configure a digitalização básica de imagens do ECR para digitalizar no envio de imagens. Use uma função AWS Lambda como o provedor de ação. Configure a função Lambda para verificar os resultados da verificação e falhar no pipeline se houver descobertas.

[RESPOSTA] B

[EXPLICACAO]
Aqui está uma justificativa detalhada de por que a opção B é a melhor solução, juntamente com conceitos e links de apoio: O principal requisito é analisar imagens de contêiner antes da implantação, mas depois que a imagem for criada, integrando-o perfeitamente ao pipeline de CI/CD existente com eficiência operacional. A opção B aborda isso diretamente inserindo um novo estágio do CodePipeline após a construção da imagem. Ele aproveita Digitalização básica de imagens on push integrada do ECR, que é operacionalmente eficiente porque é um serviço gerenciado recurso que requer infraestrutura personalizada mínima. A função AWS Lambda atua como um orquestrador, verificando verificar resultados e falhar no pipeline com base nas descobertas. Isto cria uma “porta” no pipeline, impedindo imagens vulneráveis sejam implantadas. A natureza sem servidor e orientada a eventos do Lambda garante economia e escalabilidade para esta tarefa. A opção A é menos eficiente. Contando com os desenvolvedores para executar o docker scan localmente e aplicar isso com pré-commit hooks está sujeito a erros humanos e aplicação inconsistente. Não garante segurança consistente práticas em toda a equipe de desenvolvimento e carece de controle centralizado. A opção C concentra-se na verificação do código-fonte, o que é valioso, mas não aborda diretamente as vulnerabilidades que podem ser introduzidos durante o processo de construção da imagem do contêiner (por exemplo, pacotes desatualizados extraídos de repositórios durante a construção do docker). Embora a análise do código-fonte seja importante, ela não satisfaz o requisito de analisando a imagem do contêiner. A opção D tenta inserir a lógica de digitalização no estágio de implantação, que ocorre após a imagem já ter sido passou pelos estágios anteriores do pipeline. Isso não é o ideal, pois atrasa a detecção de vulnerabilidades até que um posteriormente e pode exigir a reversão de uma imagem implantada se forem encontrados problemas. Além disso, ao aproveitar A digitalização ECR e o Lambda são bons, adicioná-los ao estágio de implantação não analisa verdadeiramente a imagem "anteriormente" no pipeline, o que é um requisito fundamental. Portanto, a opção B oferece o melhor equilíbrio entre eficiência operacional, integração com o CI/CD existente pipeline e o momento crucial da análise de imagem após a construção, mas antes da implantação. ECR integrado a varredura e uma função Lambda simples minimizam a sobrecarga operacional. Conceitos e links de apoio: Digitalização de imagens do Amazon ECR: https://docs.aws.amazon.com/AmazonECR/latest/userguide/image- digitalização.html AWS Lambda: https://aws.amazon.com/lambda/ AWS CodePipeline: https://aws.amazon.com/codepipeline/ Pipelines de CI/CD: Compreender os princípios do CI/CD ajuda a entender onde as diferentes verificações de segurança caber no pipeline para máximo impacto.

---

## Q62

[ENUNCIADO]
Uma empresa implantou um aplicativo no AWS Elastic Beanstalk. A empresa configurou o Auto Scaling grupo associado ao ambiente do Elastic Beanstalk tenha cinco instâncias do Amazon EC2. Se a capacidade houver menos de quatro instâncias do EC2 durante a implantação, o desempenho do aplicativo será prejudicado. A empresa está usando a política de implantação completa. Qual é a maneira MAIS econômica de resolver o problema de implantação?

[A] Altere o grupo do Auto Scaling para seis instâncias desejadas.
[B] Alterar a política de implantação para divisão de tráfego. Especifique um tempo de avaliação de 1 hora.
[C] Alterar a política de implantação para rolar com lote adicional. Especifique um tamanho de lote de 1.
[D] Altere a política de implantação para contínua. Especifique um tamanho de lote de 2.

[RESPOSTA] C

[EXPLICACAO]
Aqui está uma justificativa detalhada de por que a opção C é a solução mais econômica, juntamente com links relevantes para pesquisas adicionais: O principal problema é que a política de implantação "tudo de uma vez" no Elastic Beanstalk faz com que o aplicativo degradação porque pode reduzir brevemente a contagem de instâncias abaixo do limite exigido (4 instâncias). O o objetivo é manter pelo menos quatro instâncias em execução durante todo o processo de implantação e, ao mesmo tempo, minimizar os custos. Opção A (aumentar as instâncias desejadas para seis): Isso garante a capacidade durante a implantação, mas é o menor custo eficaz. A empresa pagará permanentemente por uma instância adicional, mesmo quando as implantações não forem acontecendo. Esta é uma solução superprovisionada e, portanto, cara. Opção B (divisão de tráfego com avaliação): a divisão de tráfego (implantações Canary) é uma estratégia válida, mas concentra-se mais na verificação da nova versão antes de uma implementação completa. O período de avaliação adiciona despesas gerais e não aborda diretamente o problema de contagem de instâncias durante a fase inicial de implantação. Também é mais complexo de implementar e gerenciar. Opção C (Lançamento com lote adicional, tamanho de lote 1): Esta é a mais econômica. "Rolando com adicional batch" aumenta temporariamente a capacidade desejada do grupo de Auto Scaling pelo tamanho do lote durante o implantação. Um tamanho de lote igual a 1 significa que uma nova instância é iniciada antes que uma instância antiga seja retirada do serviço. Como o grupo do Auto Scaling começa com cinco instâncias, a contagem de instâncias aumentará brevemente para seis. Isso garante que sempre haverá pelo menos quatro instâncias íntegras servindo o tráfego durante o implantação. Depois que a implantação em um lote for concluída, essa instância se juntará ao pool de instâncias original, permitindo que outro lote seja implantado. Após a conclusão de toda a implantação, a instância temporária é removido, retornando a contagem total em execução aos cinco desejados. Isto apenas acrescenta custos temporários para o duração da implantação e apenas por uma instância por vez. Opção D (contínuo, tamanho de lote 2): implantações contínuas atualizam instâncias em lotes, mas sem o "adicional funcionalidade em lote", ele derrubará duas instâncias simultaneamente, o que pode degradar o desempenho e violar o requisito de manter pelo menos quatro instâncias em execução. Em resumo: a Opção C atinge o equilíbrio ideal entre a manutenção da capacidade e a minimização dos custos. Por adicionar apenas uma instância adicional por vez durante a implantação e removê-la posteriormente, minimiza sobrecarga enquanto ainda atende ao requisito. Links autorizados para pesquisas futuras: Políticas de implantação do AWS Elastic Beanstalk: https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using- recursos-deploy-policies.html Implantações contínuas do Elastic Beanstalk com lote adicional: https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using-features-rolling-version-deploy.html Auto Scaling da AWS: https://aws.amazon.com/autoscaling/

---

## Q69

[ENUNCIADO]
Um desenvolvedor está configurando o ambiente de implantação de um aplicativo no AWS CodePipeline. O código do aplicativo é armazenado em um repositório GitHub. O desenvolvedor deseja garantir que os testes de unidade do pacote de repositório sejam executados no novo ambiente de implantação. O desenvolvedor já definiu o provedor de origem do pipeline para GitHub e especificou o repositório e a ramificação a serem usados na implantação. Qual combinação de etapas o desenvolvedor deve seguir para atender a esses requisitos com a MENOS sobrecarga? (Escolha dois.)

[A] Crie um projeto AWS CodeCommit. Adicione os comandos build e test do pacote de repositório ao projeto especificação de construção.
[B] Criar um projeto AWS CodeBuild. Adicione os comandos build e test do pacote de repositório ao projeto especificação de construção.
[C] Criar um projeto AWS CodeDeploy. Adicione os comandos build e test do pacote de repositório ao projeto especificação de construção.
[D] Adicione uma ação ao estágio de origem. Especifique o projeto recém-criado como provedor de ação. Especifique a compilação artefato como o artefato de entrada da ação.
[E] Adicione um novo estágio ao pipeline após o estágio de origem. Adicione uma ação ao novo estágio. Especifique o novo projeto criado como o provedor de ação. Especifique o artefato de origem como artefato de entrada da ação.

[RESPOSTA] B,E

[EXPLICACAO]
A resposta correta é SER. Aqui está o porquê: B. Crie um projeto AWS CodeBuild. Adicione os comandos build e test do pacote de repositório ao arquivo buildspec do projeto. AWS CodeBuild é um serviço de integração contínua totalmente gerenciado que compila fontes código, executa testes e produz pacotes de software prontos para implantação. Um arquivo buildspec.yml é usado para defina os comandos de construção, incluindo os comandos necessários para executar testes de unidade. Isto é exatamente o que o desenvolvedor precisa realizar. CodeBuild se integra diretamente ao CodePipeline. https://aws.amazon.com/codebuild/ E. Adicione um novo estágio ao pipeline após o estágio de origem. Adicione uma ação ao novo estágio. Especifique o novo projeto criado como o provedor de ação. Especifique o artefato de origem como artefato de entrada da ação. Esta etapa conecta o projeto CodeBuild ao CodePipeline. Após a etapa "Fonte" (onde o código é recuperado do GitHub), é necessária uma nova etapa de "Build" para executar os testes unitários. O "provedor de ação" está definido para o Projeto CodeBuild, e o "artefato de entrada" é o código-fonte recuperado do GitHub (o "artefato de origem"). Isso garante que o projeto CodeBuild receba o código do estágio de origem, execute os testes definidos no buildspec.yml e produz um artefato para o próximo estágio (se houver). https://docs.aws.amazon.com/codepipeline/latest/userguide/tutorial-create-simple-pipeline.html Por que as outras opções estão incorretas: A. Crie um projeto AWS CodeCommit. Adicione os comandos build e test do pacote de repositório ao arquivo buildspec do projeto. O código já está em um repositório GitHub. Criando um projeto CodeCommit e duplicar o código é uma sobrecarga desnecessária. O CodePipeline se integra diretamente ao GitHub, portanto não há precisa migrar o código. C. Crie um projeto AWS CodeDeploy. Adicione os comandos build e test do pacote de repositório ao arquivo buildspec do projeto. O AWS CodeDeploy é um serviço de implantação que automatiza implantações de aplicativos para vários serviços de computação, como EC2, ECS, Lambda e servidores locais. Embora o CodeDeploy possa ser executado testes como parte da implantação, não é a ferramenta certa para executar testes de unidade antes da implantação. CodeBuild é projetado especificamente para fases de construção e teste em um pipeline. https://aws.amazon.com/codedeploy/ D. Adicione uma ação ao estágio de origem. Especifique o projeto recém-criado como provedor de ação. Especifique o construir artefato como artefato de entrada da ação. O objetivo do estágio de origem é recuperar o código-fonte. Adicionando um projeto de construção para o estágio de origem é ilógico. O estágio de origem deve tratar apenas da busca do código do repositório. Além disso, não há nenhum artefato de construção no estágio de origem, porque o código não foi compilado ou testado ainda.

---

## Q80

[ENUNCIADO]
Uma empresa está planejando usar o AWS CodeDeploy para implantar um aplicativo no Amazon Elastic Container Service (Amazon ECS). Durante a implantação de uma nova versão da aplicação, a empresa inicialmente deverá expor apenas 10% do tráfego ativo para a nova versão do aplicativo implantado. Então, após decorridos 15 minutos, a empresa deverá rotear todo o tráfego ativo restante para a nova versão do aplicativo implantado. Qual configuração predefinida do CodeDeploy atenderá a esses requisitos?

[A] CodeDeployDefault.ECSCanary10Percent15Minutes
[B] CodeDeployDefault.LambdaCanary10Percent5Minutes
[C] CodeDeployDefault.LambdaCanary10Percentl15Minutes
[D] CodeDeployDefault.ECSLinear10PercentEvery1Minutes

[RESPOSTA] A

[EXPLICACAO]
A resposta correta é A. CodeDeployDefault.ECSCanary10Percent15Minutes. Aqui está uma justificativa detalhada: CodeDeploy oferece configurações de implantação predefinidas para gerenciar a mudança de tráfego durante a aplicação atualizações. O cenário requer uma estratégia de implantação canário para uma aplicação em execução no Amazon ECS (Serviço de Contêiner Elástico). Uma implantação canário envolve inicialmente o roteamento de uma pequena porcentagem do tráfego para o nova versão do aplicativo, monitorando seu desempenho e, em seguida, transferindo gradualmente mais tráfego, se tudo está estável. A opção A, CodeDeployDefault.ECSCanary10Percent15Minutes, foi projetada especificamente para implantações canário para o ECS. Primeiro ele encaminha 10% do tráfego para a nova versão. Após um período de espera de 15 minutos, roteia automaticamente os 90% restantes do tráfego para a nova versão. Isto se alinha perfeitamente com o requisito de expor inicialmente apenas 10% do tráfego ao vivo por 15 minutos e depois transferir o tráfego restante. A opção B, CodeDeployDefault.LambdaCanary10Percent5Minutes, é para implantações do AWS Lambda, não para ECS. Além disso, espera apenas 5 minutos, o que não satisfaz o período de espera de 15 minutos. A opção C, CodeDeployDefault.LambdaCanary10Percentl15Minutes, tem um nome de configuração inválido. Mesmo que seja Se uma configuração Lambda for válida, os mesmos problemas da Opção B se aplicam: é para Lambda e não para ECS. A opção D, CodeDeployDefault.ECSLinear10PercentEvery1Minutes, usa uma estratégia de implantação linear onde o tráfego é alterado em incrementos (10% a cada 1 minuto). Esta não é uma implantação canário e não afeta diretamente cumprir o requisito específico de 10% por 15 minutos seguido de 100%. Portanto, apenas a opção A cumpre com precisão os requisitos indicados. É uma predefinição específica do ECS configuração que implementa uma implantação canário com a exposição de tráfego inicial desejada de 10% e uma período de espera de um minuto antes de transferir todo o tráfego restante. Links oficiais para pesquisas futuras: Documentação do AWS CodeDeploy: https://docs.aws.amazon.com/codedeploy/latest/userguide/welcome.html Configurações de implantação do CodeDeploy: https://docs.aws.amazon.com/codedeploy/latest/userguide/deployment-configurations.html Implantações Canary com CodeDeploy: https://aws.amazon.com/blogs/devops/performing-canary- implantações com código awsdeploy/ Obrigado Obrigado por estar tão interessado no material de exame premium. Fico feliz em saber que você o achou informativo e útil. Mas espere Queria avisar que há mais conteúdo disponível na versão completa. O documento completo contém seções adicionais e informações que podem ser úteis, e eu encorajo você a baixá-lo para obter uma visão mais abrangente e detalhada de todo o assunto. Baixe a versão completa agora 551 perguntas Total: Link: https://certyiq.com/papers/amazon/aws-certified-developer-associate-dva-c02

---

