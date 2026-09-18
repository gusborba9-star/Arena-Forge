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
**AUDIT / CONTRACT DEFINITION — NÃO IMPLEMENTADO.** A2 foi auditado após o fechamento do CI #154. A1, Expansion Scale, Forge War Foundation e Bootstrap permanecem VALIDATED. Nenhuma implementação/refactor de produção A2 foi executada.

Objetivo: eliminar lógica duplicada e garantir uma única autoridade de estado da batalha. A implementação permanece bloqueada até revisão/aprovação explícita do contrato abaixo.

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

## A2 — Auditoria arquitetural e contrato proposto — 2026-09-18

### Escopo auditado
A auditoria percorreu todos os scripts de produção Godot presentes em `game/scripts`, além de `main.tscn`, `project.godot` e os runners A1/Engine/Expansion Scale/Bootstrap relevantes. O inventário de produção inclui:

- `game/scripts/arena_forge_prototype.gd`
- Core: `match_runtime.gd`, `match_state.gd`, `arena_director.gd`, `telegraph.gd`, `arena_state.gd`, `arena_rules.gd`, `combat.gd`, `progression.gd`, `match_rewards.gd`, `hero.gd`, `enemy.gd`, `energy.gd`, `build_state.gd`, `upgrade_offer.gd`
- Cards: `card.gd`, `effect.gd`, `card_runtime.gd`, `card_effect_resolver.gd`, `deck.gd`, `cooldown_tracker.gd`
- Data: definições de hero/card/arena, catálogo/validação, synergy, mastery, progressão, rewards, competitive, live ops, season e fundações Forge/War.
- Input: `mobile_input.gd`
- Bootstrap: `game/scenes/main.tscn`, `game/project.godot`

### Descoberta principal
Existe hoje uma **duplicação estrutural real do estado/simulador de batalha**: `arena_forge_prototype.gd` instancia e muta diretamente `ArenaHero`, `EnergyPool`, `ArenaState`, `CombatSystem`, `MatchState`, `MatchProgression`, `ArenaDeck`, `CardRuntime`, `CardEffectResolver`, `ArenaDirector`, `Telegraph`, `BuildState`, inimigos, `pending_event`, timers, `kills` e `rewards`. Em paralelo, `MatchRuntime` possui suas próprias instâncias de `MatchState`, `ArenaState`, `ArenaDirector`, `Telegraph`, `CombatSystem`, `MatchProgression`, hero, inimigos, `pending_event`, `kills` e `rewards`.

O `main.tscn` instancia diretamente `arena_forge_prototype.gd`; o prototype **não instancia nem delega a simulação ao MatchRuntime**. Portanto, o MatchRuntime atual é uma autoridade isolada usada pelos contratos A1, enquanto o fluxo executado pelo prototype é outro simulador.

### Mapa de duplicações
| Responsabilidade | Autoridade atual no prototype | MatchRuntime | Duplicação | Destino A2 |
|---|---|---|---|---|
| lifecycle/tempo | `match_state` + `_process` | `state.tick` | SIM | Runtime |
| hero | `hero` | `hero` | SIM | Runtime |
| inimigos | `enemies` + movimento no prototype | `enemies` + tick no runtime | SIM | Runtime |
| arena state | `arena` + mutações no prototype/resolver | `arena` + `_resolve_event` | SIM | Runtime |
| eventos/pending | `director`, `telegraph`, `pending_event`, `_tick_event` | `request_event`, `telegraph`, `pending_event`, `_resolve_event` | SIM | Runtime |
| cataclysm | `director` + `_cataclysm_damage` | `director` + `_apply_cataclysm_pressure` | SIM | Runtime |
| combate | `combat` + `_auto_attack/_enemy_attack/_cataclysm_damage` | `combat` + `deal_damage` | SIM | Runtime |
| kills/XP | `kills`, `progression.add_xp` | `kills`, `progression.add_xp` | SIM | Runtime |
| result/rewards | `rewards` + cálculo no `_process` | `_finish` + `result` | SIM | Runtime |
| energia | `energy` | ausência no MatchRuntime | INCONSISTENTE | Runtime |
| deck/cartas | `deck/runtime/resolver` no prototype | ausência no MatchRuntime | INCONSISTENTE | Runtime via boundary de comando |
| upgrades/build | `build/upgrades/pending_upgrade` no prototype | ausência no MatchRuntime | INCONSISTENTE | Runtime |
| timers de ataque/inimigo/cataclysm | variáveis no prototype | ausência equivalente | INCONSISTENTE | Runtime/simulação |
| input | `MobileInput` + `_input` | nenhum | NÃO É DUPLICAÇÃO | Presentation/Input |

