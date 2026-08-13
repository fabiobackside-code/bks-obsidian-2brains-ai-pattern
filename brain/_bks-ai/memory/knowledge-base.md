# Cérebro de Conhecimento — como consultar

A wiki de estudo vive em `../../knowledge/` (migrada de `X:\llm-base-conhecimento`;
X: é só backup, não usar). É a fonte para fundamentar decisões e reduzir alucinação.

## Regra
Antes de decidir arquitetura, padrão ou trade-off, CONSULTE a wiki e CITE a
página usada. Se a wiki não cobrir o tema, diga isso — não invente.

## Como pesquisar
- Busca full-text: `bash ../../knowledge/tools/search.sh "<termo>"`
- Catálogo: `../../knowledge/wiki/index.md`
- Schema/regras da wiki: `../../knowledge/CLAUDE.md`

## O que já existe (temas fortes)
Hexagonal / ports & adapters, DDD (fundamentos, ubiquitous language),
microserviços (API gateway, tracing, transações distribuídas, EIP),
Spec-Driven Development, harness engineering, context windows / custo de
tokens, C4 Model, TOGAF, TCP sockets. ~43 páginas curadas em `wiki/`.

## Ingerir nova fonte
Coloque o arquivo em `../../knowledge/raw/{papers|articles|videos|notes}/`
e peça: "ingira raw/...". O assistente cria/atualiza a página e registra em
`wiki/index.md` + `wiki/log.md`. Nunca edite `raw/` (imutável).
