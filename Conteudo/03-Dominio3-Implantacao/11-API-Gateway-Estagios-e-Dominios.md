# API Gateway — Estágios e Domínios Customizados

> Foco DVA-C02 – Domínio 3: Deployment

---

## Estágios (Stages)

- Um estágio é um **ambiente nomeado** do deploy da API (dev, staging, prod).
- URL padrão: `https://api-id.execute-api.region.amazonaws.com/stage-name`
- Alterações na API **não ficam ativas** até deploy para um estágio.

### Stage Variables
- Variáveis chave-valor por estágio.
- Referenciadas no ARN de integração: `${stageVariables.lambdaAlias}`.
- Útil para apontar para diferentes aliases Lambda por estágio.

```
Estágio dev → stageVariables.lambdaAlias = dev
Estágio prod → stageVariables.lambdaAlias = prod

Integração: arn:aws:lambda:...:function:MinhaFuncao:${stageVariables.lambdaAlias}
```

### Canary Release em Stages
- Percentual de tráfego para nova versão do deploy no mesmo estágio.
- Rollback: zerar o percentual canary.

---

## Cache por Estágio

- TTL: 0 a 3.600 s (padrão 300 s).
- Capacidade: 0.5 GB a 237 GB.
- Invalidação: `Cache-Control: max-age=0` (requer permissão IAM do cliente).
- Custo: cobrado por hora por GB de cache.

---

## Domínios Customizados

```
minha-api.empresa.com → API Gateway
```

1. Criar certificado ACM (mesmo certificado deve ser em `us-east-1` para edge-optimized).
2. Criar "Custom Domain Name" no API Gateway.
3. Criar base path mapping (ex: `/v1` → API + Stage).
4. Criar CNAME/Alias no Route 53 apontando para o domínio API Gateway.

### Tipos de endpoint
| Tipo | Descrição |
|---|---|
| **Edge-optimized** | CloudFront + API Gateway; certificado ACM em us-east-1 |
| **Regional** | Sem CloudFront; certificado ACM na mesma região |
| **Private** | Somente via VPC Endpoint |

---

## Throttling

| Nível | Padrão |
|---|---|
| Account-level | 10.000 req/s (soft limit) |
| Stage-level | Configurável |
| Method-level | Configurável |
| Per-client (Usage Plans) | Configurável por chave |

- `429 Too Many Requests` quando throttled.

---

## Conceitos críticos para a prova ⚠️

- Deploy sem estágio = mudança **invisível** para os clientes.
- Canary no Stage: não muda versão do Lambda — usa aliases configurados.
- Edge-optimized → ACM cert em **us-east-1** obrigatório.
- Custom Domain + Base Path Mapping: mapeia domínio para API + Stage específico.

---

## Pegadinhas da prova 🎯

- Stage Variables são **por estágio** — não são variáveis globais da API.
- Cache habilitado = requests idênticos (método + path + params) retornam resposta cacheada.
- Throttle no método tem prioridade sobre throttle no estágio.
- Invalidar cache via `Cache-Control: max-age=0`: cliente precisa de IAM policy `execute-api:InvalidateCache`.

---

## Referências oficiais

- [API Gateway stages](https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-stages.html)
- [Custom domain names](https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-custom-domains.html)
- [API caching](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-caching.html)