### Ownership proposto
| Estado/responsabilidade | Dono A2 | Mutação permitida |
|---|---|---|
| fase/elapsed | MatchRuntime → MatchState | Runtime |
| hero/inimigos | MatchRuntime | Runtime/serviços chamados pelo Runtime |
| arena tiles/hazards | MatchRuntime → ArenaState | Runtime |
| agenda/cataclysm/eventos | MatchRuntime → ArenaDirector/Telegraph | Runtime |
| combate | MatchRuntime → CombatSystem | Runtime |
| kills/XP/level | MatchRuntime → MatchProgression | Runtime |
| rewards/result | MatchRuntime → MatchRewards | Runtime |
| energia/deck/hand/cooldown | MatchRuntime → CardRuntime/ArenaDeck/EnergyPool | Runtime |
| build/upgrades | MatchRuntime → BuildState/UpgradeOffer | Runtime |
| input/touch | Presentation/Input | somente gerar comandos |
| renderização | Presentation | somente leitura do estado/runtime |
| conteúdo/definitions | Data layer | imutável durante a partida |

### Mutações observadas
- Prototype altera diretamente `match_state`, `energy`, `hero`, `arena`, `progression`, `deck`, `runtime`, `resolver`, `director`, `telegraph`, `build`, `enemies`, `pending_event`, `kills`, `rewards` e timers.
- `CardEffectResolver` recebe referências externas de hero/enemies/arena e muta esses objetos diretamente.
- `CombatSystem` muta `ArenaEnemy`/`ArenaHero` diretamente; no estado atual o prototype é quem transforma o retorno de morte em `kills++`/XP, enquanto o MatchRuntime encapsula essa consequência em `deal_damage`.
- `ArenaDirector` mantém estado de agenda/evento/cataclysm próprio; `MatchRuntime` também mantém `pending_event` e coordena a transição.
- `ArenaState`, `MatchState`, `Progression` e `MatchRewards` são componentes especializados corretos, mas não devem ser instanciados em paralelo por dois simuladores.

### Fluxos reais
**Prototype atual:** Input → `_input/_process` → mutações locais → MatchState/Energy/CardRuntime/Resolver/Director/Combat/Progression/ArenaState → desenho.

**Runtime atual (contrato A1):** caller → `MatchRuntime.request_event()`/`tick()`/`deal_damage()` → componentes internos → estado interno → `result()/finished`.

**Evento:** `request_event()` → `ArenaDirector.request_next_event()` → `MatchRuntime.pending_event` + `Telegraph` → `MatchRuntime.tick()` → `Telegraph.tick()` → `_resolve_event()` → `ArenaDirector.resolve_pending_event()` → `ArenaState.destroy_tile/add_hazard/set_tile` → clear pending + reset telegraph → `event_resolved`.

**Prototype mantém rota paralela:** `_tick_event()` chama diretamente `director.request_next_event()`, cria `Telegraph`, chama `director.resolve_pending_event()` e muta `ArenaState`.

**Combate:** prototype → `CombatSystem.resolve_hit/resolve_hero_hit` → entidades; Runtime → `deal_damage()` → `CombatSystem.resolve_hit` → entidade → kill/XP no Runtime.

**Cartas:** prototype → `CardRuntime.play(index, energy, resolver, context)` → `CardEffectResolver.resolve(card, context)` → mutações diretas em hero/enemies/arena ou comandos devolvidos no context → prototype aplica speed/spawn. O MatchRuntime atualmente não possui deck/energy/CardRuntime/resolver integrados.

### Contrato A2 proposto
**A2.1 Single Authority:** `MatchRuntime` é a única autoridade de estado e simulação da partida.

**A2.2 State Ownership:** todos os objetos de estado da partida são instâncias internas do MatchRuntime; componentes especializados permanecem sem autoridade externa concorrente.

