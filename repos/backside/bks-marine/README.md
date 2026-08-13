# BKS-Marine — esqueleto de exemplo

Esta pasta existe só para mostrar a **estrutura canônica** de um projeto no padrão
BKS (ver `brain/_bks-ai/templates/project-structure.md`). Está vazia de propósito —
sem escopo real, sem stack definida, sem specs preenchidas.

## Estrutura
- `app/` — código
- `brain/` — cérebro de domínio do produto (`knowledge/`, `methodology/`)
- `specs/{features,tests,tasks}/` — specs bks-sdd deste projeto
- `decisions/` — ADRs deste projeto
- `docs/{canonical,design,input,prompts,history}/` — documentação por ciclo de vida

## Como usar de verdade
Rode `/novo-projeto <nome> <categoria>` com o Claude Code aberto em `brain/_bks-ai`
para gerar a sua versão preenchida, com o wiring completo. Depois siga
`HOW-TO-WORK.md` e o `GUIA-OBSIDIAN-CLAUDE.md` na raiz do repositório.
