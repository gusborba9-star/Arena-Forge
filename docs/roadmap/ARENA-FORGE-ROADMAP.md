# Arena Forge — Roadmap Executivo

## Regra de execução
CRIAR → ADAPTAR → EXCLUIR LEGADO → TESTAR → VALIDAR → CORRIGIR → TESTAR NOVAMENTE → ATUALIZAR ROADMAP → AVANÇAR.

## Estado de validação — 2026-09-15
- O runner GitHub-hosted foi comprovado funcional por um workflow mínimo: run `35013229305` concluiu com sucesso e recebeu runner real.
- Os runs do CI de implementação `#40`, `#41` e `#42` falharam antes do primeiro step. Essa falha de provisionamento foi posteriormente superada pelo GitHub Actions e não é mais o bloqueio atual.
- Run `35032881405` (`#53`) foi a primeira execução real do CI após a recuperação: `validate` passou integralmente e `godot` recebeu runner, iniciou Godot 4.4.1 e executou `tests/engine_contract_runner.gd`, mas falhou porque as classes globais não estavam disponíveis no primeiro carregamento headless.
- Auditoria estrutural confirmou que as classes de domínio existem no projeto, usam `class_name` corretamente e suas dependências principais também existem. O problema estava no bootstrap do projeto em ambiente CI limpo: o cache de classes globais do Godot (`.godot/global_script_class_cache.cfg`) não existia porque `.godot` é gerado localmente e ignorado pelo Git.
- Correção arquitetural: o job Godot agora inicializa o projeto em modo editor headless antes de executar os contratos, permitindo que o Godot construa seu registro de classes globais de forma determinística. Não foram adicionados preloads artificiais ao runner nem mocks.
- Run `35035279579` (`#54`) validou a correção: `validate` passou em `npm install`, `npm test`, `typecheck`, `lint` e `build`; `godot` passou por inicialização de container, checkout, registro do projeto e `tests/engine_contract_runner.gd` com sucesso.
- Evidência final do Gate 1: execução Godot headless real concluída com sucesso no commit `0f0e5d37abd246796f385adfaf95371c70ae790e`, job Godot `104602904042`, run `35035279579`.

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
- [ ] Validação funcional Godot de todas as cartas

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
