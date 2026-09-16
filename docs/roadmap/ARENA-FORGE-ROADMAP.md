# Arena Forge — Roadmap Executivo

## Regra de execução
CRIAR → ADAPTAR → EXCLUIR LEGADO → TESTAR → VALIDAR → CORRIGIR → TESTAR NOVAMENTE → REGISTRAR EVIDÊNCIA → ATUALIZAR ROADMAP → AVANÇAR.

CI verde é obrigatório, mas não suficiente. Um item só pode ser considerado concluído quando houver implementação real, teste comportamental, validação e regressão compatível com o requisito.

## Estado de validação — 2026-09-15
- Run `35013229305` comprovou o runner GitHub-hosted funcional.
- Run `35035279579` (`#54`) comprovou o bootstrap de classes Godot e validou o conjunto de contratos do core existente.
- Run `35037001697` (`#69`) e a execução final posterior comprovaram os contratos funcionais das 16 cartas no ambiente Godot 4.4.1.
- Auditoria de dependências registrada em `docs/audit/PRODUCT-DEPENDENCY-AUDIT.md`, baseline `f57fc16487f425cebe8f53c7c5812f22ea90de77`.
- A auditoria reabriu itens de Gate 1 e Gate 3 que estavam marcados `[x]` sem cobertura comportamental específica suficiente. Isso não significa que o código deixou de existir; significa que a evidência não sustenta o status de conclusão sob o protocolo atual.
- A ordem de execução passa a ser determinada por dependências arquiteturais, não pela numeração dos Gates.

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

**Estado:** PARCIAL / ABERTO.

## Gate 1 — Core Combat
- [ ] Herói controlável — implementação presente; falta contrato comportamental específico.
- [ ] Movimento teclado + abstração mobile — implementação presente; falta regressão específica de input.
- [ ] Auto-ataque — implementação integrada ao prototype; falta teste de aquisição/alvo/dano.
- [ ] HP/dano/morte/knockback — implementação presente; cobertura atual não comprova todos os caminhos.
- [ ] XP/level — implementação presente; falta teste de progressão real.
- [ ] Energia compartilhada — EnergyPool validado, mas falta contrato de integração compartilhada com o match.
- [ ] Papéis de inimigos — cinco roles implementados; falta contrato comportamental por role.
- [x] Arena tile/state — runner testa hazards e estado de tiles.
- [x] Destruição e Abyss — runner testa NORMAL → CRACKED → COLLAPSED → ABYSS.
- [ ] Telegraph — implementação integrada; falta validação temporal comportamental.
- [ ] Fases da partida — implementação das quatro fases existe; runner atual não cobre todas as transições.
- [x] Validação headless Godot verde no repositório novo — run `35035279579`, job `104602904042`, commit `0f0e5d37abd246796f385adfaf95371c70ae790e`

**Estado:** IMPLEMENTADO / VALIDAÇÃO INCOMPLETA. O `[x]` anterior do Gate 1 não é mantido como fechamento agregado.

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
- [x] Validação funcional Godot de todas as cartas — runs `35037001697`/execução final posterior, ambiente `barichello/godot-ci:4.4.1`

### Evidência do Gate 2
- `card_data_contract_runner.gd`: IDs/custos, criação das cartas, catálogo, deck 8, mão 4 e draw/play.
- `card_runtime_contract_runner.gd`: execução real das 16 cartas via `CardRuntime.play` + `CardEffectResolver`, com mutações reais de estado.
- `card_guard_contract_runner.gd`: índice inválido, energia insuficiente e cooldown real do Blink.
- O Gate 2 permanece validado no escopo definido; a auditoria não o reabre apenas por ausência de testes adicionais que pertencem ao core da partida.

