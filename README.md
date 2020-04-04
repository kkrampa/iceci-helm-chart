iceci
=====
A Helm chart for Kubernetes

Current chart version is `0.1.0`



## Chart Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | postgresql | 8.6.13 |

## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| api.enabled | bool | `true` |  |
| api.image.pullPolicy | string | `"IfNotPresent"` |  |
| api.image.repository | string | `"docker.io/iceci/iceci-api"` |  |
| api.ingress.annotations | object | `{}` |  |
| api.ingress.enabled | bool | `false` |  |
| api.ingress.hosts[0].host | string | `"charts.example"` |  |
| api.ingress.hosts[0].paths | list | `[]` |  |
| api.replicaCount | int | `1` |  |
| database.dbName | string | `"iceci"` |  |
| database.password | string | `"pass"` |  |
| database.port | int | `5432` |  |
| database.type | string | `"postgres"` |  |
| database.user | string | `"user"` |  |
| fullnameOverride | string | `""` |  |
| iceciOperator.enabled | bool | `true` |  |
| iceciOperator.image.pullPolicy | string | `"IfNotPresent"` |  |
| iceciOperator.image.repository | string | `"docker.io/iceci/iceci-operator"` |  |
| iceciOperator.persistence.dynamicVolume.annotations | object | `{}` |  |
| iceciOperator.persistence.dynamicVolume.hostPath | string | `"/iceci/dynamic-storage"` |  |
| iceciOperator.persistence.dynamicVolume.size | string | `"1Gi"` |  |
| iceciOperator.persistence.dynamicVolume.storageClass | string | `"-"` |  |
| iceciOperator.persistence.sharedVolume.annotations | object | `{}` |  |
| iceciOperator.persistence.sharedVolume.hostPath | string | `"/iceci/shared-storage"` |  |
| iceciOperator.persistence.sharedVolume.size | string | `"1Gi"` |  |
| iceciOperator.persistence.sharedVolume.storageClass | string | `"-"` |  |
| iceciOperator.replicaCount | int | `1` |  |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| postgresql.install | bool | `true` |  |
| postgresql.persistence.enabled | bool | `true` |  |
| postgresql.postgresqlDatabase | string | `"iceci"` |  |
| postgresql.postgresqlPassword | string | `"pass"` |  |
| postgresql.postgresqlUsername | string | `"user"` |  |
| rbac.create | bool | `true` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `nil` |  |
| sync.enabled | bool | `true` |  |
| sync.image.pullPolicy | string | `"IfNotPresent"` |  |
| sync.image.repository | string | `"docker.io/iceci/iceci-sync"` |  |
| sync.replicaCount | int | `1` |  |
| tolerations | list | `[]` |  |
| ui.enabled | bool | `true` |  |
| ui.image.pullPolicy | string | `"IfNotPresent"` |  |
| ui.image.repository | string | `"docker.io/iceci/iceci-ui"` |  |
| ui.ingress.annotations | object | `{}` |  |
| ui.ingress.enabled | bool | `false` |  |
| ui.ingress.hosts[0].host | string | `"charts.example"` |  |
| ui.ingress.hosts[0].paths | list | `[]` |  |
| ui.replicaCount | int | `1` |  |
