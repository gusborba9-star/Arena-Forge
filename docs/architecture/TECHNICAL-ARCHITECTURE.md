# Technical Architecture

Godot 4 é o cliente de gameplay. Next.js/TypeScript é a camada de API/ops. Supabase é o armazenamento persistente. Vercel permanece como destino operacional de `velor-api` durante o cutover.

Princípios: servidor valida recursos críticos; cliente executa simulação local; eventos PvP são leves e sincronizados por eventos, não por streaming contínuo; configuração pode ser remota; testes automatizados são requisito de gate.
