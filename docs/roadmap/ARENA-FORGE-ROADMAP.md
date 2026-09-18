# Arena Forge — Roadmap Executivo

## Regra de execução
CRIAR → ADAPTAR → EXCLUIR LEGADO → TESTAR → VALIDAR → CORRIGIR → TESTAR NOVAMENTE → REGISTRAR EVIDÊNCIA → ATUALIZAR ROADMAP → AVANÇAR.

CI verde é obrigatório, mas não suficiente. Um item só pode ser considerado concluído quando houver implementação real, teste comportamental, validação e regressão compatível com o requisito.

## Estado de validação — 2026-09-18
- `16-card validated runtime scope` permanece preservado como baseline técnico.
- O **Launch Product Target** foi formalizado: 25+ cards, 8+ heroes, 15 arenas, coleção/progressão/mastery/Forge/rewards/eventos/competição/analytics/live ops preparados por contratos.
- A fundação social/competitiva foi formalmente incorporada: Forja + Guerra das Forjas + War Arena + War Rulesets + scoring/contribution/ranking/rewards + Season linkage.
- Novos runners foram adicionados para Content Foundation, Forge War Foundation, A1 Runtime, Expansion Scale e bootstrap smoke.
- **CI #129 / run `35052778615`** permanece como histórico de falha no job Godot; Node ficou integralmente verde. A1 e Expansion Scale ainda não eram válidos naquele ponto porque os runners posteriores foram bloqueados.
- A correção de `mastery_id` nos 16 cards foi aplicada antes do #129; o runner chegou a imprimir `ARENA_FORGE_CONTENT_FOUNDATION_OK`, mas o processo encerrou com exit code 1. O runner foi posteriormente endurecido para registrar explicitamente o exit code e falhas futuras.
- **CI #154 / run `35290216288`**, commit `573efaeb32535cc744dc4d113a192c8aacc6f6fc`, executou o workflow completo com jobs `godot` e `validate` concluídos com SUCCESS. O job Godot executou, em sequência, Runner Exit Contract, Engine, Card Data, Card Runtime, Card Guards, Content Foundation, Expansion Scale, Forge War Foundation, A1 Runtime e Bootstrap Smoke, todos com sucesso.
- O Run #154 comprovou os marcadores `ARENA_FORGE_RUNNER_EXIT_PASS_OK`, `RUNNER_EXIT_CONTRACT pass_exit=0 expected=0 fail_exit=1 expected=1`, `ARENA_FORGE_ENGINE_CONTRACTS_OK`, `ARENA_FORGE_CARD_DATA_OK cards=16`, `ARENA_FORGE_CARD_RUNTIME_OK cards=16`, `ARENA_FORGE_CARD_GUARDS_OK invalid=2 cooldown=5`, `ARENA_FORGE_CONTENT_FOUNDATION_OK cards=16 validated heroes=4 fixtures arenas=15 launch cards>=25 heroes>=8`, `ARENA_FORGE_CONTENT_EXPANSION_SCALE_OK card=26 hero=9 arena=16 war_arena=2 forge=2 forge_war=100`, `ARENA_FORGE_FORGE_WAR_FOUNDATION_OK forge=contract war=contract arena=contract rulesets=contract season=contract analytics=9`, `ARENA_FORGE_A1_RUNTIME_OK lifecycle=4 phases events=2 cataclysm=progressive roles=5 combat=xp rewards=result` e `ARENA_FORGE_BOOTSTRAP_SMOKE_OK main_scene=instantiated`.
- A1 foi validado após a correção do runner de fronteira temporal em `573efaeb32535cc744dc4d113a192c8aacc6f6fc`; a execução CI confirmou que o teste termina com sucesso sem `SCRIPT ERROR`, `A1 FAILURE`, `context canceled` ou timeout do watchdog.
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
- [x] Telegraph — IMPLEMENTED + validado temporalmente pelo A1 no CI #154.
- [x] Fases da partida — IMPLEMENTED + CONTROL → IGNITION → CATACLYSM → RESULT validados pelo A1 no CI #154.

**Estado:** IMPLEMENTED / VALIDAÇÃO INCOMPLETA. O contrato A1 agora está validado no CI, mas o Gate 1 como um todo ainda contém itens sem contrato/regressão específica completa.

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
- [x] Identidade Arena 1 — IMPLEMENTED + contrato A1, validado no CI #154.
- [x] Eventos ambientais telegrafados — IMPLEMENTED + A1 request → telegraph → warning → resolve → mutation, validado no CI #154.
- [x] Cataclysm progressivo — IMPLEMENTED + A1 prova raio start > intermediate > end e inside/outside, validado no CI #154.
- [x] 5 papéis de inimigos — IMPLEMENTED + A1 prova comportamento distinto, validado no CI #154.
- [x] Recompensas determinísticas — IMPLEMENTED + A1 integra MATCH → RESULT → rewards, validado no CI #154.
- [ ] Interações ambientais completas água/eletricidade/óleo/fogo/gelo/vento — NOT STARTED.
- [ ] UI de batalha de produção — BLOCKED até contrato de estado/eventos estabilizar.
- [ ] Balanceamento por telemetria — BLOCKED até analytics.

