# Guia — Obsidian + Claude Code no seu Segundo Cérebro

> Companheiro operacional do `CONTEXT.md`.
> O `CONTEXT.md` diz **o que é** o segundo cérebro. Este guia diz **como você usa**
> o Obsidian (o app) junto com o Claude Code para começar e tocar projetos —
> e como ficar fluente na ferramenta. Idioma: PT-BR nos docs, inglês no código.

---

## 1. Mapa mental em 30 segundos

Você tem quatro peças. Cada uma tem um papel; não confunda os papéis:

| Peça | Papel | Metáfora |
|------|-------|----------|
| **A pasta `2b-projects`** | Onde tudo vive: markdown, specs, código, conhecimento | O prédio |
| **Obsidian** | A **lente**: navega, conecta, busca, visualiza o markdown | Os seus olhos |
| **Claude Code** | As **mãos**: lê e escreve o markdown e o código seguindo suas regras | As suas mãos |
| **BKS-SDD** | O **método**: transforma um escopo em código (Contexto → PRD → FEAT → TEST → LOOP-4) | A linha de produção |

A frase que resume tudo: **o Obsidian é como você lê o cérebro; o Claude Code é como você o escreve.** Os dois olham para os mesmos arquivos `.md` na mesma pasta. Nada de sincronizar nada — é o mesmo disco.

E a regra de ouro que você já definiu: **o cérebro de trabalho (`_bks-ai/`) consulta o cérebro de conhecimento (`knowledge/`) antes de decidir.**

### De onde vem o padrão que você usa, e o que é seu

Vale deixar claro, porque isso muda o que você pode mexer: **não existe padrão de mercado
para layout de vault do Obsidian.** O Obsidian é só uma pasta de arquivos `.md` — a
estrutura interna é 100% livre. O que existe são *convenções de comunidade* (PARA,
Zettelkasten, LYT) e propostas individuais, nenhuma obrigatória.

