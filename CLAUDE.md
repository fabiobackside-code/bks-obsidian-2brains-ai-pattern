# 2b-projects — segundo cérebro do Fabio

Este arquivo existe só para o Claude Code carregar contexto ao abrir na raiz do vault.
Leitura obrigatória antes de qualquer coisa: CONTEXT.md.

## Comandos disponíveis aqui na raiz
- `/brain` — retoma a sessão: quem você é, onde parei, próximo passo.
- `/new-project <nome> <categoria>` — cria um projeto novo (única forma de começar).
- `/canonize` — consolida docs/input/ + docs/design/ de um projeto em docs/canonical/CONTEXT.md.
- `/prd` — gera docs/canonical/PRD-{projeto}.md a partir do CONTEXT.md consolidado.
- `/review` — dispara revisão de segurança (agente reviewer) num repo específico.

Comandos de código (`/spec`, `/arch`, `/loop`, `/save`) rodam DENTRO do repo do projeto
(`repos/{categoria}/{projeto}/`), não aqui — abra uma sessão nova lá quando for codar.

Regras completas: `GUIA-OBSIDIAN-CLAUDE.md` e `MANUAL-COMANDOS.md`.
