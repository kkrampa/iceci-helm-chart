{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "iceci.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "iceci.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 40 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 40 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 40 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "iceci.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "iceci.labels" -}}
helm.sh/chart: {{ include "iceci.chart" . }}
{{ include "iceci.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "iceci.selectorLabels" -}}
app.kubernetes.io/name: {{ include "iceci.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "iceci.ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "iceci.name" . }}-ui
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "iceci.api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "iceci.name" . }}-api
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "iceci.postgresql.selectorLabels" -}}
app.kubernetes.io/name: {{ include "iceci.name" . }}-postgresql
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "iceci.sync.selectorLabels" -}}
app.kubernetes.io/name: {{ include "iceci.name" . }}-sync
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "iceci.operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "iceci.name" . }}-operator
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "iceci.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "iceci.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{- define "iceci.stepFullname" -}}
{{- printf "%s-step" (include "iceci.fullname" .)  -}}
{{- end -}}

{{- define "iceci.stepServiceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "iceci.stepFullname" .) .Values.serviceAccount.stepName }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.stepName }}
{{- end -}}
{{- end -}}

{{- define "iceci.databaseEnvs" -}}
- name: ICECI_DB_USER
  value: {{ required ".Values.database.user" .Values.database.user }}
- name: ICECI_DB_HOST
{{- if .Values.database.host }}
  value: {{ .Values.database.host }}
{{- else }}
  value: {{ include "iceci.fullname" . }}-postgresql
{{- end }}
- name: ICECI_DB_NAME
  value: {{ required ".Values.database.dbName" .Values.database.dbName }}
- name: ICECI_DB_PASS
  value: {{ required ".Values.database.password" .Values.database.password }}
- name: ICECI_DB_PORT
  value: {{ required ".Values.database.port" .Values.database.port | quote }}
- name: ICECI_DB_DIALECT
  value: "postgres"
{{- end -}}

{{- define "iceci.dockerBuildEnvs" -}}
- name: STEP_SERVICE_ACCOUNT
  value: {{ include "iceci.stepServiceAccountName" . }}
- name: ICE_IMAGE_KANIKO
  value: "gcr.io/kaniko-project/executor:v0.16.0"
- name: ICE_IMAGE_BUILDKIT
  value: "moby/buildkit:v0.6.4-rootless"
- name: ICE_IMAGE_UTILS
  value: "iceci/utils-arm:2"
{{- end -}}
