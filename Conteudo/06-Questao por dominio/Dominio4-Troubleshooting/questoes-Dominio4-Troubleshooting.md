# Questões — Dominio4-Troubleshooting

> Formato: cada bloco separado por `---`. Campos `[ENUNCIADO]`, `[A]`..`[E]`, `[RESPOSTA]`, `[EXPLICACAO]`.
> Alternativas devem ocupar UMA linha. Enunciado e explicação podem ter múltiplas linhas.

---

## Q7

[ENUNCIADO]
Um desenvolvedor tem um aplicativo que faz solicitações em lote diretamente ao Amazon DynamoDB usando o método Operação de API de baixo nível BatchGetItem. As respostas frequentemente retornam valores no elemento UnprocessedKeys. Quais ações o desenvolvedor deve tomar para aumentar a resiliência do aplicativo quando a resposta em lote inclui valores em UnprocessedKeys? (Escolha dois.)

[A] Repita a operação em lote imediatamente.
[B] Tente novamente a operação em lote com espera exponencial e atraso aleatório.
[C] Atualizar o aplicativo para usar um kit de desenvolvimento de software AWS (AWS SDK) para fazer as solicitações.
[D] Aumentar a capacidade de leitura provisionada das tabelas do DynamoDB que a operação acessa.
[E] Aumentar a capacidade de gravação provisionada das tabelas do DynamoDB que a operação acessa.

[RESPOSTA] B,D

[EXPLICACAO]
O elemento UnprocessedKeys em uma resposta BatchGetItem indica que o DynamoDB não conseguiu recuperar alguns itens devido a limitação ou erros internos. Para melhorar a resiliência do aplicativo, precisamos resolver esse problema efetivamente. A opção B está correta porque tentar novamente a operação em lote com espera exponencial e atraso aleatório é uma abordagem padrão e de melhores práticas para lidar com erros transitórios e limitação em sistemas distribuídos. A espera exponencial aumenta gradualmente o tempo de espera entre novas tentativas, reduzindo a probabilidade de esmagador DynamoDB. O atraso aleatório ajuda ainda mais a evitar um efeito de "rebanho trovejante", onde vários clientes tentam novamente simultaneamente, agravando potencialmente o problema de limitação. Esta estratégia segue princípios de tolerância a falhas e mecanismos de nova tentativa na computação em nuvem. https://aws.amazon.com/blogs/architecture/exponencial-backoff-and-jitter/ A opção D também está correta porque UnprocessedKeys pode indicar que a capacidade de leitura da tabela DynamoDB é insuficiente para lidar com a solicitação de leitura em lote. Aumentar a capacidade de leitura provisionada pode reduzir o frequência de limitação e, portanto, a ocorrência de UnprocessedKeys. Ele aborda diretamente a causa potencial do erro aumentando os recursos disponíveis para a aplicação. Isso se alinha com o conceito de escalonamento recursos para atender à demanda em ambientes de nuvem. https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.ReadWriteCapacityMode.html A opção A está incorreta porque tentar novamente imediatamente e sem demora pode piorar a situação, potencialmente levando a um maior estrangulamento. A opção C está incorreta. Embora o uso do SDK da AWS seja geralmente recomendado, ele não resolve inerentemente o emissão de UnprocessedKeys. O SDK fornece métodos úteis, incluindo lógica de nova tentativa, mas o aplicativo ainda precisa ser configurado para lidar adequadamente com solicitações aceleradas usando espera exponencial e aleatória nervosismo. A opção E está incorreta porque UnprocessedKeys no contexto de BatchGetItem está relacionada a operações de leitura, não operações de gravação. Aumentar a capacidade de gravação não resolverá o problema.

---

## Q8

[ENUNCIADO]
Uma empresa está executando um aplicativo personalizado em um conjunto de servidores Linux locais que são acessados usando Amazon Gateway de API. O rastreamento do AWS X-Ray foi habilitado no estágio de teste da API. Como um desenvolvedor pode habilitar o rastreamento do X-Ray nos servidores locais com a MENOS quantidade de configuração?

[A] Instale e execute o X-Ray SDK nos servidores locais para capturar e retransmitir os dados para o serviço X-Ray.
[B] Instalar e executar o daemon do X-Ray nos servidores locais para capturar e retransmitir os dados para o X-Ray serviço.
[C] Capturar solicitações recebidas no local e configurar uma função AWS Lambda para extrair, processar e retransmitir dados relevantes para o X-Ray usando a chamada de API PutTraceSegments.
[D] Capturar solicitações recebidas no local e configurar uma função AWS Lambda para extrair, processar e retransmitir dados relevantes para o X-Ray usando a chamada de API PutTelemetryRecords.

