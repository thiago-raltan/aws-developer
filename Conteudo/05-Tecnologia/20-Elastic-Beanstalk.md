# AWS Elastic Beanstalk — Referência Rápida

> Ficha de referência para a prova DVA-C02

---

## Descrição

**O que é:** Plataforma como Serviço (PaaS) que provisiona e gerencia automaticamente a infraestrutura (EC2, Load Balancer, Auto Scaling, RDS, CloudWatch) para aplicações web. O desenvolvedor apenas faz deploy do código.

**Para que usamos:** Deploy simplificado de aplicações web (Node.js, Python, Java, .NET, Docker) sem gerenciar infraestrutura, com acesso às configurações subjacentes quando necessário — diferente de serviços totalmente opacos.

**Exemplo de prova:** Um desenvolvedor precisa instalar uma dependência de SO específica (ex: `ffmpeg`) e ajustar a configuração do Nginx durante cada deploy no Elastic Beanstalk. Como automatizar isso sem acessar manualmente as instâncias EC2?
→ Usar arquivos **`.ebextensions/`** incluídos no pacote de deploy (ZIP). Criar um arquivo `.config` em YAML com as seções `packages` (para instalar via yum/apt), `files` (para criar/modificar arquivos de configuração) e `container_commands` (para comandos executados após o deploy do código mas antes de iniciar o servidor).

---

## Tiers

| | Web Server | Worker |
|---|---|---|
| Entrada | HTTP (ALB) | SQS queue |
| Ideal | APIs, web apps | Processamento assíncrono |

---

## Políticas de deploy

| Política | Downtime | Rollback | Capacidade |
|---|---|---|---|
| All at Once | Possível | Manual | Reduzida durante deploy |
| Rolling | Não | Lento | Reduzida durante deploy |
| Rolling + batch | Não | Lento | Mantida (custo extra) |
| Immutable | Não | Imediato (terminar instâncias) | Dobrada temporariamente |
| Traffic splitting | Não | Imediato | Mantida |
| Blue/Green | Não | Imediato (Swap URLs) | Dobrada permanentemente |

---

## .ebextensions

Diretório `.ebextensions/` na raiz; arquivos YAML de configuração:
- `option_settings`: configurações do ambiente.
- `packages`: instalar pacotes do SO.
- `commands`: executar comandos durante deploy.
- `container_commands`: no contexto da aplicação (após extração).

---

## eb CLI

`eb init`, `eb create`, `eb deploy`, `eb status`, `eb logs`, `eb config`, `eb swap`, `eb terminate`.

---

## Considerações RDS

- RDS **dentro** do ambiente Beanstalk: deletar ambiente = deletar RDS.
- **Recomendado**: criar RDS separado e referenciar via variável de ambiente.

---

## Referências oficiais

- [Elastic Beanstalk](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/Welcome.html)
