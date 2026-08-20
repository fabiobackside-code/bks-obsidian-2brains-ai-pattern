NOTA (versao global): este comando opera sobre o vault em D:/Fabio/2b-projects/. Todos os caminhos abaixo sao absolutos de proposito — funciona rodando de qualquer cwd. Se voce nao estiver dentro do repo do projeto alvo, PERGUNTE qual projeto antes de agir.

Consolida o material de pesquisa (docs/input/ + docs/design/) de UM projeto em um contexto
canônico único — a fonte que vai alimentar o /prd e, depois, o /spec.

Este comando pode rodar aberto na raiz do vault (pergunte QUAL projeto,
D:/Fabio/2b-projects/repos/{categoria}/{projeto}) ou já dentro do repo do projeto (aí o projeto é óbvio, não
pergunte).

Pré-requisito: o projeto existe (foi criado com /new-project) e tem algo em docs/input/ e/ou
docs/design/. Se as duas pastas estiverem vazias, avise e pare — não invente contexto.

Faça, nesta ordem:

1. Leia TUDO em docs/input/{scope,interviews,research,assets}/ e docs/design/ (arquivos .md,
   .txt, .html; para PDF/docx, extraia o texto). NÃO leia brain/knowledge/ (isso é RAG de
   domínio do produto, não escopo/contexto) nem app/ (isso é código/experimento).

2. Monte um rascunho de docs/canonical/CONTEXT.md com, no mínimo, estas seções: Propósito do
   produto, Usuários/personas, Escopo (dentro/fora), Decisões já fixadas (com a fonte), Lacunas
   e perguntas em aberto, Glossário. Cite a fonte de cada afirmação relevante (ex.:
   "[docs/input/interviews/entrevista-01.md]").

3. Onde o material diverge ou é ambíguo, NÃO decida sozinho — marque
   `> [!uncertain] <pergunta objetiva>` no lugar e liste todas essas perguntas no fim, sob
   "## Perguntas em aberto". Pergunte ao usuário antes de fechar o documento, se possível.

4. Se já existir um docs/canonical/CONTEXT.md anterior: NÃO sobrescreva sem arquivar — copie a
   versão atual para docs/history/CONTEXT-v{N}-{YYYY-MM-DD}.md primeiro, incremente a versão no
   frontmatter do novo (version: N+1) e resuma o que mudou sob "## O que mudou desde v{N}".

5. Frontmatter obrigatório no CONTEXT.md:
   ---
   projeto: {nome}
   version: N
   status: rascunho | revisado
   atualizado: YYYY-MM-DD
   fontes: [lista dos arquivos de docs/input/ e docs/design/ usados]
   ---

6. Registre o critério usado nesta consolidação em docs/prompts/prompt-canonize-{YYYY-MM-DD}.md
   — é o que permite regerar ou auditar depois.

7. Reporte: o que entrou no canônico, quantas perguntas ficaram em aberto, e o próximo passo
   ("revise docs/canonical/CONTEXT.md, responda as perguntas em aberto se quiser fechar tudo, e
   rode /prd quando o contexto estiver bom o suficiente para virar requisito").

Nunca promova para canônico algo que você mesmo inventou para preencher lacuna — isso é
alucinação disfarçada de síntese. Marque como incerto e pergunte.