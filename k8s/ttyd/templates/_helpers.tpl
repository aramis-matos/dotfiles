{{/*
Expand the name of the chart.
*/}}
{{- define "ttyd.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ttyd.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ttyd.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ttyd.labels" -}}
helm.sh/chart: {{ include "ttyd.chart" . }}
{{ include "ttyd.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ttyd.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ttyd.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
context is a dict of the following shape: {"root": $ "name": str}
*/}}
{{- define "ttyd.frontend" -}}
{{- printf "%s-%s-%s" .root.Chart.Name .name "frontend" | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
context is a dict of the following shape: {"root": $ "name": str}
*/}}
{{- define "ttyd.names.fullname" -}}
{{- printf "%s-%s" .root.Chart.Name .name | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
