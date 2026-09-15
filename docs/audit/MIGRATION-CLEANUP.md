# Migration Cleanup

O Arena Forge não herda runtime Hórus. Foram preservados apenas conceitos e estruturas genéricas: Git/versionamento, padrões Supabase/RLS, APIs, idempotência, logs, testes, configuração e controles de custo. Domínios específicos do Hórus, agentes, workflows, memória pessoal, Nexus/studio e lógica de apostas ficam fora do repositório.

Estratégia: migrar somente o contrato Arena Forge, validar no repositório novo, conectar ao `velor-api`, validar produção e então congelar/remover o legado da cadeia operacional.