[RESPOSTA] B

[EXPLICACAO]
A resposta correta é B porque fornece a maneira mais simples e eficiente de ativar o rastreamento de raios X em servidores locais com configuração mínima. O daemon X-Ray foi projetado especificamente para essa finalidade. Isso escuta o tráfego na porta UDP 2000, armazena documentos de segmento em buffer e os carrega no AWS X-Ray. Aqui está um resumo de por que as outras opções são menos adequadas: A. Instale e execute o SDK do X-Ray nos servidores locais para capturar e retransmitir os dados para o X-Ray serviço: embora o SDK seja necessário para instrumentar o próprio código do aplicativo para criar segmentos e subsegmentos, ele não retransmite automaticamente os dados para o X-Ray. O SDK normalmente requer integração com o Daemon X-Ray ou chamadas diretas de API da AWS, aumentando a complexidade. C. Capture solicitações recebidas no local e configure uma função AWS Lambda para extrair, processar e retransmitir dados relevantes para o X-Ray usando a chamada de API PutTraceSegments: esta abordagem envolve sobrecarga. Requer capturar os dados necessários, configurar e gerenciar uma função Lambda e manualmente elaborar os dados no formato esperado pela API PutTraceSegments. Isso aumenta a complexidade e despesas gerais de gerenciamento substancialmente. D. Capture solicitações recebidas no local e configure uma função AWS Lambda para extrair, processar e retransmitir dados relevantes para o X-Ray usando a chamada de API PutTelemetryRecords: PutTelemetryRecords é usado para métricas e dados operacionais, não para rastrear dados como segmentos. Não é apropriado para enviar rastreamento de raio-X informação. Semelhante à opção C, este método introduz sobrecarga e complexidade significativas usando Lambda. O daemon X-Ray fornece uma solução simplificada e dedicada para coletar e encaminhar dados de rastreamento. Por executando o daemon nos servidores locais, o aplicativo pode enviar dados de rastreamento para o daemon, que em seguida, agrupa e envia os dados com eficiência para o X-Ray. Essa abordagem evita a necessidade de código personalizado complexo ou chamadas diretas de API da AWS do próprio aplicativo. O daemon lida automaticamente com autenticação e buffer, reduzindo a complexidade do envio de rastreamento dados para Raio-X. É a abordagem recomendada para descarregar a tarefa de enviar dados de rastreamento do seu aplicações. Links autorizados: Daemon do AWS X-Ray: https://docs.aws.amazon.com/xray/latest/devguide/xray-daemon.html SDK do AWS X-Ray: https://docs.aws.amazon.com/xray/latest/devguide/xray-sdk.html

---

## Q16

[ENUNCIADO]
Um desenvolvedor escreveu uma função AWS Lambda. A função é vinculada à CPU. O desenvolvedor quer garantir que a função retorna respostas rapidamente. Como o desenvolvedor pode melhorar o desempenho da função?

[A] Aumentar a contagem de núcleos da CPU da função.
[B] Aumentar a memória da função.
[C] Aumentar a simultaneidade reservada da função.
[D] Aumentar o tempo limite da função.

[RESPOSTA] B

