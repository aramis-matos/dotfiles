{{/*
Expand the name of the chart.
*/}}
{{- define "vpn-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "vpn-chart.fullname" -}}
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
{{- define "vpn-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "vpn-chart.labels" -}}
helm.sh/chart: {{ include "vpn-chart.chart" . }}
{{ include "vpn-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "vpn-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vpn-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{- /* The context is a dict of the following shape: {"root": $, "name": str, "type": str} */ -}};
{{- define "vpn-chart.generic.fullname" -}}
{{- printf "%v-%v-%v" (include "vpn-chart.fullname" .root) .name .type  }}
{{- end }}

{{- /* The context is a dict of the following shape: {"root": $, "name": str} */ -}};
{{- define "vpn-chart.service" -}}
{{-  set . "type" "service"  | include "vpn-chart.generic.fullname"  }}
{{- end }}

{{- /* The context is a dict of the following shape: {"root": $, "name": str} */ -}};
{{- define "vpn-chart.deployment" -}}
{{-  set . "type" "deployment"  | include "vpn-chart.generic.fullname"  }}
{{- end }}

{{- /* The context is a dict of the following shape: {"root": $, "name": str} */ -}};
{{- define "vpn-chart.secret" -}}
{{-  set . "type" "secret"  | include "vpn-chart.generic.fullname"  }}
{{- end }}

{{- /* The context is a dict of the following shape: {"root": $, "name": str} */ -}};
{{- define "vpn-chart.pvc" -}}
{{-  set . "type" "pvc"  | include "vpn-chart.generic.fullname"  }}
{{- end }}

{{- /* The context is a dict of the following shape: {"root": $, "name": str} */ -}};
{{- define "vpn-chart.ingress" -}}
{{-  set . "type" "ingress"  | include "vpn-chart.generic.fullname"  }}
{{- end }}

{{- define "vpn-chart.load.env" -}}
{{- range $key, $_ := . }}
- name: "{{ $key }}"
  value: "{{ . }}"
{{- end }}
{{- end -}}

{{- define "vpn-chart.load.ports" -}}
{{- range $key, $_ := . }}
- name: "{{ $key }}"
  containerPort: {{ .port }}
  protocol: "{{ .protocol }}"
{{- end }}
{{- end -}}

{{- /* The context is a dict of the following shape: {"root": $, "name": str} */ -}};
{{- define "vpn-chart.load.volumeMounts" -}}
{{- $pattern := printf "^%v.*" .name -}}
{{- range $key, $_ := (.root.Values.volumes) }}
{{- if regexMatch $pattern $key }}
- name: "{{ $key }}"
  mountPath: "{{ .mountPath }}"
{{- end }}
{{- end }}
{{- end }}

{{- /* The context is a dict of the following shape: {"ports": $, "name": str} */ -}};
{{- define "vpn-chart.load.ports.service" -}}
{{- range $key, $_ := (get .root.Values .name).ports }}
{{- if regexMatch "^.+-frontend" $key }}
- name: "{{ $key }}"
  protocol: "{{ .protocol }}"
  port: {{ .port }}
  targetPort: {{ .port }}
{{- end -}}
{{- end }}
{{- end }}
