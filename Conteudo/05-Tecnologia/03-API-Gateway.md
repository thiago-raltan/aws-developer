# Amazon API Gateway — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Serviço gerenciado para criar, publicar, proteger e monitorar APIs REST, HTTP e WebSocket em qualquer escala. Atua como porta de entrada para backends como Lambda, EC2 ou serviços HTTP.

**Para que usamos:** Expor funções Lambda como APIs HTTP, aplicar autenticação via Cognito/IAM/Lambda Authorizer, controle de tráfego com throttling e Usage Plans, transformação de request/response com Mapping Templates.

**Exemplo de prova:** Uma API REST no API Gateway recebe picos de tráfego que causam throttling na Lambda downstream. A equipe quer aceitar as requisições extras sem rejeitá-las imediatamente, processando-as de forma assíncrona. Qual arquitetura implementar?
→ Configurar o API Gateway com **integração direta ao SQS** (AWS Service Integration). As requisições são enfileiradas no SQS e a Lambda consome a fila de forma assíncrona. Isso desacopla a ingestão do processamento e evita que picos de tráfego atinjam diretamente a Lambda.

---

## Tipos de API

| Tipo | Protocolo | Cache | Lambda Auth | Cognito Auth | Cost |
|---|---|---|---|---|---|
| REST API | HTTP | Sim | Sim | Sim | Maior |
| HTTP API | HTTP | Não | Sim | Sim (JWT) | ~71% menor |
| WebSocket API | WS | N/A | Sim | Não diretamente | — |

---

## Limites REST API

| Item | Valor |
|---|---|
| Timeout de integração | 29 s (máximo) |
| Payload request máximo | 10 MB |
| Throttle padrão | 10.000 req/s burst, 5.000 req/s steady |
| Cache TTL | 0–3.600 s (padrão 300 s) |

---

## Autorizadores

| Tipo | Valida | Cache | Uso |
|---|---|---|---|
| Cognito | JWT automaticamente | TTL configurável | Cognito User Pools |
| Lambda (Token) | Bearer token | TTL configurável | Tokens customizados |
| Lambda (Request) | Headers/params | TTL configurável | Lógica complexa |
| IAM | SigV4 | Sem cache | AWS services / CLI |
| API Key + Usage Plan | Chave de API | — | Rate limiting por cliente |

---

## Estágios e Variáveis

- Deploy necessário para ativar mudanças no stage.
- Stage variables: `${stageVariables.varName}` em ARNs de integração.
- Canary: percentual de tráfego para nova versão no mesmo stage.

---

## Domínio customizado

- Edge-optimized: cert ACM em **us-east-1**.
- Regional: cert ACM na mesma região.
- Base path mapping: domínio → API + stage.

---

## Referências oficiais

- [API Gateway Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)