**A2.3 Mutation Rules:** somente MatchRuntime e métodos especializados invocados por ele podem mutar o estado da partida. Presentation/Input não acessa mutações internas.

**A2.4 Command Boundary:** input traduz intenção em comandos explícitos (movimento, jogar carta, seleção de upgrade, etc.) consumidos pelo MatchRuntime.

**A2.5 Read Boundary:** presentation lê snapshots/estado exposto pelo MatchRuntime; não mantém cópias mutáveis de estado de batalha.

**A2.6 Card Boundary:** CardRuntime/Resolver tornam-se mecanismos de execução pertencentes ao MatchRuntime. O resolver não recebe um grafo arbitrário de objetos do presentation; recebe contexto/handles controlados pelo Runtime e retorna/solicita mutações através da autoridade do Runtime.

**A2.7 Event Boundary:** request, telegraph, warning, resolve e mutation passam por MatchRuntime. ArenaDirector/Telegraph são componentes especializados sem segunda fila de eventos concorrente no presentation.

**A2.8 Combat Boundary:** ataques, dano, armor, knockback, morte, kills e XP entram por comandos/serviços coordenados pelo MatchRuntime. Não haverá rota presentation → CombatSystem concorrente.

**A2.9 Result Boundary:** somente MatchRuntime finaliza RESULT, calcula/retém rewards e expõe o resultado final.

**A2.10 Determinism:** estado inicial + sequência ordenada de comandos + deltas de tempo definidos devem produzir o mesmo estado. Não introduzir relógios globais, aleatoriedade não controlada ou mutações externas.

### Inconsistências documentais
1. Roadmap usa nomes conceituais `MatchProgression` e `CombatSystem`; arquivos reais são `game/scripts/core/progression.gd` e `game/scripts/core/combat.gd`.
2. Roadmap descreve `MatchRuntime` como contrato determinístico já introduzido no A1, mas o bootstrap atual instancia diretamente `arena_forge_prototype.gd`, que contém o simulador paralelo. O contrato A1 existe e é validado isoladamente; a integração do produto ainda não ocorreu.
3. Roadmap lista energia, deck/cartas e upgrades como partes do core, mas MatchRuntime ainda não os possui; esses estados permanecem no prototype.
4. Roadmap chama a fase A2 de “única fonte de verdade”, coerente como objetivo futuro, mas não como estado atual. Esta auditoria corrige a leitura: A2 está em AUDIT / CONTRACT DEFINITION, não IMPLEMENTED.

### Plano de migração — não executado
1. preservar baseline A1;
2. estabelecer ownership e API de comandos/leitura;
3. migrar estado para MatchRuntime;
4. migrar mutações e integrar energia/deck/build;
5. transformar prototype em presentation/input;
6. integrar cards;
7. integrar eventos;
8. integrar combate;
9. integrar progressão/rewards;
10. remover duplicações e impedir acesso mutável paralelo;
11. adicionar contrato A2 e testes de anti-duplicação;
12. regressão A1 + Expansion Scale + Bootstrap;
13. CI completo.

### Critérios de aceitação A2
- uma única autoridade de estado da batalha;
- prototype sem estado paralelo de batalha;
- prototype sem segunda simulação;
- eventos passando pela autoridade única;
- combate passando pela autoridade única;
- progressão passando pela autoridade única;
- rewards passando pela autoridade única;
- cartas sem estado paralelo;
- A1 verde;
- Expansion Scale verde;
- Bootstrap verde;
- comportamento previamente validado preservado.

### Testes A2 propostos
- **Single-runtime integration:** bootstrap cria um único MatchRuntime como dono do estado.
- **Prototype no-simulation contract:** inspeção estrutural impede `MatchState.new`, `ArenaState.new`, `ArenaDirector.new`, `CombatSystem.new`, `CardRuntime.new`, `ArenaDeck.new`, `MatchProgression.new` e mutações de estado de batalha no presentation.
- **Command/read boundary:** comandos alteram o Runtime; presentation apenas lê resultados.
- **Event authority:** request → telegraph → resolve → mutation ocorre uma única vez e somente via Runtime.
- **Combat authority:** uma morte gera exatamente uma mutação de kill/XP pelo Runtime.
- **Card authority:** play/cooldown/energy/draw/effects não mantêm cópia paralela fora do Runtime.
- **Result authority:** RESULT/rewards são finalizados uma única vez.
- **Deterministic replay:** mesma configuração + comandos + deltas produz snapshots equivalentes.
- **Negative duplication guard:** fixture/branch de segundo simulador deve falhar o contrato.
- Reexecutar A1, Expansion Scale e Bootstrap após a migração.

