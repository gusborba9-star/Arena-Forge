# Arena Forge — Roadmap Executivo

## Regra de execução
CRIAR → ADAPTAR → EXCLUIR LEGADO → TESTAR → VALIDAR → CORRIGIR → TESTAR NOVAMENTE → REGISTRAR EVIDÊNCIA → ATUALIZAR ROADMAP → AVANÇAR.

CI verde é obrigatório, mas não suficiente. Um item só pode ser considerado concluído quando houver implementação real, teste comportamental, validação e regressão compatível com o requisito.

## Estado de validação — 2026-09-16
- `16-card validated runtime scope` permanece preservado como baseline técnico.
- O **Launch Product Target** foi formalizado: 25+ cards, 8+ heroes, 15 arenas, coleção/progressão/mastery/Forge/rewards/eventos/competição/analytics/live ops preparados por contratos.
- A fundação social/competitiva foi formalmente incorporada: Forja + Guerra das Forjas + War Arena + War Rulesets + scoring/contribution/ranking/rewards + Season linkage.
- Novos runners foram adicionados para Content Foundation, Forge War Foundation, A1 Runtime, Expansion Scale e bootstrap smoke.
- **CI #129 / run `35052778615` falhou no job Godot no runner `content_foundation_contract_runner.gd`; Node ficou integralmente verde.** A1 e Expansion Scale não foram validados porque os runners posteriores foram corretamente bloqueados.
- A correção de `mastery_id` nos 16 cards foi aplicada antes do #129; o runner chegou a imprimir `ARENA_FORGE_CONTENT_FOUNDATION_OK`, mas o processo encerrou com exit code 1. O runner foi endurecido para registrar explicitamente o exit code e falhas futuras.
- Expansion Scale foi endurecido para validar pipeline comportamental de Card #26, construção/consumo de Hero #9, processamento de Arena #16 e referências sociais, além de procurar tokens de fixtures nos motores auditados.
- Auditoria independente de Vercel/Supabase Hórus foi registrada em `docs/audit/HORUS-INFRASTRUCTURE-MIGRATION-AUDIT.md`; nenhuma migração ou alteração de infraestrutura foi executada.
- A ordem de execução continua sendo determinada por dependências arquiteturais, não pela numeração dos Gates.

## Estados usados
- **VALIDATED** — implementação + teste comportamental + CI/regressão comprovados.
- **IMPLEMENTED** — implementação presente, evidência ainda incompleta.
- **PLANNED** — contrato/decisão registrada, implementação futura.
- **BLOCKED** — depende de outro estágio.
- **NOT STARTED** — não implementado.
- **ARCHITECTURE PREPARED** — contrato data-driven preparado e testado arquiteturalmente, mas sistema de produção ainda não implementado.

## Gate 0 — Fundação
- [x] Blueprint
- [x] Roadmap
- [x] Arquitetura de gameplay
- [x] Arquitetura técnica
- [x] Contratos data-driven
- [x] Matriz de migração Hórus → Arena Forge
- [x] Repositório independente criado
- [x] Runner GitHub-hosted comprovado funcional
- [ ] Conexão do repositório ao Vercel `velor-api` após validação
- [ ] Cutover de produção e validação Efí

**Estado:** IMPLEMENTED / ABERTO. Itens de infraestrutura externa continuam pendentes.

## Gate 1 — Core Combat
- [ ] Herói controlável — IMPLEMENTED, validação específica ainda pendente.
- [ ] Movimento teclado + abstração mobile — IMPLEMENTED, regressão específica ainda pendente.
- [ ] Auto-ataque — IMPLEMENTED, aquisição/alvo/dano ainda pendentes de contrato dedicado.
- [ ] HP/dano/morte/knockback — IMPLEMENTED, A1 agora cobre dano/morte/knockback; integração completa ainda precisa regressão do core.
- [ ] XP/level — IMPLEMENTED, A1 cobre XP por kill e reward XP; progressão completa ainda pendente.
- [ ] Energia compartilhada — VALIDATED isoladamente; integração completa com match ainda pendente.
- [ ] Papéis de inimigos — IMPLEMENTED; A1 adiciona comportamento verificável dos cinco roles, sujeito à validação CI.
- [x] Arena tile/state — VALIDATED.
- [x] Destruição e Abyss — VALIDATED.
- [ ] Telegraph — IMPLEMENTED; A1 agora testa temporalmente, sujeito à validação CI.
- [ ] Fases da partida — IMPLEMENTED; A1 agora cobre CONTROL → IGNITION → CATACLYSM → RESULT, sujeito à validação CI.

