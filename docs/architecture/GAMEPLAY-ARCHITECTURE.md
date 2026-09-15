# Gameplay Architecture

Hero → MatchState → ArenaState / ArenaDirector → Combat / Progression → CardRuntime → CardEffectResolver.

O runtime recebe dados; não conhece uma lista fixa de cartas. Cards e arenas são contratos de dados. Efeitos são composáveis. Eventos ambientais usam Telegraph antes da resolução.
