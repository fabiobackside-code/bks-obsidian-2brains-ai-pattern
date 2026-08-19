---
tipo: manual
atualizado: 2026-08-17
---
# Manual de Comandos — 2b-projects

Referência única de todo comando disponível no seu workbench: o que faz, quando usar, o que
produz, e um exemplo real. Complementa o `GUIA-OBSIDIAN-CLAUDE.md` (que explica o fluxo geral) —
este arquivo é para consulta rápida durante o trabalho.

Convenção (revisada 2026-08-17): `/brain`, `/new-project`, `/canonize`, `/prd` e `/review` rodam
com o Claude Code aberto na **raiz do vault** (`D:\Fabio\2b-projects`) — é o único lugar onde
você precisa abrir sessão para retomar, começar um projeto novo, ou consolidar pesquisa em
contexto/PRD. `/spec`, `/arch`, `/loop` e `/save` rodam **na raiz do repo** do projeto — só
entra lá quando for de fato especificar ou codar.

> Nomes antigos (`/novo-projeto`, `/revisao`) foram renomeados para inglês e movidos para a
> raiz do vault; se você digitar o nome antigo em `_bks-ai`, ele aponta pro novo.

---

## 0. Comandos da raiz do vault (ponto de entrada único)

### `/brain`
**Faz:** carrega `memory/user_profile.md` + `memory/MEMORY.md` + `memory/hot.md` + última nota
de sessão; resume em ~5 linhas quem você é, onde parou, próximo passo.
**Onde rodar:** raiz do vault (`D:\Fabio\2b-projects`).
**Quando:** primeira coisa de toda sessão.
**Produz:** um resumo em texto — nenhum arquivo.
**Exemplo:**
```
/brain
→ "Você é o Arquiteto Sênior BKS. Projeto ativo: bks-marine (backside), fase design.
   Última sessão: montei a estrutura e aprovamos a stack .NET 10 + Supabase.
   Próximo passo: revisar/aprovar o FEAT-autenticacao e gerar o TEST."
```

### `/new-project <nome> <categoria>`
**Faz:** cria a estrutura canônica do projeto — `app/`, `brain/`, `specs/{features,tests,
tasks}/`, `decisions/`, `outputs/`, `docs/input/{scope,interviews,research,assets}/`,
`docs/design/`, `docs/canonical/`, `docs/prompts/`, `docs/history/` — mais `CLAUDE.md`,
`README.md` (com exemplos de prompt), `HOW-TO-WORK.md`, `.gitignore`, e a ficha em
`_bks-ai/projects/`.
**Onde rodar:** raiz do vault.
**Quando:** iniciar um projeto do zero. É o **único** comando de criação — substitui o antigo
`/novo-projeto`.
**Produz:** árvore completa em `repos/{categoria}/{nome}/` + `_bks-ai/projects/{nome}.md`.
**Exemplo:**
```
/new-project bks-marine backside
→ cria repos/backside/bks-marine/... e _bks-ai/projects/bks-marine.md; próximo passo sugerido:
  "traga material para docs/input/ e rode /canonize"
```

### `/canonize`
**Faz:** lê tudo em `docs/input/` + `docs/design/` do projeto e consolida em
`docs/canonical/CONTEXT.md` (com frontmatter versionado, fontes citadas, e
`> [!uncertain]` nas divergências — nunca inventa para fechar lacuna). Se já existir um
CONTEXT.md, arquiva a versão anterior em `docs/history/` antes de sobrescrever.
**Onde rodar:** raiz do vault (informe o projeto) ou já dentro do repo dele.
**Quando:** depois de acumular material de pesquisa suficiente, e sempre que adicionar material
novo relevante (rodar de novo é normal e esperado).
**Produz:** `docs/canonical/CONTEXT.md` + `docs/prompts/prompt-canonize-*.md`.
**Exemplo:**
```
/canonize
→ lê docs/input/scope/proposta.pdf + docs/input/interviews/entrevista-01.md, gera
  docs/canonical/CONTEXT.md v1 com 3 perguntas em "## Perguntas em aberto"
```

### `/prd`
**Faz:** lê `docs/canonical/CONTEXT.md` e gera `docs/canonical/PRD-{projeto}.md` — Problema,
Objetivo, Usuários, Escopo, Requisitos funcionais/não-funcionais, Fases, Riscos. Todo requisito
rastreia de volta ao CONTEXT.md; nunca inventa requisito sem base nele.
**Onde rodar:** raiz do vault (informe o projeto) ou já dentro do repo dele.
**Pré-requisito:** `docs/canonical/CONTEXT.md` já existe (rodou `/canonize` antes).
**Quando:** contexto já revisado, pronto para virar requisito formal — a partir daqui, `/spec`
só cita `docs/canonical/`.
**Produz:** `docs/canonical/PRD-{projeto}.md`.
**Exemplo:**
```
/prd
→ gera docs/canonical/PRD-bks-marine.md a partir do CONTEXT.md v2; aponta 2 perguntas em
  aberto que ainda bloqueiam o requisito de auditoria
```

---

## 1. Comandos do repo do projeto (fase de código)