**Estado:** IMPLEMENTED / VALIDAÇÃO INCOMPLETA até a nova suíte A1 ficar verde no CI.

## Gate 2 — Cards & Builds
- [x] Schema de carta data-driven
- [x] Deck 8
- [x] Mão 4
- [x] Draw/play
- [x] Efeitos compostos
- [x] Custo de energia
- [x] Cooldown
- [x] Upgrades
- [x] 16 cartas iniciais
- [x] Validação funcional Godot das 16 cartas

**Estado:** VALIDATED no escopo `16-card validated runtime scope`. O target de lançamento é 25+ e será expandido por dados, sem reabrir o baseline validado.

## Gate 3 — Vertical Slice Arena 1
- [ ] Identidade Arena 1 — IMPLEMENTED + contrato A1, validação CI pendente.
- [ ] Eventos ambientais telegrafados — IMPLEMENTED + A1 request → telegraph → warning → resolve → mutation, validação CI pendente.
- [ ] Cataclysm progressivo — IMPLEMENTED + A1 prova raio start > intermediate > end e inside/outside, validação CI pendente.
- [ ] 5 papéis de inimigos — IMPLEMENTED + A1 prova comportamento distinto, validação CI pendente.
- [ ] Recompensas determinísticas — IMPLEMENTED + A1 integra MATCH → RESULT → rewards, validação CI pendente.
- [ ] Interações ambientais completas água/eletricidade/óleo/fogo/gelo/vento — NOT STARTED.
- [ ] UI de batalha de produção — BLOCKED até contrato de estado/eventos estabilizar.
- [ ] Balanceamento por telemetria — BLOCKED até analytics.

**Estado:** IMPLEMENTED / VALIDAÇÃO A1 PENDENTE.

## Launch Product Foundation
- [x] Separação documental `VALIDATED PROTOTYPE SCOPE` vs `LAUNCH PRODUCT TARGET`.
- [x] `16-card validated runtime scope` preservado como baseline.
- [x] HeroDefinition escalável.
- [x] CardDefinition escalável.
- [x] ArenaDefinition escalável.
- [x] CardSynergy genérica.
- [x] MasteryDefinition para card/hero/arena.
- [x] ForgeDefinition para especialização futura.
- [x] Progression/Trophy Road data-driven contract.
- [x] Reward/Forge Crate com escolha de N preparada.
- [x] Competitive Ruleset/Normalization preparado.
- [x] Event/Season/Rotation separados do evento ambiental da partida.
- [x] Analytics event schema versionado.
- [x] ContentCatalog preparado para crescimento de conteúdo.
- [x] ForgeGuildDefinition para Forjas sociais.
- [x] ForgeWar + estados + duração configurável.
- [x] WarArenaDefinition.
- [x] WarRulesetDefinitions.
- [x] WarScoringDefinitions.
- [x] WarContributionDefinitions.
- [x] WarRankingDefinition.
- [x] WarRewardsDefinitions.
- [x] SeasonDefinitions com referência a guerras.
- [x] Analytics social da Guerra das Forjas.
- [ ] Persistência/Inventory real.
- [ ] Economy/Entitlements reais.
- [ ] Matchmaking/Tournaments/Leaderboards/Replays.
- [ ] LiveOps real.

**Estado:** IMPLEMENTED / FOUNDATION ONLY + SOCIAL ARCHITECTURE PREPARED. Os sistemas superiores não foram implementados prematuramente.

## FORGE / SOCIAL
- [x] **ARCHITECTURE PREPARED** — `ForgeGuildDefinition`.
- [x] **ARCHITECTURE PREPARED** — membros, líder, officers, nível, troféus, temporada, estatísticas, regras, configuração e histórico.
- [ ] UI social.
- [ ] convites.
- [ ] busca.
- [ ] chat.
- [ ] persistência de produção.

**Estado:** ARCHITECTURE PREPARED.

