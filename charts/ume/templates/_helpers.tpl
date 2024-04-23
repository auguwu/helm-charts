{{/*
# 🐻‍❄️🏴‍☠️ Noel's Helm Charts: Curated catalog of Noel's Helm charts.: Helm Charts for Noel's software and other software I use on a day to day basis
# Copyright (c) 2024 Noel Towa <cutie@floofy.dev>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "ume.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ume.fullname" -}}
{{- if .Values.fullNameOverride -}}
{{- .Values.fullNameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ume.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ume.labels" -}}
{{ include "ume.selectorLabels" . }}
k8s.noel.pink/managed-by: Helm
{{- end }}

{{- define "ume.selectorLabels" -}}
k8s.noel.pink/name: {{ include "ume.name" . }}
k8s.noel.pink/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ume.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ume.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Default annotations
*/}}
{{- define "ume.annotations" -}}
k8s.noel.pink/component: misc
k8s.noel.pink/product: ume
{{- if .Chart.AppVersion }}
k8s.noel.pink/version: {{ .Chart.AppVersion | quote }}
{{- end }}

{{- range $key, $val := .Values.global.annotations }}
    {{ $key }}: {{ $val | quote }}
{{- end }}
{{- end -}}

{{/*
Default Pod security context object
*/}}
{{- define "ume.defaultPodSecurityContext" -}}
fsGroup: 1001
seccompProfile:
  type: "RuntimeDefault"
{{- end -}}

{{/*
Default container security context object
*/}}
{{- define "ume.defaultContainerSecurityContext" -}}
runAsUser: 1001
runAsNonRoot: true
readOnlyRootFilesystem: false
allowPrivilegeEscalation: false
capabilities:
    drop: ["ALL"]
{{- end -}}

{{/*
Default resource limits
*/}}
{{- define "ume.defaultResourceLimits" -}}
limits:
    memory: 4Gi
    cpu: 1500m
requests:
    memory: 1Gi
    cpu: 500m
{{- end -}}

{{/*
Image definition for Ume
*/}}
{{- define "ume.image" -}}
{{/* define our variables */}}
{{- $registry := default "docker.io" .Values.image.registry -}}
{{- $repo := .Values.image.image -}}
{{- $tag := default .Chart.AppVersion .Values.image.tag -}}
{{- $sep := ":" -}}

{{- if .Values.image.digest }}
    {{- $tag := .Values.image.digest | toString -}}
    {{- $sep := "@" -}}
{{- end -}}

{{/* bring it all together */}}
{{- printf "%s/%s%s%s" $registry $repo $sep $tag -}}
{{- end -}}
