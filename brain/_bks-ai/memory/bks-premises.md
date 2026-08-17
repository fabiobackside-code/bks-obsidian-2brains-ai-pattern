# Premissas de Codificação BKS (fonte de verdade)

Este arquivo governa COMO o gêmeo gera código — é conhecimento sobre MÉTODO,
compartilhado entre todos os projetos. Nunca deve citar decisão ou nome real
de um projeto como parte da regra em si; exemplos de projeto real (quando
ajudam a ilustrar) vêm só ao final de cada ponto, entre parênteses.
Autoridade, nesta ordem:
1. Skills BKS globais: `bks-dotnet-solutions`, `bks-sdd`, `bks-c4-diagrams`,
   `bks-typescript-backend` (prescritivas, conduzem entrevista antes de gerar).
2. Exemplares reais de aplicação — cada projeto guarda os seus em
   `repos/{cat}/{proj}/brain/methodology/` (ex.: `repos/w3/nquantic/brain/methodology/`
   tem as skills de domínio bancário aplicadas). Consulte o do projeto atual.
3. Wiki de conhecimento em `../../knowledge/wiki/` (fundamentos e trade-offs,
   sempre agnóstica de projeto).

## Princípio-mestre: pragmatismo token-aware
Cada arquivo extra é token extra; cada indireção é ruído que compete com a
lógica que importa (ver `wiki/architecture/arquitetura-custo-contexto-ia.md`).
**Gere a solução mais simples que resolve o problema.** Abstração é custo —
só entra quando paga o próprio preço. Refatorar código simples com IA é mais
barato que navegar abstração que tentou adivinhar o futuro (YAGNI).

## Padrão-base: Hexagonal + Pipeline + TXC + Result
- **Hexagonal real, não ritualística:** domínio referencia só `System.*`;
  infra entra por Porta. Sem camadas/arquivos que não carregam valor.
- **TXC (Transaction Context):** estado transacional em um `record` imutável
  que flui pela pipeline; a aplicação lê, não muta. Conceito geral em
  `wiki/patterns/txc-transaction-context.md`; aplicação concreta de cada
  projeto fica no `brain/methodology/` do repo dele.
- **Pipeline explícito:** Validação → Idempotência → Enriquecimento →
  Processamento → PósProcessamento. **NUNCA MediatR** — orquestração explícita.
- **Result Pattern:** operações retornam um tipo `Result<T>` (ou o equivalente
  que o projeto definir — ex.: `NqResultado<T>` no NQuantic); exceptions de
  negócio não escapam da pipeline.
- Observabilidade embutida nos estágios (spans automáticos, sem `Activity` à mão).

## DDD e Object Calisthenics: por julgamento, não por ritual
Aplicar quando o domínio justifica (regras ricas, invariantes reais), não
como cerimônia obrigatória:
- Value Objects: para invariantes de verdade — não embrulhe todo primitivo.
- Bounded Contexts explícitos: quando há complexidade essencial que os separe.
- Calisthenics (sem ELSE, 1 nível de indentação, first-class collections,
  Tell-Don't-Ask): guia de qualidade, aplicado onde melhora leitura — não
  dogma que gera classes artificiais.
> Regra prática: se uma abstração não reduz complexidade essencial nem risco
> real, ela é complexidade acidental. Corte.

## Idioma do código
Inglês por padrão. **Exceção por projeto quando o repo definir** (ex.: NQuantic
usa pt-BR sem acentos). O `REPO-CLAUDE.md` de cada projeto manda.

## Antes de gerar
Rodar a entrevista da skill BKS aplicável; consultar a wiki e CITAR a página;
o que for incerto, marcar `> [!uncertain]` — nunca chutar.
