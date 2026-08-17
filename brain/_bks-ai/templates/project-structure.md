# Padrão de organização de projeto (2b-projects)

Padrão canônico (revisado 2026-08-17 — comandos em inglês, ciclo pesquisa→canônico→PRD→SDD
explícito). Aplique a QUALQUER projeto novo, sempre via `/new-project` (raiz do vault). Idioma
dos nomes de arquivo/pasta: inglês. Conteúdo/conversa: PT-BR. Código: inglês (ou o que o repo
definir).

## Estrutura canônica

```
repos/{category}/{project}/            ← category: backside | w3 | private
├── CLAUDE.md            boot da sessão: manda ler o segundo cérebro (ver abaixo)
├── README.md            gerado a partir de templates/PROJECT-README.md — ciclo de vida,
│                        onde entra material de apoio, exemplos de prompt
├── HOW-TO-WORK.md       guia simples: pesquisa → canônico → PRD → SDD → código
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
├── outputs/               entregáveis: ARCH-*.md, apresentações, documentos executivos/técnicos
└── docs/                 documentação por CICLO DE VIDA:
    ├── input/              MATERIAL BRUTO, imutável, por tipo:
    │   ├── scope/            proposta, RFP, escopo do cliente
    │   ├── interviews/       entrevistas, transcrições, respostas de formulário
    │   ├── research/         artigos, benchmarks, pesquisa externa ainda não classificada
    │   └── assets/           prints, mockups, logos, imagens de referência
    ├── design/              bancada ATIVA: sua análise, notas, escopo em rascunho
    ├── canonical/            CONTEXT.md (fonte única vigente) + PRD-{project}.md — gerados
    │                        por /canonize e /prd, nunca editados à mão sem versionar
    ├── prompts/              prompt/critério de cada rodada de /canonize (auditoria)
    └── history/              versões superadas de CONTEXT.md/PRD.md (nunca fonte de verdade)
```

No workbench (fora do repo, compartilhado entre projetos):
```
brain/_bks-ai/projects/{project}.md          ← ficha do projeto (aponta pro repo)
brain/_bks-ai/decisions/ADR-NNN.md           ← decisões SOBRE O WORKBENCH EM SI (raro)
```

## O ciclo de vida do conteúdo (novo, explícito desde 2026-08-17)

```
docs/input/ + docs/design/  --/canonize-->  docs/canonical/CONTEXT.md  --/prd-->
docs/canonical/PRD-{project}.md  --/spec-->  specs/  --/loop-->  app/
```

`/spec` só pode citar `docs/canonical/` — nunca `docs/input/` ou `docs/design/` direto. Se
faltar algo no canônico para especificar uma feature, rode `/canonize` de novo em vez de
"emprestar" do material bruto.

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

## Comandos e onde rodam

| Comando | Onde | Faz |
|---|---|---|
| `/brain` | raiz do vault | retoma a sessão |
| `/new-project` | raiz do vault | cria a estrutura acima |
| `/canonize` | raiz do vault ou do repo | `docs/input/`+`docs/design/` → `docs/canonical/CONTEXT.md` |
| `/prd` | raiz do vault ou do repo | `docs/canonical/CONTEXT.md` → `docs/canonical/PRD-*.md` |
| `/spec` | raiz do repo | PRD/CONTEXT.md → `specs/features/` → `specs/tests/` |
| `/arch` | raiz do repo | specs → `outputs/ARCH-*.md` (C4/Mermaid) |
| `/loop` | raiz do repo | implementa via LOOP-4 |
| `/save` | raiz do repo ou workbench | ADR, `hot.md`, nota de sessão |
| `/review` | raiz do vault | revisão de segurança (Alto/Crítico) |

## Receita para aplicar (o que o /new-project faz)

1. Criar as pastas listadas acima.
2. Criar wiring: `CLAUDE.md` (boot), `README.md` (a partir de `templates/PROJECT-README.md`),
   `HOW-TO-WORK.md`, `.gitignore`.
3. Criar `brain/_bks-ai/projects/{proj}.md` (ficha apontando para o repo, status: pesquisa).
4. NÃO trazer material bruto nem iniciar git — passos manuais do usuário.
5. Depois, manualmente: trazer material para `docs/input/{scope,interviews,research,assets}/`,
   rodar `/canonize`, revisar `docs/canonical/CONTEXT.md`, rodar `/prd`, e só então `/spec`.
6. Git: inicializar **nativo no Windows**, dentro do próprio `repos/{cat}/{proj}/`.
7. Registrar no `hot.md` e no `CONTEXT.md` se for um projeto ativo.
