Dispare o agente `reviewer` (brain/_bks-ai/agents/reviewer.md) em invocação SEPARADA da sessão
de implementação — read-only, nunca quem escreveu o código revisando a si mesmo.

Argumento esperado: qual repo revisar (repos/{categoria}/{projeto}). Se não informado, pergunte
antes de continuar — nunca adivinhe o projeto ativo.

Pré-requisitos:
1. O projeto tem manifesto em {repo}/.claude/multiagente.md? Se não, PARE e oriente a criar a
   partir de brain/_bks-ai/templates/manifesto-projeto.md antes de revisar código crítico.
2. A mudança toca alguma "Área sensível" declarada no manifesto? Se não, revisão é opcional —
   não gaste Opus revisando mudança de documentação.

Contexto obrigatório para o reviewer:
- brain/_bks-ai/references/checklist-revisao-critica.md
- Seção "Invariantes do domínio" e "Áreas sensíveis" do manifesto do projeto
- {repo}/decisions/ (não repetir achado já decidido/aceito NESTE projeto)
- Diff ou arquivos específicos da entrega (não o repo inteiro)

Saída esperada: lista de achados no formato arquivo:linha/problema/exploração/severidade, ou
declaração explícita do escopo verificado se nada foi encontrado. Crítica bloqueia a entrega —
registre em {repo}/decisions/ e devolva ao builder para correção em invocação separada.
