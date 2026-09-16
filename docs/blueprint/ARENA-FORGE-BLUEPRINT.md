# Arena Forge — Blueprint de Produção

## Visão
Arena Forge é um survivor mobile de partidas curtas em que o jogador controla um único herói e usa um deck de 8 cartas para sobreviver, criar pressão e manipular uma arena viva. O diferencial competitivo é que o cenário não é decoração: ele é uma camada de decisão.

## Pilares
1. **Ação imediata:** movimento, auto-ataque, inimigos com papéis distintos e decisões constantes.
2. **Deckbuilding:** mão de 4, deck de 8, energia compartilhada e efeitos compostos.
3. **Arena como arma:** tiles, elementos, hazards, destruição e eventos ambientais.
4. **Habilidade > gasto:** progressão amplia opções; não deve comprar vitória automática.
5. **Justiça:** eventos de alto impacto são telegrafados; RNG cria contexto e o jogador responde.
6. **Escala:** conteúdo é data-driven; adicionar cartas, heróis e arenas não exige reescrever o núcleo.

## Escopos oficiais

### VALIDATED PROTOTYPE SCOPE
`16-card validated runtime scope`.

Este é o baseline técnico já validado. Ele permanece preservado para regressão e não deve ser confundido com o conteúdo final de lançamento.

### LAUNCH PRODUCT TARGET
- 25+ cards;
- 8+ heroes;
- 15 arenas;
- 1 hero por partida;
- 8 cards por deck;
- 4 cards na mão;
- próximo card entrando automaticamente após uso;
- shared energy;
- arena dinâmica;
- eventos ambientais telegráficos;
- progressão por arenas e desbloqueio progressivo;
- coleção;
- rewards e Forge Crates;
- Card/Hero/Arena Mastery;
- Forge/Specialization preparado;
- eventos e temporadas;
- competição com Ruleset/Normalization;
- analytics e live ops preparados para expansão contínua.

25 cards é o mínimo de lançamento, não o limite arquitetural. O núcleo deve aceitar `25 → 40 → 60 → 100+` sem refatoração estrutural e `8 → 10 → 15+` heróis sem mudança de arquitetura.

## Loop de partida
CONTROL 0–90s → IGNITION 90–180s → CATACLYSM 180–240s → RESULT.
O Cataclysm reduz progressivamente a área segura. Não existe hard-kill arbitrário no início.

## Heróis
Giant: tanque, lento, combate corpo a corpo.
Mage: frágil, alto dano elemental.
Elf: móvel, ranged, alta capacidade de reposicionamento.
Warrior: híbrido de dano e resistência.

A arquitetura suporta 8+ heróis. O herói não é uma carta.

## Cartas
O runtime validado contém 16 cartas. O produto-alvo começa em 25+ e pode crescer continuamente. Cada carta possui ID estável, custo, efeitos, tags, desbloqueio, mastery e contrato futuro de Forge/Synergy.

## Arenas
15 arenas são o target de lançamento. Arena 1 é o vertical slice: Campo de Batalha, eventos de fogo/destruição, telegraph e Cataclysm. As demais possuem identidade mecânica declarativa e entram por contratos de conteúdo sem alterar o motor.

Arena = regras + hazards + zonas/tipos de tile + eventos + interações + identidade de sinergia + desbloqueio.

## Progressão e coleção
A regra de produto é:

`ARENA → NOVO CONTEÚDO → NOVAS POSSIBILIDADES ESTRATÉGICAS`.

A distribuição de desbloqueios é data-driven. Arenas podem liberar cards, heroes, recursos, mastery, eventos e sistemas; não existe regra rígida de uma carta por arena.

## Mastery / Forge
Existem três contratos de mastery: Card, Hero e Arena. Forge/Specialization é uma camada futura para variantes e especializações. Recompensas podem incluir cosméticos, emotes, badges, efeitos, animações, variantes e aumentos de poder controláveis. Modos competitivos podem normalizar qualquer variável de poder.

## Rewards / Forge Crates
O contrato de rewards suporta cards, fragments, resources, cosmetics, emotes, choices e recompensas de eventos/temporadas. Forge Crate suporta tanto distribuição ponderada quanto escolha de 1 entre N quando o produto utilizar essa mecânica.

## Eventos
**MATCH ENVIRONMENT EVENT** e **LIVE OPS EVENT** são sistemas separados. O primeiro pertence ao runtime da partida e exige telegraph → warning → resolution → mutation. O segundo pertence ao meta e usa Event/Season/Rotation/Ruleset.

## Competitivo
A progressão normal pode carregar níveis. Modos competitivos terão Ruleset configurável com Normalization de hero level, card level e futuras variáveis. Torneios, ligas, matchmaking, leaderboards, replays/ghosts e anti-cheat serão implementados posteriormente.

## Analytics
O schema de analytics é versionado e extensível. Eventos preparados incluem hero_selected, card_played, card_unused, match_started, match_finished, arena_selected, arena_event_triggered, reward_received, card_unlocked, hero_unlocked, mastery_progressed, deck_configuration, energy_spent, match_duration e result.

## Fórmula estratégica
HERÓI → DECK → BUILD DA PARTIDA → ARENA → EVENTO → SINERGIA → ESTRATÉGIA → HABILIDADE.

## Monetização responsável
Cosméticos, passes, chests/Forge Crates sem mecânica de aposta, progressão acelerada e anúncios recompensados opcionais. Competitivo deve normalizar níveis quando necessário para preservar habilidade e estratégia.

## Critério de qualidade
Uma feature só é concluída quando tem implementação, teste, validação e regressão verde. Não usar existência de código como prova de conclusão.
