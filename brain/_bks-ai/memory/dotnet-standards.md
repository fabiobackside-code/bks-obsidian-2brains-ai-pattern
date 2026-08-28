# Padrões .NET — BKS Stack

## Regras de dependência
Core (Domain + Ports) <- Infrastructure (Adapters) <- API/Worker.
Domain nunca referencia infraestrutura. Domain/Core/Common sem
NuGet externo. Composition Root só em Program.cs.

## SingleProject (referência)
{ServiceName}/
  _Shared/Domain/Core/Common/Pipeline/ (Orchestrator, Steps)
  _Shared/Domain/Core/Common/Transactions/BaseTransaction.cs
  _Shared/Adapters/ (Inbound/API, Outbound/Persistence)
  Features/{Contexto}Context/{Entidade}/
    Domain/  Persistence/  {Operação}/ (Steps, Transactions, UseCase)

## MultiProject
{ServiceName}.Core / .Infrastructure / .API (ou .Worker)

## Solution e assercao (ADR-010, 27/08)
- Toda solution .NET 10 e `.slnx` (formato padrao do SDK 10). `.sln` classico
  so quando alguma ferramenta exigir.
- Assercao em teste: `Assert` nativo do xUnit. NUNCA FluentAssertions — a v8
  passou a licenca comercial paga (Xceed); a v7.x e a ultima Apache 2.0.

## Pipeline por complexidade
Rico: Full (Validation+Pre+Processing+Post)
CRUD: Minimal (GetById/List/Delete) ou Standard (Create/Update)

> Detalhes completos: skill bks-dotnet-solutions (entrevista obrigatória).