A ideia original de isolar uma pasta de "workbench" (memória, specs, decisões, sessões,
comandos em `.claude/commands/`) veio do repositório
**[obsidian-ai-workbench](https://github.com/RenzoTakada/obsidian-ai-workbench)**
(RenzoTakada) — a proposta de **uma pessoa**, não um padrão da indústria. Duas convenções
por trás do nome original `_AI/`, caso seja útil saber:
- **O `_` (underscore) na frente** é um truque comum do Obsidian/sistemas de arquivo: pastas
  com `_` ordenam antes das outras alfabeticamente, então a pasta do workbench sempre
  aparece no topo da barra lateral.
- **Zona isolada de trabalho do assistente**, em oposição às suas notas em `brain/notes/`.

Isso é a ÚNICA parte do layout que veio de fora — e mesmo essa você já reescreveu em
2026-08-13 para o seu vocabulário (`_bks-ai/`), com sua própria regra dos dois lugares.

**O que É de fato fixo — as duas únicas convenções do Claude Code (a ferramenta, não o
método), não do Obsidian nem de nenhum "padrão de mercado":**
1. O arquivo de boot de cada pasta/repo precisa se chamar exatamente `CLAUDE.md`.
2. Comandos slash (`/spec`, `/loop`, etc.) precisam morar exatamente em `.claude/commands/`
   (caminho fixo, não renomeável) dentro da pasta onde o Claude Code é aberto.

Tudo o mais — nome de pasta, nome de comando, quantos níveis de categoria, onde ficam
specs e decisões — é **livre, e você já redefiniu para o seu jeito de trabalhar.**

O seu sistema foi bem além do modelo original: você separou em **dois cérebros**
(`_bks-ai/` = trabalho, `knowledge/` = estudo — o workbench original não tem essa
distinção), amarrou tudo ao método **bks-sdd** completo (PRD→PLAN→FEAT→TEST→TASK), moveu
specs e decisões de projeto para dentro do repositório de cada produto (2026-08-13, veja
seção 8), e incorporou **governança multi-agente** (seção 9). Mesmo ponto de partida,
sistema seu, mais maduro.

---

## 2. Ficar fluente no Obsidian (a parte que faltava)

O Obsidian é só um leitor/editor de arquivos `.md` de uma pasta (o *vault*). Ele não guarda nada em nuvem nem em banco: o que está na pasta é o que existe. Isso é perfeito pro seu caso, porque o Claude Code escreve arquivos e o Obsidian os mostra na hora.

### 2.1 Abrir o vault certo

Abra o Obsidian → **Open folder as vault** → aponte para `D:\Fabio\2b-projects`.
Pronto: `CONTEXT.md`, `brain/`, `repos/`, tudo aparece na barra lateral esquerda (*File explorer*).

> Dica: `brain/_bks-ai/`, `brain/knowledge/` e `repos/` são conceitualmente diferentes, mas mantê-los no **mesmo vault** do Obsidian é o que permite linkar uma spec a uma página da wiki com `[[ ]]`. Deixe um vault só.

### 2.2 Os 5 painéis que você vai usar o tempo todo

1. **File explorer** (`Ctrl+Shift+E`) — a árvore de pastas.
2. **Search** (`Ctrl+Shift+F`) — busca full-text em todo o vault. É o seu `grep` visual.
3. **Quick switcher** (`Ctrl+O`) — pula para qualquer arquivo digitando o nome. Você vai viver aqui.
4. **Graph view** (`Ctrl+G`) — o grafo de links. Útil para ver como specs, ADRs e conhecimento se conectam.
5. **Command palette** (`Ctrl+P`) — executa qualquer ação/plugin pelo nome.

Decore só três: `Ctrl+O` (abrir), `Ctrl+Shift+F` (buscar), `Ctrl+P` (comandos). Com esses três você já anda rápido.

### 2.3 Links e backlinks — o que faz virar "cérebro"

Dentro de qualquer nota, `[[nome-da-nota]]` cria um link. No rodapé do painel direito, **Backlinks** mostra quem aponta para a nota atual. Isso é o que transforma pastas soltas em rede de conhecimento.

Uso concreto no seu fluxo:
- Num `FEAT-*.md` (agora dentro do repo, em `specs/features/`), linke a página da wiki que fundamentou a decisão: `Baseado em [[txc-transaction-context]]`.
- Num `ADR-NNN.md` (agora dentro do repo, em `decisions/`), linke a feature afetada: `Afeta [[FEAT-login]]`.
- Na ficha do projeto (`brain/_bks-ai/projects/bks-marine.md`), linke as specs relevantes: assim a ficha vira um índice vivo.

### 2.4 Plugins — o mínimo que vale a pena (Community plugins)

Ative em **Settings → Community plugins → Browse**. Comece com poucos; adicione só quando sentir falta.

| Plugin | Para quê | Prioridade |
|--------|----------|-----------|
| **Dataview** | Monta tabelas/painéis vivos a partir do frontmatter (dashboard de specs, ADRs, projetos) | Alta |
| **Templater** | Cria nota nova já preenchida a partir dos seus templates de `brain/_bks-ai/templates/` | Alta |
| **Obsidian Git** | Faz commit/backup automático do vault (versiona seu conhecimento) | Média |
| **Mermaid** (core, já embutido) | Renderiza os diagramas C4 que o `/arch` gera | Já tem |
| **Kanban** | Board visual de tarefas do projeto, se você gosta de quadro | Baixa |
| **Home tab / Dashboard++** | Uma home page do vault | Baixa |

> Core plugins (nativos) que valem ligar: **Templates**, **Backlinks**, **Outline**, **Page preview**, **Command palette**. Mermaid já vem ligado.

### 2.5 Frontmatter — o que destrava os painéis

Hoje seus templates usam header inline (`**Status:** Rascunho`). O Obsidian não consegue filtrar por isso. Para ter dashboards, basta pôr um bloco YAML no topo das notas (o Obsidian chama de *Properties*):

```markdown
---
tipo: feat
projeto: bks-marine
categoria: backside
context: Autenticacao
status: rascunho     # rascunho | aprovada | em-execucao | concluida
---
# FEAT-login
...
```

Com isso, o Dataview monta sozinho a tabela de todas as features do projeto e seu status (queries prontas no Apêndice A). Os templates já vêm com frontmatter (seção 6).

### 2.6 Rotina de fluência (2 semanas, 10 min/dia)

- **Dia 1–2:** abrir o vault, navegar com `Ctrl+O`, ler o `CONTEXT.md` e 2 páginas da `knowledge/wiki/`.
- **Dia 3–4:** criar uma nota em `brain/notes/`, linkar (`[[ ]]`) para uma página da wiki, ver o backlink aparecer.
- **Dia 5–6:** instalar Dataview + Templater; colar um dashboard do Apêndice A numa nota `HOME.md`.
- **Semana 2:** rodar um projeto de verdade (o bks-marine) e usar o Obsidian só para **ler** o que o Claude Code escreve — specs, ADRs, o ARCH com diagrama. A fluência vem do uso real, não de estudar o app.

---

## 3. Como Obsidian e Claude Code trabalham juntos

O padrão é um **loop de duas mãos**:

```
       você lê/decide no Obsidian
                  │
                  ▼
   Claude Code escreve markdown/código  ──►  arquivos .md na pasta
                  ▲                                   │
                  │                                   ▼
                  └────────── Obsidian renderiza na hora
```

Na prática:
1. Você **conversa** com o Claude Code no terminal (dentro do `_bks-ai/` ou do repo).
2. O Claude **escreve** o `FEAT-*.md`, o `ADR-*.md`, o código.
3. Você **abre no Obsidian** para revisar com calma, ver o diagrama Mermaid renderizado, seguir os links.
4. Aprova ou pede ajuste — e o ciclo segue.

Obsidian **não** roda o Claude. Ele só mostra o resultado bonito e navegável. Quem roda é o terminal.

### 3.1 Onde abrir o terminal do Claude Code (decisão importante)

Desde 2026-08-13, specs e decisões de projeto moram **dentro do repo do projeto**, não no
workbench — isso muda um pouco onde você abre cada comando:

- **`/brain`, `/novo-projeto`, `/revisao`**: abra o Claude Code em
  `D:\Fabio\2b-projects\brain\_bks-ai`.
  É aqui que vivem memória, templates, agentes e comandos.

- **`/spec`, `/arch`, `/loop`**: abra o Claude Code **na raiz do repositório do projeto**, ex.
  `D:\Fabio\2b-projects\repos\backside\bks-marine`.
  O `CLAUDE.md` do repo (template `REPO-CLAUDE.md`) manda o Claude ler, por caminho absoluto, seu `user_profile.md`, `bks-premises.md` e a ficha do projeto — então mesmo lá dentro ele continua sendo seu gêmeo BKS, mas agora com specs, decisões e código todos ali, sem trocar de pasta.

- **`/save`**: roda em qualquer um dos dois — ele sabe rotear decisão de projeto para o
  `decisions/` do repo, e decisão sobre o workbench em si para `_bks-ai/decisions/`.

Regra simples: **"é sobre este projeto → mora no repo dele; é sobre como eu trabalho →
mora no `_bks-ai/`."** O `REPO-CLAUDE.md` é a ponte que conecta os dois.

### 3.2 O contrato que mantém tudo consistente

Você já embutiu isso e é o que faz o sistema não alucinar:
- Nada de código sem spec aprovada (`_bks-ai/CLAUDE.md`, regra 2).
- Toda decisão sobre um projeto vira ADR **no repo dele** (`/save` roteia para `{repo}/decisions/`).
- Implementação sob **LOOP-4**: no máximo 4 tentativas, com goals verificáveis (build limpo, teste verde, cenários do TEST cobertos, código fiel ao `user_profile.md`); na 5ª falha, PARA e gera um `BLOQUEIO-*.md` com a pergunta objetiva pra você.
- Antes de decidir, consultar a `knowledge/wiki/` e **citar a página** (`search.sh "<termo>"`).

---

## 4. Começar um projeto do ZERO (passo a passo didático)

Este é o roteiro completo. Cada passo tem duas partes: **o que é / por que / como fazer**, e logo abaixo um **Exemplo (bks-marine)** — o caso real que construímos juntos, para você ver a teoria virar prática. Troque os nomes pelos do seu próximo projeto.

---

### Passo 0 — Ter o escopo à mão

O ponto de partida de qualquer projeto é entender **o que** você vai construir, **para quem** e **o que ele conversa com o mundo** (integra com TCP? filas? SEDA? só HTTP?). Não precisa de um documento perfeito nem completo — precisa de material suficiente para o gêmeo te entrevistar com inteligência. Pode ser um parágrafo escrito por você, ou documentos que o cliente te mandou. Guarde tudo que for "bruto" (PDFs, docx, transcrições) para organizar no Passo 3.

> **Exemplo (bks-marine):** o escopo chegou como material do cliente — um `Escopo_Sistema.docx`, uma `Proposta`, uma `entrevista.txt` e mockups do app. Deles extraí a essência: um sistema que digitaliza operações de **atracação e desatracação de navios** em portos, hoje feito à mão com planilha + foto + WhatsApp, com transmissão imediata online e relatórios em PDF. Isso já bastou para começar — não precisei de mais nada para o Passo 1.

### Passo 1 — Criar o esqueleto do projeto

Todo projeto seu nasce com a **mesma estrutura canônica** (a receita está em `brain/_bks-ai/templates/project-structure.md`). Isso garante que todo projeto tenha os mesmos lugares para código, domínio, specs e documentação — você nunca fica se perguntando "onde ponho isso?". Em vez de digitar um prompt longo, use o comando **`/novo-projeto`** (Claude Code aberto em `brain/_bks-ai`): basta passar o **nome** e a **categoria** (backside | w3 | private). Ele cria a árvore e já gera todo o wiring (CLAUDE.md, README, HOW-TO-WORK, .gitignore), as pastas de specs/decisions e a ficha do projeto.

> **Exemplo (bks-marine):** o comando é uma linha só —
> ```
> /novo-projeto bks-marine backside
> ```
> e ele monta:
> ```
> repos/backside/bks-marine/
> ├── app/                              (o código .NET virá aqui)
> ├── brain/{knowledge,methodology}       (domínio do produto)
> ├── specs/{features,tests,tasks}          (specs bks-sdd DESTE projeto)
> ├── decisions/                              (ADRs DESTE projeto)
> ├── docs/{canonical,design,input,prompts,history}
> ├── CLAUDE.md  README.md  HOW-TO-WORK.md  .gitignore
> brain/_bks-ai/projects/bks-marine.md   (ficha do projeto, no workbench)
> ```
> (Se preferir, ainda dá para pedir em texto livre — mas o comando é o caminho rápido.)

### Passo 2 — Wiring do repo (a ponte entre o repo e o seu cérebro)

"Wiring" é a **fiação** que faz o Claude continuar sendo o seu gêmeo BKS mesmo quando aberto dentro do repositório (e não no `_bks-ai/`). Na prática é o `CLAUDE.md` do repo: ele manda o Claude carregar, **por caminho absoluto**, o seu perfil, suas premissas de código, os padrões .NET, o contexto quente e a ficha do projeto — mais as skills BKS — e aponta as specs/decisions para as pastas **do próprio repo**. Sem esse wiring, o Claude aberto no repo seria "burro" sobre quem você é; com ele, já chega sabendo como você codifica. Confira sempre se o `CLAUDE.md` seguiu o template `REPO-CLAUDE.md`.

> **Exemplo (bks-marine):** o `repos/backside/bks-marine/CLAUDE.md` abre mandando carregar, nesta ordem: `user_profile.md`, `bks-premises.md`, `dotnet-standards.md`, `hot.md` e `projects/bks-marine.md` (todos por caminho `D:\Fabio\2b-projects\...`), declara as skills `bks-sdd`, `bks-dotnet-solutions`, `bks-c4-diagrams`, aponta as specs para `./specs/{features,tests,tasks}/` e as decisões para `./decisions/` (ambas dentro do próprio repo) e diz que o domínio do produto está em `./brain/`. É essa fiação que faz o `/loop` implementar já no seu padrão Hexagonal + TXC.

### Passo 3 — Trazer o material bruto para os lugares certos

Agora você distribui o material do Passo 0 pela estrutura, seguindo a **regra dos dois cérebros**: o que é do *produto* vai no repo; o que é *conhecimento seu geral* vai no `knowledge/`. Escopo e entrevistas (cru) vão para `docs/input/`; documentos que o produto precisa "saber" (normas, relatórios-modelo do negócio) vão para `brain/knowledge/` (dentro do repo); código ou protótipos de referência vão para `app/`. (O mapa completo de "o que vai onde" está na seção 8.)

> **Exemplo (bks-marine):** distribuí assim — `Escopo`, `Proposta`, `entrevista.txt` e a `Sintese` foram para `docs/input/`; os **mockups React** do app foram para `app/mockups-app-react/` (referência de UI); e os **relatórios reais de operação (exemplo do cliente)** (mais o modelo de relatório) foram para `brain/knowledge/`, porque são conhecimento do domínio portuário que o produto precisa reproduzir.

### Passo 4 — Design antes de spec

Antes de especificar features, você pensa a **arquitetura macro** e lista as **decisões em aberto**. Essa é a bancada de trabalho em `docs/design/`: um `escopo-produto.md` (a síntese do que o produto faz), um `arquitetura-macro.md` (bounded contexts, agregados, pipeline, o que é assíncrono) e um `decisoes-abertas.md` (tudo que ainda não está decidido). Quando uma decisão **firma** (ex.: a stack), ela sai daqui e vira um **ADR** em `decisions/` **do próprio repo** — decisão registrada não se rediscute. O escopo já consolidado vai para `docs/canonical/`.

> **Exemplo (bks-marine):** o `arquitetura-macro.md` já identificou os **4 bounded contexts** (Identidade & Acesso, Cadastros, Operações Portuárias — o CORE — e Relatórios), com `Operacao` como aggregate root e o **envio de fotos** marcado como candidato a estágio **SEDA** (assíncrono, tolera 24h). O `decisoes-abertas.md` listou D1–D12; e na entrevista você **firmou** três: stack **.NET 10 + Supabase**, **auth próprio no .NET** e **login por e-mail** — essas viram um ADR no próximo `/save`, dentro de `repos/backside/bks-marine/decisions/`.

### Passo 5 — `/brain` (carregar o contexto da sessão)

Sempre que você senta para trabalhar, a primeira coisa é rodar `/brain` (Claude Code aberto em `brain/_bks-ai`). Ele lê seu perfil, o índice de memória, o contexto quente (`hot.md`) e a última nota de sessão, e te devolve em ~5 linhas quem você é, em que estava trabalhando e qual o próximo passo. É o que elimina a "amnésia" entre sessões e evita que você reexplique tudo.

> **Exemplo (bks-marine):** um `/brain` hoje responderia algo como: *"Você é o Arquiteto Sênior BKS. Projeto ativo: bks-marine (backside), fase design. Última sessão: montei a estrutura e aprovamos a stack .NET 10 + Supabase. Próximo passo: revisar/aprovar o `FEAT-autenticacao` e gerar o TEST."*

### Passo 6 — `/spec` (especificar a primeira feature via entrevista)

Aqui o gêmeo te **entrevista** sobre um bounded context — objetivos, entidades, operações (use cases), integrações e critérios de aceite verificáveis — e escreve a spec `FEAT-[nome].md` **dentro do repo do projeto**, em `specs/features/`. Rode com o Claude Code aberto na **raiz do repo** (não no `_bks-ai/`). Regra de ouro: **uma feature por vez** e **nada de código nesta etapa**. Você revisa a spec no Obsidian; ao aprovar, o gêmeo gera o `TEST-[nome].md` em `specs/tests/` com os cenários que depois viram os goals do LOOP-4.

> **Exemplo (bks-marine):** a entrevista da primeira feature perguntou a abordagem de autenticação, o escopo, o identificador de login e o modelo de perfis. Você respondeu **auth próprio no .NET**, **só o login**, **por e-mail** e **3 perfis** (Full, Operacional, Comum, ligados aos módulos Configuração/Operações/Relatórios via tabela Perfil↔Transação). Disso saiu o `specs/features/FEAT-autenticacao.md`: use case `AutenticarUsuario` em pipeline **Standard**, com **TXC** (`AutenticarTransaction`), Ports `IUsuarioRepository`/`IPasswordHasher`/`ITokenService`, e **7 critérios de aceite** verificáveis (ex.: "credencial inválida retorna 401 genérico, sem revelar se o e-mail existe").

### Passo 7 — `/arch` (gerar a visão de arquitetura)

Com specs aprovadas, o `/arch` (também na raiz do repo) lê as specs do próprio repo e gera a **documentação de arquitetura** em `outputs/`: um `ARCH-[projeto].md` com diagramas **C4** (Contexto, Container, Componente) em Mermaid, o mapa de bounded contexts, as decisões de pipeline/SEDA e o contrato de protocolo quando houver. Você abre no Obsidian e vê os diagramas **renderizados** (o Mermaid já vem ligado). É o que dá a visão de cima antes de implementar.

> **Exemplo (bks-marine):** um `/arch bks-marine` produziria um C4 de **Contexto** com o app React Native e o painel React consumindo a **API .NET 10**, que fala com o **Supabase** (Postgres + Storage); um de **Container** separando API, banco e storage de fotos; e um de **Componente** detalhando os 4 bounded contexts. E registraria explicitamente que **não há TCP** aqui — a comunicação é toda HTTPS.

### Passo 8 — Git (inicializar no Windows)

Quando a estrutura e o design estão de pé, você versiona o **repositório do projeto**. Inicialize o git **nativo no Windows** (nunca pelo ambiente Linux, que quebra permissão/encoding), na raiz do repo — **um git por projeto**, nunca um só para o vault inteiro. Sobe código, docs em markdown, specs e decisions; ficam de fora binários pesados e **segredos** (o `.gitignore` já cuida disso).

> **Exemplo (bks-marine):** os comandos seriam
> ```
> cd D:\Fabio\2b-projects\repos\backside\bks-marine
> git init && git add . && git commit -m "chore: estrutura inicial + design"
> ```
> As chaves do Supabase (URL, anon key, service key) ficam num `.env` que o `.gitignore` já bloqueia — elas **nunca** entram num commit.

### Passo 9 — `/loop` (implementar sob o protocolo LOOP-4)

Agora sim, código — e com Claude Code aberto **na raiz do repo** (não no `_bks-ai/`). O `/loop` pega uma task e implementa sob o **LOOP-4**: no máximo 4 tentativas, e a cada rodada ele roda `dotnet build; dotnet test` e audita os goals (build limpo, testes verdes, cenários do TEST cobertos, código fiel ao seu perfil). Só marca como pronto se **todos** passarem; se falhar 4 vezes, ele **para** e escreve um `BLOQUEIO-*.md` com o erro exato e a pergunta objetiva para você — em vez de insistir alucinando.

> **Exemplo (bks-marine):** na Autenticação, o `/loop` implementaria primeiro os testes dos cenários do `specs/tests/TEST-autenticacao.md` (estado RED), depois o `AutenticarUsuario` até os testes passarem (GREEN): validar e-mail+senha, buscar usuário, conferir o hash bcrypt, checar se está ativo, emitir o JWT e montar o menu do perfil. Goal G3 seria "os 7 critérios de aceite do FEAT cobertos"; G4, "respeita calisthenics + hexagonal".

### Passo 10 — `/save` (fechar a sessão sem perder nada)

Ao terminar, o `/save` **roteia** o que aconteceu pela regra dos dois lugares: decisão sobre este projeto vira `ADR-NNN.md` em `decisions/` **do repo**; decisão sobre o workbench (rara) vai para `_bks-ai/decisions/`; specs novas/alteradas ficam em `specs/` do repo; o progresso e o próximo passo vão para `_bks-ai/memory/hot.md`; entregáveis para `outputs/` do repo; e uma nota de sessão para `_bks-ai/sessions/`. É isso que faz o próximo `/brain` te devolver exatamente onde você parou. Se for projeto ativo, registre também na tabela do `CONTEXT.md`.

> **Exemplo (bks-marine):** um `/save` agora gravaria um `ADR-00X — Stack e autenticação` em `repos/backside/bks-marine/decisions/` (.NET 10 + Supabase, auth próprio no .NET, 3 perfis), atualizaria o `_bks-ai/memory/hot.md` com *"bks-marine: FEAT-autenticacao em revisão; próximo = gerar TEST"*, e criaria a nota `_bks-ai/sessions/sessao-2026-08-12.md` com o resumo da entrevista.

---

### O ciclo, resumido
```
escopo → /brain (_bks-ai) → design (docs/design, no repo) → decisão vira ADR (decisions/, no repo) →
/spec+/arch (no repo, FEAT+TEST+C4) → git init (no repo) → /loop (no repo, LOOP-4) → /save
                                  └── você revisa tudo no Obsidian ──┘
```

---

## 5. Erros comuns (e como o sistema te protege)

Cada erro abaixo vem com a explicação e um exemplo concreto de como ele apareceria — e como o seu sistema já te protege dele.

### Pedir código sem spec
O `_bks-ai/CLAUDE.md` (regra 2) proíbe gerar código sem uma FEAT/TEST aprovada. Se você se pega pedindo implementação e ainda não há spec, é sinal de que pulou o `/spec`. A spec é o que dá goals verificáveis ao LOOP-4 — sem ela, o Claude "adivinha" o que você quer.

> **Exemplo (bks-marine):** pedir *"já implementa o login"* agora seria o erro — o `FEAT-autenticacao` ainda está em **Rascunho** e não há `TEST-autenticacao`. O caminho certo é aprovar a FEAT, gerar o TEST e só então `/loop`.

### Criar spec ou ADR de projeto no lugar errado
Desde 2026-08-13, specs (`FEAT/TEST/TASK`) e ADRs **de um projeto** moram **no repo dele**
(`specs/`, `decisions/`), não mais em `_bks-ai/`. O `_bks-ai/` guarda só o que é **sobre
como você trabalha** — memória, templates, perfis de agente — compartilhado entre todos
os projetos.

> **Exemplo (bks-marine):** o `FEAT-autenticacao.md` vive em
> `repos/backside/bks-marine/specs/features/` — e não em `brain/_bks-ai/specs/...` (esse
> caminho nem existe mais). Se você pegar um projeto antigo com specs ainda no workbench,
> é sinal de migração pendente.

### Implementar dentro do `_bks-ai/`
O `_bks-ai/` é o cérebro de **memória e método** — perfis, templates, comandos. Código, specs e decisões de produto **nunca** moram aqui; vão para o repositório do produto em `repos/`. Misturar os dois quebra a regra dos dois lugares e polui a memória compartilhada.

> **Exemplo (bks-marine):** o código do `AutenticarUsuario` vai para `repos/backside/bks-marine/app/` — e a spec que o originou fica em `repos/backside/bks-marine/specs/features/FEAT-autenticacao.md`, ambos dentro do repo do produto.

### Abstrair cedo demais
O `bks-premises.md` é **token-aware**: a melhor solução é a mais simples que resolve o problema; abstração só entra quando paga o próprio preço. Criar camadas "para o futuro" gera complexidade acidental que compete com a lógica que importa. Refatorar código simples com IA é barato; navegar uma abstração que tentou adivinhar o futuro é caro.

> **Exemplo (bks-marine):** no login, criar já uma "estratégia de autenticação plugável" com fábricas e interfaces genéricas seria abstrair cedo — só temos **um** método (e-mail+senha). O certo é um `AutenticarUsuario` direto; se um dia entrar login social, aí sim a abstração paga o preço.

### Decidir sem consultar a wiki
"Wiki" aqui é a sua **base de conhecimento curada** em `brain/knowledge/wiki/` — as páginas que você mesmo vetou sobre SOLID, DDD, hexagonal, SEDA, TCP, microserviços, etc. A regra é: antes de **fixar** uma decisão técnica ou de arquitetura, o gêmeo procura o tema lá (`search.sh "<termo>"`) e **cita a página** que embasou, em vez de decidir "de cabeça" ou no chute da IA. Se a wiki não cobrir o tema, ele diz isso abertamente e marca `> [!uncertain]` — nunca inventa. É isso que mantém as decisões ancoradas numa fonte confiável e reduz alucinação. Em resumo: **decisão técnica boa cita de onde veio.**

> **Exemplo (bks-marine):** para definir a política de **retry e backpressure** do estágio SEDA que envia as fotos (aquelas que toleram 24h), o certo é rodar `search.sh "SEDA"` (e `"backpressure"`), ler a página na `knowledge/wiki/` e citá-la no `arquitetura-macro.md` — em vez de o gêmeo simplesmente arbitrar "3 tentativas de 5s". Se não existir página sobre isso, ele marca `> [!uncertain]` e te pergunta, em vez de fingir que sabe.

### Git pelo ambiente Linux (e não no Windows)
O repositório fica no seu disco Windows; inicializar ou commitar pelo ambiente Linux quebra permissões e encoding. Sempre rode o git **nativo no Windows**, na raiz do repo do projeto.

> **Exemplo (bks-marine):** o `git init` do bks-marine é feito no PowerShell/terminal do Windows dentro de `D:\Fabio\2b-projects\repos\backside\bks-marine` — nunca pelo terminal Linux de uma sessão remota.

---

## 6. Upgrades sugeridos (opcionais, para fluência)

1. **Frontmatter nos templates** (`FEAT.md`, `ADR.md`, ficha de projeto) para destravar Dataview — modelos prontos no Apêndice B.
2. **Uma `HOME.md` no vault** com os dashboards do Apêndice A (features por status, ADRs recentes, projetos ativos).
3. **Obsidian Git** no vault para versionar conhecimento e specs automaticamente.
4. **Ficha de projeto para o Layan** — ainda falta em `brain/_bks-ai/projects/layan.md` (ver `PENDENCIAS.md`).

---

## 7. Glossário e referência de comandos

### 7.1 Termos do seu sistema (o que cada palavra quer dizer)

- **Vault** — a pasta que o Obsidian abre como cofre de notas. No seu caso, `D:\Fabio\2b-projects`. Tudo que o Obsidian mostra vem de arquivos `.md` dessa pasta.
- **Frontmatter (Properties)** — o bloco YAML entre `---` no topo de uma nota. É o que o Dataview lê para montar painéis. Ex.: `status: rascunho`, `projeto: bks-marine`.
- **Wiring** — literalmente "fiação/ligação". São os arquivos e caminhos que **conectam o repositório ao seu workbench**, para o Claude Code carregar o gêmeo BKS mesmo trabalhando dentro do repo. O wiring do bks-marine é: o `CLAUDE.md` do repo (que manda ler, por caminho absoluto, `user_profile.md`, `bks-premises.md`, `dotnet-standards.md`, `hot.md` e a ficha `_bks-ai/projects/bks-marine.md`, e aponta `specs/` e `decisions/` locais), mais o `README.md`, `HOW-TO-WORK.md` e `.gitignore`. Sem o wiring, abrir o Claude no repo seria "cru"; com ele, o Claude já sabe quem você é e como você codifica. O template é `_bks-ai/templates/REPO-CLAUDE.md`.
- **Boot** — o carregamento inicial de contexto no começo da sessão (o que o `/brain` faz e o que o `CLAUDE.md` do repo dispara).
- **Bounded Context / Aggregate / Pipeline / TXC / Result** — vocabulário de arquitetura definido em `_bks-ai/memory/bks-premises.md` e `user_profile.md`. TXC = Transaction Context (record imutável que flui pela pipeline).
- **RPI** — Research → Plan → Implement, o ciclo de cada projeto.
- **LOOP-4** — o protocolo de implementação: no máximo 4 tentativas, com goals verificáveis; na 5ª falha, para e gera `BLOQUEIO-*.md`.

### 7.2 Comandos do workbench (`_bks-ai/.claude/commands/`)

São os seus comandos "do dia a dia". `/brain`, `/novo-projeto` e `/revisao` rodam com o Claude Code aberto em `brain/_bks-ai`; `/spec`, `/arch` e `/loop` rodam **na raiz do repo do projeto**.

| Comando | Onde rodar | Para que serve | Quando usar | O que produz |
|---------|-----------|----------------|-------------|--------------|
| `/brain` | `_bks-ai` | Carrega perfil + memória + contexto quente e resume em 5 linhas quem você é, onde parou e o próximo passo | **Início de toda sessão** | Um resumo; nenhum arquivo |
| `/spec` | **repo** | Faz a entrevista bks-sdd de um bounded context e gera a spec da feature | Ao iniciar uma feature nova | `specs/features/FEAT-*.md` e, após aprovado, `specs/tests/TEST-*.md` (no repo) |
| `/arch` | **repo** | Gera a visão de arquitetura a partir das specs do próprio repo | Depois de ter specs aprovadas | `outputs/ARCH-{proj}.md` (C4 em Mermaid) + `README.md` |
| `/loop` | **repo** | Implementa a task sob LOOP-4 | Na fase de código | Código + `dotnet build`/`test` verdes; ou `outputs/BLOQUEIO-*.md` |
| `/save` | `_bks-ai` ou repo | Roteia o resultado da sessão para os lugares certos | Ao fechar a sessão | ADR em `decisions/` (repo, ou `_bks-ai/decisions/` se for do workbench), `hot.md`, `outputs/`, nota em `sessions/` |
| `/novo-projeto` | `_bks-ai` | Cria a estrutura canônica + wiring + ficha | Iniciar um projeto do zero | árvore em `repos/{cat}/{proj}/` + ficha em `_bks-ai/projects/` |
| `/revisao` | `_bks-ai` | Dispara o agente `reviewer` (segregação de função) | Antes de aprovar entrega em área sensível (projeto Alto/Crítico) | achados de segurança ou OK explícito |

Exemplos:

- `/brain` → *"Você é o Arquiteto Sênior BKS. Estamos no bks-marine, fase design. Próximo: /spec da Autenticação."*
- `/spec` (no repo) → começa a entrevista: *"Qual o bounded context? Entidades? Operações? Integrações (TCP/filas/SEDA)? Critérios de aceite verificáveis?"* e escreve `specs/features/FEAT-autenticacao.md`.
- `/arch bks-marine` (no repo) → escreve `outputs/ARCH-bks-marine.md` com os diagramas C4 que você abre no Obsidian.
- `/loop` (no repo) → implementa a primeira task, roda build+test, audita os goals G1–G4.
- `/save` → *"Gravei ADR-003 em decisions/ (stack .NET 10 + Supabase), atualizei hot.md e a nota de sessão."*

### 7.3 Comandos da skill `bks-sdd` (o fluxo completo, para produtos maiores)

O `/spec` do workbench é uma versão **enxuta** do bks-sdd: vai direto ao `FEAT`/`TEST`, já dentro do repo. A **skill `bks-sdd`** é o fluxo **completo**, com PRD e plano, criando um `workspace-*/` com `.states`/`.logs` (memória entre sessões). Use a skill quando o produto é grande e você quer o rastro PRD → PLAN → FEAT → TEST → TASK; use o `/spec` quando já sabe a feature e quer velocidade.

| Comando | Fase | Para que serve |
|---------|------|----------------|
| `/bks-sdd` | 0 | Cria o `workspace-[nome]/` (research, plan, projects, `.states`, `.logs`) |
| `/bks-sdd --prd` | 1 | Gera o `PRD.md` a partir do que está em `research/` |
| `/bks-sdd --project` | 2 | Cria um projeto interno (`project-[nome]`) e coleta a stack |
| `/bks-sdd --project-prd` | 3 | Gera o PRD daquele projeto |
| `/bks-sdd --project-plan` | 4 | Gera o `PLAN-[nome].md` (fases + lista de features) |
| `/bks-sdd --feature` | 5.1 | Gera um `FEAT-[nome].md` (uma feature por vez) |
| `/bks-sdd --feature-tests` | 5.2 | Gera o `TEST-[nome].md` (cenários Gherkin) do FEAT aprovado |
| `/bks-sdd --feature-task` | 5.3 | Quebra a feature em `TASK-*.md` (pares RED/GREEN, TDD) |
| `/bks-sdd --feature-list` | 5 | Mostra o status de todas as features (FEAT/TEST/Tasks) |
| `/bks-sdd --continue` | 1.5 | Retoma a sessão do último estado salvo |
| `/bks-sdd --tan` / `--clear` | 1.5 | Encerra com segurança salvando o estado (evita "amnésia") |
| `/help-workspace` | — | Explica o papel de cada pasta do workspace |

Regras de bloqueio da skill (garantem qualidade): `--feature-tests` só roda com FEAT aprovado; `--feature-task` só roda com TEST aprovado. Não dá para pular etapas.

### 7.4 Qual usar: `/spec` (workbench) ou `bks-sdd` (skill)?

- **`/spec`** — features pontuais dentro de um projeto que você já entende. Rápido, gera FEAT/TEST direto em `specs/` do repo. É o seu caminho padrão no bks-marine.
- **`bks-sdd` (skill)** — produto novo e grande, ou quando você quer PRD + PLAN + rastro de TASKS com memória de sessão (`workspace-*`). Vale quando o escopo é incerto e precisa de decomposição formal.

Nos dois casos, o gêmeo segue o `bks-premises.md` (Hexagonal + Pipeline + TXC + Result, token-aware) e cita a wiki antes de decidir.

---

## 8. Onde colocar cada coisa (mapa de pastas)

Você tem **dois níveis**: o **vault/cérebro** (conhecimento e workbench, compartilhado entre projetos) e o **repo do projeto** (o produto em si, incluindo suas specs e decisões). A regra: conhecimento geral e método no cérebro; tudo que é do produto — inclusive specs e ADRs dele — no repo.

| O que você tem | Onde colocar | Observação |
|----------------|--------------|------------|
| **Anotações de estudo** de um tema (aprender DDD, hexagonal, etc.) | Fonte em `brain/knowledge/raw/{papers\|articles\|videos\|notes}/` → peça "ingira" → vira página em `brain/knowledge/wiki/` | `raw/` é imutável; a wiki é curada |
| **Nota solta / ideia rápida** | `brain/notes/` ou `_bks-ai/inbox/` | Captura; depois roteia |
| **Requisitos / escopo bruto** do projeto (docs do cliente, entrevistas, propostas) | `repos/{cat}/{proj}/docs/input/` | É o que entra "cru" para conciliar |
| **Escopo vigente / consolidado** (a verdade atual) | `repos/{cat}/{proj}/docs/canonical/` | Fonte única do que vale hoje |
| **Rascunho de arquitetura/decisões** em andamento | `repos/{cat}/{proj}/docs/design/` | Bancada ativa |
| **Decisão firmada** deste projeto (arquitetura, stack) | `repos/{cat}/{proj}/decisions/ADR-NNN.md` | Via `/save`, no repo |
| **Decisão sobre o workbench em si** (rara) | `_bks-ai/decisions/ADR-NNN.md` | Via `/save`, no `_bks-ai` |
| **Specs** (FEAT, TEST, TASK) deste projeto | `repos/{cat}/{proj}/specs/{features,tests,tasks}/` | No repo, **não** mais no workbench |
| **Logotipos, identidade visual, layouts, mockups** (referência de UI) | `repos/{cat}/{proj}/app/` (ex.: `mockups-app-react`) ou `docs/design/assets/` | Material visual de referência do produto |
| **PDFs de domínio** (relatórios-modelo, normas, docs técnicos do negócio) | `repos/{cat}/{proj}/brain/knowledge/` | O que o **produto** precisa saber |
| **Código gerado** (a solução .NET) | `repos/{cat}/{proj}/app/` | É aqui que o `/loop` escreve o código |
| **Prompts de refinamento** | `repos/{cat}/{proj}/docs/prompts/` | O que gera o canônico |
| **Versões superadas** | `repos/{cat}/{proj}/docs/history/` | Nunca é fonte de verdade |
| **Entregáveis do projeto** (ARCH, diagramas, BLOQUEIO) | `repos/{cat}/{proj}/outputs/` | Gerados por `/arch` e `/loop`, no repo |
| **Nota de sessão** | `_bks-ai/sessions/sessao-YYYY-MM-DD.md` | Via `/save`, no workbench |

Exemplo real (bks-marine): o escopo e a proposta foram para `docs/input/`; os mockups React para `app/mockups-app-react/`; os relatórios-modelo do navio para `brain/knowledge/`; a `FEAT-autenticacao.md` para `specs/features/`. um logotipo do cliente entraria em `app/` (ou `docs/design/assets/`); um manual técnico do porto, em `brain/knowledge/`.

### A regra dos dois lugares (para não errar)
- **"É sobre este projeto"** (specs, ADR de stack/arquitetura, código, docs) → mora no repo dele: `repos/{cat}/{proj}/`.
- **"É sobre como eu trabalho"** (memória, perfis de agente, templates, decisão sobre o workbench em si) → mora em `brain/_bks-ai/`. Compartilhado entre TODOS os projetos.

### A regra dos dois cérebros (dentro do repo, para não errar diferente)
- **`_bks-ai/`** = COMO construir (seu, compartilhado entre projetos): memória, templates, comandos, agentes.
- **`{repo}/brain/`** = O QUE o produto sabe (domínio daquele produto): conhecimento e relatórios do negócio.
O repo consulta o `_bks-ai/`; o `_bks-ai/` não guarda domínio específico de um produto.

### Git — onde iniciar e o que subir

- **Onde iniciar:** na **raiz do repo do projeto** — `repos/backside/bks-marine`. **Um git por projeto.** Não inicie um git único cobrindo o vault inteiro (evita repositórios aninhados e bagunça).
  ```
  cd D:\Fabio\2b-projects\repos\backside\bks-marine
  git init
  git add .
  git commit -m "chore: estrutura inicial + design"
  ```
- **O que SOBE (versionado):** o código em `app/`, os docs em markdown (`README.md`, `CLAUDE.md`, `HOW-TO-WORK.md`, `docs/**/*.md`), **specs** (`specs/**/*.md`), **decisions** (`decisions/**/*.md`), o `.gitignore`, e o `brain/` de domínio em markdown.
- **O que NÃO sobe (já no `.gitignore`):** `bin/`, `obj/`, `node_modules/`, `.env*`, `*.pdf`, `*.docx`, `Thumbs.db`, `.DS_Store`. Ou seja: binários pesados, PDFs/docx brutos e **segredos**.
- **Segredos do Supabase** (URL, anon key, service key): sempre em `.env` (fora do git). No código, leia de variável de ambiente. Se um segredo vazar para um commit, rotacione a chave no painel do Supabase.
- **E o workbench (`_bks-ai/`)?** Continua fora do repo do produto — é seu, pessoal, compartilhado entre projetos. Se quiser versionar o workbench, use um git próprio dentro de `brain/_bks-ai/`, separado do repo de cada produto, ou o plugin **Obsidian Git** sobre o vault inteiro.

---

## 9. Governança multi-agente (para projetos Alto/Crítico)

Desde 2026-08-13, seu workbench tem uma camada extra, adaptada do repositório
[bks-multiagent-skill](https://github.com/DiegoAmorimDev/bks-multiagent-skill) (DiegoAmorimDev,
MIT) para o seu vocabulário BKS. Ela resolve um problema específico: até aqui, o mesmo agente que
implementa também "aprova" o próprio trabalho — sem segregação de função. Em projeto que move
dinheiro ou guarda dado regulado (seu caso no NQuantic), isso é uma lacuna real.

### O que mudou
- **4 perfis de agente** em `_bks-ai/agents/`: `planner` (Sonnet, ≈ seu `/spec`), `builder` (Sonnet,
  ≈ seu `/loop`), **`reviewer`** (Opus, **novo** — revisão de segurança read-only, invocação
  separada), `scribe` (Haiku, ≈ parte do seu `/save`).
- **Comando novo `/revisao`** — dispara o `reviewer` contra uma entrega, com checklist de
  segurança (`_bks-ai/references/checklist-revisao-critica.md`): auth, isolamento multi-tenant,
  idempotência por constraint, zero float em campo monetário, segredos, etc.
- **Manifesto por projeto** (`_bks-ai/templates/manifesto-projeto.md`) — um arquivo
  `{repo}/.claude/multiagente.md` que declara: zonas de contenção (arquivos que toda mudança
  toca — `Program.cs`, migrations, ADRs), recursos numerados a reservar antes de paralelizar, e
  áreas sensíveis que exigem `/revisao` obrigatória.
- **Campo `criticidade`** na ficha do projeto (`_bks-ai/projects/{projeto}.md`): `padrao` | `alto` |
  `critico`. Só projetos **Alto**/**Crítico** exigem manifesto e `/revisao` obrigatória; em
  **Padrão** (caso do bks-marine hoje) é opcional.

> Regra zero da governança, direto da fonte: **"sequencial é o padrão; paralelo é a exceção que
> precisa ser justificada."** Isso não é sobre rodar agentes em paralelo — é sobre nunca aprovar
> o próprio trabalho quando o risco é alto.

### Exemplo de gap real que isso pega
No material de origem há um caso documentado: um agente implementou uma query de dashboard sem
filtro por `cliente_id` — vazando dado de todos os clientes. O próprio autor "sabia" que o filtro
estava lá, porque ele o pôs nas outras três queries do mesmo arquivo — viés de quem revisa a
própria obra. Só o `reviewer`, em invocação separada, achou. É esse tipo de erro que a segregação
de função existe para capturar — e que hoje seu LOOP-4 solo, sozinho, não pega.

### Quando ativar
Marque `criticidade: alto` (ou `critico`) na ficha do projeto, copie o
`_bks-ai/templates/manifesto-projeto.md` para `{repo}/.claude/multiagente.md`, preencha as zonas de
contenção e áreas sensíveis do seu domínio, e a partir daí `/revisao` passa a ser obrigatória
antes de aprovar entregas que tocam área sensível.

> **Candidato natural:** NQuantic (w3) — já bancário, já usa TXC com dado contábil. Ainda não tem
> o manifesto preenchido (fica no backlog do `PENDENCIAS.md`).

Detalhes de cada comando e exemplos práticos: ver `MANUAL-COMANDOS.md`.

---

## 10. Alimentando o cérebro de conhecimento (artigos, vídeos, PDFs, links)

O `_bks-ai/` só decide bem se o `knowledge/` tiver conteúdo — e alimentar essa
base é um hábito contínuo, não uma tarefa de setup única. O mecanismo já vem
pronto em `brain/knowledge/`:

1. **Fonte bruta entra em `raw/`**, na subpasta certa — `papers/` (PDFs,
   artigos acadêmicos), `articles/` (artigos web clipados em Markdown — o
   [Obsidian Web Clipper](https://obsidian.md/clipper) resolve isso direto do
   navegador), `videos/` (transcrições), `links/` (bookmarks ainda não
   processados), `notes/` (suas anotações soltas). `raw/` é **imutável**: uma
   vez lá, o arquivo não é editado — só a wiki curada evolui a partir dele.

2. **Peça a ingestão** ao Claude Code aberto em `brain/knowledge`:
   ```
   ingira raw/papers/nome-do-arquivo.pdf
   ```
   Para lote, preencha `tools/batch-ingest.md` (tabela fonte → prioridade) e
   peça "processe todas as fontes em tools/batch-ingest.md". O agente resume,
   decide a pasta certa da `wiki/` (`foundations/`, `patterns/`,
   `architecture/`, `ddd/`, `tdd/`, `sdd/`, `templates/`, `examples/`,
   `comparisons/`), cria/atualiza a página com frontmatter padronizado, e
   registra em `wiki/log.md` + `wiki/index.md`. Regras completas de curadoria:
   `brain/knowledge/CLAUDE.md`.

3. **Busque o que já existe** com `bash brain/knowledge/tools/search.sh
   "termo"` — o mesmo grep full-text que o `_bks-ai` usa para citar fonte antes
   de decidir arquitetura (seção 3.2).

4. **Peça curadoria periódica**: "faça um lint da wiki" revisita páginas
   `draft`, promove para `stable` ou marca pendência, e aponta lacunas.

> Quanto mais o `knowledge/` cresce com fonte própria, mais as decisões do
> `_bks-ai/` citam **sua** wiki em vez de "lembrar" do treinamento do modelo —
> é esse hábito, mantido sessão após sessão, que faz o segundo cérebro valer o
> esforço de manter.

---

## Apêndice A — Dashboards Dataview (cole numa `HOME.md`)

> Requer o plugin Dataview e frontmatter nas notas (Apêndice B). Repare que specs e ADRs agora
> ficam **dentro de cada repo**, então as queries apontam para `repos/`, não mais para `_bks-ai/`.

**Features por status (projeto bks-marine):**
````markdown
```dataview
table status, context as "Bounded Context"
from "repos/backside/bks-marine/specs/features"
where tipo = "feat"
sort status asc
```
````

**ADRs mais recentes (projeto bks-marine):**
````markdown
```dataview
table status, data
from "repos/backside/bks-marine/decisions"
where tipo = "adr"
sort data desc
limit 10
```
````

**Projetos ativos (fichas no workbench):**
````markdown
```dataview
table categoria, status, criticidade
from "brain/_bks-ai/projects"
sort projeto asc
```
````

## Apêndice B — Templates com frontmatter (Templater-ready)

**FEAT (`_bks-ai/templates/FEAT.md`, aplicado dentro de `{repo}/specs/features/`):**
```markdown
---
tipo: feat
projeto:
categoria:
context:
status: rascunho     # rascunho | aprovada | em-execucao | concluida
---
# FEAT-[nome]
**Bounded Context:** {{context}}
## Objetivo
## Regras de negócio
## Entidades e Value Objects
## Operações (use cases) e Pipeline (Minimal/Standard/Full)
## Integrações (TCP frames / filas / SEDA estágios)
## Fora de escopo
## Critérios de aceite (verificáveis — viram goals do LOOP-4)
- [ ] ...
```

**ADR (`_bks-ai/templates/ADR.md`, aplicado dentro de `{repo}/decisions/`):**
```markdown
---
tipo: adr
projeto:
status: aceita       # proposta | aceita | descartada | superada
data:
---
# ADR-NNN — [título]
## Contexto
## Decisão
## Alternativas descartadas e por quê
## Consequências
```

**Ficha de projeto (`_bks-ai/projects/{projeto}.md`):**
```markdown
---
projeto:
categoria:           # backside | w3 | private
status: design        # design | implementacao | pausado | concluido
criticidade: padrao   # padrao | alto | critico
repo:
---
# {Projeto}
## Resumo
## Bounded contexts
## Specs
- [[FEAT-...]]        (links para o repo do projeto)
## ADRs relevantes
- [[ADR-...]]          (links para o repo do projeto)
```

## Apêndice C — Referências para se especializar

Este padrão combina várias práticas que existem de forma independente na
literatura de engenharia. Para ir além deste guia e entender cada peça na
fonte original:

**Spec-Driven Development e desenvolvimento agêntico**
- [GitHub Spec Kit — documentação](https://github.github.com/spec-kit/) e [spec-driven.md](https://github.com/github/spec-kit/blob/main/spec-driven.md) — o toolkit que formalizou publicamente o fluxo spec-driven usado como base conceitual do `/spec` deste guia.
- [Meet GitHub Spec-Kit (MarkTechPost)](https://www.marktechpost.com/2026/05/08/meet-github-spec-kit-an-open-source-toolkit-for-spec-driven-development-with-ai-coding-agents/) — visão geral acessível do porquê SDD existe.

**Claude Code e agentes (fonte primária: Anthropic)**
- [Claude Code: Best Practices for Agentic Coding](https://www.anthropic.com/engineering/claude-code-best-practices) — inspira boa parte das convenções de `CLAUDE.md`/comandos usadas aqui.
- [How Claude Code is used in practice](https://www.anthropic.com/research/claude-code-expertise) — padrões reais de uso.
- [Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) — por que memória bem curada supera prompt longo — o argumento por trás do `_bks-ai/memory/`.
- [How we built our multi-agent research system (resumo por Simon Willison, com link ao original)](https://simonwillison.net/2025/Jun/14/multi-agent-research-system/) e [When to use multi-agent systems (and when not to)](https://claude.com/blog/building-multi-agent-systems-when-and-how-to-use-them) — fundamentam a seção 9 (governança multi-agente) e quando ela vale o custo.
- [Claude Agent SDK — visão geral](https://code.claude.com/docs/en/agent-sdk/overview) — para ir além do CLI e construir agentes customizados sobre a mesma base.

**Segundo cérebro / PKM**
- [Building a Second Brain × Zettelkasten](https://zettelkasten.de/posts/building-a-second-brain-and-zettelkasten/) — compara o método PARA (Tiago Forte) com a tradição Zettelkasten (Niklas Luhmann) — a raiz conceitual da separação em dois cérebros deste guia.
- [Obsidian Web Clipper](https://obsidian.md/clipper) — ferramenta prática para popular `knowledge/raw/articles/` direto do navegador.

**Arquitetura: Hexagonal, DDD, Pipeline, Result**
- [Hexagonal Architecture — Alistair Cockburn (fonte original)](https://alistair.cockburn.us/hexagonal-architecture) — o artigo que cunhou Ports & Adapters.
- [Implementing Domain-Driven Design — Vaughn Vernon (O'Reilly)](https://www.oreilly.com/library/view/implementing-domain-driven-design/9780133039900/ch04lev1sec3.html) — referência tática de DDD.
- [Hexagonal architecture pattern — AWS Prescriptive Guidance](https://docs.aws.amazon.com/prescriptive-guidance/latest/cloud-design-patterns/hexagonal-architecture.html) — versão aplicada/moderna.
- [Railway Oriented Programming — Scott Wlaschin](https://fsharpforfunandprofit.com/rop/) — base conceitual do Result Pattern.

**SEDA e TCP**
- [SEDA: An Architecture for Well-Conditioned, Scalable Internet Services (paper original, SOSP 2001)](https://www.sosp.org/2001/papers/welsh.pdf) — Matt Welsh et al.
- [Staged event-driven architecture — Wikipedia](https://en.wikipedia.org/wiki/Staged_event-driven_architecture) — resumo acessível.
- [Volatile and Decentralized: A Retrospective on SEDA](http://matt-welsh.blogspot.com/2010/07/retrospective-on-seda.html) — o próprio autor revisitando o que funcionou/não funcionou uma década depois; leitura essencial antes de aplicar SEDA de verdade.
- [Message Framing — Stephen Cleary](https://blog.stephencleary.com/2009/04/message-framing.html) e [Length-prefix framing for protocol buffers — Eli Bendersky](https://eli.thegreenplace.net/2011/08/02/length-prefix-framing-for-protocol-buffers) — o problema de framing em TCP e a implementação do padrão length-prefix usado neste stack.

**Qualidade de código**
- [Object Calisthenics — Jeff Bay (texto original)](https://bolcom.github.io/student-dojo/legacy-code/DevelopersAnonymous-ObjectCalisthenics.pdf) — as 9 regras por trás da disciplina cobrada nas revisões.
- [Object Calisthenics — William Durand](https://williamdurand.fr/2013/06/03/object-calisthenics/) — aplicação prática regra a regra.

