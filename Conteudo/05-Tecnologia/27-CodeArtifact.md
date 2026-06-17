# AWS CodeArtifact — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Repositório gerenciado de artefatos e pacotes de software compatível com npm, Maven, pip, NuGet, Gradle e Swift. Permite hospedar pacotes privados e configurar proxies para repositórios públicos (npmjs.com, PyPI, Maven Central) com cache automático.

**Para que usamos:** Hospedar pacotes internos privados da empresa, centralizar gerenciamento de dependências, fazer cache de repositórios públicos para builds mais rápidos e resilientes, auditoria e controle de versão de dependências aprovadas.

**Exemplo de prova:** Um pipeline CodeBuild precisa instalar dependências de um repositório npm privado hospedado no CodeArtifact. O build falha com erro 401 Unauthorized ao tentar `npm install`. O que está faltando no `buildspec.yml`?
→ Gerar um token de autorização temporário no `pre_build`: `aws codeartifact get-authorization-token --domain MEU_DOMAIN --query authorizationToken --output text`. Configurar o `.npmrc` com a URL do repositório e o token: `npm config set //MEU_DOMAIN.d.codeartifact.REGION.amazonaws.com/npm/MEU_REPO/:_authToken TOKEN`. O token expira em **12 horas** por padrão.

---

## Componentes

```
Domain
  └── Repository
        ├── Packages (npm, PyPI, Maven, NuGet, Swift, Generic)
        └── Upstream (npmjs.com, PyPI, Maven Central, etc.)
```

---

## Autenticação

```bash
# Token (12h máximo)
TOKEN=$(aws codeartifact get-authorization-token   --domain meu-domain --domain-owner ACCOUNT_ID   --query authorizationToken --output text)

# Login automatizado
aws codeartifact login --tool pip   --repository meu-repo   --domain meu-domain   --domain-owner ACCOUNT_ID
```

---

## Upstream repositories

- CodeArtifact busca em repositórios externos se não encontrar localmente.
- Armazena cópia local após primeiro download.
- Builds podem funcionar offline após cache.

---

## Cross-account

```json
{
  "Statement": [{
    "Effect": "Allow",
    "Principal": {"AWS": "arn:aws:iam::OUTRA_CONTA:root"},
    "Action": "codeartifact:ReadFromRepository",
    "Resource": "*"
  }]
}
```

---

## Integração CodeBuild

```yaml
pre_build:
  commands:
    - aws codeartifact login --tool pip --repository repo --domain domain
```

---

## Referências oficiais

- [AWS CodeArtifact](https://docs.aws.amazon.com/codeartifact/latest/ug/welcome.html)
