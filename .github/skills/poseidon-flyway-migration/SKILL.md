---
name: poseidon-flyway-migration
description: 'Use when: poseidon resolves a request to generate a SQL database schema migration using Flyway.'
user-invocable: false
---

# Flyway SQL Migration

## Purpose
- Generates idempotent SQL schema migrations following Flyway versioning standards.

## Output Contract
- db/migration/V<version>__<description>.sql

## Governance Rules
- File MUST follow the format V[Version]__[Description].sql.
- Destructive operations (DROP TABLE, DROP COLUMN) MUST include an explicit comment: -- WARNING: DESTRUCTIVE OPERATION.

## Assets
- ssets/poseidon-flyway.checklist.md
- ssets/poseidon-migration.sql.tpl.md
