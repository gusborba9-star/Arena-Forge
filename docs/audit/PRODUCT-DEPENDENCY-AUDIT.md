# Arena Forge — Auditoria de Dependências do Produto

**Baseline auditado:** `f57fc16487f425cebe8f53c7c5812f22ea90de77` (main)
**Data:** 2026-09-15
**Escopo:** documentação, código, contratos, testes, workflow e migração Hórus.

## 1. Fonte de verdade

O Blueprint define o produto como survivor mobile com 1 herói, deck 8, mão 4, energia compartilhada, arena viva, 15 arenas planejadas, 16 cartas iniciais, conteúdo data-driven e Arena 1 como vertical slice. A qualidade exige implementação + teste + validação + regressão verde. fileciteturn1058file0

O protocolo operacional exige criar/adaptar, remover legado, testar, validar, corrigir, repetir, registrar evidência, atualizar roadmap e somente então avançar. CI verde é necessário, mas não suficiente. fileciteturn1059file0

## 2. Estado real dos Gates

| Gate | Estado após auditoria | Motivo |
|---|---|---|
| Gate 0 | **PARCIAL / ABERTO** | Fundação e CI existem, mas conexão ao `velor-api` e cutover/validação Efí continuam sem evidência de fechamento. |
| Gate 1 | **IMPLEMENTADO + VALIDAÇÃO INCOMPLETA** | O runtime existe e o CI passou, porém vários itens marcados como concluídos não possuem teste comportamental específico nem regressão suficiente. |
| Gate 2 | **IMPLEMENTADO + VALIDADO NO ESCOPO DO GATE** | Os runners Godot executam as 16 cartas e guards reais; a validação cobre data, runtime, energia, deck, efeitos e cooldown. Permanecem oportunidades de testes semânticos mais granulares, mas não alteram o escopo já validado do Gate 2. |
| Gate 3 | **PARCIAL** | Arena 1 possui runtime/configuração real, mas telegraph, cataclysm, identidade, papéis e recompensas não têm cobertura comportamental suficiente para sustentar todos os `[x]`. |
| Gate 4 | **NÃO INICIADO COMO SISTEMA DE META** | Existe apenas um schema persistente mínimo de perfil/deck e nenhuma implementação completa de inventário, Trophy Road, economia, matchmaking ou monetização. |
| Gate 5 | **AUSENTE** | Ligas, torneios, replay/ghost, leaderboard e anti-cheat não estão implementados. |
| Gate 6 | **AUSENTE** | Escala de conteúdo, live ops e analytics/remote balance ainda não existem como sistemas de produção. |

## 3. Auditoria dos itens marcados como concluídos

### Gate 0

| Item | Estado | Evidência |
|---|---|---|
| Blueprint | IMPLEMENTADO + VALIDADO | Documento versionado. |
| Roadmap | IMPLEMENTADO + VALIDADO | Documento versionado e atualizado por evidência. |
| Arquitetura gameplay/técnica | IMPLEMENTADO + VALIDADO DOCUMENTALMENTE | Documentos definem Hero → MatchState → ArenaState/ArenaDirector → Combat/Progression → CardRuntime → CardEffectResolver e a separação Godot/API/Supabase/Vercel. fileciteturn1062file0 fileciteturn1063file0 |
| Contratos data-driven | IMPLEMENTADO + VALIDADO NO ESCOPO DOS CONTRATOS | Card/Arena/Hero são contratos de dados; conteúdo atual é carregado por definições. fileciteturn1061file0 |
| Matriz Hórus → Arena Forge | IMPLEMENTADO + VALIDADO DOCUMENTALMENTE | Reuso/adaptação/descarte explicitados. fileciteturn1065file0 |
| Repositório independente | IMPLEMENTADO + VALIDADO | Estrutura atual não contém runtime Hórus. |
| Runner GitHub-hosted | IMPLEMENTADO + VALIDADO | Runs anteriores de CI comprovaram execução real. |
| Vercel `velor-api` | NÃO VALIDADO | Continua pendente no roadmap. |
| Efí/cutover | NÃO VALIDADO | Continua pendente no roadmap. |

