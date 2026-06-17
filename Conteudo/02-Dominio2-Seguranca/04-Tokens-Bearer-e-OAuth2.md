# Tokens Bearer e OAuth 2.0

> Foco DVA-C02 – Domínio 2: Security

---

## OAuth 2.0

Framework de autorização (não autenticação) que permite acesso delegado a recursos.

### Roles no OAuth 2.0
| Role | Descrição |
|---|---|
| **Resource Owner** | Usuário que possui os dados |
| **Client** | Aplicação que quer acesso |
| **Authorization Server** | Emite tokens (Cognito User Pool) |
| **Resource Server** | API que protege os recursos |

### Grant Types
| Grant Type | Uso |
|---|---|
| **Authorization Code** | Apps web/mobile; mais seguro |
| **Authorization Code + PKCE** | Apps públicas (SPA, mobile) |
| **Client Credentials** | Comunicação machine-to-machine |
| **Implicit** | Depreciado; não use |

---

## JWT (JSON Web Token)

```
eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJ1c2VyMTIzIn0.signature
     HEADER                    PAYLOAD           SIGNATURE
```

### Validação JWT
1. Verificar **assinatura** com chave pública do emissor.
2. Verificar `exp` (expiração).
3. Verificar `iss` (issuer) = URL do User Pool.
4. Verificar `aud` (audience) = App Client ID.

### Cognito JWT Claims importantes
| Claim | Descrição |
|---|---|
| `sub` | Subject — ID único do usuário |
| `iss` | Issuer — URL do User Pool |
| `aud` | Audience — App Client ID |
| `exp` | Expiration time (epoch) |
| `iat` | Issued at (epoch) |
| `cognito:groups` | Grupos do usuário |
| `token_use` | `id` ou `access` |

---

## Bearer Token no API Gateway

### Cognito Authorizer
- API Gateway valida JWT automaticamente.
- Não precisa de Lambda.
- Verifica assinatura, expiração e audience.

### Lambda Authorizer (Token-based)
```
[Cliente] → Authorization: Bearer <token> → [API Gateway]
                                               → [Lambda Authorizer]
                                                   → valida token
                                                   → retorna IAM Policy
                                               → [Backend]
```
- Cache da policy: TTL configurável (0–3.600 s).
- Tipos: **TOKEN** (header bearer) ou **REQUEST** (headers, query params, etc.).

---

## Conceitos críticos para a prova ⚠️

- **JWT não é criptografado** (apenas assinado) — não coloque dados sensíveis no payload.
- Access Token: para autorizar chamadas à API (escopos OAuth).
- ID Token: para identificar o usuário (atributos de perfil).
- PKCE protege contra interceptação do authorization code em apps públicas.

---

## Pegadinhas da prova 🎯

- Lambda Authorizer cache usa o token como chave — tokens iguais retornam a mesma policy em cache.
- `token_use: access` vs `token_use: id` — use o correto para cada propósito.
- Client Credentials grant = sem usuário envolvido (server-to-server).

---

## Referências oficiais

- [Amazon Cognito tokens](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-using-tokens-with-identity-providers.html)
- [API Gateway Lambda authorizers](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-use-lambda-authorizer.html)
- [JWT validation](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-using-tokens-verifying-a-jwt.html)
