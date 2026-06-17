# Amazon S3 — Operações e Ciclo de Vida

> Foco DVA-C02 – Domínio 1: Development with AWS Services

---

## Operações fundamentais

| Operação | SDK/CLI | Descrição |
|---|---|---|
| `PutObject` | `put_object` | Upload de objeto |
| `GetObject` | `get_object` | Download de objeto |
| `DeleteObject` | `delete_object` | Remove objeto |
| `ListObjectsV2` | `list_objects_v2` | Lista objetos do bucket |
| `CopyObject` | `copy_object` | Copia objeto dentro/entre buckets |
| `HeadObject` | `head_object` | Metadados sem baixar conteúdo |
| `CreateMultipartUpload` | — | Inicia upload multipart |

---

## Multipart Upload

- Recomendado para objetos > **100 MB**; obrigatório > **5 GB**.
- Máximo de objeto: **5 TB**.
- Partes: de 5 MB a 5 GB cada (última parte pode ser menor).
- Permite upload paralelo e retomada em caso de falha.

```python
# boto3 facilita com TransferConfig
import boto3
from boto3.s3.transfer import TransferConfig
config = TransferConfig(multipart_threshold=1024*25)  # 25 MB
s3.upload_file('arquivo.zip', 'meu-bucket', 'arquivo.zip', Config=config)
```

---

## Presigned URLs

- Gera URL temporária para acesso sem credenciais AWS.
- Operações: GET (download) e PUT (upload).
- `ExpiresIn`: até **7 dias** (604.800 s).
- Útil para: uploads diretos do browser, downloads privados temporários.

```python
url = s3.generate_presigned_url(
    'get_object',
    Params={'Bucket': 'meu-bucket', 'Key': 'arquivo.pdf'},
    ExpiresIn=3600
)
```

---

## Classes de armazenamento

| Classe | Retrieval | Durabilidade | Uso |
|---|---|---|---|
| **Standard** | Imediato | 99.999999999% | Acesso frequente |
| **Standard-IA** | Imediato | 99.999999999% | Acesso infrequente; mín. 30 dias |
| **One Zone-IA** | Imediato | 99.999999999% (1 AZ) | IA, reproduzível |
| **Intelligent-Tiering** | Imediato | 99.999999999% | Padrão desconhecido |
| **Glacier Instant** | Imediato | 99.999999999% | Arquivos, 1×/trimestre |
| **Glacier Flexible** | 1-12h | 99.999999999% | Arquivos raro acesso |
| **Glacier Deep Archive** | 12-48h | 99.999999999% | 7-10 anos |

---

## Lifecycle Policies

```xml
<Rule>
  <Transition>
    <Days>30</Days>
    <StorageClass>STANDARD_IA</StorageClass>
  </Transition>
  <Transition>
    <Days>90</Days>
    <StorageClass>GLACIER</StorageClass>
  </Transition>
  <Expiration>
    <Days>365</Days>
  </Expiration>
</Rule>
```

---

## S3 Object Lambda

- Intercepta `GetObject` e executa Lambda para transformar dados na entrega.
- Casos de uso: remover PII, redimensionar imagem, converter formato.
- Configure: S3 Access Point → Object Lambda Access Point → Lambda Function.

---

## Conceitos críticos para a prova ⚠️

- S3 **não é** um sistema de arquivos — é object storage (flat namespace).
- Versioning: após habilitar, **não pode ser desabilitado** (só suspenso).
- MFA Delete: requer MFA para deletar versões ou suspender versionamento.
- S3 Event Notifications → Lambda (assíncrono), SQS, SNS, EventBridge.
- **Cross-Region Replication (CRR)**: requer versionamento em ambos os buckets.

---

## Pegadinhas da prova 🎯

- Presigned URL usa credenciais de quem **gerou** a URL — se o role for deletado, URL invalida.
- Multipart upload incompleto gera custo — configure lifecycle para abortar após N dias.
- S3 Standard-IA e One Zone-IA têm **custo mínimo de armazenamento de 30 dias**.
- S3 **não bloqueia acesso público** por padrão em novas contas (Block Public Access pode ser habilitado).

---

## Referências oficiais

- [Amazon S3 User Guide](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html)
- [Multipart upload](https://docs.aws.amazon.com/AmazonS3/latest/userguide/mpuoverview.html)
- [Presigned URLs](https://docs.aws.amazon.com/AmazonS3/latest/userguide/ShareObjectPreSignedURL.html)
- [S3 Lifecycle](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lifecycle-mgmt.html)
- [S3 Object Lambda](https://docs.aws.amazon.com/AmazonS3/latest/userguide/transforming-objects.html)