[EXPLICACAO]
A resposta correta é B. Aumente a memória da função. Aqui está uma justificativa detalhada: As funções Lambda alocam automaticamente a potência da CPU proporcional à quantidade de memória configurada. Um O desempenho da função vinculada à CPU se beneficia diretamente do aumento do poder de processamento. Ao aumentar o memória alocada para a função Lambda, a computação subjacente também aumenta, fornecendo mais núcleos de CPU e poder de processamento. Isso permite que a função execute suas tarefas com uso intensivo de CPU mais rapidamente, levando a tempos de resposta. A opção A, “Aumentar a contagem de núcleos de CPU da função”, não é diretamente possível no AWS Lambda configuração. Você não pode ajustar manualmente a contagem de núcleos da CPU. Em vez disso, você aumenta indiretamente o poder da CPU em aumentando a memória. A opção C, "Aumentar a simultaneidade reservada da função", melhora a capacidade da função de lidar com um número maior número de solicitações simultâneas, mas não aborda diretamente o desempenho de uma única solicitação vinculada à CPU. execução da função. A simultaneidade gerencia o número de execuções simultâneas, não a velocidade de uma única execução. A opção D, “Aumentar o tempo limite da função”, permite apenas que a função seja executada por mais tempo antes de ser encerrada; isso não melhora seu desempenho. É uma solução alternativa para desempenho lento, não uma solução para torná-lo mais rápido. Em resumo, aumentar a memória alocada para uma função Lambda vinculada à CPU aumenta a CPU disponível potência, resultando em execução mais rápida e melhores tempos de resposta. Esta é a maneira mais direta e eficaz de melhorar o desempenho da função neste cenário. Pesquisa adicional: Preços do AWS Lambda: https://aws.amazon.com/lambda/pricing/ - Entendendo como a memória afeta o custo e desempenho. Configurando opções de função Lambda: https://docs.aws.amazon.com/lambda/latest/dg/configuration- options.html – Informações detalhadas sobre alocação de memória e como ela se relaciona com os recursos subjacentes.

---

## Q18

[ENUNCIADO]
Uma empresa está construindo um aplicativo sem servidor na AWS. O aplicativo usa uma função AWS Lambda para processar pedidos de clientes 24 horas por dia, 7 dias por semana. A função Lambda chama a API HTTP de um fornecedor externo para processar pagamentos. Durante os testes de carga, um desenvolvedor descobre que a API de processamento de pagamentos de fornecedores externos ocasionalmente atinge o tempo limite e retorna erros. A empresa espera que algumas chamadas da API de processamento de pagamentos retornem erros. A empresa deseja que a equipe de suporte receba notificações quase em tempo real apenas quando o processamento do pagamento a taxa de erro da API externa excede 5% do número total de transações em uma hora. Os desenvolvedores precisam usar um tópico existente do Amazon Simple Notification Service (Amazon SNS) configurado para notificar a equipe de suporte. Qual solução atenderá a esses requisitos?

[A] Escreva os resultados das chamadas de API de processamento de pagamentos para o Amazon CloudWatch. Usar logs do Amazon CloudWatch Insights para consultar os logs do CloudWatch. Agende a função Lambda para verificar os logs do CloudWatch e notificar o tópico SNS existente.
[B] Publicar métricas personalizadas no CloudWatch que registrem as falhas das chamadas de API de processamento de pagamentos externos. Configure um alarme do CloudWatch para notificar o tópico SNS existente quando a taxa de erros exceder a taxa especificada.
[C] Publicar os resultados das chamadas de API de processamento de pagamentos externos em um novo tópico do Amazon SNS. Assine o apoiar os membros da equipe no novo tópico do SNS.
[D] Escreva os resultados das chamadas de API de processamento de pagamentos externos para o Amazon S3. Agende um Amazon Athena consulta seja executada em intervalos regulares. Configure o Athena para enviar notificações ao tópico SNS existente quando o taxa de erro excede a taxa especificada.

[RESPOSTA] B

[EXPLICACAO]
A melhor solução é B: publicar métricas personalizadas no CloudWatch que registrem as falhas do externo chamadas de API de processamento de pagamentos. Configure um alarme do CloudWatch para notificar o tópico SNS existente quando o taxa de erro excede a taxa especificada. Aqui está o porquê: Monitoramento e alertas em tempo real: o CloudWatch foi projetado para monitoramento em tempo real de métricas e configurações ativar alarmes com base em limites. Isso se alinha com o requisito de notificações quase em tempo real quando o a taxa de erro excede 5%. Métricas personalizadas: como as métricas padrão do CloudWatch podem não rastrear diretamente a chamada de API externa falhas, métricas personalizadas são cruciais. Podemos publicar métricas registrando especificamente APIs bem-sucedidas e com falha chamadas. Alarmes do CloudWatch: os alarmes do CloudWatch permitem definir uma métrica (neste caso, a taxa de erro calculada das métricas personalizadas), um limite (5%) e uma ação (notificar o tópico SNS existente) quando o limite for violado. Aproveitar a infraestrutura existente: Esta solução reutiliza o tópico SNS existente, minimizando a necessidade de novos configurações e integrações. Por que outras opções são menos adequadas: R: CloudWatch Logs Insights: embora o CloudWatch Logs Insights possa consultar logs, não é a melhor opção para monitoramento e alertas em tempo real. Funções Lambda agendadas que consultam logs introduziriam latência e complexidade. Ele não foi projetado para monitoramento e alarmes contínuos e em tempo real. C: Novo tópico SNS: A criação de um novo tópico SNS exigiria o gerenciamento de um fluxo de notificação adicional para o equipe de suporte quando a necessidade é reutilizar a existente. Isso não resolve a agregação de métricas e problema de monitoramento de limite. D: Amazon S3 e Athena: esta abordagem é voltada para cargas de trabalho analíticas, não para monitoramento em tempo real e alertando. Armazenar dados no S3, executar consultas do Athena em intervalos e acionar notificações seria introduzem latência e sobrecarga operacional significativas em comparação ao uso do CloudWatch. Não foi projetado para alertas e monitoramento em tempo real ou quase em tempo real. Em resumo, a Opção B fornece a solução mais eficiente, em tempo real e económica, ao aproveitando os recursos de monitoramento e alerta do CloudWatch com métricas e alarmes personalizados. É eficiente atende ao requisito de notificar a equipe de suporte por meio do tópico SNS existente quando a taxa de erro excede o limite especificado. Links autorizados: Métricas personalizadas do CloudWatch: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/publishingMetrics.html Alarmes CloudWatch: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html

