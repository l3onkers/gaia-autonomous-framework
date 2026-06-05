---
name: hades-chaos-mesh-experiment
description: 'Use when: hades resolves a request to generate a chaos engineering experiment using Chaos Mesh for Pod or Network failures.'
user-invocable: false
---

# Chaos Mesh Experiment Generator

## Purpose
- Scaffolds a Chaos Mesh CRD (PodChaos or NetworkChaos).
- Ensures experiments are bounded by strict duration and blast radius constraints.

## Output Contract
- k8s/chaos/experiment.yaml

## Governance Rules
- MUST NOT target the production, kube-system, or chaos-testing namespaces.
- Duration MUST NOT exceed 5 minutes.

## Assets
- ssets/hades-chaos.checklist.md
- ssets/hades-pod-chaos.yaml.tpl.md
"@ | Out-File -FilePath "d:\BONKERS\Documents\GitHub\IA-Agents\.github\skills\hades-chaos-mesh-experiment\SKILL.md" -Encoding UTF8 -Force

@"
# Chaos Mesh Checklist

- [ ] Target namespace is strictly defined and is NOT production or kube-system.
- [ ] Experiment duration is defined and <= 5 minutes.
- [ ] Label selectors are specific (e.g., pp: my-app) to limit blast radius.
