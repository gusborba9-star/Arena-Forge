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

## Loop de partida
CONTROL 0–90s → IGNITION 90–180s → CATACLYSM 180–240s → RESULT.
O Cataclysm reduz progressivamente a área segura. Não existe hard-kill arbitrário no início.

## Heróis
Giant: tanque, lento, combate corpo a corpo.
Mage: frágil, alto dano elemental.
Elf: móvel, ranged, alta capacidade de reposicionamento.
Warrior: híbrido de dano e resistência.

## Cartas iniciais
16 cartas: ice_wall, wind_blast, oil_pool, spark_bomb, healing_pillar, water_geyser, blink, goblin_invasion, meteor, snowstorm, black_hole, brute_invasion, earth_spikes, air_current, overload, shock_chain.

## Arenas
15 arenas planejadas. Arena 1 é o vertical slice: Campo de Batalha, eventos de fogo/destruição, telegraph e Cataclysm. Selva, Tundra, Vulcão, Terremoto e demais arenas entram por contratos de conteúdo, sem alterar o motor.

## Fórmula estratégica
HERÓI → DECK → BUILD DA PARTIDA → ARENA → ESTRATÉGIA → HABILIDADE.

## Monetização responsável
Cosméticos, passes, chests sem mecânica de aposta, progressão acelerada e anúncios recompensados opcionais. Competitivo deve normalizar níveis quando necessário para preservar habilidade e estratégia.

## Critério de qualidade
Uma feature só é concluída quando tem implementação, teste, validação e regressão verde. Não usar existência de código como prova de conclusão.
