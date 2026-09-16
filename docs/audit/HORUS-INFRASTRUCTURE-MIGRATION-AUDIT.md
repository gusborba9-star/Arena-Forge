# Hórus Infrastructure Migration Audit

Date: 2026-09-16
Status: AUDIT ONLY — NO MIGRATION PERFORMED

## Scope

This audit evaluates the current Hórus-linked Vercel and Supabase infrastructure for possible future Arena Forge reuse. No production connection, deployment, rename, deletion, migration, or schema mutation was performed.

## Vercel

| COMPONENTE | ORIGEM | FUNÇÃO | REUTILIZAR/ADAPTAR/DESCARTAR | JUSTIFICATIVA | DEPENDÊNCIAS | AÇÃO FUTURA |
|---|---|---|---|---|---|---|
| Vercel project `velor-api` | Hórus | Next.js hosting/deployment | ADAPTAR | Existing project is operational infrastructure, but currently linked to `gusborba9-star/gusborba9-star-Horus-` | Hórus GitHub repo, existing env/config, deployment history | Keep unchanged until Arena Forge infrastructure cutover is separately planned and validated |
| Git integration | Hórus | GitHub deployment source | ADAPTAR | Current source is Hórus repository; Arena Forge is not the linked repository | Hórus repo, branch/deployment configuration | Reconfigure only during controlled cutover |
| Domains | Hórus | Project access/aliases | ADAPTAR | Existing `velor-api` domains belong to Hórus infrastructure | Vercel project | Do not rename or repoint now |
| Serverless/Next.js runtime | Hórus | API/web execution | ADAPTAR | Runtime pattern is reusable, application code is domain-specific | Next.js app, env vars, routes | Extract generic hosting/runtime configuration later |
| Environment variables | Hórus | AI, Supabase, Efí, application configuration | ADAPTAR | Names and values are Hórus-domain specific; secrets were not copied or migrated | Vercel environment configuration | Inventory names/semantics during controlled cutover; never copy secrets blindly |
| Deployment history | Hórus | Operational evidence | REUTILIZAR | Useful for understanding deployment behavior and rollback patterns | Existing project | Preserve as Hórus history |

Observed Vercel project: `velor-api`, Next.js, currently linked to `gusborba9-star/gusborba9-star-Horus-`. Latest inspected deployment metadata also references that Hórus repository. No Arena Forge deployment was created.

## Hórus environment contract observed in repository

The Hórus `.env.example` declares Gemini, OpenRouter, Supabase, Efí/Gerencianet and application URL variables. These are configuration contracts of Hórus and must not be treated as Arena Forge secrets or copied directly.

## Supabase

Audited project: `gusborba9-star-Horus-`
Region: `sa-east-1`
Status at audit time: `ACTIVE_HEALTHY`

| COMPONENTE | ORIGEM | FUNÇÃO | REUTILIZAR/ADAPTAR/DESCARTAR | JUSTIFICATIVA | DEPENDÊNCIAS | AÇÃO FUTURA |
|---|---|---|---|---|---|---|
| Auth/user identity pattern | Hórus | User identity and organization access | ADAPTAR | Generic identity/RLS concepts are reusable; tables and claims are Hórus-specific | `auth.users`, organizations, memberships | Design Arena Forge identity schema independently |
| RLS patterns | Hórus | Row-level authorization | REUTILIZAR | Authorization principles are generic | Supabase Auth | Reimplement against Arena Forge entities |
| Idempotency pattern | Hórus | Duplicate-operation protection | REUTILIZAR | Generic backend reliability pattern | Hórus tables/RPCs currently implement it | Port conceptually into Arena Forge contracts |
| Billing/entitlements | Hórus | AI credit/subscription economics | ADAPTAR | Ledger/idempotency concepts may be useful; domain and products are different | Hórus economic schema | Redesign for Arena Forge economy |
| Analytics/audit | Hórus | Execution and economic telemetry | ADAPTAR | Generic audit/event ideas are useful; event vocabulary is Hórus-specific | Hórus schemas/functions | Define Arena Forge event schema independently |
| Memory/Nexus | Hórus | Semantic memory and agent execution | DESCARTAR | No functional role in Arena Forge gameplay architecture | Hórus-specific tables/RPCs | Do not migrate |
| Hórus chat/collaborators | Hórus | Agent/team collaboration | DESCARTAR | Not part of Arena Forge product domain | Hórus tables/RPCs | Do not migrate |
| Efí payment contracts | Hórus | AI/studio payments | ADAPTAR | Provider integration mechanics may be generic; products and entitlement semantics are Hórus-specific | Efí credentials, checkout tables | Rebuild Arena Forge payment contracts later |
| Storage | Hórus | Artifact storage | ADAPTAR | Storage infrastructure may be reusable conceptually | Supabase storage policies/config | Audit buckets/policies during cutover |
| Edge Functions | Hórus | Supabase server-side functions | DESCARTAR/ADAPTAR | No Edge Functions were listed in the audited Hórus project; RPCs are the main database-side execution surface | PostgreSQL RPCs | Reassess only when Arena Forge backend needs them |

## Database evidence

The Hórus Supabase project contains extensive Hórus-specific tables, including `horus_*`, `nexus_*`, `personal_*`, `studio_*`, economic/credit tables, memory graph tables, and provider/model registries. Migrations are explicitly named around Hórus identity, financial, memory, Nexus, studio, personal runtime, enterprise state and execution economics.

Public routines include Hórus execution, credit, orchestrator, enterprise-state, memory, Nexus, studio-secret and personal-runtime functions. These are domain-specific and should not be migrated as-is.

The project has no deployed Supabase Edge Functions at audit time.

## Security finding requiring future remediation decision

Supabase reports a critical RLS advisory for two public tables with RLS disabled:

- `public.studio_execution_deployments`
- `public.studio_artifacts`

The advisory indicates these tables are exposed to anon/authenticated Supabase client roles unless separately protected. No remediation was applied because this audit is explicitly read-only and changing Hórus production was not authorized.

## Payments / Efí

The Hórus repository environment contract contains Efí/Gerencianet credentials and payment identifiers. The Hórus Supabase schema also contains studio payment fields and Efí status fields. These are classified as **ADAPTAR**, not direct reuse, because Arena Forge will require separate product, entitlement, transaction and reward semantics.

No Efí credentials were read, copied, rotated, or changed.

## Domain contamination assessment

Observed Hórus-specific infrastructure/domain surfaces include:

- Hórus-named tables and RPCs;
- Nexus execution/memory/billing infrastructure;
- personal assistant/runtime tables;
- studio project/execution/payment infrastructure;
- provider/model/economic execution registries;
- Hórus-specific webhook/audit contracts;
- Hórus-specific Efí payment contracts.

These are not Arena Forge runtime dependencies.

## Cutover rule

Future migration must follow:

`AUDITAR → EXTRAIR GENÉRICO → DEFINIR CONTRATO ARENA FORGE → MIGRAR REFERÊNCIAS → TESTAR → APAGAR LEGADO SOMENTE APÓS VALIDAÇÃO → TESTAR NOVAMENTE`

No cutover is authorized by this document.
