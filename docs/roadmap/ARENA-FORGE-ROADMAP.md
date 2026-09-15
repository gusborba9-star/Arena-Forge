# Arena Forge — Roadmap Executivo

## Regra de execução
CRIAR → ADAPTAR → EXCLUIR LEGADO → TESTAR → VALIDAR → CORRIGIR → TESTAR NOVAMENTE → ATUALIZAR ROADMAP → AVANÇAR.

## Gate 0 — Fundação
- [x] Blueprint
- [x] Roadmap
- [x] Arquitetura de gameplay
- [x] Arquitetura técnica
- [x] Contratos data-driven
- [x] Matriz de migração Hórus → Arena Forge
- [x] Repositório independente criado
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
- [ ] Validação headless Godot verde no repositório novo

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