## FORGE WAR
- [x] **ARCHITECTURE PREPARED** — `ForgeWarDefinitions`.
- [x] **ARCHITECTURE PREPARED** — `SCHEDULED → PREPARATION → ACTIVE → FINALIZING → COMPLETED`.
- [x] **ARCHITECTURE PREPARED** — 24h preparation + 48h active como configuração inicial.
- [x] **ARCHITECTURE PREPARED** — participação múltipla de Forjas.
- [x] **ARCHITECTURE PREPARED** — batalhas individuais e contribuição agregada.
- [ ] Guerra real.
- [ ] matchmaking real.
- [ ] notificações.

**Estado:** ARCHITECTURE PREPARED.

## WAR ARENA
- [x] **ARCHITECTURE PREPARED** — `WarArenaDefinition`.
- [x] **ARCHITECTURE PREPARED** — terrain, hazards, events, rules, modifiers e objectives.
- [ ] War Arena runtime.
- [ ] War Arena visual production.

**Estado:** ARCHITECTURE PREPARED.

## WAR RULESET
- [x] **ARCHITECTURE PREPARED** — normalização hero/card.
- [x] **ARCHITECTURE PREPARED** — deck/card/hero restrictions.
- [x] **ARCHITECTURE PREPARED** — arena modifiers e event frequency.
- [x] **ARCHITECTURE PREPARED** — War Energy/Battle Attempts.
- [x] **ARCHITECTURE PREPARED** — scoring/contribution/objectives/rewards.
- [ ] regras de guerra de produção.

**Estado:** ARCHITECTURE PREPARED.

## WAR FAIRNESS / INTEGRITY
- [x] **ARCHITECTURE PREPARED** — contribution limits.
- [x] **ARCHITECTURE PREPARED** — battle attempt limits.
- [x] **ARCHITECTURE PREPARED** — reward idempotency policy.
- [x] **ARCHITECTURE PREPARED** — deterministic ranking finalization.
- [ ] enforcement de produção.
- [ ] anti-exploit completo.

**Estado:** ARCHITECTURE PREPARED.

## Gate 4 — Meta
- [ ] Inventário persistente — NOT STARTED.
- [ ] Trophy Road — PLANNED / contrato preparado.
- [ ] Progressão de arenas — PLANNED / distribuição preparada.
- [ ] Matchmaking indireto — NOT STARTED.
- [ ] Economia — NOT STARTED.
- [ ] Pass — NOT STARTED.
- [ ] Ads recompensados — NOT STARTED.
- [ ] Cosméticos/emotes — PLANNED no contrato de rewards, implementação futura.

**Estado:** NOT STARTED COMO SISTEMA DE META.

## Gate 5 — Social/Competitive
- [ ] Forjas sociais — ARCHITECTURE PREPARED.
- [ ] Guerra das Forjas — ARCHITECTURE PREPARED.
- [ ] Ligas normalizadas — PLANNED / Ruleset preparado.
- [ ] Tournaments — PLANNED / contrato preparado.
- [ ] Replays/ghosts — NOT STARTED.
- [ ] Leaderboards — NOT STARTED.
- [ ] Anti-cheat híbrido — NOT STARTED.

**Estado:** ARCHITECTURE PREPARED / SISTEMAS SOCIAIS E COMPETITIVOS AUSENTES.

## Gate 6 — Escala
- [ ] 25+ cards de lançamento — PLANNED; baseline atual permanece 16.
- [ ] 15 arenas completas — PLANNED; 15 definições já formalizadas, runtime completo ainda não.
- [ ] eventos sazonais — PLANNED / contratos preparados.
- [ ] live ops — PLANNED / contratos preparados.
- [ ] analytics e remote balance — PLANNED / schema analítico preparado.

**Estado:** PLANNED / AUSENTE COMO SISTEMA DE PRODUÇÃO.

## A1 — Arena 1 Runtime Hardening + Battle-State Contract

### Implementação realizada
- `MatchRuntime` introduz um contrato determinístico de estado da partida.
- Lifecycle completo executável: CONTROL → IGNITION → CATACLYSM → RESULT.
- Event lifecycle executável: REQUEST → TELEGRAPH → WARNING ELAPSED → RESOLVE → STATE MUTATION.
- Cataclysm expõe raio progressivo e teste de entidade inside/outside.
- Os cinco enemy roles possuem comportamento verificável.
- Combat integra armor, damage, death, knockback e XP por kill.
- RESULT calcula rewards determinísticas.
- Bootstrap smoke runner carrega e instancia `main.tscn`.

