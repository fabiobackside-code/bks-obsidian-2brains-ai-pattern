# Documentação — comentário mínimo, README + ARCHITECTURE.md

Código não se documenta a si mesmo com comentário. A intenção e a decisão vivem fora dele.

## Comentário no código
- Proibido: bloco explicando decisão arquitetural, trade-off ou histórico — isso é ADR,
  vai para `ARCHITECTURE.md`, nunca para o código.
- Proibido: comentário que só repete o nome do método/variável.
- Permitido: resumo de 1 linha em classe pública e método público não trivial
  (`/// <summary>` em C#, JSDoc em TS, docstring em Python) — o **quê** faz, nunca o **como**.
- Exceção rara: "gotcha" não óbvio (workaround de bug externo, ordem de chamada imposta
  por lib de terceiro). Pontual, não regra.

## README.md (raiz do projeto)
Geral, funcional. O que é · como rodar · estrutura de pastas (1 nível) · stack · links
(`ARCHITECTURE.md`, `docs/design/`, `specs/`). Nunca ADR nem detalhe classe-a-classe.

## ARCHITECTURE.md (raiz do projeto) — dicionário técnico vivo
Índice interno + visão de camadas + ADRs (curto: Contexto/Decisão/Consequência — linka
`decisions/` se a pasta já existir no projeto, sem duplicar) + dicionário por
módulo/classe/função relevante gerada ou alterada.

## Quando gerar/atualizar
A cada tarefa que cria ou altera classe, função pública ou decisão estrutural — antes de
encerrar a tarefa, com ou sem `bks-sdd`. Comportamento automático, não se pergunta se deve
fazer.

## Retrofit em repositório já finalizado
Skills BKS (`bks-dotnet-solutions`, `bks-typescript-backend`, `bks-sdd`) aplicam este padrão
só na hora de GERAR código novo — não auditam código já pronto sozinhas. Repo finalizado antes
desta regra existir precisa de uma passada dedicada:

1. **Fazer por módulo/feature, nunca o repo inteiro de uma vez.** Repo grande estoura contexto
   e a revisão do diff fica inviável.
2. Para cada classe/método público: reduzir comentário de bloco a um resumo de 1 linha
   (`/// <summary>`/JSDoc/docstring); qualquer decisão/trade-off que estava no comentário vira
   entrada em `ARCHITECTURE.md`, não é descartada.
3. Gerar/atualizar `README.md` e `ARCHITECTURE.md` na raiz a partir do que já existe no repo —
   é engenharia reversa: ler a estrutura e os comentários antes de apagá-los, extrair o
   dicionário de classes/funções e as decisões que davam pra inferir. Marcar `> [!uncertain]`
   o que não dá pra confirmar sem o autor original.
4. Se o repo já tem `decisions/` (ADRs), `ARCHITECTURE.md` linka pra lá; senão, ADR inferido
   entra inline, marcado como reconstruído (não é o registro original da decisão).
5. Revisar o diff antes de aceitar — retrofit de comentário é edição, não geração; não é pra
   rodar "às cegas" em lote.

Prompt-modelo pra rodar por módulo:
> "Aplique `documentacao.md` neste módulo/pasta: reduza os comentários de bloco a resumo de
> 1 linha por classe/método público, mova decisão/trade-off pra `ARCHITECTURE.md`, e
> atualize `README.md`/`ARCHITECTURE.md` com o que existe aqui hoje. Me mostre o diff antes
> de aplicar."

Complementar: se o repo também precisa de diagrama C4 atualizado a partir do código legado,
usar a skill `bks-c4-diagrams` no modo "Reengenharia de Legado" (analisa `\src`/`\docs`).
