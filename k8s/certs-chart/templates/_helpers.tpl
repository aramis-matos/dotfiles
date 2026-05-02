{{/*
Expand the name of the chart.
*/}}
{{- define "certs-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "certs-chart.fullname" -}}
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

{{- define "certs-chart.fullname.lab" -}}
{{- include "certs-chart.fullname" . | printf "%v-lab" | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "certs-chart.fullname.cf" -}}
{{- include "certs-chart.fullname" . | printf "%v-cf" | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "certs-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "certs-chart.clusterIssuers.lab" -}}
{{ printf "%v-cluster-issuer" (include "certs-chart.fullname.lab" .) }}
{{- end }}

{{- define "certs-chart.clusterIssuers.cf" -}}
{{ printf "%v-cluster-issuer" (include "certs-chart.fullname.cf" .) }}
{{- end }}

{{- define "certs-chart.secretName.lab" -}}
{{ printf "%v-certificate" (include "certs-chart.fullname.lab" .) }}
{{- end }}

{{- define "certs-chart.namespaces" -}}
{{- .Values.namespaces | join "," -}}
{{- end }}

{{- define "certs-chart.privateKeyRef.cf" -}}
{{ printf "%v-private-key-ref" (include "certs-chart.fullname.cf" .) }}
{{- end }}

{{- define "certs-chart.secretName.cf" -}}
{{ printf "%v-api-token" (include "certs-chart.fullname.cf" .) }}
{{- end }}