## Gate 3 — Vertical Slice Arena 1
- [ ] Identidade Arena 1 — configuração/runtime presentes; falta contrato de aceitação da Arena 1.
- [ ] Eventos ambientais telegrafados — dois eventos configurados e integrados; falta prova executável warning → resolve → mutation.
- [ ] Cataclysm progressivo — raio e dano fora da área existem; falta validação temporal do raio/progressão.
- [ ] 5 papéis de inimigos — roles e wave inicial existem; falta comportamento específico validado.
- [ ] Recompensas determinísticas — cálculo existe; falta teste e integração validada ao RESULT.
- [ ] Interações ambientais completas água/eletricidade/óleo/fogo/gelo/vento
- [ ] UI de batalha de produção
- [ ] Balanceamento por telemetria

**Estado:** PARCIAL / VALIDAÇÃO INCOMPLETA.

## Gate 4 — Meta
- [ ] Inventário persistente
- [ ] Trophy Road
- [ ] Progressão de arenas
- [ ] Matchmaking indireto
- [ ] Economia
- [ ] Pass
- [ ] Ads recompensados
- [ ] Cosméticos

**Estado:** NÃO INICIADO COMO SISTEMA DE META. O schema Supabase atual é apenas fundação mínima de perfil/deck; não representa inventário, economia ou progressão completas.

## Gate 5 — Social/Competitive
- [ ] Ligas normalizadas
- [ ] Tournaments
- [ ] Replays/ghosts
- [ ] Leaderboards
- [ ] Anti-cheat híbrido

**Estado:** AUSENTE.

## Gate 6 — Escala
- [ ] 40+ cartas
- [ ] 15 arenas completas
- [ ] eventos sazonais
- [ ] live ops
- [ ] analytics e remote balance

**Estado:** AUSENTE.

## Ordem arquitetural por dependência

Os Gates são agrupadores, não uma fila rígida. A sequência recomendada passa a ser:

1. **A1 — Arena 1 Runtime Hardening + Battle-State Contract**
2. **A2 — Estabilização do contrato de estado/eventos da batalha**
3. **A3 — UI de batalha de produção**
4. **A4 — Persistence/Identity Contract**
5. **A5 — Inventory + Rewards persistentes**
6. **A6 — Trophy Road + Progressão de arenas**
7. **A7 — Economy + Entitlements**
8. **A8 — Matchmaking indireto**
9. **A9 — Social/Competitive**
10. **A10 — Analytics + Remote Balance**
11. **A11 — Live Ops**
12. **A12 — Escala de conteúdo (40+ cartas / 15 arenas completas)

### Próxima etapa obrigatória

**A1 — Arena 1 Runtime Hardening + Battle-State Contract**.

Não iniciar UI de produção, Trophy Road, economia, matchmaking, social/competitive ou live ops antes de estabilizar os contratos de estado/evento necessários.

Critérios de aceite da A1:
- lifecycle CONTROL → IGNITION → CATACLYSM → RESULT verificável;
- evento ambiental: request → telegraph → resolve → mutação de estado;
- warning temporal verificável;
- cataclysm com raio progressivo verificável;
- cinco roles exercitados por contrato comportamental;
- rewards calculadas e integradas ao RESULT;
- dano/morte/knockback/XP com regressão real;
- energia/card play permanecem integrados ao core;
- bootstrap smoke test;
- CI Godot 4.4.1 verde com logs específicos dos runners;
- nenhum avanço de Gate 4/5/6 nesta etapa.

## Auditoria Hórus

A árvore atual do Arena Forge não contém arquivos/runtime Hórus e busca textual por `Horus` retornou zero resultados. A matriz de reutilização classifica estruturas genéricas como reutilizáveis/adaptáveis e domínios Hórus específicos como descartados. O legado continua fora da cadeia de runtime. O único risco operacional relacionado à migração permanece externo: cutover do `velor-api` e validação Efí.

## Regra de avanço
Nenhum Gate avança por intenção. Cada item exige evidência técnica e funcional compatível com seu requisito, registrada no roadmap.
