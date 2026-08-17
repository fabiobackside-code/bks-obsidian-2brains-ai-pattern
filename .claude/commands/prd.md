Gera um PRD inicial a partir do contexto canônico já consolidado — é a ponte entre /canonize e
/spec.

Pode rodar na raiz do vault (pergunte QUAL projeto) ou já dentro do repo do projeto.

Pré-requisito: docs/canonical/CONTEXT.md existe e está pelo menos com status "rascunho" no
frontmatter. Se não existir, PARE e oriente a rodar /canonize primeiro — nunca gere PRD direto
de docs/input/ ou docs/design/.

Faça, nesta ordem:

1. Leia docs/canonical/CONTEXT.md (e o PRD anterior em docs/canonical/PRD-{projeto}.md, se
   existir, para saber o que já foi decidido e não regredir).

2. Se a skill `bks-sdd` estiver disponível, use a estrutura de PRD dela como referência de
   forma; senão, gere com estas seções: Problema, Objetivo e métrica de sucesso,
   Usuários/personas, Escopo (fora do escopo também), Requisitos funcionais macro (numerados),
   Requisitos não-funcionais, Fases sugeridas (se o escopo for grande), Riscos, Perguntas em
   aberto herdadas do CONTEXT.md que ainda bloqueiam alguma decisão.

3. Todo requisito no PRD tem que rastrear de volta a uma seção do CONTEXT.md — não invente
   requisito sem base no contexto consolidado. Se notar uma lacuna real do CONTEXT.md necessária
   pro PRD, pare e aponte antes de preencher com suposição.

4. Salve em docs/canonical/PRD-{projeto}.md, com frontmatter:
   ---
   projeto: {nome}
   version: N
   baseado_em: docs/canonical/CONTEXT.md (vN)
   status: rascunho
   atualizado: YYYY-MM-DD
   ---
   (mesma regra de versionamento do /canonize: se já existir PRD anterior, arquive em
   docs/history/PRD-v{N}-{YYYY-MM-DD}.md antes de sobrescrever.)

5. Reporte o PRD gerado e o próximo passo: "revise o PRD, feche o que ainda está em aberto, e
   rode /spec (na raiz deste repo) para a primeira feature — a partir de agora, /spec só deve
   citar docs/canonical/ (CONTEXT.md e PRD-*.md), nunca docs/input/ ou docs/design/ direto."

O PRD e o CONTEXT.md em docs/canonical/ são, a partir deste ponto, a ÚNICA fonte que o /spec
deve usar. Se um /spec futuro citar algo de docs/input/ ou docs/design/ diretamente, isso é
sinal de que o canônico ficou incompleto — rode /canonize de novo antes de seguir.
