---
tipo: manual
atualizado: 2026-08-13
---
# Manual de Comandos — 2b-projects

Referência única de todo comando disponível no seu workbench: o que faz, quando usar, o que
produz, e um exemplo real. Complementa o `GUIA-OBSIDIAN-CLAUDE.md` (que explica o fluxo geral) —
este arquivo é para consulta rápida durante o trabalho.

Convenção: `/brain`, `/novo-projeto` e `/revisao` rodam com o Claude Code aberto em
`brain/_bks-ai` — `/spec`, `/arch` e `/loop` rodam **na raiz do repo** do projeto (desde
2026-08-13, specs e decisões moram no próprio repo, não mais no workbench).

---

## 1. Comandos do workbench (dia a dia)

### `/brain`
**Faz:** carrega `user_profile.md` + `MEMORY.md` + `hot.md` + última nota de sessão; resume em
~5 linhas quem você é, onde parou, próximo passo.
**Onde rodar:** `brain/_bks-ai`.
**Quando:** primeira coisa de toda sessão.
**Produz:** um resumo em texto — nenhum arquivo.
**Exemplo:**
```
/brain
→ "Você é o Arquiteto Sênior BKS. Projeto ativo: bks-marine (backside, criticidade padrão),
   fase design. Última sessão: aprovamos a stack .NET 10 + Supabase.
   Próximo passo: aprovar o FEAT-autenticacao e gerar o TEST."
```

### `/novo-projeto <nome> <categoria>`
**Faz:** cria a estrutura canônica do projeto (`app/`, `brain/`, `specs/{features,tests,tasks}/`,
`decisions/`, `docs/{...}`) + wiring (`CLAUDE.md`, `README.md`, `HOW-TO-WORK.md`, `.gitignore`) +
ficha em `_bks-ai/projects/`.
**Onde rodar:** `brain/_bks-ai`.
**Quando:** iniciar um projeto do zero.
**Produz:** árvore completa em `repos/{categoria}/{nome}/` (specs e decisions já dentro do repo)
+ `_bks-ai/projects/{nome}.md`.
**Exemplo:**
```
/novo-projeto bks-marine backside
→ cria repos/backside/bks-marine/... (com specs/ e decisions/ próprios) e
  _bks-ai/projects/bks-marine.md
```

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

---

## 2. Comandos de governança multi-agente

Adaptados do repositório `bks-multiagent-skill` (DiegoAmorimDev, MIT) para o vocabulário BKS.
Ativam quando um projeto é marcado **Alto** ou **Crítico** (campo `criticidade` na ficha
`_bks-ai/projects/{projeto}.md`). Em projeto **Padrão** (ex.: bks-marine hoje), são opcionais.

### `/revisao`
**Faz:** dispara o agente `reviewer` (Opus, read-only) em **invocação separada** de quem
implementou, aplicando `_bks-ai/references/checklist-revisao-critica.md` contra a entrega. Nunca
quem escreveu o código revisa a si mesmo — segregação de função.
**Onde rodar:** `_bks-ai` (mas avalia entrega de qualquer repo).
**Quando:** antes de aprovar qualquer entrega que toca uma "área sensível" declarada no manifesto
do projeto (`{repo}/.claude/multiagente.md`) — auth, dinheiro, dado regulado, isolamento
multi-tenant, webhook.
**Pré-requisito:** o projeto precisa ter `{repo}/.claude/multiagente.md` preenchido a partir de
`_bks-ai/templates/manifesto-projeto.md`. Sem manifesto, `/revisao` orienta a criar um antes.
**Produz:** lista de achados (`arquivo:linha`, problema, exploração, severidade) ou declaração
explícita do escopo verificado, se nada foi encontrado.
**Exemplo (cenário hipotético, adaptado do exemplo-fintech do repo original):**
```
/revisao
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
3. A partir daí, `/revisao` é obrigatório antes de aprovar entrega em área sensível.

**Exemplo de projeto candidato:** NQuantic (w3) — bancário, já usa TXC com dado contábil. Ainda
não tem o manifesto preenchido (fica no backlog).

---

## 3. Comandos da skill `bks-sdd` (fluxo completo, para produtos maiores)

Ver seção 7.3 do `GUIA-OBSIDIAN-CLAUDE.md` para a tabela completa
(`/bks-sdd`, `--prd`, `--project`, `--project-plan`, `--feature`, `--feature-tests`,
`--feature-task`, `--continue`, `--tan`). Use quando o produto é grande e você quer PRD + PLAN +
rastro de TASKS com memória de sessão (`workspace-*`); use `/spec` quando já sabe a feature.

---

## 4. Tabela-resumo (cola rápida)

| Comando | Onde rodar | Pré-requisito | Produz |
|---|---|---|---|
| `/brain` | `_bks-ai` | — | resumo da sessão |
| `/novo-projeto` | `_bks-ai` | nome + categoria | estrutura + wiring + ficha |
| `/spec` | **repo** | projeto existente | `specs/features/FEAT-*` → `specs/tests/TEST-*` |
| `/arch` | **repo** | specs aprovadas | `outputs/ARCH-*` (C4) + README |
| `/loop` | **repo** | FEAT+TEST aprovados | código + testes ou `outputs/BLOQUEIO-*` |
| `/save` | `_bks-ai` ou repo | — | `decisions/ADR-*`, `hot.md`, `outputs/`, sessão |
| `/revisao` | `_bks-ai` | manifesto preenchido | achados de segurança ou OK |
