# Arena Forge

Arena Forge — survivor de ação com deckbuilding, PvP indireto e arenas dinâmicas onde o cenário é parte da estratégia.

## Estrutura

- `game/` — protótipo e runtime Godot 4.
- `docs/` — blueprint, arquitetura, contratos e roadmap.
- `db/` — contratos de dados e schema Supabase.
- `tests/` — contratos automatizados do backend e do jogo.
- `.github/workflows/` — validação contínua.

## Regra de execução

CRIAR → ADAPTAR → EXCLUIR LEGADO → TESTAR → VALIDAR → CORRIGIR → TESTAR NOVAMENTE → ATUALIZAR ROADMAP → AVANÇAR.

O repositório não deve carregar runtime, documentação ou lógica específica do Hórus.
