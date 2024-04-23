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

{{- define "ume.pod" -}}
serviceAccountName: {{ include "ume.serviceAccountName" . }}
{{- if .Values.global.affinity }}
affinity: {{- include "common.tplvalues.render" (dict "value" .Values.global.affinity "context" $) }}
{{- end }}
{{- if .Values.global.nodeSelector }}
nodeSelector: {{- include "common.tplvalues.render" (dict "value" .Values.global.nodeSelector "context" $) }}
{{- end }}
{{- if .Values.global.tolerations }}
tolerations: {{- include "common.tplvalues.render" (dict "value" .Values.global.tolerations "context" $) }}
{{- end }}
{{- if .Values.global.affinity }}
affinity: {{- include "common.tplvalues.render" (dict "value" .Values.global.affinity "context" $) }}
{{- end }}
{{- if .Values.global.dnsPolicy }}
dnsPolicy: {{ .Values.global.dnsPolicy }}
{{- end }}
{{- with .Values.global.dnsConfig }}
dnsConfig:
    {{ toYaml . | nindent 2 }}
{{- end }}
volumes:
    - name: config
      configMap:
        name: {{ .Values.config.existingMap | default (printf "%s-%s" (include "ume.fullname" .) .Values.config.mapName) }}
{{- if eq .Values.storage.kind "Filesystem" }}
    - name: data
      persistentVolumeClaim:
        claimName: {{ default (printf "%s-%s" (include "ume.fullname" .) .Values.storage.filesystem.claimName) .Values.storage.filesystem.existingClaim }}
{{- end }}
containers:
    - name: {{ include "ume.fullname" . }}
      image: {{ include "ume.image" . }}
      imagePullPolicy: {{ .Values.image.pullPolicy }}
      resources: {{ default (include "ume.defaultResourceLimits" .) .Values.global.resources | nindent 8 }}
      securityContext: {{ default (include "ume.defaultContainerSecurityContext" .) .Values.global.containerSecurityContext | nindent 8 }}
      volumeMounts:
        - name: config
          mountPath: /app/noel/ume/config/ume.hcl
          subPath: ume.hcl
        {{- if eq .Values.storage.kind "Filesystem" }}
        - name: data
          mountPath: /app/noel/ume/data
        {{- end }}
      ports:
        - name: http
          containerPort: {{ .Values.service.port }}
      env:
        - name: UME_UPLOADER_KEY
          valueFrom:
            secretKeyRef:
                name: {{ default (printf "%s-uploader-key" (include "ume.fullname" .)) .Values.config.uploaderKey.secret.existingSecret }}
                key: {{ default "uploader-key" .Values.config.uploaderKey.secret.key }}
      {{- if .Values.global.extraEnvVars }}
      {{ include "common.tplvalues.render" (dict "value" .Values.global.extraEnvVars "context" $) | nindent 8 }}
      {{- end }}
      {{- if .Values.deployment.startupProbe.enabled }}
      startupProbe:
        httpGet:
            path: /heartbeat
            port: {{ .Values.service.port }}
        initialDelaySeconds: {{ .Values.deployment.startupProbe.initialDelaySeconds }}
        timeoutSeconds: {{ .Values.deployment.startupProbe.timeoutSeconds }}
        periodSeconds: {{ .Values.deployment.startupProbe.periodSeconds }}
        successThreshold: {{ .Values.deployment.startupProbe.successThreshold }}
        failureThreshold: {{ .Values.deployment.startupProbe.failureThreshold }}
      {{- end }}
      {{- if .Values.deployment.readinessProbe.enabled }}
      readinessProbe:
        httpGet:
            path: /heartbeat
            port: {{ .Values.service.port }}
        initialDelaySeconds: {{ .Values.deployment.readinessProbe.initialDelaySeconds }}
        timeoutSeconds: {{ .Values.deployment.readinessProbe.timeoutSeconds }}
        periodSeconds: {{ .Values.deployment.readinessProbe.periodSeconds }}
        successThreshold: {{ .Values.deployment.readinessProbe.successThreshold }}
        failureThreshold: {{ .Values.deployment.readinessProbe.failureThreshold }}
      {{- end }}
      {{- if .Values.deployment.livenessProbe.enabled }}
      livenessProbe:
        httpGet:
            path: /heartbeat
            port: {{ .Values.service.port }}
        initialDelaySeconds: {{ .Values.deployment.livenessProbe.initialDelaySeconds }}
        timeoutSeconds: {{ .Values.deployment.livenessProbe.timeoutSeconds }}
        periodSeconds: {{ .Values.deployment.livenessProbe.periodSeconds }}
        successThreshold: {{ .Values.deployment.livenessProbe.successThreshold }}
        failureThreshold: {{ .Values.deployment.livenessProbe.failureThreshold }}
      {{- end }}
{{- end -}}
