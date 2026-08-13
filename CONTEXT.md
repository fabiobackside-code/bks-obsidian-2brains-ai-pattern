# CONTEXT — bks-obsidian-2brains-ai-pattern

> Ponto de entrada do template. Leia isto ANTES de qualquer sessão de trabalho,
> depois personalize para o seu caso.

## Propósito

Transformar conhecimento e padrões pessoais de desenvolvimento em um sistema
persistente que guia a construção de aplicações com IA. Objetivos:

- **Assertividade** — decisões ancoradas na wiki e nas specs, não em achismo.
- **Anti-alucinação** — o assistente consulta a base curada antes de gerar;
  o que for incerto é marcado `> [!uncertain]`, nunca chutado.
- **Menos tokens** — conteúdo curto, bem delimitado e cruzado por links.

## Os dois cérebros

1. **`brain/knowledge/` — cérebro de conhecimento (estudo).**
   Base de conhecimento no padrão "Karpathy LLM Wiki". Fontes imutáveis em
   `raw/`, páginas curadas com frontmatter YAML em `wiki/`. Vem vazio neste
   template — popule com o seu próprio material de estudo.

2. **`brain/_bks-ai/` — cérebro de trabalho (workbench / gêmeo profissional).**
   O assistente configurado como gêmeo profissional: Arquiteto Sênior. Aqui
   ficam memória, perfis de agente, templates e comandos que produzem código
   para os seus repositórios. Regras em `_bks-ai/CLAUDE.md`.

Regra de ouro: **o cérebro de trabalho consulta o cérebro de conhecimento.**

## A regra dos dois lugares

Specs e decisões de cada projeto moram **no repositório dele**, não no workbench:

- **É sobre este projeto** (specs FEAT/TEST/TASK, ADR de stack/arquitetura,
  código, docs) → mora em `repos/{categoria}/{projeto}/`.
- **É sobre como você trabalha** (memória, perfis de agente, templates, decisão
  sobre o workbench em si) → mora em `brain/_bks-ai/`. Compartilhado entre
  todos os projetos.

## Estrutura de diretórios

```text
.
├── CONTEXT.md
├── GUIA-OBSIDIAN-CLAUDE.md
├── MANUAL-COMANDOS.md
├── brain\
│   ├── knowledge\              # cérebro de conhecimento (vazio — popule você)
│   └── _bks-ai\                    # cérebro de trabalho
│       ├── CLAUDE.md
│       ├── memory\             # user_profile, dotnet-standards, calisthenics,
│       │                       #   seda-tcp, knowledge-base, hot, MEMORY (índice)
│       ├── projects\           # fichas de projeto (vazio)
│       ├── templates\          # ADR, FEAT, REPO-CLAUDE, project-structure, manifesto
│       ├── agents\              # builder / reviewer / planner / scribe
│       ├── references\           # checklist-revisao-critica
│       ├── outputs\, sessions\, inbox\, archive\
│       └── .claude\commands\         # /brain /spec /arch /loop /save /novo-projeto /revisao
└── repos\                      # seus repositórios reais (git), um por projeto
    └── backside\bks-marine\      # ESQUELETO DE EXEMPLO — vazio de propósito
```

## Convenções (inegociáveis)

- **Claude Code (as duas únicas fixas):** arquivo de boot chama-se exatamente
  `CLAUDE.md`; comandos slash vivem exatamente em `.claude/commands/`.
- **Idioma:** nomes de pasta/arquivo em inglês; conversa/conteúdo no idioma que
  você preferir (o autor original usa PT-BR); código em inglês.
- **Arquitetura-base (ajustável):** Hexagonal + DDD tático + Pipeline
  Orchestration + SEDA + TCP length-prefix. Detalhes em `_bks-ai/memory/`.
- **Segurança:** nunca gravar segredos, tokens ou dados de cliente na memória
  ou no repo deste template.
- **Encoding:** UTF-8 sem BOM, quebras `\n`.

## Primeiros passos

1. Abra esta pasta como vault no Obsidian.
2. Leia `GUIA-OBSIDIAN-CLAUDE.md` — passo a passo completo, com exemplo real.
3. Ajuste `brain/_bks-ai/memory/user_profile.md` e `bks-premises.md` para o seu
   próprio jeito de trabalhar.
4. Rode `/novo-projeto <nome> <categoria>` para criar seu primeiro projeto.