---

## Q41

[ENUNCIADO]
Um desenvolvedor está criando um aplicativo web que usa o Amazon API Gateway para expor uma função do AWS Lambda a processar solicitações de clientes. Durante o teste, o desenvolvedor percebe que o API Gateway atinge o tempo limite, mesmo que a função Lambda termina abaixo do limite de tempo definido. Qual das seguintes métricas do API Gateway no Amazon CloudWatch pode ajudar o desenvolvedor a solucionar problemas do questão? (Escolha dois.)

[A] CacheHitCount
[B] IntegraçãoLatência
[C] CacheMissCount
[D] Latência
[E] Contagem

[RESPOSTA] B,D

[EXPLICACAO]
O problema surge quando o API Gateway atinge o tempo limite, apesar da função Lambda ser concluída em seu tempo alocado. Para solucionar isso de forma eficaz, precisamos investigar as métricas relacionadas ao API Gateway interação com a função backend do Lambda e o tempo geral de processamento da solicitação. B. IntegrationLatency: esta métrica mede o tempo que o API Gateway leva para enviar uma solicitação ao backend da função Lambda e receba uma resposta. Um IntegrationLatency alto indica um gargalo ou atraso no a comunicação entre o API Gateway e a função Lambda. Isso pode ser devido a problemas de rede, A função Lambda é inicializada a frio ou o tempo de processamento da função Lambda está próximo do limite. Se IntegrationLatency for alto, mesmo que a função Lambda seja concluída dentro do limite geral configurado, o tempo de interação mais o tempo de execução do Lambda pode estar excedendo a configuração de tempo limite do API Gateway. D. Latência: esta métrica representa o tempo total que o API Gateway leva para processar uma solicitação, desde o do momento em que recebe a solicitação até o momento em que envia a resposta de volta ao cliente. Um alto valor de latência sugere um problema no próprio API Gateway ou em sua interação com o back-end. Comparando a latência com IntegrationLatency, o desenvolvedor pode discernir se o gargalo está no API Gateway ou em seu comunicação com a função Lambda. Se a diferença entre Latência e IntegraçãoLatência for significativo, indica atrasos no processamento dentro do API Gateway, como autorização ou transformação passos. Por que outras opções são menos relevantes: A. CacheHitCount e C. CacheMissCount: essas métricas referem-se à funcionalidade de cache do API Gateway. Como o problema surge mesmo quando a função Lambda é concluída dentro do limite de tempo, o comportamento de armazenamento em cache é improvável que seja a causa raiz do tempo limite. O cache normalmente é usado para reduzir invocações do Lambda e melhorar os tempos de resposta para dados acessados com frequência. No entanto, os tempos limite geralmente indicam um problema fundamental com o processamento ou a interação do API Gateway com o serviço de back-end, e não com que frequência o cache é atingido ou faltou. E. Contagem: esta métrica indica o número total de solicitações recebidas pelo API Gateway. Embora útil para entendendo o volume de tráfego, ele não fornece insights sobre os problemas de desempenho que causam o tempo limite. Um a alta contagem de solicitações não explica inerentemente por que uma solicitação está expirando, apenas que muitas solicitações estão sendo processado. Não ajudará no diagnóstico do problema de latência. Em resumo, IntegrationLatency e Latency fornecem as informações mais relevantes para identificar a causa do Tempo limite do API Gateway. Essas métricas permitem ao desenvolvedor identificar se o atraso ocorre durante o integração com a função Lambda ou dentro do próprio API Gateway. Documentação de apoio: Monitoramento da execução da API do API Gateway com métricas do Amazon CloudWatch

