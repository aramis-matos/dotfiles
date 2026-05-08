{{/*
Expand the name of the chart.
*/}}
{{- define "certs.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "certs.fullname" -}}
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

{{- define "certs.fullname.lab" -}}
{{- include "certs.fullname" . | printf "%v-lab" | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "certs.fullname.cf" -}}
{{- include "certs.fullname" . | printf "%v-cf" | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "certs.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "certs.clusterIssuers.lab" -}}
{{ printf "%v-cluster-issuer" (include "certs.fullname.lab" .) }}
{{- end }}

{{- define "certs.clusterIssuers.cf" -}}
{{ printf "%v-cluster-issuer" (include "certs.fullname.cf" .) }}
{{- end }}

{{- define "certs.secretName.lab" -}}
{{ printf "%v-certificate" (include "certs.fullname.lab" .) }}
{{- end }}

{{- define "certs.namespaces" -}}
{{- .Values.namespaces | join "," -}}
{{- end }}

{{- define "certs.privateKeyRef.cf" -}}
{{ printf "%v-private-key-ref" (include "certs.fullname.cf" .) }}
{{- end }}

{{- define "certs.secretName.cf" -}}
{{ printf "%v-api-token" (include "certs.fullname.cf" .) }}
{{- end }}