**Estado:** IMPLEMENTED / VALIDAÇÃO A1 CONCLUÍDA; vertical slice completo ainda não está fechado porque interações ambientais completas e UI de produção permanecem pendentes.

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

### Evidência de fechamento
- Commit: `573efaeb32535cc744dc4d113a192c8aacc6f6fc`.
- CI: **#154** / Run ID `35290216288`.
- Resultado: **SUCCESS**.
- Godot: job concluído com SUCCESS; Runner Exit Contract, Engine, Card Data, Card Runtime, Card Guards, Content Foundation, Expansion Scale, Forge War Foundation, A1 Runtime e Bootstrap Smoke executaram em sequência.
- A1: `ARENA_FORGE_A1_RUNTIME_OK lifecycle=4 phases events=2 cataclysm=progressive roles=5 combat=xp rewards=result`.
- Bootstrap: `ARENA_FORGE_BOOTSTRAP_SMOKE_OK main_scene=instantiated`.
- Não foram encontrados `SCRIPT ERROR`, `A1 FAILURE` ou `context canceled` no log Godot; nenhum runner excedeu o watchdog de 30s.

### Critério de fechamento
A1 exige CI Godot 4.4.1 verde com os contratos comportamentais correspondentes. Esse critério foi satisfeito no CI #154.

**Estado A1:** VALIDATED.

## Expansion Scale Contract

### Critério
`NOVO CONTEÚDO = DADOS, NÃO NOVO CÓDIGO DE MOTOR.`

### Cobertura implementada
- Card #26 atravessa ContentCatalog → ArenaCard → ArenaDeck → CardRuntime → CardEffectResolver → efeito real, incluindo consumo de energia e avanço de draw index.
- Hero #9 atravessa `HeroDefinition.from_dict`.
- Arena #16 atravessa `ArenaDefinition.from_dict` e configuração/tick de `ArenaDirector`, incluindo cataclysm genérico.
- WarArena adicional, Forge adicional e ForgeWar adicional são registrados e referenciados por IDs.
- O runner inspeciona `CardRuntime`, `CardEffectResolver`, `CombatSystem`, `ArenaDirector`, `MatchRuntime`, `ArenaState` e `ForgeWarDefinitions` para impedir tokens de fixtures hardcoded.

**Estado:** VALIDATED. CI #154 comprovou o pipeline de expansão com Card #26, Hero #9, Arena #16, War Arena adicional, Forge adicional e ForgeWar adicional; marcador `ARENA_FORGE_CONTENT_EXPANSION_SCALE_OK card=26 hero=9 arena=16 war_arena=2 forge=2 forge_war=100`.

## A2 — MatchRuntime como única fonte de verdade
**DESBLOQUEADO PARA REVISÃO.** A1 e Expansion Scale estão VALIDATED pelo CI #154. Nenhuma implementação de A2 é iniciada automaticamente por este registro.

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

Objetivo: eliminar lógica duplicada e garantir uma única autoridade de estado da batalha. A2 permanece somente liberado para revisão de escopo; sua implementação depende de revisão/aprovação explícita.

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

## Regra de sincronização do Roadmap
Toda criação, alteração estrutural, validação de contrato, correção, teste relevante e mudança de gate deve ser refletida neste Roadmap oficial. Nenhum gate é oficialmente encerrado sem atualização correspondente do Roadmap, e nenhuma nova fase deve ser iniciada sem que o Roadmap reflita corretamente o estado da fase anterior.

Para cada ciclo: consultar o Roadmap → confirmar gates anteriores → definir escopo → implementar após aprovação → testar → validar pelo CI quando aplicável → registrar evidências → atualizar o Roadmap → liberar o próximo gate.

Quando uma etapa falhar, registrar bloqueio, causa, correção e novo teste; só marcar VALIDATED após evidência real. Decisões de arquitetura devem registrar decisão, motivo, impacto/dependências e estado IMPLEMENTADA, PREPARADA, VALIDADA ou PLANEJADA.

## Regra de avanço
Nenhum Gate avança por intenção. Cada item exige evidência técnica e funcional compatível com o requisito, registrada no roadmap.
