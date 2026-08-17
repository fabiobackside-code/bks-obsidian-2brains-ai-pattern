# bks-obsidian-2brains-ai-pattern

> Um padrão de **segundo cérebro para engenharia de software assistida por IA**:
> Obsidian como camada de conhecimento pessoal (PKM), Claude Code como agente que lê
> e escreve nesse conhecimento, e um método de desenvolvimento orientado a
> especificação (spec-driven) com governança multi-agente para manter o sistema
> confiável à medida que cresce.

Este documento assume que você já tem uma noção do que são **SDD (Spec-Driven
Development)**, **agentes de IA para codificação** e o **Claude Code**. Se esses
termos são novos, vale ler as referências da seção 8 antes de seguir — elas
explicam cada peça na fonte original.

---

## 1. O problema que isso resolve

Programar com um agente de IA como o Claude Code é poderoso, mas tem uma falha
recorrente sem estrutura: **o agente não tem memória entre sessões, e sem uma
fonte de verdade explícita ele preenche lacunas com suposição — o que chamamos
de alucinação.** Isso piora à medida que o número de projetos cresce: você
reexplica contexto, o agente decide arquitetura "no chute", e decisões
importantes se perdem entre conversas.

A resposta não é um prompt melhor. É dar ao agente uma **base de conhecimento
persistente e navegável** (o segundo cérebro) e um **processo formal antes de
codificar** (spec-driven development), com **memória entre sessões** (arquivos
`.md` versionados, não o histórico de chat) e, para os casos de maior risco,
**segregação de função entre quem implementa e quem revisa** (governança
multi-agente).

## 2. O conceito: segundo cérebro aplicado a engenharia

"Segundo cérebro" é um conceito de gestão de conhecimento pessoal (PKM) — a
ideia de externalizar pensamento e conhecimento num sistema confiável de notas
conectadas, popularizado por Tiago Forte (método **PARA**) e, antes dele, pela
tradição do **Zettelkasten** de Niklas Luhmann (ver seção 8.3). Neste template,
o conceito é aplicado à prática de desenvolvimento de software com um agente de
IA, com uma adaptação central: **dois cérebros separados, não um só.**

- **Cérebro de conhecimento** (`brain/knowledge/`) — o que você aprendeu e quer
  reaproveitar entre projetos: padrões de arquitetura, artigos, papers,
  anotações de estudo. Curado por você, consultado pelo agente antes de decidir.
- **Cérebro de trabalho** (`brain/_bks-ai/`) — como você trabalha: seu perfil de
  engenharia, padrões de código, comandos, perfis de agente. Isso é o que faz o
  Claude Code se comportar como o **mesmo profissional sênior** em qualquer
  projeto que você abrir, ao invés de recomeçar do zero a cada sessão.

Cada projeto real vive no seu próprio repositório (`repos/{categoria}/{projeto}/`),
com suas specs e decisões **dentro dele** — o cérebro de trabalho nunca guarda
dado específico de um produto.

## 3. O método: Spec-Driven Development + LOOP-4

**Spec-Driven Development (SDD)** é a prática de tratar a especificação —
não o prompt solto — como a fonte de verdade que orienta o agente, prática
formalizada publicamente pelo **GitHub Spec Kit** (ver seção 8.1). Aqui ela
aparece como um fluxo de quatro artefatos:

```
Contexto → FEAT (o que construir, critérios de aceite verificáveis)
         → TEST (cenários que provam que a FEAT está correta)
         → TASK (unidades de trabalho, pares RED/GREEN)
         → LOOP-4 (implementação: no máx. 4 tentativas, goals verificáveis,
                    ou para e pergunta — nunca insiste alucinando)
```

A ideia central, alinhada ao que a própria Anthropic recomenda em seus
materiais de engenharia de agentes (seção 8.2): **um agente com objetivo
verificável e permissão para dizer "não sei, preciso de decisão humana" é mais
confiável que um agente que tenta sempre entregar algo.**

## 4. A arquitetura de referência: BKS Stack

O padrão traz uma arquitetura-base opinativa — você pode trocar por outra, mas
ela já vem com justificativa e fontes:

- **Hexagonal / Ports & Adapters** (Alistair Cockburn) — isola domínio de
  infraestrutura.
- **DDD tático** (Eric Evans, Vaughn Vernon) — entidades, agregados, value
  objects, aplicado com pragmatismo, não como ritual.
- **Pipeline Orchestration + TXC** (Transaction Context) — um record imutável
  que flui por estágios explícitos, no lugar de um mediador implícito (nunca
  MediatR).
