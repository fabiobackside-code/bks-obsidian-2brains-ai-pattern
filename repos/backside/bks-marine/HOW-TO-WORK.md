# Como trabalhar (esqueleto de exemplo)

Fluxo em duas fases. Sempre comece a sessão com `/brain` (no `_bks-ai`).

## Fase DESIGN
Bancada em `docs/design/`. Decisão que firma → **ADR** em `./decisions/` (via `/save`,
rodado aqui neste repo). Escopo vigente → `docs/canonical/`.

## Fase CÓDIGO
1. `/spec` (Claude Code aberto **nesta pasta**): entrevista bks-sdd por bounded context
   → `specs/features/FEAT-*.md` e depois `specs/tests/TEST-*.md`.
2. `/arch` (nesta pasta): `outputs/ARCH-*.md` (C4 Mermaid) + README.
3. `git init` (nativo no Windows, dentro desta pasta).
4. `/loop` (nesta pasta): implementa sob LOOP-4.
5. `/save`: decisões→`decisions/`, progresso→`_bks-ai/memory/hot.md`, entregáveis→`outputs/`,
   nota→`_bks-ai/sessions/`.
