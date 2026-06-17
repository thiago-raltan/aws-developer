# APIs REST no Amazon API Gateway

> Foco DVA-C02 – Domínio 1: Development with AWS Services

---

## Tipos de API no API Gateway

| Tipo | Protocolo | Uso |
|---|---|---|
| **REST API** | HTTP/HTTPS | Recursos, métodos, estágios — o mais cobrado na prova |
| **HTTP API** | HTTP/HTTPS | Mais barato, mais rápido, menos features |
| **WebSocket API** | WebSocket | Comunicação bidirecional em tempo real |

---

## Componentes principais (REST API)

```
[Cliente]
    ↓
[API Gateway — Endpoint]
    ↓
[Recurso: /usuarios]
    ↓
[Método: GET / POST / PUT / DELETE]
    ↓
[Integração: Lambda / HTTP / Mock / AWS Service]
    ↓
[Stage: dev / prod]
```

### Stages e Deploy
- Alterações **não ficam ativas** até o deploy para um Stage.
- Stage Variables: variáveis por ambiente (`${stageVariables.lambdaAlias}`).
- Canary deploy: % do tráfego vai para nova versão no mesmo Stage.

### Autorizadores (Authorizers)
| Tipo | Como funciona |
|---|---|
| **Cognito User Pool** | Valida JWT do Cognito automaticamente |
| **Lambda Authorizer (Token)** | Lambda valida bearer token, retorna política IAM |
| **Lambda Authorizer (Request)** | Lambda valida headers/params, retorna política IAM |
| **IAM** | Assinatura SigV4 nas requisições |
| **API Key** | Chave de uso com planos de uso |

### Mapeamento de requisição/resposta
- **Mapping Templates** (VTL): transformam payload entre cliente e backend.
- Integration Request / Integration Response: onde configurar mapeamento.

---

## Conceitos críticos para a prova ⚠️

- **Timeout**: máximo **29 segundos** para integração REST API (10 s padrão, ajustável).
- **CORS**: configure no API Gateway para permitir chamadas de outros domínios.
- **Usage Plans + API Keys**: controle de quota e throttle por cliente.
- **Private API**: acesso somente via VPC Endpoint (Interface endpoint).
- **Cache**: TTL de 0 a 3.600 s; pode ser invalidado por `Cache-Control: max-age=0`.
- **Lambda Proxy Integration**: passa tudo para Lambda sem mapeamento; Lambda formata a resposta completa.

---

## Pegadinhas da prova 🎯

- Deploy no API Gateway é **manual** por padrão — não automático ao salvar.
- Stage Variables não são variáveis de ambiente da Lambda.
- Lambda Authorizer **retorna** uma IAM Policy — API Gateway avalia essa policy.
- CORS precisa ser habilitado **no API Gateway**, não apenas na Lambda.
- HTTP API não suporta: API Keys, Usage Plans, Request Validation nativo, Resource Policies.

---

## Referências oficiais

- [Amazon API Gateway REST API](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-rest-api.html)
- [API Gateway authorizers](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-use-lambda-authorizer.html)
- [API Gateway stages](https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-stages.html)
- [Enable CORS](https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-cors.html)
