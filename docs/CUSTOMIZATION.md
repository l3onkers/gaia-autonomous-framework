# Customization Guide

> How to adapt the Copilot Governance Framework to your organization.

## Overview

This framework is designed to be **forked and customized**. Every reference to company names, package registries, UI components, and tech stack versions can be changed to match your organization.

---

## 1. Company Branding

### Namespaces and Prefixes

The framework uses generic placeholders that you should replace:

| Placeholder | Where it appears | Replace with |
|------------|-----------------|-------------|
| `Company.*` | .NET namespace references | Your company namespace (e.g., `Acme.*`) |
| `corp-*` | Angular component selectors | Your component prefix (e.g., `acme-*`) |
| `@corp/ui-components` | Angular package references | Your component library package name |
| `corporate` | Documentation references | Your company name |
| `example.com` | Email and URL placeholders | Your domain |

### Where to change

- `.github/agents/ng-build/ng-build.tpl.md` — Angular governance (prefixes, packages)
- `.github/agents/net-build/net-build.tpl.md` — .NET governance (namespaces, packages)
- `.github/skills/components-catalog/` — UI component definitions
- `.github/skills/global-styles/` — Design tokens and color palette

---

## 2. UI Component Library

### Current state

The proprietary component library has been removed and replaced with a stub. The framework references `@corp/ui-components` as a placeholder.

### Option A: Use a public library

Replace references to `@corp/ui-components` with:
- **Angular Material** — `@angular/material`
- **PrimeNG** — `primeng`
- **Any other Angular component library**

Update the component selectors in `components-catalog/` to match your chosen library.

### Option B: Build your own

1. Create your component library
2. Pack it as a tarball: `npm pack`
3. Place it in `.github/governance/modules/angular/`
4. Update references in `ng-build.tpl.md`

See `.github/governance/modules/angular/README.md` for detailed instructions.

---

## 3. Tech Stack Versions

### Angular

Edit `.github/agents/ng-build/ng-build.tpl.md`:
- Angular version pins (currently `~21.1.x`)
- Node.js version (currently `^22.12.0 || >=24.0.0`)
- TypeScript version
- Approved package list

### .NET

Edit `.github/agents/net-build/net-build.tpl.md` and profile-specific skills:
- .NET version (currently `8+`)
- NuGet package versions
- Architecture patterns

### Python

Edit `.github/agents/py-build/py-build.tpl.md` and layer skills:
- Python version (currently `3.12+`)
- Package versions (FastAPI, pytest, etc.)
- Virtual environment strategy

---

## 4. Package Registry

The framework references a generic "package registry" for private packages. To configure yours:

### npm (Angular)

1. Edit `.github/governance/modules/README.md`
2. Update registry URL in `ng-build.tpl.md`
3. Optionally configure `.npmrc` in your generated projects

### NuGet (.NET)

1. Update NuGet source references in `net-build.tpl.md`
2. Update package names in profile skill templates

### PyPI (Python)

1. Update pip index references in layer skill templates
2. Configure private index in `add-layer-py-environment` assets

---

## 5. Security Policies

### Content Exclusion

Edit `.github/copilot-content-exclusion.yaml` to define which files/directories should be excluded from Copilot context.

### Secret Scanning Patterns

Edit `.github/skills/commit-secret-scan/` to add or modify secret detection patterns specific to your organization.

---

## 6. CI/CD Integration

The framework uses generic CI/CD references. To integrate with your pipeline:

| CI/CD Platform | What to change |
|---------------|---------------|
| **GitHub Actions** | Add `.github/workflows/` with your pipeline definitions |
| **GitLab CI** | Replace CI config references with `.gitlab-ci.yml` |
| **Azure DevOps** | Update to `azure-pipelines.yml` references |
| **Jenkins** | Add `Jenkinsfile` references back |

Update the CI/CD skill templates:
- `.github/skills/add-layer-py-cicd/` — Python CI/CD
- `.github/skills/add-layer-net-cicd/` — .NET CI/CD

---

## 7. Adding New Technology Stacks

To add support for a new technology (e.g., Go, Rust, Java):

1. **Create a new agent:** Use `build` to create `{lang}-build.agent.md`
2. **Create profile skills:** Add `{lang}-setup-{profile}/SKILL.md` for each supported project type
3. **Add governance:** Update `ng-build.tpl.md` as a model for your new `{lang}-build.tpl.md`
4. **Register the agent:** Add the entry to `.github/AGENT.md`

See [Creating Agents](CREATING_AGENTS.md) and [Creating Skills](CREATING_SKILLS.md) for step-by-step guides.

---

## Quick Customization Checklist

- [ ] Replace `Company.*` namespaces with your company name
- [ ] Replace `corp-*` component prefixes with your prefix
- [ ] Replace `@corp/ui-components` with your component library
- [ ] Update `example.com` placeholders with your domain
- [ ] Configure your package registry
- [ ] Update tech stack version pins
- [ ] Set up your CI/CD platform
- [ ] Customize the design system skills
- [ ] Review and update security policies
- [ ] Update the README with your project details
