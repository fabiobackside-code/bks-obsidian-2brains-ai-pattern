# Padrão de organização de projeto (2b-projects)

Padrão canônico (2026-08-13). Aplique a QUALQUER projeto novo. Idioma dos nomes de
arquivo/pasta: inglês. Conteúdo/conversa: PT-BR. Código: inglês (ou o que o repo definir).

## Estrutura canônica

```
repos/{category}/{project}/            ← category: backside | w3 | private
├── CLAUDE.md            boot da sessão: manda ler o segundo cérebro (ver abaixo)
├── README.md            o que é, estado, como rodar
├── HOW-TO-WORK.md       guia simples de uso (fase design → fase código)
├── .gitignore           node_modules, .env, binários/PDFs pesados, backups
├── app/                 CÓDIGO (ou material de apoio/referência)
├── brain/               CÉREBRO DE DOMÍNIO do produto (o que ele sabe)
│   ├── knowledge/       fontes de RAG (curadas)
│   └── methodology/     conhecimento canônico do domínio
├── specs/                bks-sdd — SOBRE este projeto
│   ├── features/          FEAT-*.md
│   ├── tests/              TEST-*.md
│   └── tasks/                TASK-*.md
├── decisions/            ADR-NNN.md — decisões DESTE projeto (stack, arquitetura)
└── docs/                 documentação por CICLO DE VIDA:
    ├── canonical/         a verdade VIGENTE (vN) — fonte única
    ├── design/            bancada ATIVA: notas, escopo-produto, arquitetura-macro,
    │                      fluxos, decisoes-abertas
    ├── input/              entradas brutas (entrevistas, respostas) a conciliar
    ├── prompts/            prompts de refinamento (o que gera o canônico)
    └── history/            versões superadas (nunca fonte de verdade)
```

No workbench (fora do repo, compartilhado entre projetos):
```
brain/_bks-ai/projects/{project}.md          ← ficha do projeto (aponta pro repo)
brain/_bks-ai/decisions/ADR-NNN.md           ← decisões SOBRE O WORKBENCH EM SI (raro)
```

## Regra dos dois lugares

- **É sobre este projeto** (specs, ADR de stack/arquitetura, código, docs) →
  mora no repo dele: `repos/{cat}/{proj}/`.
- **É sobre como eu trabalho** (memória, perfis de agente, templates, decisão sobre
  o workbench em si) → mora em `brain/_bks-ai/`. Compartilhado entre TODOS os projetos.

## Regra dos dois cérebros (dentro do repo)

- **Dev/arquitetura (meu, compartilhado):** `brain/_bks-ai/` — COMO construir.
- **Domínio (do produto):** `{repo}/brain/` — O QUE o produto sabe.
O repo consulta o meu; o meu não sabe do domínio específico.

## Boot do CLAUDE.md do repo (obrigatório)

No topo, mandar carregar por caminho absoluto:
`brain/_bks-ai/memory/user_profile.md`, `bks-premises.md`, `hot.md`,
`brain/_bks-ai/projects/{project}.md`, e as skills BKS aplicáveis. Depois o domínio
(`{repo}/brain/`).

## Receita para aplicar a um projeto novo (checklist)

1. Criar pastas: `repos/{cat}/{proj}/{app, brain/knowledge, brain/methodology,
   specs/{features,tests,tasks}, decisions, docs/{canonical,design,input,prompts,history}}`.
2. Trazer material existente:
   - código/experimentos → `app/`
   - fontes de conhecimento/RAG → `brain/knowledge/`
   - metodologia canônica → `brain/methodology/`
   - entrevistas/respostas brutas → `docs/input/`
   - prompts de refinamento → `docs/prompts/`
   - escopo/arquitetura vigentes → `docs/canonical/`
   - versões antigas → `docs/history/`
3. Criar wiring: `CLAUDE.md` (boot), `README.md`, `HOW-TO-WORK.md`, `.gitignore`.
4. Seedar `docs/design/`: notas, escopo-produto, arquitetura-macro, fluxos,
   decisoes-abertas.
5. Workbench: criar `brain/_bks-ai/projects/{proj}.md` (ficha apontando para o repo).
6. Git: inicializar **nativo no Windows** (nunca pelo ambiente Linux), dentro do
   próprio `repos/{cat}/{proj}/`.
7. Registrar no `hot.md` e no CONTEXT.md se for um projeto ativo.

## Fluxo de trabalho (igual em todos)

Design em `docs/design/` → decisão firma → **ADR** em `{repo}/decisions/` →
escopo vira **FEAT/TEST/TASK** em `{repo}/specs/...` (`/spec`) → implementa **LOOP-4**
(`/loop`, na raiz do repo) → `/save`. Canônico sempre em `docs/canonical/`.
