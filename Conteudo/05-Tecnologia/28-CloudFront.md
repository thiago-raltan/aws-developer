# Amazon CloudFront — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** CDN (Content Delivery Network) global da AWS com mais de 400 edge locations. Distribui conteúdo estático e dinâmico com baixa latência, integra com WAF para proteção, e permite executar lógica na borda com **Lambda@Edge** e **CloudFront Functions**.

**Para que usamos:** Acelerar entrega de assets estáticos (S3 + CloudFront), proteger origens com OAC (Origin Access Control), adicionar lógica na borda (autenticação, reescrita de URL, redirecionamento), cachear respostas de API para reduzir carga no backend.

**Exemplo de prova:** Uma API precisa validar tokens JWT em cada requisição antes de encaminhar ao API Gateway. A equipe quer fazer essa validação na borda para minimizar latência, mas sem o custo e overhead de Lambda@Edge. Qual a solução mais eficiente?
→ Usar **CloudFront Functions** (runtime JavaScript) no evento `viewer-request`. CloudFront Functions executam nas edge locations com latência <1ms, são até 10x mais baratas que Lambda@Edge e suportam manipulação de headers e validação de tokens simples. Lambda@Edge é necessária apenas para lógica que precisa de acesso ao corpo da requisição ou chamadas a serviços externos.

---

## O que é

CDN (Content Delivery Network) global da AWS com +400 pontos de presença.

---

## Origens

| Origem | Tipo |
|---|---|
| S3 bucket | Static content, SPA |
| ALB / EC2 | Dynamic content |
| API Gateway | REST/HTTP APIs |
| Custom HTTP server | Qualquer servidor HTTP |

---

## Cache

- **TTL**: controlado por `Cache-Control` e `Expires` headers da origem.
- **Invalidação**: `aws cloudfront create-invalidation --paths '/api/*'`
- **Cache key**: URL + (opcionalmente) headers, cookies, query strings.

---

## Signed URLs vs. Signed Cookies

| | Signed URL | Signed Cookie |
|---|---|---|
| Acesso a | 1 arquivo | Múltiplos arquivos |
| Ideal | Download único | Área restrita |

---

## Lambda@Edge e CloudFront Functions

| | Lambda@Edge | CloudFront Functions |
|---|---|---|
| Executa em | Regional edge | PoP (mais próximo) |
| Latência | Menor | Mínima |
| Runtimes | Node.js, Python | JavaScript |
| Uso | Req/Res complexo | Header manipulation simples |

---

## HTTPS

- Certificado ACM: **obrigatório em us-east-1** para CloudFront.
- Redirect HTTP → HTTPS: configurar no behavior.

---

## OAC (Origin Access Control)

- Restringe acesso ao bucket S3 apenas via CloudFront.
- Substitui OAI (legado).

---

## Referências oficiais

- [Amazon CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html)