- **Result Pattern** — inspirado em *Railway Oriented Programming* (Scott
  Wlaschin) — erros como valores de retorno, não exceções para controle de
  fluxo.
- **SEDA** (Staged Event-Driven Architecture, Matt Welsh) — estágios
  assíncronos com filas e controle de admissão para processamento que tolera
  atraso.
- **TCP sockets com length-prefix framing** — quando o protocolo é
  proprietário e não HTTP.
- **Object Calisthenics** (Jeff Bay) — disciplina de qualidade de código,
  aplicada nas revisões.

## 5. Governança multi-agente

Para projetos que movem dinheiro ou guardam dado regulado, um único agente que
implementa e "aprova" o próprio trabalho é um ponto cego real — documentado no
próprio material de origem desta camada (ver seção 8.2 e `MANUAL-COMANDOS.md`
seção 2). O padrão adiciona 4 perfis (`planner`, `builder`, `reviewer`,
`scribe`) com o `reviewer` sempre em invocação separada, e um manifesto por
projeto que declara zonas de contenção e áreas sensíveis.

## 6. Para quem isso é útil

- Quem já programa com Claude Code (ou outro agente CLI) e sente a "amnésia"
  entre sessões e a inconsistência de padrão entre projetos.
- Quem mantém **múltiplos projetos** e quer um único lugar para memória de
  engenharia, sem duplicar contexto em cada repositório.
- Quem já pratica (ou quer praticar) SDD e precisa de uma estrutura de pastas e
  comandos que sustente o fluxo, não só o conceito.
- Quem trabalha ou vai trabalhar em domínio de maior risco (financeiro,
  multi-tenant, dado regulado) e precisa de segregação de função entre quem
  codifica e quem revisa.

**Não** é para quem quer só "um prompt de sistema melhor" — o ganho real vem de
manter o hábito de registrar decisão como ADR e spec como FEAT/TEST, sessão
após sessão.

## 7. Estrutura e como usar

```
CLAUDE.md                   boot do Claude Code na raiz (aponta pro CONTEXT.md)
CONTEXT.md                  ponto de entrada
GUIA-OBSIDIAN-CLAUDE.md      material completo — conceito + passo a passo + referências
MANUAL-COMANDOS.md          referência rápida de todo comando
.claude/commands/            /brain /new-project /canonize /prd /review — rodam AQUI, na raiz
brain/
├── knowledge/                cérebro de conhecimento (wiki de estudo, vazio)
└── _bks-ai/                    cérebro de trabalho (workbench)
    ├── CLAUDE.md                regras do workbench
    ├── memory/                    perfil, premissas, padrões (editáveis)
    ├── templates/                   FEAT, ADR, REPO-CLAUDE, project-structure,
    │                                  PROJECT-README, manifesto
    ├── agents/                        builder/reviewer/planner/scribe
    ├── references/                      checklist de revisão crítica
    └── projects/                          fichas de projeto (vazio)
repos/backside/bks-marine/  exemplo de esqueleto vazio de projeto
                             (specs/, decisions/, outputs/, docs/{input/{scope,interviews,
                              research,assets},design,canonical,prompts,history} rodam
                              /spec /arch /loop /save AQUI DENTRO)
```

1. Copie esta pasta para a sua máquina e abra como vault no Obsidian.
2. Leia `GUIA-OBSIDIAN-CLAUDE.md` — o material completo, com o conceito
   explicado, o passo a passo e as referências.
3. Personalize `brain/_bks-ai/memory/user_profile.md` e `bks-premises.md` com o
   seu próprio perfil e arquitetura de preferência.
4. Rode `/new-project <nome> <categoria>` (Claude Code aberto na **raiz deste
   vault**) para criar seu primeiro projeto real — depois traga material de
   pesquisa para `docs/input/` e rode `/canonize` → `/prd` → `/spec`.

## 8. Referências — para se especializar em cada peça

