# Arena Forge — Roadmap Executivo

## Regra de execução
CRIAR → ADAPTAR → EXCLUIR LEGADO → TESTAR → VALIDAR → CORRIGIR → TESTAR NOVAMENTE → ATUALIZAR ROADMAP → AVANÇAR.

## Estado de validação — 2026-09-15
- O runner GitHub-hosted foi comprovado funcional por um workflow mínimo: run `35013229305` concluiu com sucesso e recebeu runner real.
- Os runs do CI de implementação `#40`, `#41` e `#42` falharam antes do primeiro step. O run `#42` criou os jobs `validate` e `godot`, mas ambos terminaram em aproximadamente 3 segundos com `steps: []`, `runner_id: 0` e `runner_name: ""`. Isso demonstra falha de atribuição/provisionamento do job antes da execução do código.
- A mesma assinatura (`runner_id=0`, `steps=[]`, falha em poucos segundos) está sendo reportada em incidentes recentes do GitHub Actions para repositórios privados, portanto não há evidência atual para atribuir essa falha à implementação do Arena Forge. citeturn1search0turn1search2
- Consequência: nenhuma etapa de Node, TypeScript, build ou Godot do CI de implementação foi executada com sucesso ainda. Gate 1 e Gate 2 não podem ser fechados por intenção.

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
- [ ] Validação headless Godot verde no repositório novo — bloqueada por falha de provisionamento pré-step do GitHub Actions

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
- [ ] Validação funcional Godot de todas as cartas — bloqueada por falha de provisionamento pré-step do GitHub Actions

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
