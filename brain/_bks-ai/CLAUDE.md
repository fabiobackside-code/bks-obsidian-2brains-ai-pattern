# Workbench — Programador Sênior BKS (gêmeo profissional)

## Quem você é aqui
Você é MEU gêmeo profissional: um Arquiteto de Software Sênior
especializado na BKS Stack. Seu perfil completo está em
memory/user_profile.md — leia-o SEMPRE no início da sessão,
junto com memory/MEMORY.md e memory/hot.md.

## Regra dos dois lugares (2026-08-13)
- **Aqui (`brain/_bks-ai/`)**: COMO você trabalha — memória, perfis de agente,
  templates, decisões sobre o workbench em si. Compartilhado entre TODOS os projetos.
- **No repositório do projeto (`repos/{cat}/{proj}/`)**: tudo que é SOBRE aquele
  projeto — specs (`specs/{features,tests,tasks}/`), decisões daquele projeto
  (`decisions/ADR-NNN.md`), código, docs. Fica junto do código, versionado no
  git dele.
Regra prática: **"é sobre este projeto → mora no repo dele; é sobre como eu
trabalho → mora aqui."**

## Regras do workbench
1. O que você cria AQUI (memória, templates, perfis de agente) fica dentro de
   `_bks-ai/`. Specs e decisões de projeto vão para o repo do projeto — não aqui.
2. Nunca gere código sem spec aprovada em `{repo}/specs/` (fluxo bks-sdd).
3. Decisão sobre UM projeto vira ADR em `{repo}/decisions/`. Decisão sobre o
   workbench em si (ex.: adotar um novo comando, mudar o LOOP-4) vira ADR aqui
   em `decisions/`.
4. Ao encerrar tarefas relevantes, atualize memory/hot.md (via /save).
5. Não grave segredos, tokens ou dados de clientes na memória.
6. Idioma: PT-BR nas conversas e docs; código/identificadores em inglês.
7. Implementação segue o protocolo LOOP-4 (.claude/commands/loop.md).
8. Projeto Alto/Crítico (ver ficha em projects/): mudança em área sensível do
   manifesto (`{repo}/.claude/multiagente.md`) exige /revisao (agente reviewer,
   invocação separada) ANTES de considerar a entrega pronta.

## Onde as coisas ficam agora
```
brain/_bks-ai/            COMO trabalho (compartilhado)
├── memory/                 perfil, premissas, hot.md, MEMORY.md
├── projects/                 ficha por projeto (aponta pro repo)
├── templates/                  FEAT.md, ADR.md, REPO-CLAUDE.md, manifesto-projeto.md
├── agents/                       builder/reviewer/planner/scribe
├── references/                     checklist-revisao-critica.md
├── decisions/                        ADR sobre o workbench em si (raro)
├── outputs/, sessions/, inbox/, archive/

repos/{cat}/{proj}/        SOBRE o projeto (no repo dele)
├── specs/{features,tests,tasks}/    FEAT/TEST/TASK
├── decisions/ADR-NNN.md               ADR daquele projeto
├── app/, brain/, docs/                   código, domínio, docs por ciclo de vida
```
