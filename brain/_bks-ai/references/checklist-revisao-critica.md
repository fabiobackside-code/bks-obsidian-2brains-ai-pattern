# Checklist do portão de revisão — reviewer

Usado pelo agente `reviewer`. Ler quando a mudança toca área declarada sensível no manifesto do
projeto (`{repo}/.claude/multiagente.md`). Cada item exige `arquivo:linha`, não "parece ok".

## Núcleo (qualquer domínio)
- Auth: toda operação que lê/altera dado de titular exige credencial válida? O identificador do
  titular vem DA CREDENCIAL, nunca da URL/corpo? Ownership verificado contra o dono real?
- Multi-tenant/inquilino: toda query filtra por `InquilinoId` — sem exceção, inclusive
  agregados/relatórios? Existe teste "tenant A não enxerga dado de B"?
- Injeção: toda query usa parâmetro vinculado — zero concatenação de string?
- Segredos: nenhum token/chave/senha commitado ou logado, nem em debug?
- Resiliência: falha de terceiro nunca desfaz operação já confirmada; timeout explícito em toda
  chamada de saída; falha deixa rastro reprocessável (estado + motivo persistidos).
- Idempotência: garantida por CONSTRAINT de banco, não só checagem em código (dois processos
  concorrentes passam pela checagem lógica ao mesmo tempo).
- Auditoria: operação bloqueada por regra crítica deixa registro imutável (insert-only).

## Perfil financeiro (TXC com valor monetário)
- Zero `float`/`double` em campo monetário — busca por `float`/`double` no diff volta vazia?
- Unidade consistente por camada (menor unidade no banco, `decimal` no domínio, string na API).
- Decomposição de valor fecha a soma; sobra de arredondamento tem destino único e definido.
- Reversão é proporcional; nada reverte valor já liquidado sem bloqueio explícito.

## Perfil dado pessoal/regulado (LGPD)
- Dado sensível minimizado — só o que a operação exige.
- Log/telemetria não carregam dado identificável.
- Existe caminho de exclusão/anonimização que remove o dado dos rastros.

## Perfil webhook/assinatura
- Assinatura validada ANTES de qualquer efeito colateral; comparação em tempo constante.
- Corpo usado no cálculo é o bruto recebido, não re-serializado.
- Mensagem repetida é idempotente.

## Formato do achado
```
ARQUIVO:LINHA
Problema: <uma frase>
Exploração: <entrada concreta → efeito concreto>
Severidade: crítica | alta | média | baixa
```
Crítica bloqueia entrega. Reviewer não propõe refatoração ampla — aponta o problema e o menor
caminho de correção; quem corrige é o `builder`, em invocação separada.

Fonte: adaptado de github.com/DiegoAmorimDev/bks-multiagent-skill (MIT) para o vocabulário BKS.