---

## Q43

[ENUNCIADO]
Um desenvolvedor está projetando uma função AWS Lambda que cria arquivos temporários com menos de 10 MB durante invocação. Os arquivos temporários serão acessados ​​e modificados diversas vezes durante a invocação. O desenvolvedor tem não há necessidade de salvar ou recuperar esses arquivos no futuro. Onde os arquivos temporários devem ser armazenados?

[A] o diretório /tmp
[B] Amazon Elastic File System (Amazon EFS)
[C] Amazon Elastic Block Store (Amazon EBS)
[D] Amazon S3

[RESPOSTA] A

[EXPLICACAO]
O local correto para armazenar arquivos temporários em uma função AWS Lambda, especificamente aqueles menores mais de 10 MB que não requerem armazenamento persistente, é o diretório /tmp. Aqui está o porquê: Armazenamento temporário: o Lambda fornece 512 MB de espaço em disco temporário no diretório /tmp. Este armazenamento é disponível apenas durante a invocação da função. Assim que a execução da função for concluída, o /tmp o conteúdo do diretório é descartado. Desempenho: acessar arquivos no diretório /tmp é significativamente mais rápido em comparação ao uso externo serviços de armazenamento como Amazon S3 ou Amazon EFS. Os arquivos são armazenados localmente na execução do Lambda ambiente. Econômico: o uso de /tmp é gratuito e não acarreta custos adicionais. O custo está implicitamente incluído no Custo de execução do Lambda, com base na duração da função e na alocação de memória. Caso de uso apropriado: a pergunta afirma que os arquivos temporários são criados e acessados várias vezes durante a invocação e não precisam ser armazenados ou recuperados. Isso se alinha perfeitamente com o uso de /tmp. Amazon S3 Inapropriado: o Amazon S3 foi projetado para armazenamento durável baseado em objetos. Usando S3 temporariamente arquivos introduziriam sobrecarga desnecessária (latência de rede, chamadas de API, custo), uma vez que os arquivos só são necessários durante a execução da função. Amazon EFS Inapropriado: Amazon EFS é um sistema de arquivos de rede ideal para armazenamento persistente compartilhado. Semelhante para o S3, ele não foi projetado para arquivos efêmeros e de curta duração gerados durante uma única invocação do Lambda. Seria também introduzem latência e custo de rede desnecessários. Amazon EBS inapropriado: os volumes do Amazon EBS são dispositivos de armazenamento em bloco normalmente conectados ao EC2 instâncias. Eles não são diretamente compatíveis com funções Lambda da mesma forma que /tmp e adicioná-los envolveria configuração e complexidade adicionais. Portanto, o diretório /tmp fornece o equilíbrio ideal entre desempenho, custo e conveniência para armazenar arquivos temporários dentro do cenário de função Lambda descrito. Leitura adicional: Trabalhando com camadas e extensões do AWS Lambda em imagens de contêiner: https://aws.amazon.com/blogs/compute/working-with-aws-lambda-layers-and-extensions-in-container- images/ (discute o armazenamento temporário de arquivos em funções Lambda baseadas em contêiner, que também usam /tmp) Ambiente de execução AWS Lambda: https://docs.aws.amazon.com/lambda/latest/dg/lambda-environment- variáveis.html (menciona o diretório /tmp e suas limitações)

---

## Q56

[ENUNCIADO]
Uma empresa está usando uma função AWS Lambda para processar registros de um fluxo de dados do Amazon Kinesis. O a empresa observou recentemente um processamento lento dos registros. Um desenvolvedor percebe que a métrica de idade do iterador para o função está aumentando e que a duração da execução do Lambda está constantemente acima do normal. Quais ações o desenvolvedor deve realizar para aumentar a velocidade de processamento? (Escolha dois.)

[A] Aumentar o número de fragmentos do fluxo de dados do Kinesis.
[B] Diminuir o tempo limite da função Lambda.
[C] Aumentar a memória alocada para a função Lambda.
[D] Diminuir o número de fragmentos do fluxo de dados do Kinesis.
[E] Aumente o tempo limite da função Lambda.

