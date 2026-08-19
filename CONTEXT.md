# CONTEXT — 2b-projects (Segundo Cérebro do Fabio)

> Projeto de **config, setup e estudo**. Este arquivo é o ponto de entrada:
> descreve o que é o segundo cérebro, como ele está montado e como usá-lo
> para que meus projetos saiam mais assertivos, aluciném menos e consumam
> menos tokens. Leia isto ANTES de qualquer sessão de trabalho.

## Propósito

Transformar meu conhecimento e meus padrões em um sistema persistente que
guia a construção das minhas aplicações. Objetivos mensuráveis:

- **Assertividade** — decisões ancoradas na wiki e nas specs, não em achismo.
- **Anti-alucinação** — o assistente consulta a base curada antes de gerar;
  o que for incerto é marcado `> [!uncertain]`, nunca chutado.
- **Menos tokens** — conteúdo curto, bem delimitado e cruzado por links,
  em vez de reexplicar tudo a cada prompt.

## Os dois cérebros

O `2b-projects` tem dois cérebros que se complementam:

1. **`brain/knowledge/` — cérebro de conhecimento (estudo).**
   Base de conhecimento no padrão "Karpathy LLM Wiki". Fontes imutáveis em
   `raw/`, páginas curadas com frontmatter YAML em `wiki/`, e o schema em
   `knowledge/CLAUDE.md`. É o que consulto para fundamentar decisões (SOLID,
   DDD, hexagonal, SDD, harness engineering, microserviços, TCP sockets, SEDA...).

2. **`brain/_bks-ai/` — cérebro de trabalho (workbench / gêmeo profissional).**
   O assistente configurado como MEU gêmeo: Arquiteto Sênior BKS. Aqui ficam
   memória, perfis de agente, templates e comandos que produzem código para
   os meus repositórios. Regras em `_bks-ai/CLAUDE.md`.

Regra de ouro: **o cérebro de trabalho consulta o cérebro de conhecimento.**
Antes de decidir arquitetura ou padrão, o `_bks-ai` pesquisa a `wiki/`
(`brain/knowledge/tools/search.sh "<termo>"`) e cita a página usada.

## A regra dos dois lugares (2026-08-13)

Desde 2026-08-13, **specs e decisões de cada projeto moram no repositório
dele**, não mais no workbench. Isso resolveu a confusão de "onde fica o quê"
nos 3+ projetos ativos.

- **É sobre este projeto** (specs FEAT/TEST/TASK, ADR de stack/arquitetura,
  código, docs) → mora em `repos/{categoria}/{projeto}/`.
- **É sobre como eu trabalho** (memória, perfis de agente, templates, decisão
  sobre o workbench em si) → mora em `brain/_bks-ai/`. Compartilhado entre
  TODOS os projetos.

## Estrutura de diretórios

```text
D:\Fabio\2b-projects\
├── CONTEXT.md                  # este arquivo — porta de entrada
├── GUIA-OBSIDIAN-CLAUDE.md     # guia de fluxo completo
├── MANUAL-COMANDOS.md          # referência de todo comando
├── PENDENCIAS.md               # backlog por área
├── brain\
│   ├── knowledge\              # CÉREBRO DE CONHECIMENTO (wiki de estudo)
│   │   ├── CLAUDE.md           # schema do mantenedor da wiki (não misturar c/ _bks-ai)
│   │   ├── raw\                # fontes imutáveis: papers, articles, videos, notes
│   │   ├── wiki\                # páginas curadas + index.md + log.md
│   │   └── tools\                # search.sh, batch-ingest.md
│   ├── _bks-ai\                    # CÉREBRO DE TRABALHO (workbench BKS)
│   │   ├── CLAUDE.md           # regras do workbench (gêmeo profissional)
│   │   ├── memory\             # user_profile, dotnet-standards, calisthenics,
│   │   │                       #   seda-tcp, knowledge-base, hot, MEMORY (índice)
│   │   ├── projects\           # fichas dos projetos ativos (aponta pro repo)
│   │   ├── decisions\          # ADRs SOBRE O WORKBENCH EM SI (raro)
│   │   ├── templates\          # ADR, FEAT, REPO-CLAUDE, project-structure,
│   │   │                       #   manifesto-projeto
│   │   ├── agents\              # builder / reviewer / planner / scribe
│   │   ├── references\           # checklist-revisao-critica
│   │   ├── outputs\               # entregáveis do workbench
│   │   ├── sessions\               # notas de sessão (sessao-YYYY-MM-DD.md)
│   │   ├── inbox\ / archive\        # captura rápida / arquivo morto
│   │   └── .claude\commands\         # (pointers) novo-projeto -> /new-project, revisao -> /review
│   └── notes\                  # notas soltas do Obsidian
├── repos\                      # repositórios reais (git), cada um com:
│   │                           #   app/, brain/, specs/{features,tests,tasks}/,
│   │                           #   decisions/, docs/{canonical,design,input,
│   │                           #   prompts,history}/
│   ├── backside\                 # bks-marine (template), terra-one, layan
│   ├── w3\                         # nquantic
│   └── private\
├── sandbox\                    # experimentação livre (sem spec)
└── new-project.ps1             # scaffold de novo projeto
```

## Projetos ativos (revisão semanal)