### `/spec`
**Faz:** entrevista bks-sdd sobre um bounded context (entidades, operações, integrações,
critérios de aceite verificáveis); gera a `FEAT-[nome].md`. Depois de aprovada, gera a
`TEST-[nome].md`.
**Onde rodar:** **raiz do repo do projeto** (não mais em `_bks-ai`).
**Quando:** especificar uma feature nova. Uma por vez — nunca implementa aqui.
**Produz:** `{repo}/specs/features/FEAT-*.md` e, após aprovação, `{repo}/specs/tests/TEST-*.md`.
**Exemplo real (já feito no bks-marine):**
```
/spec
→ "Qual o bounded context?" — Identidade & Acesso
→ "Auth própria ou gerenciada?" — própria no .NET
→ gera specs/features/FEAT-autenticacao.md (status: Rascunho)
```

### `/arch [projeto]`
**Faz:** lê as specs aprovadas (do próprio repo) e gera a visão de arquitetura: C4 (Contexto/
Container/Componente) em Mermaid, mapa de bounded contexts, decisões de pipeline/SEDA, contrato
TCP se houver.
**Onde rodar:** **raiz do repo do projeto**.
**Quando:** depois de ter specs aprovadas, antes ou durante a implementação.
**Produz:** `{repo}/outputs/ARCH-{projeto}.md` + `README.md` do repo.
**Exemplo:**
```
/arch bks-marine
→ outputs/ARCH-bks-marine.md com C4 mostrando App RN + Painel React → API .NET 10 → Supabase
```

### `/loop`
**Faz:** implementa a task atual sob o protocolo **LOOP-4** — no máx. 4 tentativas; a cada
rodada roda `dotnet build; dotnet test` e audita os goals (build limpo, testes verdes, cenários
do TEST cobertos, código fiel ao `user_profile.md`). Falhou 4x → gera `BLOQUEIO-*.md` e para.
**Onde rodar:** **raiz do repo do projeto**.
**Quando:** fase de código.
**Produz:** código + testes; ou `outputs/BLOQUEIO-[task].md`.
**Exemplo:**
```
/loop
→ tentativa 1: implementa AutenticarUsuario, roda build+test, G3 (cenários do TEST) falha
→ tentativa 2: corrige o hash bcrypt, todos os goals passam → conclui, roda /save
```

### `/save`
**Faz:** roteia o resultado da sessão pela regra dos dois lugares — decisão sobre o projeto →
`{repo}/decisions/ADR-NNN.md`; decisão sobre o workbench (rara) → `_bks-ai/decisions/ADR-NNN.md`;
specs novas/alteradas → `{repo}/specs/`; progresso → `_bks-ai/memory/hot.md`; entregáveis →
`{repo}/outputs/`; nota de sessão → `_bks-ai/sessions/sessao-YYYY-MM-DD.md`.
**Onde rodar:** `_bks-ai` ou o repo — funciona nos dois.
**Quando:** ao fechar a sessão, ou após qualquer marco (feature aprovada, task concluída).
**Produz:** os arquivos acima, listados no chat antes de finalizar.
**Exemplo:**
```
/save
→ "Gravei ADR-003 em decisions/ (stack .NET 10 + Supabase), atualizei hot.md,
   criei sessions/sessao-2026-08-12.md"
```

### `/ingest <fonte>`
**Faz:** ingere UMA fonte (PDF, artigo `.md`, página `.html` salva, transcrição de vídeo, link
direto) ou um LOTE (`tools/batch-ingest.md`, ou a pasta inteira `raw/_inbox/`) para dentro da
wiki curada, com frontmatter YAML padronizado.
**Onde rodar:** `brain/knowledge` (Claude Code aberto ali — **não** dentro de `_bks-ai` nem do
repo de um projeto).
**Escopo — não confundir:** este comando alimenta **seu** conhecimento técnico pessoal
(compartilhado entre todos os projetos). Material de domínio de UM projeto específico não passa
por aqui — vai direto para `repos/{cat}/{proj}/brain/` (organizado à mão, ou com um `/ingest`
próprio se você copiar o comando para dentro do repo do projeto).
**Quando:** sempre que estudar algo novo (artigo, vídeo, doc técnico) que vale virar página
permanente da wiki.
**Produz:** página(s) em `brain/knowledge/wiki/{categoria}/`, registro em `wiki/index.md` e
`wiki/log.md`.
**Exemplo:**
```
/ingest raw/papers/hexagonal-architecture.pdf
→ cria wiki/architecture/hexagonal-architecture.md, registra em index.md e log.md

/ingest raw/_inbox/
→ classifica cada arquivo da pasta pela extensão, ingere um a um, resume:
  "✓ 4 processados, ✗ 1 falhou: video.mp4 (falta transcrição)"
```
Detalhamento completo (todos os tipos de fonte, exemplo de lote): seção 10 do
`GUIA-OBSIDIAN-CLAUDE.md`.

---

## 2. Comandos de governança multi-agente

Adaptados do repositório `bks-multiagent-skill` (DiegoAmorimDev, MIT) para o vocabulário BKS.
Ativam quando um projeto é marcado **Alto** ou **Crítico** (campo `criticidade` na ficha
`_bks-ai/projects/{projeto}.md`). Em projeto **Padrão** (ex.: bks-marine hoje), são opcionais.

