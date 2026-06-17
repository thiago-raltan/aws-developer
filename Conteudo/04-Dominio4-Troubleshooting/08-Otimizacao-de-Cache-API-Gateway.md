# Otimização de Cache — API Gateway

> Foco DVA-C02 – Domínio 4: Troubleshooting and Optimization

---

## Cache no API Gateway

Armazena respostas do backend para requests idênticos.

### Configuração
- Habilitado por **Stage**.
- **TTL**: 0 a 3.600 s (padrão: 300 s).
- **Capacidade**: 0.5, 1.6, 6.1, 13.5, 28.4, 58.2, 118, ou 237 GB.
- **Custo**: cobrado por hora por GB de cache provisionado.

### Chave de cache (cache key)
Por padrão: método + path + query string parameters + headers selecionados.

```
GET /users?id=123 → chave do cache
GET /users?id=456 → chave diferente → cache miss
```

Customização da chave: adicionar headers, query params, path params.

---

## Invalidação de cache

### Por TTL
- Cache expira automaticamente após o TTL configurado.

### Por request (cliente)
```
GET /users?id=123
Cache-Control: max-age=0
```
- Requer permissão IAM: `execute-api:InvalidateCache`.
- Sem permissão: retorna 403 ou ignora o header (configurável).

### Via console/CLI
```bash
aws apigateway flush-stage-cache   --rest-api-id abc123   --stage-name prod
```

---

## Otimizações adicionais no API Gateway

### Throttling
- Limita requests para proteger o backend.
- Conta: 10.000 req/s burst, 5.000 req/s steady-state.
- Stage/método: configurável.
- Response: `429 Too Many Requests`.

### Compression
- Habilite compressão no stage (Accept-Encoding: gzip).
- Mínimo de bytes configurável para compressão.

### HTTP API vs. REST API
| | REST API | HTTP API |
|---|---|---|
| Cache | Sim | Não |
| Custo | Maior | ~71% mais barato |
| Features | Completas | Básicas |
| Latência | Maior | Menor |

---

## Integração com CloudFront

Para cache na borda (edge) com TTL controlado:
```
[Cliente] → [CloudFront] → [API Gateway] → [Lambda]
```
- Cache no CloudFront: para APIs públicas com alta leitura.
- `Cache-Control: max-age=300` controla TTL no CloudFront.
- Invalidação: `aws cloudfront create-invalidation`.

---

## Conceitos críticos para a prova ⚠️

- Cache do API Gateway: apenas para **REST API** (não HTTP API).
- Cache por stage — não por método individualmente (mas pode desabilitar por método).
- Para invalidar cache programaticamente: header `Cache-Control: max-age=0`.
- Custo do cache: mesmo sem requests, paga pela capacidade provisionada.

---

## Pegadinhas da prova 🎯

- Cache `TTL = 0` desabilita o cache efetivamente.
- Invalidação requer permissão IAM — configure no Cognito/Lambda Authorizer se necessário.
- HTTP API não tem cache nativo — use CloudFront ou ElastiCache no backend.
- API Gateway cache não é compartilhado entre stages.

---

## Referências oficiais

- [API Gateway caching](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-caching.html)
- [API Gateway throttling](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-request-throttling.html)
- [CloudFront with API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/cloudfront-behind-custom-domain-name.html)
