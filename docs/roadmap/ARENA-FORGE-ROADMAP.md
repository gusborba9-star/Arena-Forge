# Arena Forge — Roadmap Executivo

## Regra de execução
CRIAR → ADAPTAR → EXCLUIR LEGADO → TESTAR → VALIDAR → CORRIGIR → TESTAR NOVAMENTE → ATUALIZAR ROADMAP → AVANÇAR.

## Estado de validação — 2026-09-15
- O runner GitHub-hosted foi comprovado funcional por workflow mínimo: run `35013229305` concluiu com sucesso.
- A recuperação do runner permitiu execução real do CI; o primeiro problema Godot foi o bootstrap do registro de classes globais em checkout limpo.
- Correção arquitetural: o job Godot inicializa o projeto em modo editor headless antes dos contratos, sem preloads artificiais nem mocks.
- Run `35035279579` (`#54`) validou Gate 1: `validate` passou integralmente e Godot 4.4.1 executou `tests/engine_contract_runner.gd` com sucesso.
- Para Gate 2, a auditoria confirmou que as 16 cartas são data-driven e que o runtime real é composto por `ArenaCard`, `ArenaDeck`, `CardRuntime`, `CardEffectResolver`, `EnergyPool`, `ArenaState`, `ArenaHero` e `ArenaEnemy`.
- A primeira suíte funcional de cartas revelou uma falha de qualidade de teste: um `assert` falhava em uma carta composta, mas não produzia exit code não-zero no runner. O teste foi corrigido para falhar explicitamente com `quit(1)` e o cenário composto foi ajustado para manter o inimigo vivo quando o efeito de push também é validado.
- Run final de Gate 2 `35037001697` (`#69`) executou no mesmo ambiente `barichello/godot-ci:4.4.1`. `validate` e `godot` concluíram com sucesso.
- Evidência funcional final: job Godot `104608252568` executou `tests/engine_contract_runner.gd`, `tests/card_data_contract_runner.gd`, `tests/card_runtime_contract_runner.gd` e `tests/card_guard_contract_runner.gd`, todos concluídos com sucesso. Os logs registraram `ARENA_FORGE_CARD_DATA_OK cards=16`, `ARENA_FORGE_CARD_RUNTIME_OK cards=16` e `ARENA_FORGE_CARD_GUARDS_OK invalid=2 cooldown=5`.

## Gate 0 — Fundação
- [x] Blueprint
- [x] Roadmap
- [x] Arquitetura de gameplay
- [x] Arquitetura técnica
- [x] Contratos data-driven
- [x] Matriz de migração Hórus → Arena Forge
- [x] Repositório independente criado
- [x] Runner GitHub-hosted comprovado funcional por workflow mínimo
- [ ] Conexão do repositório ao Vercel `velor-api` após validação
- [ ] Cutover de produção e validação Efí

## Gate 1 — Core Combat
- [x] Herói controlável
- [x] Movimento teclado + abstração mobile
- [x] Auto-ataque
- [x] HP/dano/morte/knockback
- [x] XP/level
- [x] Energia compartilhada
- [x] Papéis de inimigos
- [x] Arena tile/state
- [x] Destruição e Abyss
- [x] Telegraph
- [x] Fases da partida
- [x] Validação headless Godot verde no repositório novo — run `35035279579`, job `104602904042`, commit `0f0e5d37abd246796f385adfaf95371c70ae790e`

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
- [x] Validação funcional Godot de todas as cartas — run `35037001697`, job `104608252568`, commit `9560621689583b0ccc5ebf630560eb289d372cfb`

### Evidência do Gate 2
- `card_data_contract_runner.gd`: 16 IDs, custos, criação das cartas, catálogo, deck 8, mão 4 e draw/play.
- `card_runtime_contract_runner.gd`: execução real das 16 cartas via `CardRuntime.play` + `CardEffectResolver`, com mutação real de dano, cura, push, tiles de arena, speed, spawn e slow, além de consumo de energia e rotação da mão.
- `card_guard_contract_runner.gd`: uso inválido por índice/energia e cooldown real do Blink.
- Ambiente: Godot `4.4.1.stable.official.49a5bc7b6`, container `barichello/godot-ci:4.4.1`.
- Workflow: inicialização headless do registro de classes antes da execução dos contratos.
- `validate`: PASS — npm install, test, typecheck, lint e build.
- `godot`: PASS — todos os quatro runners concluídos com sucesso.

## Gate 3 — Vertical Slice Arena 1
- [x] Identidade Arena 1
- [x] Eventos ambientais telegrafados
- [x] Cataclysm progressivo
- [x] 5 papéis de inimigos
- [x] Recompensas determinísticas
- [ ] Interações ambientais completas água/eletricidade/óleo/fogo/gelo/vento
- [ ] UI de batalha de produção
- [ ] Balanceamento por telemetria

## Gate 4 — Meta
- [ ] Inventário persistente
- [ ] Trophy Road
- [ ] Progressão de arenas
- [ ] Matchmaking indireto
- [ ] Economia
- [ ] Pass
- [ ] Ads recompensados
- [ ] Cosméticos

## Gate 5 — Social/Competitive
- [ ] Ligas normalizadas
- [ ] Tournaments
- [ ] Replays/ghosts
- [ ] Leaderboards
- [ ] Anti-cheat híbrido

## Gate 6 — Escala
- [ ] 40+ cartas
- [ ] 15 arenas completas
- [ ] eventos sazonais
- [ ] live ops
- [ ] analytics e remote balance

### Regra de avanço
Nenhum Gate avança por intenção. O avanço exige evidência técnica e funcional registrada pelo CI e pelos testes do motor.