### Gate 1

| Item | Estado | Evidência |
|---|---|---|
| Herói controlável | IMPLEMENTADO + NÃO VALIDADO ESPECIFICAMENTE | `arena_forge_prototype.gd` integra input e movimento, mas não há runner dedicado de controle. fileciteturn1067file0 |
| Movimento teclado + mobile | IMPLEMENTADO + NÃO VALIDADO ESPECIFICAMENTE | `MobileInput` existe e o prototype integra teclado/touch. fileciteturn1111file0 fileciteturn1067file0 |
| Auto-ataque | IMPLEMENTADO + NÃO VALIDADO ESPECIFICAMENTE | Integração existe no loop do prototype; não há assert de aquisição/alvo/dano no runner. fileciteturn1067file0 |
| HP/dano/morte/knockback | PARCIAL | Dano/morte/knockback existem em Hero/Enemy/Combat; cobertura atual não valida todos os caminhos. fileciteturn1099file0 fileciteturn1073file0 fileciteturn1079file0 |
| XP/level | IMPLEMENTADO + NÃO VALIDADO ESPECIFICAMENTE | Progression existe e é usado pelo prototype, mas `engine_contract_runner` não verifica subida de nível. fileciteturn1083file0 |
| Energia compartilhada | IMPLEMENTADO + PARCIALMENTE VALIDADO | EnergyPool tem testes reais; integração compartilhada com todos os sistemas não é coberta como contrato. fileciteturn1102file0 |
| Papéis de inimigos | IMPLEMENTADO + NÃO VALIDADO ESPECIFICAMENTE | Cinco papéis existem e são usados na criação da wave, sem runner dedicado. fileciteturn1073file0 fileciteturn1067file0 |
| Arena tile/state | IMPLEMENTADO + VALIDADO | Runner testa hazards e transição de tiles. fileciteturn1070file0 |
| Destruição/Abyss | IMPLEMENTADO + VALIDADO | Runner testa NORMAL → CRACKED → COLLAPSED → ABYSS. fileciteturn1072file0 |
| Telegraph | IMPLEMENTADO + NÃO VALIDADO ESPECIFICAMENTE | Runtime usa Telegraph e warning de 1.5s/1.8s; teste Node atual apenas compara constantes e não executa o comportamento. fileciteturn1067file0 fileciteturn1074file0 fileciteturn1076file0 |
| Fases da partida | PARCIALMENTE VALIDADO | MatchState implementa as quatro fases, mas o runner verifica diretamente apenas CATACLYSM e RESULT. fileciteturn1078file0 |

**Conclusão:** o `[x]` agregado do Gate 1 é prematuro sob o critério atual de qualidade. Deve permanecer aberto até existir uma suíte comportamental que valide o core de partida e sua integração.

### Gate 2

| Item | Estado | Evidência |
|---|---|---|
| Schema data-driven | IMPLEMENTADO + VALIDADO | `ArenaCard` constrói efeitos a partir da definição. fileciteturn1097file0 |
| Deck 8 / mão 4 / draw-play | IMPLEMENTADO + VALIDADO | `ArenaDeck` e runner Godot verificam os estados. fileciteturn1088file0 fileciteturn1093file0 |
| Runtime/energia/cooldown | IMPLEMENTADO + VALIDADO | `CardRuntime` verifica energia/cooldown, resolve, consome e gira deck. fileciteturn1086file0 |
| 16 cartas | IMPLEMENTADO + VALIDADO | Definições e runners cobrem 16 IDs. fileciteturn1082file0 fileciteturn1093file0 |
| Efeitos | IMPLEMENTADO + VALIDADO NO CONTRATO EXISTENTE | Resolver executa damage/heal/push/speed/tile/destroy/spawn/slow; runner exercita as categorias presentes nas cartas. fileciteturn1087file0 fileciteturn1075file0 |
| Guards | IMPLEMENTADO + VALIDADO | Índice inválido, energia insuficiente e cooldown de Blink são executados. fileciteturn1094file0 |
| Upgrades | IMPLEMENTADO + VALIDADO | BuildState e UpgradeOffer existem e o engine runner aplica upgrade ao herói. fileciteturn1089file0 fileciteturn1108file0 |

