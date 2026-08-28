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

## Legado .NET Framework 4.7.0 / .NET Core 2.1

Green field é sempre **.NET 10**. Quando o contexto obriga o legado, o padrão-base
continua valendo (Hexagonal, TXC, Pipeline, Result) — muda só a tecnologia de borda.

**Stack prescrita no 4.7.0 (não é opção, é o default do legado):**
- **Serviços expostos: WCF SOAP Services.** Contrato por `[ServiceContract]` /
  `[OperationContract]`; DTOs em `[DataContract]` / `[DataMember]`. O `.svc` e o WCF
  são **Adapter Inbound** — o contrato SOAP nunca vaza para o domínio: o adapter
  traduz o request no TXC e devolve o `Result<T>` mapeado. Sem regra de negócio
  dentro da classe de serviço.
- **Processos de background: Worker Service hospedado com TopShelf.** Um único
  executável console que roda como Windows Service (`Service.Install` /
  `Service.Uninstall`) e depura como console. `TopShelf` é só host — o `Start`/`Stop`
  aciona a mesma pipeline do domínio, nada de lógica no ponto de entrada.
- **Concorrência e estado no worker: Akka.NET.** Ator por unidade de estado; supervisão
  para reinicializar o ramo que falhou; mailbox no lugar de lock manual. Os atores são
  **infraestrutura de concorrência**, não o domínio — o ator recebe a mensagem, monta
  o TXC e chama a pipeline; a regra permanece testável sem `ActorSystem`.

**O que cai no 4.7.0 e o substituto:**

| No .NET 10 | No 4.7.0 |
|---|---|
| Minimal API | WCF SOAP (ou Web API 2 / OWIN quando o contrato for REST) |
| `record` | classe imutável (campos `readonly`, construtor completo, sem setter) |
| DI nativa (`IServiceCollection`) | container do host (Autofac / Unity) no Composition Root |
| `System.Text.Json` | `Newtonsoft.Json` (ou `DataContractSerializer` no caminho SOAP) |
| `IHostedService` / `BackgroundService` | TopShelf + Akka.NET |
| `IAsyncEnumerable` | `IEnumerable` + paginação explícita, ou TPL Dataflow |

> .NET Core 2.1 fica no meio: já tem DI nativa e `IHostedService`, **não tem** WCF
> server-side nem `record`. Tratar como .NET moderno com C# 7.3 — alvo de migração,
> não de projeto novo.

## Idioma do código
Inglês por padrão. **Exceção por projeto quando o repo definir** (ex.: NQuantic
usa pt-BR sem acentos). O `REPO-CLAUDE.md` de cada projeto manda.

## Comentário e documentação externa
Comentário no código é exceção, não regra: resumo de 1 linha em classe/método público
(`/// <summary>`, JSDoc, docstring) — nunca bloco explicando decisão ou histórico. Decisão
arquitetural, trade-off e dicionário de classes/funções vivem em `README.md` (visão geral)
e `ARCHITECTURE.md` (dicionário técnico + ADRs), gerados/atualizados a cada tarefa de
código — com ou sem bks-sdd. Detalhe em `documentacao.md`.

## Antes de gerar
Rodar a entrevista da skill BKS aplicável; consultar a wiki e CITAR a página;
o que for incerto, marcar `> [!uncertain]` — nunca chutar.