| Projeto   | Categoria | Repo                          | Specs (no repo)                | Criticidade |
|-----------|-----------|--------------------------------|---------------------------------|-------------|
| bks-marine| backside  | `repos\backside\bks-marine`    | `specs\{features,tests,tasks}` | padrão · **template de referência do guia/manual** |
| Terra One | backside  | `repos\backside\terra-one`     | `specs\{features,tests,tasks}` | a definir |
| Layan     | backside  | `repos\backside\layan`         | `specs\{features,tests,tasks}` | a definir |
| NQUANTIC  | w3        | `repos\w3\nquantic`            | `specs\{features,tests,tasks}` | bancário → candidato a **crítico** |
| poc-sec-sdk | backside | `repos\backside\poc-sec-sdk`  | `specs\{features,tests,tasks}` | padrão · fase **pesquisa**, escopo não definido |

Detalhes de cada um em `brain/_bks-ai/projects/`.

> **Correção 2026-08-17:** "Allef" não é um projeto separado — era uma cópia antiga e
> duplicada do repo do **Layan** (rename `allef` → `layan` iniciado em 2026-08-05 e nunca
> concluído). `repos/backside/allef/` foi retirado por Fabio; `layan/` é o repo ativo. A
> ficha `_bks-ai/projects/allef.md` agora só aponta para `layan.md`.

## Como usar na prática

Desde 2026-08-17, a raiz do vault (`D:\Fabio\2b-projects`) é o ponto de entrada único —
`/brain`, `/new-project`, `/canonize`, `/prd` e `/review` rodam abrindo o Claude Code AQUI, não
mais dentro de `_bks-ai`.

Fluxo padrão de um projeto novo até a primeira feature:

1. `/brain` (raiz do vault) — carrega perfil, memória e contexto quente; diz onde paramos.
2. `/new-project <nome> <categoria>` (raiz do vault) — cria a estrutura, incluindo
   `docs/input/{scope,interviews,research,assets}/` para o material de pesquisa.
3. Traga o material bruto para `docs/input/` (manual) e rode `/canonize` (raiz do vault ou já
   no repo) quantas vezes precisar, até `docs/canonical/CONTEXT.md` estar bom.
4. `/prd` — gera `docs/canonical/PRD-{projeto}.md` a partir do CONTEXT.md.
5. `/spec` (**na raiz do repo do projeto**) — entrevista bks-sdd sobre o
   bounded context, citando o PRD/CONTEXT.md, e gera `FEAT-*.md` (e depois `TEST-*.md`) em
   `specs/features/` e `specs/tests/`. **Nunca implementa nesta etapa.**
6. `/arch` (na raiz do repo) — gera visão C4 (Mermaid) + README do repo a
   partir das specs.
7. `/loop` (na raiz do repo) — implementa via **LOOP-4**: máx. 4 tentativas,
   goals verificáveis (build limpo, testes verdes, cenários do TEST cobertos,
   código fiel ao `user_profile.md`). Na 5ª falha, PARA e gera
   `outputs/BLOQUEIO-*.md`.
8. `/save` (no repo ou no workbench) — roteia decisão do projeto → ADR **no
   repo**; decisão sobre o workbench → ADR no `_bks-ai`; progresso → `hot.md`;
   entregáveis → `outputs/` do repo; nota de sessão → `sessions/`.

Projeto **Alto/Crítico**: mudança em área sensível do manifesto exige
`/review` (raiz do vault, agente `reviewer`, invocação separada) antes de considerar a
entrega pronta. Ver seção 0 do `MANUAL-COMANDOS.md`.

Ciclo de conhecimento (quando estudo algo novo): jogo a fonte em
`knowledge/raw/` e peço "ingira `raw/...`" — o assistente cria/atualiza a
página na `wiki/` e registra em `index.md` + `log.md`.

## Convenções (inegociáveis)

- **Idioma:** nomes de pasta/arquivo em **inglês**; conversas e conteúdo em
  **PT-BR**; código em inglês (ou o que o repo definir).
- **Arquitetura:** Hexagonal BKS + DDD tático + Pipeline Orchestration + SEDA +
  TCP length-prefix. Detalhes em `_bks-ai/memory/`.
- **Qualidade:** SOLID, DRY, Object Calisthenics em toda revisão.
- **Segurança:** nunca gravar segredos, tokens ou dados de cliente na memória
  ou no repo do template público.
- **Encoding:** todos os arquivos em **UTF-8 sem BOM**, quebras `\n`.
- **`raw/` é imutável.** Só o humano curou as fontes; o assistente cura a wiki.
- **`Claude Code` — as duas únicas convenções fixas de fora:** arquivo de boot
  precisa se chamar exatamente `CLAUDE.md`; comandos slash vivem exatamente em
  `.claude/commands/`. Tudo o mais (nomes de pasta, de comando, de ficha) é
  livre — foi redefinido para o meu vocabulário em 2026-08-13.

## Estado atual

- Reestruturação de 2026-08-13 concluída: specs/decisões movidas do workbench
  para dentro de cada repo; `_AI/` renomeado para `_bks-ai/`; `docs/` traduzido
  para `{canonical,design,input,prompts,history}`.
- 4 projetos com pasta em `repos/` (bks-marine, terra-one, layan, nquantic), todos com
  ficha em `_bks-ai/projects/`. "Allef" era duplicata do Layan — corrigido em 2026-08-17.
- bks-marine é o projeto mais adiantado — usado como template de referência
  no `GUIA-OBSIDIAN-CLAUDE.md` e no `MANUAL-COMANDOS.md`.
- Template público (`bks-obsidian-2brains-ai-pattern`) em preparação: estrutura
  + templates + comandos + agentes + guia + manual, **sem** dado real de cliente.
- **Próximo passo:** gerar starter-kit sanitizado do bks-marine (skeleton
  vazio) e publicar o repo público.