### Gate 3

| Item marcado `[x]` | Estado real | Motivo |
|---|---|---|
| Identidade Arena 1 | **PARCIAL** | `ArenaRuntimeDefinitions.arena_1()` existe e é carregado pelo prototype, mas a identidade ainda é essencialmente configuração mínima; não há teste de aceitação específico da Arena 1. fileciteturn1069file0 |
| Eventos ambientais telegrafados | **PARCIAL** | Há dois eventos (`fire_patch`, `ground_break`) com warning e o prototype usa Telegraph antes de resolver. Não há runner que prove a sequência warning → resolução → mutação do estado. fileciteturn1069file0 fileciteturn1067file0 |
| Cataclysm progressivo | **PARCIAL** | `ArenaDirector` interpola raio e o prototype aplica dano fora do raio, mas não há assert da progressão do raio nem integração temporal completa. fileciteturn1109file0 fileciteturn1067file0 |
| 5 papéis de inimigos | **PARCIAL** | Os cinco papéis existem e são instanciados na wave inicial, mas falta contrato que valide cada papel e seu comportamento distinto. fileciteturn1073file0 fileciteturn1067file0 |
| Recompensas determinísticas | **IMPLEMENTADO + NÃO VALIDADO** | `MatchRewards.calculate` é determinístico, mas não há runner que valide entradas/saídas e integração com RESULT. fileciteturn1110file0 |

Os três itens ainda abertos do Gate 3 continuam corretamente abertos: interações ambientais completas não estão implementadas no runtime; UI de batalha de produção não existe; balanceamento por telemetria não existe.

## 4. Grafo de dependências

| Componente | Depende de | É dependência de | Estado | Teste | Gate |
|---|---|---|---|---|---|
| Game bootstrap | project.godot, main.tscn, prototype | integração de todos os sistemas locais | **PARCIAL** | CI executa cena/contratos, não smoke de gameplay completo | 1/3 |
| MatchState | configuração de partida | Cataclysm, RESULT, rewards, UI | **IMPLEMENTADO + PARCIALMENTE VALIDADO** | engine runner | 1 |
| ArenaState | geometria/tile model | cards, eventos, cataclysm, UI | **IMPLEMENTADO + VALIDADO BÁSICO** | engine runner | 1/3 |
| ArenaRules | elementos | interações ambientais/cards | **IMPLEMENTADO + VALIDADO ISOLADAMENTE** | engine runner cobre water/electricity | 3 |
| ArenaHero | HeroDefinitions | combat, cards, upgrades, UI, persistência de build | **IMPLEMENTADO + PARCIALMENTE VALIDADO** | engine runner/indireto | 1/2 |
| ArenaEnemy | roles/combat | cards, waves, arena, UI | **IMPLEMENTADO + PARCIALMENTE VALIDADO** | engine runner cobre slow/movimento | 1/3 |
| EnergyPool | configuração | CardRuntime, UI, match | **IMPLEMENTADO + VALIDADO** | engine/card runners | 1/2 |
| CardDefinitions | dados | ArenaCard/catalog/runtime | **IMPLEMENTADO + VALIDADO** | card data runner | 2 |
| ArenaCard | CardEffect | runtime/deck/UI | **IMPLEMENTADO + VALIDADO** | card runners | 2 |
| ArenaDeck | ArenaCard, regras 8/4 | CardRuntime, UI, build | **IMPLEMENTADO + VALIDADO** | card data/runtime | 2 |
| CardRuntime | Deck, EnergyPool, Resolver | gameplay/card UI | **IMPLEMENTADO + VALIDADO** | card runtime/guard | 2 |
| CardEffectResolver | Hero/Enemy/ArenaState | todas as cartas | **IMPLEMENTADO + VALIDADO NO ESCOPO ATUAL** | runtime runner | 2/3 |
| BuildState | UpgradeOffer, Hero | progression/meta | **IMPLEMENTADO + PARCIALMENTE VALIDADO** | engine runner | 2 |
| Conteúdo das cartas | CardDefinitions | runtime/effects/arena | **16 implementadas** | runtime runner | 2 |
| Arena system | ArenaDefinitions/ArenaDirector | events/cataclysm/UI | **PARCIAL** | básico | 3 |
| Eventos ambientais | ArenaDirector + Telegraph + ArenaState | gameplay/UI/telemetry | **PARCIAL** | insuficiente | 3 |
| Cataclysm | MatchState + ArenaDirector + Combat | RESULT/UI/rewards | **PARCIAL** | insuficiente | 3 |
| Telegraph | evento + warning config | fairness/UI/event resolution | **IMPLEMENTADO + NÃO VALIDADO** | teste superficial Node | 1/3 |
| Recompensa | MatchState + kills + progression | inventário/meta | **IMPLEMENTADO, isolado** | ausente | 3/4 |
| UI | game state + card runtime + input | UX de batalha/meta | **PROTÓTIPO APENAS** | ausente | 3/4 |
| Persistência | Supabase schema | inventory/progression/decks/meta | **CONTRATO MÍNIMO** | ausente | 4 |
| Progressão | trophies/profile/rewards | Trophy Road/matchmaking/economy | **INCOMPLETA** | ausente | 4 |
| Trophy Road | profile + arena unlocks | matchmaking/progression | **AUSENTE** | ausente | 4 |
| Inventário | persistence + rewards | economy/collection | **AUSENTE** | ausente | 4 |
| Economia | inventory + rewards + billing | pass/ads/monetization | **AUSENTE** | ausente | 4 |
| Matchmaking | profile/trophies/arena | PvP indireto/leagues | **AUSENTE** | ausente | 4/5 |
| Monetização | inventory/economy/entitlements | live ops | **AUSENTE** | ausente | 4/6 |
| Social/competitive | matchmaking + identity + persistence | leagues/tournaments/replays/leaderboards | **AUSENTE** | ausente | 5 |
| Analytics | event schema + backend | balance/live ops | **AUSENTE** | ausente | 6 |