### Riscos
- regressão do bootstrap ao retirar o motor do prototype;
- duplicação temporária durante a migração;
- mudança acidental da semântica de cartas;
- alteração de timing de eventos/cataclysm;
- mudança de ordem de kills/XP/rewards;
- exposição de estado mutável à UI;
- risco de tornar MatchRuntime excessivamente grande. Mitigação: manter componentes especializados (`ArenaState`, `ArenaDirector`, `CombatSystem`, etc.) como serviços/componentes do Runtime, sem criar framework adicional.

### Impacto sobre gates validados
- **A1:** baseline permanece VALIDATED; nenhuma alteração foi feita.
- **Expansion Scale:** permanece VALIDATED; nenhuma alteração foi feita.
- **Forge War Foundation:** permanece VALIDATED; nenhum código social foi alterado.
- **Bootstrap Smoke:** permanece VALIDATED pelo CI #154; deverá ser reexecutado após qualquer migração A2.
- **A2:** NÃO VALIDATED e NÃO IMPLEMENTED; somente AUDIT / CONTRACT DEFINITION.
- Nenhum sistema Hórus/Vercel/Supabase foi alterado.

### Estado desta etapa
**A2.1 VALIDATED — CI pós-implementação comprovado.**

### A2.1 — Runtime Instance / Ownership — 2026-09-18

#### Implementação
- game/scripts/arena_forge_prototype.gd agora cria exatamente uma instância executável de MatchRuntime.
- O Runtime é configurado com a definição da Arena 1 e os tempos de partida provenientes da configuração existente.
- O prototype passa a referenciar as instâncias oficiais de MatchState, ArenaHero, ArenaState, ArenaDirector, CombatSystem, MatchProgression e enemies pertencentes ao MatchRuntime.
- O comportamento legado de cartas, energia, upgrades, input e demais responsabilidades ainda não migradas permanece no prototype nesta etapa.
- Não houve alteração em MatchRuntime, RunnerExit, A1, watchdog, workflow, definições de arenas ou infraestrutura externa.

#### Testes
- game/tests/bootstrap_smoke_runner.gd foi adaptado para verificar existência do MatchRuntime no fluxo executável, configuração do Runtime, identidade compartilhada entre Runtime e referências do prototype, estado de Arena inicializado e exatamente uma ocorrência construtora de MatchRuntime.new() no prototype.
- A1 não foi alterado.
- Teste Godot local não foi executado nesta sessão; validação estática foi realizada.

#### Evidência
- Commit de implementação: 60db95b1d8fc4d5503a857aa5ba9e65a7b90e009.
- Commit de testes: 1215fae75c4605f6025c0a1500a511407c3f3134.
- Correção de ordem de configuração do hero: 39fe3ae4c6c4217fee1b0407649bbb58e3ea1ff9.
- SHA validado pelo CI pós-A2.1: `5f24deacd449c6ddf4b4df2f4871cd314530bef9`.
- CI: **#160** / Run ID `35406732677`.
- Resultado: **SUCCESS**.
- Jobs: `validate=SUCCESS`, `godot=SUCCESS`.
- Runner Exit Contract: `ARENA_FORGE_RUNNER_EXIT_PASS_OK`; `RUNNER_EXIT_CONTRACT pass_exit=0 expected=0 fail_exit=1 expected=1`.
- Engine: `ARENA_FORGE_ENGINE_CONTRACTS_OK`.
- Card Data: `ARENA_FORGE_CARD_DATA_OK cards=16`.
- Card Runtime: `ARENA_FORGE_CARD_RUNTIME_OK cards=16`.
- Card Guards: `ARENA_FORGE_CARD_GUARDS_OK invalid=2 cooldown=5`.
- Content Foundation: `ARENA_FORGE_CONTENT_FOUNDATION_OK cards=16 validated heroes=4 fixtures arenas=15 launch cards>=25 heroes>=8`.
- Expansion Scale: `ARENA_FORGE_CONTENT_EXPANSION_SCALE_OK card=26 hero=9 arena=16 war_arena=2 forge=2 forge_war=100`.
- Forge War Foundation: `ARENA_FORGE_FORGE_WAR_FOUNDATION_OK forge=contract war=contract arena=contract rulesets=contract season=contract analytics=9`.
- A1 Runtime: `ARENA_FORGE_A1_RUNTIME_OK lifecycle=4 phases events=2 cataclysm=progressive roles=5 combat=xp rewards=result`.
- Bootstrap Smoke: `ARENA_FORGE_BOOTSTRAP_SMOKE_OK main_scene=instantiated runtime=owned`.
- O job Godot terminou com SUCCESS; não houve `SCRIPT ERROR`, `A1 FAILURE`, `context canceled`, timeout do watchdog ou exit code inesperado nos runners. O `ERROR: ARENA_FORGE_RUNNER_EXIT_EXPECTED_FAILURE` pertence exclusivamente ao microteste negativo e foi corretamente capturado como `fail_exit=1`.
- Nenhuma alteração de produção, workflow, RunnerExit ou watchdog foi necessária para esta validação.

