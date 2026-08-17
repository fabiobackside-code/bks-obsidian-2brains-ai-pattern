# BKS-Marine — esqueleto de exemplo

Esta pasta existe só para mostrar a **estrutura canônica** de um projeto no padrão
BKS (ver `brain/_bks-ai/templates/project-structure.md` e
`brain/_bks-ai/templates/PROJECT-README.md`). Está vazia de propósito —
sem escopo real, sem stack definida, sem specs preenchidas.

## Estrutura
- `app/` — código
- `brain/` — cérebro de domínio do produto (`knowledge/`, `methodology/`)
- `specs/{features,tests,tasks}/` — specs bks-sdd deste projeto
- `decisions/` — ADRs deste projeto
- `outputs/` — entregáveis (ARCH, apresentações, documentos)
- `docs/`
  - `input/{scope,interviews,research,assets}/` — material bruto de pesquisa, por tipo
  - `design/` — sua bancada de análise
  - `canonical/` — CONTEXT.md + PRD, gerados por `/canonize` e `/prd`
  - `prompts/` — prompt de cada rodada de `/canonize`
  - `history/` — versões superadas

## Como usar de verdade
Rode `/new-project <nome> <categoria>` com o Claude Code aberto na **raiz deste
vault** (não mais em `brain/_bks-ai`) para gerar a sua versão preenchida, com o
wiring completo e um README com exemplos de prompt. Depois traga material para
`docs/input/`, rode `/canonize` → `/prd` → `/spec`, e siga o `HOW-TO-WORK.md`
gerado e o `GUIA-OBSIDIAN-CLAUDE.md` na raiz do vault.