### `/review`
**Faz:** dispara o agente `reviewer` (Opus, read-only) em **invocação separada** de quem
implementou, aplicando `_bks-ai/references/checklist-revisao-critica.md` contra a entrega. Nunca
quem escreveu o código revisa a si mesmo — segregação de função.
**Onde rodar:** raiz do vault (informe qual repo revisar — avalia entrega de qualquer repo).
**Quando:** antes de aprovar qualquer entrega que toca uma "área sensível" declarada no manifesto
do projeto (`{repo}/.claude/multiagente.md`) — auth, dinheiro, dado regulado, isolamento
multi-tenant, webhook.
**Pré-requisito:** o projeto precisa ter `{repo}/.claude/multiagente.md` preenchido a partir de
`_bks-ai/templates/manifesto-projeto.md`. Sem manifesto, `/review` orienta a criar um antes.
**Produz:** lista de achados (`arquivo:linha`, problema, exploração, severidade) ou declaração
explícita do escopo verificado, se nada foi encontrado.
**Exemplo (cenário hipotético, adaptado do exemplo-fintech do repo original):**
```
/review
→ dashboard_query.go:88
   Problema: query de agregação não filtra por InquilinoId
   Exploração: qualquer usuário autenticado vê o somatório de todos os inquilinos
   Severidade: crítica
→ bloqueia a entrega; correção vai para o builder, em invocação separada
```

### Os 4 perfis (`_bks-ai/agents/`) — como se relacionam com o que você já usa
| Perfil novo | Equivale a | O que ele acrescenta |
|---|---|---|
| `planner` (Sonnet) | seu `/spec` | vínculo formal ao log de decisões antes de propor |
| `builder` (Sonnet) | seu `/loop` | proibição explícita de tocar zona de contenção |
| **`reviewer` (Opus)** | **não existia** | revisão com viés zero, checklist de segurança |
| `scribe` (Haiku) | parte do seu `/save` | regra dura: nunca afirma teste sem evidência |

Ordem dentro de uma entrega: `planner → builder → reviewer → scribe` — são dependentes,
**nunca** rodam em paralelo entre si.

### Como ativar num projeto
1. Marcar `criticidade: alto` ou `criticidade: critico` na ficha `_bks-ai/projects/{projeto}.md`.
2. Copiar `_bks-ai/templates/manifesto-projeto.md` para `{repo}/.claude/multiagente.md` e preencher:
   zonas de contenção, recursos numerados, áreas sensíveis, invariantes do domínio.
3. A partir daí, `/review` é obrigatório antes de aprovar entrega em área sensível.

**Exemplo de projeto candidato:** NQuantic (w3) — bancário, já usa TXC com dado contábil. Ainda
não tem o manifesto preenchido (fica no backlog).

---

## 3. Comandos da skill `bks-sdd` (fluxo completo, para produtos maiores)

Ver seção 7.3 do `GUIA-OBSIDIAN-CLAUDE.md` para a tabela completa
(`/bks-sdd`, `--prd`, `--project`, `--project-plan`, `--feature`, `--feature-tests`,
`--feature-task`, `--continue`, `--tan`). Use quando o produto é grande e você quer PRD + PLAN +
rastro de TASKS com memória de sessão (`workspace-*`); use `/spec` quando já sabe a feature.

> **Não confunda com o `/prd` da seção 0.** `/prd` é rápido e sempre parte de
> `docs/canonical/CONTEXT.md` já consolidado — é o caminho padrão para a maioria dos projetos.
> `bks-sdd --prd` é o fluxo pesado da skill, com PLAN + rastro de TASKS — vale para produto
> grande com decomposição formal. Os dois geram PRD; a diferença é profundidade e memória de
> sessão.

---

## 4. Tabela-resumo (cola rápida)

| Comando | Onde rodar | Pré-requisito | Produz |
|---|---|---|---|
| `/brain` | raiz do vault | — | resumo da sessão |
| `/new-project` | raiz do vault | nome + categoria | estrutura + wiring + ficha |
| `/canonize` | raiz do vault ou repo | `docs/input/`/`docs/design/` com material | `docs/canonical/CONTEXT.md` |
| `/prd` | raiz do vault ou repo | `CONTEXT.md` consolidado | `docs/canonical/PRD-*.md` |
| `/spec` | **repo** | PRD/CONTEXT.md | `specs/features/FEAT-*` → `specs/tests/TEST-*` |
| `/arch` | **repo** | specs aprovadas | `outputs/ARCH-*` (C4) + README |
| `/loop` | **repo** | FEAT+TEST aprovados | código + testes ou `outputs/BLOQUEIO-*` |
| `/save` | repo ou workbench | — | `decisions/ADR-*`, `hot.md`, `outputs/`, sessão |
| `/ingest` | `brain/knowledge` | fonte ou lote | página(s) em `wiki/`, `index.md`, `log.md` |
| `/review` | raiz do vault | manifesto preenchido | achados de segurança ou OK |