[RESPOSTA] A,C

[EXPLICACAO]
A resposta correta é A e C. Eis o porquê: A. Aumentar o número de fragmentos do fluxo de dados do Kinesis: o aumento da idade do iterador sugere que A função Lambda não está acompanhando os dados recebidos. Os fragmentos do Kinesis são a unidade base da taxa de transferência. Cada O shard fornece uma capacidade de entrada de 1 MB/s e saída de 2 MB/s. Ao aumentar o número de fragmentos, você aumentar a capacidade geral de leitura do stream, permitindo que mais invocações simultâneas de funções do Lambda sejam realizadas. processar dados em paralelo. Cada execução de função do Lambda lê um único fragmento por vez. Mais fragmentos paralelizar efetivamente o processamento. Isso aborda diretamente o processamento lento e o aumento da idade do iterador. https://docs.aws.amazon.com/streams/latest/dev/kinesis-scaling.html C. Aumentar a memória alocada para a função Lambda: Aumentando a memória alocada para o A função Lambda também aumenta proporcionalmente sua alocação de CPU. Funções Lambda alocam energia da CPU proporcional à memória alocada. Se a duração da execução do Lambda estiver constantemente acima do normal, isso indica que a função pode estar vinculada à CPU ou demorar mais para ser processada. Ao aumentar a memória, você dá ao funcionar com mais potência da CPU, potencialmente acelerando o processamento de registros. Uma execução com mais desempenho diminui a duração da execução e ajuda a acompanhar os dados do fluxo de entrada. https://docs.aws.amazon.com/lambda/latest/dg/configuration-memory.html Agora, vamos considerar por que as outras opções estão incorretas: B. Diminuir o tempo limite da função Lambda: Diminuir o tempo limite apenas faria com que a função encerre prematuramente se já estiver demorando muito para processar os registros. Não aborda a causa raiz do processamento lento. D. Diminuir o número de fragmentos do fluxo de dados do Kinesis: diminuir o número de fragmentos seria reduzir a capacidade de leitura do fluxo, agravando ainda mais a lentidão do processamento e aumentando a idade do iterador. E. Aumente o tempo limite da função Lambda: Embora isso evite que o Lambda expire, não acelerar o processamento. Ele simplesmente fornece uma janela mais longa para a conclusão do processamento lento, mascarando o problema de desempenho subjacente, em vez de corrigi-lo.

---

## Q63

[ENUNCIADO]
Um desenvolvedor está incorporando o AWS X-Ray em um aplicativo que lida com informações de identificação pessoal (PII). O O aplicativo está hospedado em instâncias do Amazon EC2. As mensagens de rastreamento do aplicativo incluem PII criptografadas e vão para Amazon CloudWatch. O desenvolvedor precisa garantir que nenhuma PII saia das instâncias do EC2. Qual solução atenderá a esses requisitos?

[A] Instrumentar manualmente o SDK do X-Ray no código do aplicativo.
[B] Use o agente de instrumentação automática X-Ray.
[C] Use o Amazon Macie para detectar e ocultar PII. Chame a API X-Ray do AWS Lambda.
[D] Use AWS Distro para telemetria aberta.

[RESPOSTA] A

