# Lambda — Configuração e Ciclo de Vida

> Foco DVA-C02 – Domínio 1: Development with AWS Services

---

## Ciclo de vida do execution environment

```
[Init phase]
  ├─ Extension init
  ├─ Runtime init
  └─ Function init (código fora do handler)
        ↓
[Invoke phase] ← handler() executa aqui
        ↓
[Shutdown phase] ← container é reciclado
```

- **Cold start**: Init phase + Invoke phase (container novo).
- **Warm start**: apenas Invoke phase (container reutilizado).
- Código fora do handler (conexões, variáveis globais) persiste entre warm invocations.

---

## Configurações importantes

| Parâmetro | Padrão | Limite | Impacto |
|---|---|---|---|
| **Memory** | 128 MB | 10.240 MB | CPU proporcional à memória |
| **Timeout** | 3 s | 900 s (15 min) | Tempo máximo de execução |
| **Ephemeral storage (/tmp)** | 512 MB | 10.240 MB | Armazenamento temporário |
| **Layers** | — | 5 por função | Dependências compartilhadas |
| **Environment variables** | — | 4 KB total | Configuração sem redeployar |

### Runtimes suportados
- Python 3.9/3.10/3.11/3.12, Node.js 18/20, Java 11/17/21, .NET 6/8, Ruby 3.2, Go (custom runtime).
- **Custom Runtime**: qualquer linguagem via `bootstrap` executável.

---

## Versions e Aliases

- **Version**: snapshot imutável da função (código + configuração). `$LATEST` = versão atual.
- **Alias**: ponteiro nomeado para uma version. Ex: `prod` → version 5.
- **Weighted Alias**: divide tráfego entre 2 versions (ex: 90% v5, 10% v6) — útil para canary.

```
MyFunction:prod (alias)
  ├─ 90% → version 5
  └─ 10% → version 6
```

---

## Layers

- Pacotes ZIP compartilhados entre funções (dependências, runtimes customizados, configuração).
- Máximo 5 layers por função; tamanho total descompactado ≤ 250 MB.
- Montados em `/opt/` no filesystem da função.

---

## Lambda Extensions

- Código que roda **junto** com a função (sidecar pattern).
- Casos de uso: agentes de monitoramento (Datadog, New Relic), envio de logs, secrets refresh.
- Duas categorias: **Internal** (mesmo processo) e **External** (processo separado).

---

## Conceitos críticos para a prova ⚠️

- **Aumentar memória** também aumenta CPU — solução para funções lentas por CPU.
- `/tmp` persiste entre warm invocations do mesmo container — **não é** limpo automaticamente.
- Variáveis de ambiente são cifradas em repouso com KMS (pode usar CMK).
- `$LATEST` não pode ser referenciado por weighted alias.
- Tamanho máximo do pacote de deploy: 50 MB (ZIP) / 250 MB descompactado / 10 GB (container image).

---

## Pegadinhas da prova 🎯

- Timeout padrão = **3 segundos** — muito curto para a maioria dos casos reais.
- Layer não inclui o código da função em si.
- Alias com weighted routing ≠ blue/green deployment completo.
- Execution role é o IAM role **da função** (não confundir com resource-based policy).

---

## Referências oficiais

- [Lambda execution environment](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtime-environment.html)
- [Lambda function versions](https://docs.aws.amazon.com/lambda/latest/dg/configuration-versions.html)
- [Lambda aliases](https://docs.aws.amazon.com/lambda/latest/dg/configuration-aliases.html)
- [Lambda layers](https://docs.aws.amazon.com/lambda/latest/dg/chapter-layers.html)
