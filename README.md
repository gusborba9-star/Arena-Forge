# Arena Forge

**O survivor onde a arena é sua arma.**

Arena Forge é um mobile action-survivor com deckbuilding, PvP indireto e arenas dinâmicas. O jogador controla um herói, monta um deck de 8 cartas e transforma o próprio cenário em parte da estratégia.

## Produto
- 1 herói por partida; heróis têm identidades e atributos distintos.
- Deck de 8 cartas, mão de 4 e energia compartilhada.
- 16 cartas iniciais, projetadas para combinações e interação ambiental.
- 15 arenas planejadas; a Arena 1 é o vertical slice funcional.
- Eventos ambientais sempre telegrafados antes do impacto.
- Cataclysm progressivo: pressão espacial em vez de morte por cronômetro.
- Progressão durante a partida por XP e escolhas de upgrade.
- Arquitetura data-driven para escalar conteúdo sem reescrever o núcleo.

## Stack
Godot 4 / GDScript para gameplay; Next.js + TypeScript para APIs e operações; Supabase para dados persistentes; Vercel mantém o serviço operacional existente durante a migração.

## Regra operacional
CRIAR → ADAPTAR → EXCLUIR LEGADO → TESTAR → VALIDAR → CORRIGIR → TESTAR NOVAMENTE → ATUALIZAR ROADMAP → AVANÇAR.

## Estrutura
`game/` gameplay, `docs/` blueprint/arquitetura/roadmap, `tests/` contratos automatizados, `db/` contratos persistentes, `app/` APIs.

O repositório é independente do Hórus. Nenhum runtime ou domínio específico do Hórus deve ser introduzido aqui.
