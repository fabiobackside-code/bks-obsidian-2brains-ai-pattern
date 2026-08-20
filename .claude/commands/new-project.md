NOTA (versao global): este comando opera sobre o vault em D:/Fabio/2b-projects/. Todos os caminhos abaixo sao absolutos de proposito — funciona rodando de qualquer cwd. Se voce nao estiver dentro do repo do projeto alvo, PERGUNTE qual projeto antes de agir.

Crie um projeto novo. Este é o ÚNICO comando de entrada para começar um projeto — roda na
raiz do vault (`2b-projects`).

Argumentos esperados: NOME do projeto e CATEGORIA (backside | w3 | private). Se algum faltar,
PERGUNTE antes de criar — nunca assuma. Confirme a árvore com o usuário antes de gerar os
arquivos.

Faça, nesta ordem:

1. Estrutura canônica em D:/Fabio/2b-projects/repos/{categoria}/{nome}/ (receita completa em
   D:/Fabio/2b-projects/brain/_bks-ai/templates/project-structure.md):
   app/, brain/knowledge/, brain/methodology/,
   specs/{features,tests,tasks}/, decisions/, outputs/,
   docs/input/{scope,interviews,research,assets}/, docs/design/,
   docs/canonical/, docs/prompts/, docs/history/

2. Wiring do repo:
   - CLAUDE.md — boot por CAMINHO ABSOLUTO carregando, nesta ordem:
     D:/Fabio/2b-projects/brain/_bks-ai/memory/user_profile.md, bks-premises.md, dotnet-standards.md, hot.md,
     D:/Fabio/2b-projects/brain/_bks-ai/projects/{nome}.md; declarar skills BKS aplicáveis (bks-sdd,
     bks-dotnet-solutions, bks-c4-diagrams); apontar specs para ./specs/ (do próprio repo) e
     domínio para ./brain/. Base: D:/Fabio/2b-projects/brain/_bks-ai/templates/REPO-CLAUDE.md.
   - README.md — gerar a partir de D:/Fabio/2b-projects/brain/_bks-ai/templates/PROJECT-README.md, preenchendo
     {ProjectName}/{category}/{date}. Este README é o guia de uso do projeto: onde entra
     material de apoio, como consolidar o canônico, como gerar o PRD, exemplos de prompt.
   - HOW-TO-WORK.md — fluxo fase pesquisa → fase código:
     /canonize → /prd → /spec → /arch → /loop → /save.
   - .gitignore — bin/ obj/ node_modules/ .env* *.pdf *.docx Thumbs.db .DS_Store

3. Workbench (fica em D:/Fabio/2b-projects/brain/_bks-ai, compartilhado):
   - D:/Fabio/2b-projects/brain/_bks-ai/projects/{nome}.md — ficha com frontmatter (projeto, categoria,
     criticidade, status: pesquisa, repo: D:/Fabio/2b-projects/repos/{categoria}/{nome}).

4. NÃO iniciar git (o humano faz nativo no Windows, dentro do próprio repo) e NÃO trazer
   material bruto — isso é passo manual do usuário, jogando em
   docs/input/{scope,interviews,research,assets}/ conforme o tipo (ver tabela no README
   gerado).

5. Reportar a árvore criada e o próximo passo: "traga material de apoio para docs/input/ e
   rode /canonize quando tiver o suficiente para consolidar o contexto."

Idioma: nomes de pasta/arquivo em inglês; conversa/conteúdo PT-BR; código em inglês (ou o que
o CLAUDE.md do projeto definir).