## 5. Caminho crítico

O caminho crítico não é simplesmente Gate 3 → Gate 4. É:

**Core Match Validation → Arena 1 Runtime Hardening → Stable Battle State Contract → Battle UI Production → Persistence/Identity Contract → Collection/Inventory → Progression/Trophy Road → Economy/Entitlements → Matchmaking → Competitive Systems → Analytics/Live Ops.**

Há uma dependência especialmente importante: **UI de produção deve esperar a estabilização do contrato de estado da partida e dos eventos**, porque hoje o bootstrap é um prototype monolítico que cria e mutaciona praticamente todos os sistemas diretamente. fileciteturn1067file0

Outro ponto: inventário/economia podem ter contratos de dados preparados antes da UI, mas não devem virar implementação completa antes de definir o contrato de recompensa e progressão persistente.

## 6. Paralelização segura

Podem avançar em paralelo, desde que apenas contratos sejam produzidos e validados:

- arte/UI shell após estabilização do battle-state contract;
- backend/persistence contract e migrations;
- analytics event schema;
- catálogo/data authoring das futuras arenas/cartas;
- testes de regressão do core;
- preparação de entitlements/economia sem acoplar UX final.

## 7. O que NÃO deve começar agora

- UI de batalha de produção antes do battle-state/event contract estar estabilizado.
- Trophy Road antes de persistência/progressão estarem definidos e testados.
- Economia/monetização antes de inventário, rewards e entitlements existirem como contratos executáveis.
- Matchmaking antes de profile/trophies/arena progression estarem persistentes.
- Ligas/torneios antes de matchmaking e normalização de níveis.
- Replays antes de um modelo determinístico/event-sourced de partida.
- Leaderboards antes de identidade, resultados e anti-cheat mínimo.
- Live ops/remote balance antes de analytics e configuração remota terem contrato observável.
- Novas arenas completas antes de o runtime de Arena 1 estar validado como template.

## 8. Próxima etapa recomendada

### Etapa A1 — Arena 1 Runtime Hardening + Battle-State Contract

