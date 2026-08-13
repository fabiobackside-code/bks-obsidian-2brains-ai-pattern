# bks-obsidian-2brains-ai-pattern

Template reutilizável de **segundo cérebro** (Obsidian + Claude Code) para quem
programa com IA seguindo Hexagonal + DDD tático + Pipeline Orchestration + TXC
(Transaction Context) + SEDA + TCP sockets, com fluxo spec-driven
(FEAT → TEST → TASK) e protocolo de implementação **LOOP-4**.

Este repositório é **só o padrão** — estrutura, templates, comandos, perfis de
agente, guia e manual. **Não contém dado de nenhum cliente ou projeto real.**
O projeto `repos/backside/bks-marine/` está aqui como **esqueleto vazio**, só
para ilustrar a estrutura canônica de um projeto.

## Como usar

1. Copie esta pasta para a sua máquina (ex. `D:\SeuNome\2b-projects`).
2. Abra como vault no Obsidian (**Open folder as vault**).
3. Leia `CONTEXT.md` (o que é o sistema) e `GUIA-OBSIDIAN-CLAUDE.md` (como usar,
   passo a passo).
4. Personalize `brain/_bks-ai/memory/user_profile.md` com o seu próprio perfil
   de desenvolvedor — hoje ele reflete o autor original; ajuste stack, tom e
   preferências para os seus.
5. Rode `/novo-projeto <nome> <categoria>` (Claude Code aberto em `brain/_bks-ai`)
   para criar seu primeiro projeto de verdade.

## Estrutura

```
CONTEXT.md                  ponto de entrada
GUIA-OBSIDIAN-CLAUDE.md     guia de uso passo a passo
MANUAL-COMANDOS.md          referência de todo comando
brain/
├── knowledge/                cérebro de conhecimento (wiki de estudo, vazio)
└── _bks-ai/                    cérebro de trabalho (workbench)
    ├── CLAUDE.md                regras do workbench
    ├── memory/                    perfil, premissas, padrões (editáveis)
    ├── templates/                   FEAT, ADR, REPO-CLAUDE, project-structure, manifesto
    ├── agents/                        builder/reviewer/planner/scribe
    ├── references/                      checklist de revisão crítica
    ├── projects/                          fichas de projeto (vazio)
    └── .claude/commands/                    /brain /spec /arch /loop /save
                                                /novo-projeto /revisao
repos/backside/bks-marine/  exemplo de esqueleto vazio de projeto
```

## Licença / origem

O conceito de pasta de workbench isolada foi inspirado em
[obsidian-ai-workbench](https://github.com/RenzoTakada/obsidian-ai-workbench)
(RenzoTakada). A camada de governança multi-agente (`agents/`, `/revisao`,
manifesto por projeto) foi adaptada de
[bks-multiagent-skill](https://github.com/DiegoAmorimDev/bks-multiagent-skill)
(DiegoAmorimDev, MIT). O restante — método bks-sdd, TXC, regra dos dois
cérebros/dois lugares, LOOP-4 — é autoral.