### Testes adicionados
- `game/tests/a1_runtime_contract_runner.gd`
- `game/tests/content_foundation_contract_runner.gd`
- `game/tests/content_expansion_scale_contract_runner.gd`
- `game/tests/forge_war_foundation_contract_runner.gd`
- `game/tests/bootstrap_smoke_runner.gd`

### Evidência atual
- CI #129 / run `35052778615`: Node verde; Godot falhou em Content Foundation e bloqueou os runners posteriores.
- O runner de Expansion Scale não chegou a executar no #129.
- Após o #129 foram aplicados commits de hardening dos runners e auditoria Hórus; os respectivos commits ainda aguardam execução CI no momento deste registro.

### Critério de fechamento
A1 só será marcado VALIDATED depois de CI Godot 4.4.1 verde com todos os runners, incluindo os marcadores:
- `ARENA_FORGE_A1_RUNTIME_OK`
- `ARENA_FORGE_CONTENT_FOUNDATION_OK`
- `ARENA_FORGE_FORGE_WAR_FOUNDATION_OK`
- `ARENA_FORGE_BOOTSTRAP_SMOKE_OK`

## Expansion Scale Contract

### Critério
`NOVO CONTEÚDO = DADOS, NÃO NOVO CÓDIGO DE MOTOR.`

### Cobertura implementada
- Card #26 atravessa ContentCatalog → ArenaCard → ArenaDeck → CardRuntime → CardEffectResolver → efeito real, incluindo consumo de energia e avanço de draw index.
- Hero #9 atravessa `HeroDefinition.from_dict`.
- Arena #16 atravessa `ArenaDefinition.from_dict` e configuração/tick de `ArenaDirector`, incluindo cataclysm genérico.
- WarArena adicional, Forge adicional e ForgeWar adicional são registrados e referenciados por IDs.
- O runner inspeciona `CardRuntime`, `CardEffectResolver`, `CombatSystem`, `ArenaDirector`, `MatchRuntime`, `ArenaState` e `ForgeWarDefinitions` para impedir tokens de fixtures hardcoded.

**Estado:** IMPLEMENTED / VALIDATION PENDING. Não validado até CI executar e concluir verde.

## A2 — MatchRuntime como única fonte de verdade
**BLOCKED até A1 + Expansion Scale VALIDATED.**

Quando liberado, auditará e consolidará:
- `arena_forge_prototype.gd`;
- `MatchRuntime`;
- `MatchState`;
- `ArenaDirector`;
- `Telegraph`;
- `ArenaState`;
- `CombatSystem`;
- `MatchProgression`;
- `MatchRewards`.

Objetivo: eliminar lógica duplicada e garantir uma única autoridade de estado da batalha. Não executar A2 enquanto A1 ou Expansion Scale estiverem apenas IMPLEMENTED/VALIDATION PENDING.

## Ordem arquitetural por dependência

1. **A1 — Arena 1 Runtime Hardening + Battle-State Contract**
2. **Expansion Scale Contract — validação integral**
3. **A2 — MatchRuntime como única fonte de verdade**
4. **A3 — UI de batalha de produção**
5. **A4 — Persistence/Identity Contract**
6. **A5 — Inventory + Rewards persistentes**
7. **A6 — Trophy Road + Progressão de arenas**
8. **A7 — Economy + Entitlements**
9. **A8 — Matchmaking indireto**
10. **A9 — Social/Competitive runtime: Forjas, Guerra das Forjas, ligas, torneios e normalização completa**
11. **A10 — Analytics + Remote Balance**
12. **A11 — Live Ops: eventos, temporadas, rotações**
13. **A12 — Escala de conteúdo: 25+ → 40+ → 60+ → 100+ cards / 15+ arenas futuras**

## Auditoria Hórus

A árvore atual do Arena Forge não contém runtime Hórus e a auditoria anterior registrou zero referências textuais residuais. A auditoria externa de infraestrutura confirmou que `velor-api` permanece ligado ao repositório Hórus e que o Supabase `gusborba9-star-Horus-` permanece separado. Nenhuma conexão, deploy, rename ou migração foi executada.

Documento: `docs/audit/HORUS-INFRASTRUCTURE-MIGRATION-AUDIT.md`.

## Regra de avanço
Nenhum Gate avança por intenção. Cada item exige evidência técnica e funcional compatível com o requisito, registrada no roadmap.
