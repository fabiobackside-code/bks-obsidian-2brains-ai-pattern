# Batch Ingest List

Preencha esta tabela com as fontes a processar, depois rode:
```
/ingest tools/batch-ingest.md
```

## Sources

| # | Type  | Path or URL                                          | Title (optional)                  | Priority |
|---|-------|-------------------------------------------------------|------------------------------------|----------|
| 1 | pdf   | raw/papers/hexagonal-architecture-cockburn.pdf         | Hexagonal Architecture (Cockburn)  | high     |
| 2 | video | raw/videos/palestra-seda-welsh-transcricao.md          | Retrospectiva SEDA — Matt Welsh    | high     |
| 3 | link  | https://fsharpforfunandprofit.com/rop/                 | Railway Oriented Programming       | medium   |
| 4 | pdf   | raw/papers/object-calisthenics-jeff-bay.pdf            | Object Calisthenics — Jeff Bay     | low      |

## Instructions for this batch

Foco em arquitetura e qualidade de código — ligar cada fonte às páginas já
existentes em wiki/architecture/ e wiki/patterns/ quando fizer sentido.

> Isto é um exemplo preenchido para referência. Apague as linhas de exemplo e
> substitua pelas suas próprias fontes antes de rodar o `/ingest` de verdade.