### 8.1 Spec-Driven Development e desenvolvimento agêntico
- [GitHub Spec Kit — documentação e metodologia](https://github.github.com/spec-kit/) — o toolkit open-source que formalizou publicamente o fluxo spec-driven que este padrão usa como base conceitual.
- [spec-kit/spec-driven.md](https://github.com/github/spec-kit/blob/main/spec-driven.md) — o texto que define os princípios do SDD.
- [Meet GitHub Spec-Kit (MarkTechPost)](https://www.marktechpost.com/2026/05/08/meet-github-spec-kit-an-open-source-toolkit-for-spec-driven-development-with-ai-coding-agents/) — visão geral acessível do porquê SDD existe.

### 8.2 Claude Code, agentes e engenharia de contexto (fonte primária: Anthropic)
- [Claude Code: Best Practices for Agentic Coding](https://www.anthropic.com/engineering/claude-code-best-practices) — o texto oficial que inspira boa parte das convenções de `CLAUDE.md` e comandos usadas aqui.
- [How Claude Code is used in practice](https://www.anthropic.com/research/claude-code-expertise) — padrões reais de uso, direto da Anthropic.
- [Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) — por que memória bem curada (o cérebro de trabalho) supera prompt longo.
- [How we built our multi-agent research system](https://simonwillison.net/2025/Jun/14/multi-agent-research-system/) (resumo por Simon Willison, com link ao original Anthropic) — fundamenta a divisão em perfis de agente.
- [When to use multi-agent systems (and when not to)](https://claude.com/blog/building-multi-agent-systems-when-and-how-to-use-them) — quando vale a segregação de função (seção 5 deste guia) e quando é overhead.
- [Claude Agent SDK — visão geral](https://code.claude.com/docs/en/agent-sdk/overview) — para quem quer ir além do CLI e construir agentes customizados sobre a mesma base.

### 8.3 Segundo cérebro / gestão de conhecimento pessoal (PKM)
- [Building a Second Brain × Zettelkasten](https://zettelkasten.de/posts/building-a-second-brain-and-zettelkasten/) — compara o método de Tiago Forte (PARA) com a tradição do Zettelkasten de Niklas Luhmann; a raiz conceitual do "segundo cérebro" usado aqui.

### 8.4 Arquitetura: Hexagonal, DDD, Pipeline, Result
- [Hexagonal Architecture — Alistair Cockburn (fonte original)](https://alistair.cockburn.us/hexagonal-architecture) — o artigo que cunhou o padrão Ports & Adapters.
- [Implementing Domain-Driven Design — Vaughn Vernon (O'Reilly)](https://www.oreilly.com/library/view/implementing-domain-driven-design/9780133039900/ch04lev1sec3.html) — referência tática de DDD usada neste padrão.
- [Hexagonal architecture pattern — AWS Prescriptive Guidance](https://docs.aws.amazon.com/prescriptive-guidance/latest/cloud-design-patterns/hexagonal-architecture.html) — versão aplicada/moderna do padrão.
- [Railway Oriented Programming — Scott Wlaschin](https://fsharpforfunandprofit.com/rop/) — a base conceitual do Result Pattern usado no lugar de exceções para controle de fluxo.

### 8.5 SEDA e TCP
- [SEDA: An Architecture for Well-Conditioned, Scalable Internet Services (paper original, SOSP 2001)](https://www.sosp.org/2001/papers/welsh.pdf) — Matt Welsh et al., a fonte primária do padrão SEDA.
- [Staged event-driven architecture — Wikipedia](https://en.wikipedia.org/wiki/Staged_event-driven_architecture) — resumo acessível dos conceitos (estágios, filas, controle de admissão).
- [Volatile and Decentralized: A Retrospective on SEDA](http://matt-welsh.blogspot.com/2010/07/retrospective-on-seda.html) — o próprio autor revisitando o que funcionou e o que não funcionou, uma década depois — leitura essencial para aplicar SEDA com critério.
- [Message Framing — Stephen Cleary](https://blog.stephencleary.com/2009/04/message-framing.html) — o problema de framing em TCP e por que length-prefix é a solução padrão.
- [Length-prefix framing for protocol buffers — Eli Bendersky](https://eli.thegreenplace.net/2011/08/02/length-prefix-framing-for-protocol-buffers) — implementação concreta do padrão de framing usado neste stack.

### 8.6 Qualidade de código
- [Object Calisthenics — Jeff Bay (texto original)](https://bolcom.github.io/student-dojo/legacy-code/DevelopersAnonymous-ObjectCalisthenics.pdf) — as 9 regras que fundamentam a disciplina de qualidade cobrada nas revisões.
- [Object Calisthenics — William Durand](https://williamdurand.fr/2013/06/03/object-calisthenics/) — aplicação prática regra a regra, com exemplos.

## 9. Como alimentar seu cérebro de conhecimento (PDF, HTML, vídeo, link, lote)

> **Escopo:** este `/ingest` e o `brain/knowledge/` descritos aqui são o SEU cérebro de
> conhecimento técnico pessoal (Hexagonal, DDD, SOLID, TXC, etc.) — compartilhado entre todos
> os seus projetos. Conhecimento específico de UM projeto (normas do domínio, artigos que só
> aquele produto usa, entrevistas com especialista) não entra aqui: vai para
> `repos/{categoria}/{projeto}/brain/` — dentro do repo daquele projeto, não no workbench. Mapa
> completo de onde cada tipo de material entra: seção 8 do `GUIA-OBSIDIAN-CLAUDE.md`.

O `brain/knowledge/` vem com um comando dedicado para isso, o **`/ingest`**
(`brain/knowledge/.claude/commands/ingest.md`), que sabe lidar com cada tipo
de fonte de um jeito diferente — cada tipo tem uma armadilha diferente para
alucinação (PDF é direto; vídeo exige transcrição prévia; HTML pode vir
ruidoso; link precisa virar cópia local antes de virar página). O guia
completo, com o passo a passo de cada tipo, está na **seção 10 do
`GUIA-OBSIDIAN-CLAUDE.md`** — aqui vai o resumo com exemplo de comando:

```
/ingest raw/papers/artigo.pdf                → PDF
/ingest raw/articles/artigo.md                → artigo já em Markdown
/ingest raw/articles/pagina-salva.html        → página HTML salva localmente (sim, funciona)
/ingest raw/videos/palestra-transcricao.md    → vídeo — precisa ser a TRANSCRIÇÃO, não o .mp4
/ingest https://exemplo.com/artigo            → link direto — o agente busca, salva cópia e cura
/ingest tools/batch-ingest.md                 → lote via tabela (várias fontes, uma por vez)
/ingest raw/_inbox/                           → pasta inteira sem classificar nada
```

A última linha responde a uma dúvida comum: **sim, dá para jogar tudo
misturado numa pasta e pedir para processar em lote.** Jogue PDFs, `.md`,
`.html`, transcrições e listas de link em `raw/_inbox/` e rode `/ingest
raw/_inbox/` — o agente classifica cada arquivo pela extensão/conteúdo, move
para a subpasta certa (`papers/`, `articles/`, `videos/`, `links/`), ingere
cada um pela regra do seu tipo, e resume ao final quantos processou.

**Exemplo rápido de lote via tabela** (`/ingest tools/batch-ingest.md`) —
preencha `tools/batch-ingest.md` com as fontes, tipo e prioridade:

```markdown
| # | Type | Path or URL                                | Title                        | Priority |
|---|------|---------------------------------------------|-------------------------------|----------|
| 1 | pdf  | raw/papers/hexagonal-architecture.pdf        | Hexagonal Architecture         | high     |
| 2 | link | https://fsharpforfunandprofit.com/rop/       | Railway Oriented Programming   | medium   |
```

e rode `/ingest tools/batch-ingest.md` — o agente processa em ordem de
prioridade e devolve um resumo linha a linha (`✓ fonte → página criada`, ou
`✗ fonte → falhou: motivo`). Passo a passo completo, com mais tipos de fonte
na mesma tabela e o formato exato do resumo: seção 10 do `GUIA-OBSIDIAN-CLAUDE.md`.

O único tipo que exige um passo manual antes é **vídeo**: o Claude Code não
transcreve áudio sozinho, então uma transcrição (legenda exportada, ou uma
ferramenta local como Whisper) precisa existir como `.txt`/`.md`/`.srt` em
`raw/videos/` antes do `/ingest`.

Depois de ingerido, busque com `bash brain/knowledge/tools/search.sh "termo"`
e peça curadoria periódica com "faça um lint da wiki".

> Quanto mais o `knowledge/` cresce com fonte própria, mais as decisões do
> `_bks-ai/` citam **sua** wiki em vez de "lembrar" do treinamento do modelo —
> é esse hábito, mantido ao longo do tempo, que faz o segundo cérebro compensar
> o esforço.

## 10. Origem e licença

O conceito de pasta de workbench isolada foi inspirado em
[obsidian-ai-workbench](https://github.com/RenzoTakada/obsidian-ai-workbench)
(RenzoTakada). A camada de governança multi-agente (`agents/`, `/review`,
manifesto por projeto) foi adaptada de
[bks-multiagent-skill](https://github.com/DiegoAmorimDev/bks-multiagent-skill)
(DiegoAmorimDev, MIT). O restante — a integração do método bks-sdd, a regra dos
dois cérebros/dois lugares e o protocolo LOOP-4 — é autoral.