#### Estado formal
**A2.1: VALIDATED.**

A2 geral permanece **NÃO VALIDADO**. A2.2 está **IMPLEMENTED / VALIDATION PENDING**.

### A2.2 — Command Boundary — 2026-09-18

#### Objetivo
Estabelecer a primeira fronteira explícita e verificável entre Presentation/Input e o domínio de batalha:

**Presentation/Input → Command → MatchRuntime → State Mutation**

Esta etapa é deliberadamente parcial. O prototype ainda contém responsabilidades legadas de cartas, energia, upgrades, eventos, combate e progressão; essas migrações pertencem aos ciclos posteriores de A2.

#### Implementação
- Criado `game/scripts/core/match_command.gd` com representação explícita de comando e tipos `INVALID` e `MOVE`.
- `game/scripts/input/mobile_input.gd` passou a produzir `MatchCommand.move(...)` através de `get_move_command()`.
- `game/scripts/core/match_runtime.gd` passou a expor `submit_command(command, delta)` como fronteira de autoridade para movimento.
- O Runtime rejeita comando nulo, partida em RESULT, delta não positivo, tipo desconhecido e vetor de movimento fora do limite; somente comando aceito chama `hero.move()`.
- Clamp de posição do herói foi mantido dentro do MatchRuntime, removendo a mutação direta correspondente do prototype.
- `game/scripts/arena_forge_prototype.gd` passou a encaminhar o movimento ao Runtime; não cria uma segunda instância de MatchRuntime.
- Cartas, CardEffectResolver, energia, upgrades, eventos, combate, progressão, rewards e demais mutações legadas do prototype **não foram migrados nesta etapa**.

#### Contrato de teste
O `game/tests/bootstrap_smoke_runner.gd` agora verifica:
- Input gera um comando `MOVE`.
- Comando inválido é rejeitado.
- Comando rejeitado não altera a posição do Runtime.
- Comando válido é aceito e altera o estado pertencente ao Runtime.
- Comando com direção fora do limite é rejeitado sem mutação.
- Prototype submete movimento através de `MatchRuntime.submit_command()`.
- Prototype não chama `hero.move()` diretamente nem aplica diretamente o clamp de posição.
- O runner emite o marcador `ARENA_FORGE_A2_2_COMMAND_BOUNDARY_OK input=command runtime=authority invalid=rejected state=runtime-owned`.

#### Evidência estática
- HEAD implementado: `aa8838ce6771edf0608c2901e7f960779437eea5`.
- Diff contra o último Roadmap validado `84f275b3dc592fdcdd787a1e8cdff80b5ae34206`: somente os arquivos de comando, Runtime, input, prototype e bootstrap foram alterados.
- Nenhuma alteração em RunnerExit, watchdog, workflow CI, definições de arenas, A1, Hórus, Vercel ou Supabase.
- Godot local não está disponível nesta sessão; não foi alegado teste local.
- Nenhuma execução CI foi localizada para o HEAD `aa8838ce6771edf0608c2901e7f960779437eea5` até este registro.

#### Estado formal
**A2.2: IMPLEMENTED / VALIDATION PENDING.**

A2 geral permanece **NÃO VALIDADO**. A2.3 não foi iniciada.

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
