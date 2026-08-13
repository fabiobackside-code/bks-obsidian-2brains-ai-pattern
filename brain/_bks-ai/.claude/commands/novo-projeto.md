Crie um projeto novo seguindo templates/project-structure.md (receita canônica).

Argumentos esperados: NOME do projeto e CATEGORIA (backside | w3 | private).
Se algum faltar, pergunte antes de criar. Confirme a árvore antes de gerar.

Faça, nesta ordem:

1. Estrutura canônica em repos/{categoria}/{projeto}/:
   app/, brain/knowledge/, brain/methodology/,
   specs/{features,tests,tasks}/, decisions/,
   docs/{canonical,design,input,prompts,history}/

2. Wiring do repo (gerar a partir dos templates):
   - CLAUDE.md — boot por CAMINHO ABSOLUTO carregando, nesta ordem:
     memory/user_profile.md, memory/bks-premises.md, memory/dotnet-standards.md,
     memory/hot.md, projects/{projeto}.md; declarar skills BKS aplicáveis
     (bks-sdd, bks-dotnet-solutions, bks-c4-diagrams); apontar specs em
     ./specs/ (do próprio repo) e domínio em ./brain/. Base: templates/REPO-CLAUDE.md.
   - README.md — o que é, fase, stack (a definir), estrutura.
   - HOW-TO-WORK.md — fase design -> fase código (fluxo /brain /spec /arch /loop /save).
   - .gitignore — bin/ obj/ node_modules/ .env* *.pdf *.docx Thumbs.db .DS_Store

3. Workbench (fica em _bks-ai, compartilhado):
   - _bks-ai/projects/{projeto}.md — ficha com frontmatter
     (projeto, categoria, criticidade, status: design, repo: repos/{categoria}/{projeto}).

4. NÃO iniciar git (o humano faz nativo no Windows, dentro do próprio repo) e NÃO
   trazer material bruto (isso é passo manual: escopo -> docs/input/, domínio ->
   brain/knowledge/, etc.).

5. Reportar a árvore criada e o próximo passo sugerido: trazer material (docs/input)
   e rodar /spec da primeira feature (com o Claude Code aberto na raiz do repo).

Idioma: nomes de pasta/arquivo em inglês; conversa/conteúdo PT-BR; código em inglês
(ou o que o REPO-CLAUDE.md do projeto definir).
