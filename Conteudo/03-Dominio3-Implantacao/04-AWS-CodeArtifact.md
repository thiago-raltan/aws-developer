# AWS CodeArtifact

> Foco DVA-C02 – Domínio 3: Deployment

---

## O que é

Repositório de artefatos gerenciado para **pacotes de software** (npm, PyPI, Maven, Gradle, NuGet, etc.).

---

## Componentes

| Componente | Descrição |
|---|---|
| **Domain** | Contêiner lógico para repositórios; compartilha KMS key |
| **Repository** | Coleção de pacotes versionados |
| **Upstream** | Conecta a repositórios externos (npmjs, PyPI, Maven Central) |
| **Package** | Nome do pacote (ex: `requests`, `lodash`) |
| **Package version** | Versão específica do pacote |

---

## Fluxo de uso

```
[Dev] → npm install → [CodeArtifact Repo]
                           ↓ (cache miss)
                      [npmjs.com / upstream]
                           ↓
                      [Armazena no CodeArtifact]
```

- **Upstream caching**: CodeArtifact busca e armazena pacotes externos.
- Builds offline: após cache, não precisa de internet.

---

## Autenticação

```bash
# Obter token de autenticação (válido por 12h padrão)
aws codeartifact get-authorization-token   --domain meu-domain   --domain-owner 123456789012   --query authorizationToken --output text

# Configurar npm
aws codeartifact login --tool npm --repository meu-repo --domain meu-domain
```

- Token expira após 12h por padrão (max 12h).
- Para CI/CD: renovar token automaticamente no início do build.

---

## Integração com CodeBuild

```yaml
pre_build:
  commands:
    - aws codeartifact login --tool pip --repository meu-repo --domain meu-domain --domain-owner 123456789012
```

---

## Resource-based policy (cross-account)

```json
{
  "Statement": [{
    "Effect": "Allow",
    "Principal": {"AWS": "arn:aws:iam::OUTRA-CONTA:root"},
    "Action": ["codeartifact:ReadFromRepository"],
    "Resource": "*"
  }]
}
```

---

## Conceitos críticos para a prova ⚠️

- CodeArtifact = **repositório privado de pacotes** (não confundir com S3 para artefatos de build).
- Domain pode ter múltiplos repositórios; repositórios dentro do mesmo domain compartilham KMS key.
- Upstream repositories: CodeArtifact age como proxy para repositórios públicos.
- **Não** armazena código-fonte — apenas pacotes binários.

---

## Pegadinhas da prova 🎯

- Token de autenticação tem duração máxima de **12 horas** (não pode ser maior).
- S3 artefatos de CodePipeline ≠ CodeArtifact (são conceitos diferentes).
- Para compartilhar pacotes entre contas: use resource-based policy no domain/repositório.

---

## Referências oficiais

- [AWS CodeArtifact](https://docs.aws.amazon.com/codeartifact/latest/ug/welcome.html)
- [CodeArtifact getting started](https://docs.aws.amazon.com/codeartifact/latest/ug/getting-started.html)
- [CodeArtifact upstream](https://docs.aws.amazon.com/codeartifact/latest/ug/repos-upstream.html)