[EXPLICACAO]
A resposta correta é A: Instrumente manualmente o SDK do X-Ray no código do aplicativo. Aqui está uma justificativa detalhada: O requisito é evitar que PII saiam das instâncias do EC2 enquanto ainda usam o X-Ray para rastreamento. Manualmente instrumentar o X-Ray SDK dá ao desenvolvedor controle granular sobre quais dados são capturados e enviados como dados de rastreamento. Isso permite que o desenvolvedor exclua especificamente qualquer PII antes que os dados sejam passados para o X-Ray serviço. Ao escolher seletivamente o que rastrear, o desenvolvedor pode garantir que nenhuma informação confidencial saia do aplicação. A opção B, usando o agente de instrumentação automática X-Ray, é menos desejável porque captura automaticamente um ampla gama de dados, potencialmente incluindo PII, sem controle explícito do desenvolvedor. Isto aumenta o risco de enviar PII para fora da instância EC2. A instrumentação automática se concentra na facilidade de uso e pode não fornecer o nível de controle necessário ao lidar com dados confidenciais. A opção C, usando Amazon Macie e AWS Lambda, é um exagero e introduz complexidade desnecessária. Macie foi projetado para descobrir e proteger dados confidenciais em repouso e em trânsito na AWS e utilizar Lambda adiciona pontos extras de falha e latência. É mais eficiente controlar diretamente quais dados são rastreados a fonte em vez de tentar limpá-la mais tarde. Além disso, os dados de rastreamento já estão criptografados, então o principal A preocupação é evitar que as PII sejam coletadas e adicionadas aos rastros em primeiro lugar, o que Macie e Lambda não aborda nesta fase. A opção D, AWS Distro for OpenTelemetry (ADOT), fornece uma maneira neutra em relação ao fornecedor para coletar dados de telemetria. Embora o ADOT ofereça flexibilidade, ele ainda requer uma configuração cuidadosa para evitar a captura de PII. Usando ADOT, você precisaria configurar processadores para remover PII, o que adiciona complexidade semelhante à Opção C e é menos simples do que controlar diretamente quais dados são rastreados usando instrumentação manual. Manuais a instrumentação por meio do X-Ray SDK fornece ao desenvolvedor controle direto na origem das informações de rastreamento. Portanto, instrumentar manualmente o SDK do X-Ray no código do aplicativo garante o maior nível de controle sobre quais dados são rastreados e evita que PII saiam inadvertidamente das instâncias EC2, satisfazendo os requisitos da questão. Links de apoio: SDK do AWS X-Ray: https://docs.aws.amazon.com/xray/latest/devguide/xray-sdk.html Conceitos do AWS X-Ray: https://docs.aws.amazon.com/xray/latest/devguide/xray-concepts.html

---

## Q70

[ENUNCIADO]
Um engenheiro criou um teste A/B de um novo recurso em um projeto do Amazon CloudWatch Evidently. O engenheiro configurou duas variações do recurso (Variação A e Variação B) para o teste. O engenheiro quer trabalhar exclusivamente com a Variação A. O engenheiro precisa fazer atualizações para que a Variação A seja a única variação que aparece quando o engenheiro atinge o endpoint do aplicativo. Qual solução atenderá a esse requisito?

[A] Adicione uma substituição ao recurso. Configure o identificador da substituição para o ID do usuário do engenheiro. Defina a variação para Variação A.
[B] Adicione uma substituição ao recurso. Defina o identificador da substituição como Variação A. Defina a variação como 100%.
[C] Adicionar um experimento ao projeto. Defina o identificador do experimento como Variação B. Defina a variação como 0%.
[D] Adicionar um experimento ao projeto. Defina o identificador do experimento para a conta da conta AWS ISet the variação para a Variação A.

[RESPOSTA] A

[EXPLICACAO]
A resposta correta é A: Adicione uma substituição ao recurso. Defina o identificador da substituição para o usuário do engenheiro IDENTIFICAÇÃO. Defina a variação para Variação A. Aqui está uma justificativa detalhada: CloudWatch Evidentemente permite sinalização de recursos e testes A/B. Ao trabalhar em um recurso específico, os desenvolvedores muitas vezes precisam se isolar em uma variação específica para fins de desenvolvimento e teste sem impactar outros usuários ou distorcer os resultados gerais do teste A/B. Evidentemente fornece substituições com precisão para este cenário. As substituições permitem forçar um usuário específico (identificado por um identificador exclusivo, normalmente seu ID do usuário) para sempre receber uma variação específica de um recurso. A opção A aborda diretamente esta necessidade. Ao adicionar uma substituição, o engenheiro pode especificar seu ID de usuário como o identificador. Isso garante que sempre que o contexto de avaliação Evidentemente incluir esse ID de usuário, eles serão veiculados Variação A, independentemente da configuração do teste A/B em andamento ou de quaisquer outros fatores. Esta solução é isolada para o usuário do engenheiro, portanto, isso não afeta o teste A/B maior em execução para outros usuários. É específico e direcionado para o usuário que precisa apenas da variação. A opção B está incorreta porque as substituições devem ser associadas a identificadores de usuário específicos, não a variações eles mesmos. Definir o identificador como "Variação A" não alcançaria o isolamento específico do usuário desejado. Poderia causar comportamento inesperado ou erros. As opções C e D também estão incorretas porque sugerem o uso de experimentos em vez de substituições. Experimentos são usados para medir o impacto dos recursos em diferentes grupos, enquanto as substituições são para testes. Os experimentos podem ser caros e afetar o ambiente de produção. As substituições não devem ser executadas implantações de produção. Em resumo, a funcionalidade de substituição do Evidently permite que os desenvolvedores controlem a variação de recursos que eles experiência, fornecendo uma ferramenta valiosa para desenvolvimento e depuração sem afetar o teste A/B mais amplo resultados ou outros usuários. Consulte a documentação oficial do AWS CloudWatch Evidently para obter informações mais detalhadas: Recursos do AWS CloudWatch evidentemente CloudWatch evidentemente substitui