**Objetivo:** transformar o protótipo funcional atual em um contrato de partida suficientemente estável para servir de base à UI de produção, persistência e expansão de arenas, sem iniciar essas features ainda.

**Dependências satisfeitas:** MatchState, ArenaState, ArenaDirector, Telegraph, Combat, Hero, Enemy, EnergyPool, CardRuntime, CardEffectResolver, 16 cartas e BuildState existem. A arquitetura data-driven está documentada. fileciteturn1062file0

**Dependências faltantes:** cobertura comportamental do core; contrato explícito de estado da partida; contrato de evento ambiental; validação temporal do telegraph/cataclysm; rewards integrado ao RESULT; cobertura dos cinco roles.

**Arquivos/módulos envolvidos:** `game/scripts/arena_forge_prototype.gd`, `core/match_state.gd`, `core/arena_state.gd`, `core/arena_director.gd`, `core/telegraph.gd`, `core/combat.gd`, `core/enemy.gd`, `core/hero.gd`, `core/match_rewards.gd`, `core/energy.gd`, além de novos runners de contrato. Nenhuma feature de meta/UI de produção nesta etapa.

**Contratos necessários:**
1. lifecycle CONTROL → IGNITION → CATACLYSM → RESULT;
2. evento ambiental request → telegraph → resolve → state mutation;
3. cataclysm start/end/radius progression;
4. cinco roles com comportamento mínimo observável;
5. reward calculation + RESULT integration;
6. hero/combat/death/knockback/XP integration;
7. shared energy/card play integration;
8. bootstrap smoke contract.

**Testes necessários:** runners Godot headless reais, com asserts de estado antes/depois e falha explícita; nenhum teste baseado somente em constantes duplicadas. O workflow deve continuar usando `barichello/godot-ci:4.4.1` e inicialização do registry. fileciteturn1081file0

**Critérios de aceite:**
- cada fase possui transição verificável;
- eventos não resolvem antes do telegraph terminar;
- warning configurado é preservado e observado;
- cataclysm reduz o raio de forma verificável;
- todos os cinco roles têm comportamento exercitado;
- rewards são calculadas e associadas ao resultado correto;
- dano/morte/knockback/XP possuem regressão real;
- energia e card play permanecem verdes em conjunto com o core;
- bootstrap executa sem erro;
- todos os testes Godot relevantes passam no CI;
- nenhum item de Gate 4/5/6 é implementado nesta etapa.

**Validação CI:** workflow completo verde, job Godot verde, logs contendo marcadores específicos de cada contrato e zero assertion/script errors. Não aceitar apenas exit code 0 sem execução observável dos runners.

**Impacto no Blueprint:** nenhum novo gameplay; formaliza o vertical slice Arena 1 e a regra de justiça/eventos como contratos executáveis. fileciteturn1058file0

**Risco de retrabalho:** baixo se o battle-state/event contract for estabilizado antes da UI; alto se UI/meta forem construídos sobre o prototype atual.

## 9. Hórus / legado

A árvore atual do repositório contém apenas Arena Forge, sem paths ou arquivos Hórus identificados. Busca textual por `Horus` no repositório retornou zero resultados. A documentação de migração afirma explicitamente que não há runtime Hórus e que somente padrões genéricos foram preservados. fileciteturn1064file0 O README também estabelece que nenhum runtime/domínio Hórus deve ser introduzido. fileciteturn1095file0

**Conclusão:** não existe evidência de legado Hórus interferindo na sequência atual. O risco operacional remanescente é externo ao runtime: o cutover do `velor-api` e a validação Efí continuam como itens de Gate 0.

## 10. Decisão de ordem

A sequência recomendada passa a ser:

**A1 Core/arena validation → A2 Battle-State contract stabilization → A3 Battle UI production → A4 Persistence/Identity → A5 Inventory + Rewards → A6 Trophy Road/Progression → A7 Economy/Entitlements → A8 Matchmaking → A9 Competitive/Social → A10 Analytics/Remote Balance → A11 Live Ops → A12 Content scale.**

Gate labels permanecem como agrupadores de produto, não como ordem cega de execução.

Nenhum novo Gate é marcado como concluído por esta auditoria.
