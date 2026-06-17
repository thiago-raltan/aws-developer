# AWS CloudTrail — Auditoria

> Foco DVA-C02 – Domínio 4: Troubleshooting and Optimization

---

## O que é

Serviço que registra **todas as chamadas de API** feitas na conta AWS (quem, o quê, quando, de onde).

---

## Tipos de eventos

| Tipo | O que registra | Custo |
|---|---|---|
| **Management Events** | Operações de controle (CreateBucket, CreateFunction, etc.) | Gratuito (1 cópia) |
| **Data Events** | Operações de dados (S3 GetObject, Lambda Invoke) | Pago |
| **Insights Events** | Detecta atividade incomum | Pago |

---

## Trail

- **Trail**: configuração que envia eventos para S3 (e opcionalmente CloudWatch Logs, EventBridge).
- Trail padrão (sem configuração): evento visível por **90 dias** no Event History.
- Trail configurado: **indefinido** no S3 (configurar lifecycle).

```bash
# Criar trail que registra tudo em todas as regiões
aws cloudtrail create-trail   --name meu-trail   --s3-bucket-name bucket-auditoria   --is-multi-region-trail   --enable-log-file-validation
```

---

## Log File Integrity Validation

- `--enable-log-file-validation`: cria hash SHA-256 de cada arquivo de log.
- Detecta se arquivos foram modificados, deletados ou forjados após entrega.

---

## Integração com EventBridge

```
[CloudTrail API Event] → [EventBridge] → [SNS Notificação]
                                       → [Lambda Remediação]
```

Exemplo: detectar criação de Security Group sem aprovação → Lambda remove automaticamente.

---

## Análise com Athena

- Logs no S3 → Athena para queries SQL.
- CloudTrail cria automaticamente tabela Athena se configurado.

```sql
SELECT userIdentity.arn, eventName, eventTime, sourceIPAddress
FROM cloudtrail_logs
WHERE eventName = 'DeleteBucket'
  AND eventTime > '2024-01-01'
ORDER BY eventTime DESC;
```

---

## Conceitos críticos para a prova ⚠️

- CloudTrail registra **chamadas de API** — não registra dados transmitidos (conteúdo de objetos S3, por exemplo).
- Data Events têm custo — habilite apenas para recursos críticos.
- `sourceIPAddress` identifica de onde veio a chamada.
- `userIdentity`: ARN do usuário/role que fez a chamada.
- `errorCode` + `errorMessage`: registrado em chamadas com falha.
- Logs **não são entregues em tempo real** — latência de ~15 minutos.

---

## Pegadinhas da prova 🎯

- Event History (sem trail): apenas **90 dias** de Management Events.
- CloudTrail **não registra** data plane events (S3 GetObject) sem configuração extra.
- Integridade de logs: `log-file-validation` detecta adulteração, mas não previne.
- CloudTrail + KMS: logs podem ser criptografados com CMK.

---

## Referências oficiais

- [AWS CloudTrail](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-user-guide.html)
- [CloudTrail event types](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/logging-management-events-with-cloudtrail.html)
- [Log file integrity](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-log-file-validation-intro.html)
