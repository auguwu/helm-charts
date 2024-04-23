# 🐻‍❄️🏴‍☠️ `auguwu/ume`
[`noel/ume`](https://charts.noelware.org/~/noel/ume) is the official Helm chart for [`auguwu/ume`](https://github.com/auguwu/ume), Noel's image server.

## Requirements
* Kubernetes 1.26+
* Helm 3.12+

## Installation
```shell
$ helm repo add noel https://charts.noelware.org
$ helm install ume noel/ume
```

## Parameters

### Global Parameters

Contains any global parameters that will affected all objects in the `ume` Helm chart.

| Name                              | Description                                                                                                                                                                                              | Value           |
| --------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
| `global.replicas`                 | Amount of replicas to use                                                                                                                                                                                | `1`             |
| `global.resources`                | Resource list to apply to all containers.                                                                                                                                                                | `{}`            |
| `global.fullNameOverride`         | String to fully override the Helm installation name for all objects                                                                                                                                      | `""`            |
| `global.nameOverride`             | String to override the Helm installation name for all objects, will be in conjunction with a prefix of `<install-name>-`                                                                                 | `""`            |
| `global.clusterDomain`            | Domain host that maps to the cluster                                                                                                                                                                     | `cluster.local` |
| `global.nodeSelector`             | Selector labels to apply to contraint the pods to specific nodes. Read more in the [Kubernetes documentation](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector).    | `{}`            |
| `global.tolerations`              | List of all taints/tolerations to apply in conjunction with `global.affinity`. Read more in the [Kubernetes documentation](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration) | `[]`            |
| `global.affinity`                 | Map of all the affinity to apply to the spawned Pods. Read more in the [Kubernetes documentation](https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes-using-node-affinity/).      | `{}`            |
| `global.annotations`              | Map of annotations to append to on all objects that this Helm chart creates.                                                                                                                             | `{}`            |
| `global.extraEnvVars`             | List of extra environment variables to append to all init/sidecar containers and normal containers.                                                                                                      | `[]`            |
| `global.initContainers`           | List of init containers to create.                                                                                                                                                                       | `[]`            |
| `global.podSecurityContext`       | Security context for all spawned Pods. Read more in the [Kubernetes documentation](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/).                                          | `{}`            |
| `global.containerSecurityContext` | Security context for all init, sidecar, and normal containers. Read more in the [Kubernetes documentation](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/).                  | `{}`            |
| `global.dnsPolicy`                | DNS policy for the pod.                                                                                                                                                                                  | `""`            |
| `global.dnsConfig`                | Configures the [DNS configuration](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-dns-config) for the pod.                                                                 | `{}`            |
| `global.domain`                   | Domain to set so Ume can redirect users who use the service to that URL rather than the local address.                                                                                                   | `""`            |

### Docker Image Parameters

Parameters to modify the Docker image that is ran.

| Name                | Description                                                                                                                              | Value        |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- | ------------ |
| `image.pullPolicy`  | [Pull policy](https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy) when pulling the image.                          | `""`         |
| `image.registry`    | Registry URL to point to. For Docker Hub, use an empty string.                                                                           | `""`         |
| `image.image`       | Image name.                                                                                                                              | `auguwu/ume` |
| `image.tag`         | The tag of the image. Keep this as a empty string if you wish to use the default app's version.                                          | `""`         |
| `image.digest`      | Digest in the form of `<alg>:<hex>`, this will replace the `image.tag` property if this is not empty.                                    | `""`         |
| `image.pullSecrets` | Specify Docker Registry secrets, read more [here](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/) | `[]`         |

### Service Account Parameters

| Name                         | Description                                                                                | Value  |
| ---------------------------- | ------------------------------------------------------------------------------------------ | ------ |
| `serviceAccount.create`      | Whether or not if the service account should be created for this Helm installation.        | `true` |
| `serviceAccount.annotations` | Any additional annotations to append to this ServiceAccount                                | `{}`   |
| `serviceAccount.name`        | The name of the service account, this will be the Helm installation name if this is empty. | `""`   |

### Deployment Parameters

| Name                                            | Description                                                                                                                             | Value  |
| ----------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- | ------ |
| `deployment.strategy`                           | The [Deployment strategy](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy) when creating the deployment. | `{}`   |
| `deployment.startupProbe.enabled`               | whether or not to enable probing at startup.                                                                                            | `true` |
| `deployment.startupProbe.initialDelaySeconds`   | Delay in seconds on when to probe.                                                                                                      | `15`   |
| `deployment.startupProbe.timeoutSeconds`        | How long to wait for the probe to succeed.                                                                                              | `1`    |
| `deployment.startupProbe.periodSeconds`         | How often to perform probing (in seconds)                                                                                               | `10`   |
| `deployment.startupProbe.successThreshold`      | Minimum consecutive successes for the probe to considered successful.                                                                   | `1`    |
| `deployment.startupProbe.failureThreshold`      | Minimum consecutive failures for the probe to considered successful.                                                                    | `5`    |
| `deployment.readinessProbe.enabled`             | whether or not to enable the readiness probing                                                                                          | `true` |
| `deployment.readinessProbe.initialDelaySeconds` | Delay in seconds on when to probe.                                                                                                      | `15`   |
| `deployment.readinessProbe.timeoutSeconds`      | How long to wait for the probe to succeed.                                                                                              | `1`    |
| `deployment.readinessProbe.periodSeconds`       | How often to perform probing (in seconds)                                                                                               | `10`   |
| `deployment.readinessProbe.successThreshold`    | Minimum consecutive successes for the probe to considered successful.                                                                   | `1`    |
| `deployment.readinessProbe.failureThreshold`    | Minimum consecutive failures for the probe to considered successful.                                                                    | `5`    |
| `deployment.livenessProbe.enabled`              | whether or not to enable the liveness probing                                                                                           | `true` |
| `deployment.livenessProbe.initialDelaySeconds`  | Delay in seconds on when to probe.                                                                                                      | `15`   |
| `deployment.livenessProbe.timeoutSeconds`       | How long to wait for the probe to succeed.                                                                                              | `1`    |
| `deployment.livenessProbe.periodSeconds`        | How often to perform probing (in seconds)                                                                                               | `10`   |
| `deployment.livenessProbe.successThreshold`     | Minimum consecutive successes for the probe to considered successful.                                                                   | `1`    |
| `deployment.livenessProbe.failureThreshold`     | Minimum consecutive failures for the probe to considered successful.                                                                    | `5`    |

### Pod Disruption Budget

| Name                                 | Description                                                                                                                                             | Value   |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| `podDisruptionBudget.enabled`        | Enables the use of a `PodDisruptionBudget`. Read more in the [Kubernetes documentation](https://kubernetes.io/docs/concepts/workloads/pods/disruptions) | `false` |
| `podDisruptionBudget.minAvailable`   | Minimum number (or percentage) of pods that should be remained scheduled                                                                                | `1`     |
| `podDisruptionBudget.maxUnavailable` | Maximum number (or percentage) of pods that maybe made unavaliable.                                                                                     | `nil`   |

### Service Parameters

Parameters to configure a [Kubernetes service](https://kubernetes.io/docs/concepts/services-networking/service/) to allow external connections to your
Ume instance.

| Name                     | Description                                                                                                                                                        | Value       |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------- |
| `service.port`           | Port number to listen to.                                                                                                                                          | `3621`      |
| `service.clusterIP`      | IP to use for the cluster IP if `type` is `ClusterIP`.                                                                                                             | `""`        |
| `service.enabled`        | Whether or not if a Kubernetes service should be enabled.                                                                                                          | `true`      |
| `service.type`           | The [service type](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types) to use.                                     | `ClusterIP` |
| `service.selectorLabels` | Selector to apply this Kubernetes service to                                                                                                                       | `{}`        |
| `service.externalName`   | The external name if `service.type` == `"ExternalName"`                                                                                                            | `nil`       |
| `service.loadBalancer`   | Load balancer configuration if `service.type` == `"LoadBalanacer"`                                                                                                 | `{}`        |
| `service.nodePort`       | Node port to expose, refer to the [Kubernetes documentation](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport) for more information. | `""`        |

### Ingress

[Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress) configuration.

| Name                  | Description                                                                                                                     | Value                    |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| `ingress.className`   | Ingress class name to use.                                                                                                      | `""`                     |
| `ingress.enabled`     | Whether if Ingress record generation should be enabled or not.                                                                  | `false`                  |
| `ingress.pathType`    | Whatever [path type](https://kubernetes.io/docs/concepts/services-networking/ingress/#path-types) to use.                       | `ImplementationSpecific` |
| `ingress.path`        | Default path for the Ingress record.                                                                                            | `/`                      |
| `ingress.annotations` | Additional annotations for the Ingress record. To enable certificate autogeneration, place the `cert-manager` annotations here. | `{}`                     |
| `ingress.extraRules`  | Any extra rules to add to the Ingress record.                                                                                   | `[]`                     |
| `ingress.extraTLS`    | Any TLS records to include in the ingress record.                                                                               | `[]`                     |

### Configuration

| Name                                       | Description                                                           | Value                   |
| ------------------------------------------ | --------------------------------------------------------------------- | ----------------------- |
| `config.mapName`                           | Name of the `ConfigMap` to use.                                       | `config`                |
| `config.existingMap`                       | Name of an existing `ConfigMap` that exposes a `ume.hcl` block        | `""`                    |
| `config.uploaderKey.value`                 | Value of the uploader key, which by default, will be a random string. | `{{ randAlphaNum 32 }}` |
| `config.uploaderKey.secret.key`            | Key in the `data` block from the Secret to read from                  | `uploader-key`          |
| `config.uploaderKey.secret.existingSecret` | Name of an existing `Secret` to use instead                           | `""`                    |

### Data Storage

Describes how to configure Ume's data storage driver to store images in. Ume supports the local filesystem,
which can be configured as a [`PersistentVolumeClaim`](https://kubernetes.io/docs/concepts/storage/persistent-volumes), Amazon S3, Microsoft's Azure Blob Storage product,
and MongoDB GridFS.

Since Ume 4, we introduced the local filesystem, S3, and Azure as other ways to use Ume without requiring
a MongoDB server to hold images in since Ume v3 required it.

| Name                                          | Description                                                                                                                                                                                                      | Value                   |
| --------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------- |
| `storage.kind`                                | What storage driver is used, it can either be: `'Filesystem'`, `'S3'`, `'Azure'`, or `'Gridfs'`; other strings will result in an error.                                                                          | `Filesystem`            |
| `storage.filesystem.persisted`                | whether or not to use a [`PersistentVolumeClaim`](https://kubernetes.io/docs/concepts/storage/persistent-volumes) to hold data.                                                                                  | `true`                  |
| `storage.filesystem.existingClaim`            | An existing [`PersistentVolumeClaim`](https://kubernetes.io/docs/concepts/storage/persistent-volumes) that was created beforehand. If you use `helm upgrade` and this is not set, it'll not provision a new PVC. | `""`                    |
| `storage.filesystem.storageClass`             | The [`storageClass`](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#class-1) field when creating the PVC.                                                                                       | `""`                    |
| `storage.filesystem.claimName`                | Name suffix for the creation of the PVC. By default, this will be `<release>-data` (i.e, `ume-data`)                                                                                                             | `data`                  |
| `storage.filesystem.selector`                 | Label selector to further filter the PVC set, read in the [Kubernetes documentation](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#selector) for more information.                             | `{}`                    |
| `storage.filesystem.size`                     | The size of the PVC, in mose cases, this shouldn't be higher than 1GiB... unless you have many images.                                                                                                           | `1Gi`                   |
| `storage.filesystem.accessModes`              | List of [access modes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes)                                                                                                             | `["ReadWriteOnce"]`     |
| `storage.s3.secrets.existingSecret`           | Existing secret that contains the AWS keys to use.                                                                                                                                                               | `""`                    |
| `storage.s3.secrets.accessKeyId`              | Access key ID to authenticate with AWS                                                                                                                                                                           | `""`                    |
| `storage.s3.secrets.secretAccessKey`          | Secret access key to authenticate with AWS                                                                                                                                                                       | `""`                    |
| `storage.s3.secrets.accessKeyIdSecretKey`     | Name of the key to where the access key ID lives in (if `storage.s3.secrets.existingSecret` was set before)                                                                                                      | `aws-access-key-id`     |
| `storage.s3.secrets.secretAccessKeySecretKey` | Name of the key to where the secret access key lives in (if `storage.s3.secrets.existingSecret` was set before)                                                                                                  | `aws-secret-access-key` |
