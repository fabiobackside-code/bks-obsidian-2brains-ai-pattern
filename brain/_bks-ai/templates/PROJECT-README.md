# {ProjectName}

> Categoria: {category} · Criado em {date} · Status: pesquisa
> Ficha no workbench: `brain/_bks-ai/projects/{project}.md`

Este README é o guia de uso DESTE projeto: onde entra material de apoio, como o contexto vira
canônico, como o canônico vira PRD, e como o PRD vira código via SDD. Leia isto antes de jogar
qualquer arquivo nas pastas.

## O ciclo de vida (pesquisa → canônico → PRD → SDD → código)

```
docs/input/  →  docs/design/  →  /canonize  →  docs/canonical/CONTEXT.md  →  /prd  →
docs/canonical/PRD-{project}.md  →  /spec  →  specs/  →  /loop  →  app/
```

Regra de ouro: **specs (`/spec`) só citam `docs/canonical/`** — nunca material bruto de
`docs/input/` ou rascunho de `docs/design/` diretamente. Se uma spec precisar de algo que só
existe no material bruto, é sinal de que o canônico está incompleto: rode `/canonize` de novo
antes de seguir.

## 1. Onde colocar material de apoio (fase de pesquisa)

| Você tem isto | Coloque em | Exemplo |
|---|---|---|
| Proposta, escopo, RFP do cliente | `docs/input/scope/` | `docs/input/scope/proposta-cliente-v1.pdf` |
| Entrevista, transcrição, respostas de formulário | `docs/input/interviews/` | `docs/input/interviews/entrevista-especialista-2026-08-17.md` |
| Artigo, benchmark, pesquisa externa ainda não classificada | `docs/input/research/` | `docs/input/research/analise-concorrentes.pdf` |
| Print, mockup, logo, imagem de referência | `docs/input/assets/` | `docs/input/assets/mockup-tela-login.png` |
| Sua própria análise, notas de reunião, escopo em rascunho | `docs/design/` | `docs/design/notas-arquitetura.md` |
| Conhecimento de domínio que o PRODUTO precisa saber (RAG) | `brain/knowledge/` | `brain/knowledge/normas-setor.pdf` |
| Código ou protótipo de referência (não é a solução final) | `app/` | `app/poc-langgraph/` |

`docs/input/` é sempre material bruto e imutável — não edite os arquivos lá dentro; se algo
ficar superado, mova para `docs/history/`.

> **Não é seu conhecimento técnico pessoal.** Hexagonal, DDD, TXC, .NET etc. moram só em
> `brain/knowledge/wiki/` do workbench (fora deste repo) — aqui só entra conhecimento de
> domínio DESTE produto.

## 2. Exemplos de prompt — alimentar o contexto

Com o Claude Code aberto neste repo (ou na raiz do vault, informando o projeto):

```
Leia tudo em docs/input/scope/ e docs/input/interviews/ e me diga, antes de eu rodar /canonize,
quais perguntas em aberto você já enxerga.
```

```
/canonize
```

```
Adicionei docs/input/interviews/entrevista-02.md com a resposta da pergunta sobre X. Rode
/canonize de novo e me mostre só o que mudou em relação à versão anterior do CONTEXT.md.
```

## 3. Exemplos de prompt — gerar PRD

```
/prd
```

```
O CONTEXT.md já está com status "revisado" e as perguntas em aberto do bloco de autenticação
foram fechadas. Rode /prd focando primeiro nas features de autenticação e onboarding.
```

## 4. Exemplos de prompt — documentos e apresentações (a partir do canônico)

```
Gere um documento executivo em outputs/apresentacao-executiva.md a partir de
docs/canonical/CONTEXT.md e docs/canonical/PRD-{project}.md — foco em problema, proposta de
valor, cronograma macro e investimento. Público: diretoria do cliente, não-técnico.
```

```
Gere um documento técnico de arquitetura em outputs/arquitetura-tecnica.md a partir de
docs/canonical/ e specs/features/ já aprovadas — inclua diagrama C4 de contexto (Mermaid) e as
decisões já fixadas em decisions/.
```

```
Monte uma apresentação de kickoff em outputs/kickoff.md, com slides em markdown, resumindo o
PRD para o time técnico que vai implementar.
```

(Para slides de verdade em `.pptx`/`.html`, peça explicitamente o formato — o agente usa a
skill de apresentação/documento disponível.)

## 5. Do PRD para o código (SDD)

1. `/spec` (nesta raiz) — entrevista sobre UM bounded context por vez, gera
   `specs/features/FEAT-*.md` citando o PRD/CONTEXT.md; depois de aprovado, gera
   `specs/tests/TEST-*.md`. Nunca implementa aqui.
2. `/arch` — gera visão C4 (Mermaid) em `outputs/ARCH-{project}.md` a partir das specs
   aprovadas.
3. `/loop` — implementa via protocolo LOOP-4 (máx. 4 tentativas, goals verificáveis) em `app/`.
4. `/save` — fecha a sessão: ADR em `decisions/`, progresso no `hot.md` do workbench, nota de
   sessão.

Projeto marcado Alto/Crítico na ficha (`brain/_bks-ai/projects/{project}.md`): mudança em área
sensível exige `/review` (na raiz do vault) antes de considerar a entrega pronta.

## 6. Todos os comandos, num lugar só

| Comando | Onde rodar | Faz |
|---|---|---|
| `/brain` | raiz do vault (`2b-projects`) | retoma a sessão |
| `/new-project` | raiz do vault | cria um projeto novo |
| `/canonize` | raiz do vault ou deste repo | consolida `docs/input/`+`docs/design/` → `docs/canonical/CONTEXT.md` |
| `/prd` | raiz do vault ou deste repo | gera `docs/canonical/PRD-{project}.md` a partir do CONTEXT.md |
| `/review` | raiz do vault | revisão de segurança (projeto Alto/Crítico) |
| `/spec` | **este repo** | gera FEAT/TEST a partir do canônico |
| `/arch` | **este repo** | gera visão C4 (Mermaid) |
| `/loop` | **este repo** | implementa via LOOP-4 |
| `/save` | **este repo** ou workbench | fecha a sessão, grava decisão/progresso |

Guia completo (conceito + passo a passo): `GUIA-OBSIDIAN-CLAUDE.md` na raiz do vault.
Referência rápida de todo comando: `MANUAL-COMANDOS.md` na raiz do vault.
