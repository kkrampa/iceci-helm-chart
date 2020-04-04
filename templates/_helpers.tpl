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
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
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

{{- define "iceci.api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "iceci.name" . }}-api
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

{{- define "iceci.databaseEnvs" -}}
- name: ICECI_DB_USER
  value: {{ .Values.database.user }}
- name: ICECI_DB_HOST
{{- if and .Values.postgresql.install (not .Values.database.host) }}
  value: {{ .Release.Name }}-postgresql
{{- else }}
  value: {{ required ".Values.database.host" .Values.database.host }}
{{- end }}
- name: ICECI_DB_NAME
  value: {{ .Values.database.dbName }}
- name: ICECI_DB_PASS
  value: {{ .Values.database.password }}
- name: ICECI_DB_PORT
  value: {{ .Values.database.port | quote }}
- name: ICECI_DB_DIALECT
  value: {{ .Values.database.type }}
{{- end -}}