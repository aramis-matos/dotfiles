{{/*
Expand the name of the chart.
*/}}
{{- define "dns-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "dns-chart.fullname" -}}
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

{{- define "dns-chart.bind9.fullname" -}}
{{- include "dns-chart.fullname" . | printf "%v-bind9"  | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{- define "dns-chart.pihole.fullname" -}}
{{- include "dns-chart.fullname" . | printf "%v-pihole"  | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{- define "dns-chart.pihole.service" -}}
{{- include "dns-chart.pihole.fullname" . | printf "%v-service" | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{- define "dns-chart.bind9.service" -}}
{{- include "dns-chart.bind9.fullname" . | printf "%v-service" | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{- define "dns-chart.pihole.service.frontend" -}}
{{- include "dns-chart.pihole.service" . | printf "%v-frontend" | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{- define "dns-chart.pihole.pvc" -}}
{{- include "dns-chart.bind9.fullname" . | printf "%v-pvc" | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "dns-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "dns-chart.labels" -}}
helm.sh/chart: {{ include "dns-chart.chart" . }}
{{ include "dns-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "dns-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "dns-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "dns-chart.bind9.selectorLabels" -}}
app: {{ .Values.bind9.selectorLabels.appName }}
{{ include "dns-chart.selectorLabels" . -}}
{{- end -}}

{{- define "dns-chart.pihole.selectorLabels" -}}
app: {{ .Values.pihole.selectorLabels.appName }}
{{ include "dns-chart.selectorLabels" . -}}
{{- end -}}