---

## Q73

[ENUNCIADO]
Uma empresa executa um aplicativo na AWS. A empresa implantou o aplicativo em instâncias do Amazon EC2. O aplicativo armazena dados no Amazon Aurora. O aplicativo registrou recentemente vários erros DECRYP_ERROR personalizados específicos do aplicativo na Amazon Registros do CloudWatch. A empresa não detectou o problema até que os testes automatizados executados a cada 30 minutos falharam. Um desenvolvedor deve implementar uma solução que monitore os erros personalizados e alerte uma equipe de desenvolvimento sobre em tempo real quando esses erros ocorrem no ambiente de produção. Qual solução atenderá a esses requisitos com a MENOS sobrecarga operacional?

[A] Configure o aplicativo para criar uma métrica personalizada e enviar a métrica para o CloudWatch. Crie uma AWS Alarme do CloudTrail. Configure o alarme do CloudTrail para usar um Amazon Simple Notification Service (Amazon SNS) tópico para enviar notificações.
[B] Crie uma função AWS Lambda para ser executada a cada 5 minutos para verificar a palavra-chave nos logs do CloudWatch DECRYP_ERROR. Configure a função Lambda para usar o Amazon Simple Notification Service (Amazon SNS) para envie uma notificação.
[C] Use o Amazon CloudWatch Logs para criar um filtro de métrica que tenha um padrão de filtro para DECRYP_ERROR. Crie um Alarme do CloudWatch nesta métrica para um limite >=1. Configure o alarme para enviar Amazon Simple Notification Notificações de serviço (Amazon SNS).
[D] Instale o agente unificado CloudWatch na instância EC2. Configure o aplicativo para gerar uma métrica para os erros da palavra-chave DECRYP_ERROR. Configure o agente para enviar o Amazon Simple Notification Service (Amazon SNS) notificações.

[RESPOSTA] C

[EXPLICACAO]
A resposta correta é C porque aproveita recursos integrados do CloudWatch para monitoramento e alertas de log com sobrecarga operacional mínima. Os filtros de métricas do CloudWatch Logs permitem definir padrões de pesquisa nos logs e incrementar uma métrica quando esses padrões forem encontrados. Neste cenário, o padrão de filtro é "DECRYP_ERROR". Criar um alarme do CloudWatch com base nesta métrica permite acionar um SNS notificação quando a contagem de erros (valor métrico) atinge um limite (>=1), fornecendo alertas quase em tempo real para a equipe de desenvolvimento. A opção A está incorreta porque o CloudTrail monitora chamadas de API da AWS, não logs de aplicativos. Não é adequado para erros específicos do aplicativo, como DECRYP_ERROR. Criando uma métrica personalizada dentro do aplicativo e empurrando fazer isso no CloudWatch (conforme sugerido em A e D) é mais complexo do que usar filtros de métrica integrados. Enquanto funciona, é requer a modificação do código do aplicativo e o gerenciamento da criação de métricas e do envio de lógica dentro do aplicativo em si. A opção B envolve a criação de uma função Lambda que pesquisa o CloudWatch Logs. Isso é menos eficiente do que usar filtros métricos porque requer mais código para gerenciar e executar e incorre em custos para execução do Lambda. A pesquisa introduz latência e é menos responsiva do que os recursos de filtragem quase em tempo real do CloudWatch Logs. A opção D é menos desejável porque, embora use o CloudWatch, é necessário instalar e configurar o Agente CloudWatch em cada instância do EC2. O problema pode ser resolvido sem instalar nenhum agente no EC2 e criando métricas personalizadas no aplicativo. Isso aumenta a sobrecarga operacional. Em resumo, os filtros de métricas do CloudWatch Logs com alarmes oferecem uma maneira simples e eficiente de monitorar registra padrões específicos e aciona notificações em tempo real, atendendo aos requisitos com o mínimo carga operacional. Documentação Relevante: Filtros de métricas do CloudWatch Logs Alarmes CloudWatch Amazon SNS

---

