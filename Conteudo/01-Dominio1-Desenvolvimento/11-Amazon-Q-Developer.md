# Amazon Q Developer

> Foco DVA-C02 – Domínio 1: Development with AWS Services

---

## O que é

Amazon Q Developer é um assistente de IA generativa para desenvolvedores, integrado ao VS Code, JetBrains IDEs e console AWS. Auxilia com:
- Geração e completação de código.
- Explicação e documentação de código existente.
- Identificação de vulnerabilidades de segurança.
- Transformação e modernização de código legado.
- Interação em linguagem natural com recursos AWS.

---

## Funcionalidades principais

| Funcionalidade | Descrição |
|---|---|
| **Code completion** | Sugestões inline enquanto você digita |
| **Chat** | Perguntas e respostas em linguagem natural sobre código e AWS |
| **Security scanning** | Detecta vulnerabilidades (OWASP Top 10, CWE) |
| **/transform** | Migra Java 8/11 → Java 17; atualizações de framework |
| **Feature development** | Gera implementações completas a partir de descrições |
| **/doc** | Gera documentação de código |
| **/review** | Revisão de qualidade de código |
| **/fix** | Sugere correções para problemas encontrados |

---

## Integração com AWS Console

- Responde perguntas sobre serviços AWS diretamente no console.
- Ajuda a diagnosticar erros em CloudWatch Logs, X-Ray traces.
- Sugere políticas IAM baseadas em descrição de necessidades.

---

## Conceitos críticos para a prova ⚠️

- Amazon Q Developer **não** executa código — apenas sugere/gera.
- Disponível em tier gratuito (individual) e Pro (empresarial com customização).
- Integra com **CodeWhisperer** (unificado no Q Developer).
- Security scanning usa análise estática — não precisa executar o código.
- `/transform` suporta: Java 8 → 17, .NET upgrades.

---

## Pegadinhas da prova 🎯

- Amazon Q Developer ≠ Amazon Q Business (Q Business é para RAG sobre dados corporativos).
- Não substitui testes unitários — é um auxiliar de produtividade.
- Sugestões de código devem ser revisadas — pode gerar código incorreto.

---

## Referências oficiais

- [Amazon Q Developer](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/what-is.html)
- [Amazon Q Developer features](https://aws.amazon.com/q/developer/features/)
