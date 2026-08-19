# Guia: Gerando Telas e Protótipos de App com Claude

> Como sair de "contexto do app + logo + cores + concorrentes" até um conjunto de telas navegáveis, usando o plano Claude, com opção de integração MCP/Figma e handoff para código.

---

## 1. Qual ferramenta usar

Existem duas rotas dentro do seu plano Claude. Escolha pela sua necessidade:

| Rota | Quando usar |
|---|---|
| **Claude Design** (`claude.ai/design`) | Você quer uma interface visual dedicada (canvas + chat), com sistema de design reutilizável, comentários inline, exportação para PDF/PPTX/Figma-like/Canva/HTML e handoff direto pro código. **Recomendado para o seu caso.** |
| **Claude.ai chat + Artifacts (React/HTML)** | Você já está no chat normal e quer gerar 1-2 telas rápidas sem abrir um projeto separado. Mais leve, mas sem sistema de design persistente. |

Claude Design está disponível em beta para planos **Pro, Max, Team e Enterprise** (no Enterprise vem desligado por padrão, precisa ativar). Funciona no navegador (`claude.ai/design`) ou pela barra lateral do Claude Desktop. Todo o uso conta dentro do seu limite normal do plano — não existe cota separada.

---

## 2. Qual modelo usar

- Dentro do **Claude Design**, o modelo é aplicado automaticamente pela ferramenta — você não escolhe manualmente. A ferramenta já usa o modelo mais capaz disponível para geração visual.
- Se for pelo **chat normal (Artifacts)**, use **Claude Sonnet 5** para a maioria dos protótipos de UI — bom equilíbrio entre qualidade visual/código e custo de uso. Suba para o modelo mais avançado disponível no seu plano (Opus) apenas se as telas ficarem genéricas ou você precisar de raciocínio mais sofisticado sobre hierarquia visual/UX complexa.
- Não é necessário (nem recomendado) usar os modelos Mythos/Fable para isso — são voltados a outros casos de uso.

---

## 3. Passo a passo — do zero ao protótipo

### Passo 1 — Reunir o material antes de abrir o Claude Design
Separe com antecedência:
- **Contexto do app**: para quem é, que problema resolve, principais fluxos (ex.: onboarding, cadastro, tela principal, pagamento).
- **Logo**: arquivo (SVG/PNG) em fundo transparente.
- **Cores**: hex codes da marca (primária, secundária, neutras).
- **Concorrentes**: prints de tela ou links de 2-3 apps concorrentes que você admira ou quer superar.

Isso evita que o Claude "invente" uma identidade visual genérica.

### Passo 2 — Criar o projeto
1. Acesse `claude.ai/design`.
2. Clique em novo projeto.
3. A tela se divide em duas áreas: **chat** (esquerda) e **canvas** (direita).

### Passo 3 — Configurar o Sistema de Design (Design System)
1. No canto inferior esquerdo, clique no nome da organização/projeto.
2. Escolha **"New Design System"**.
3. Arraste os arquivos: logo, paleta de cores, prints dos concorrentes, guideline de marca (PDF/Word se tiver).
4. Clique em **"Generate System"** — Claude extrai hex codes, tipografia, espaçamentos e sugere componentes base (botão, card, etc.).
5. Revise o resultado. Se algo não bater com a marca, envie mais material e use **Remix** para regenerar.
6. Nomeie e publique (**Published = ON**). A partir daqui, todo novo projeto herda esse sistema automaticamente.

> Se você já tem um repositório de código (front-end existente), pode linkar o repo GitHub em vez de subir arquivos soltos — o Claude lê os componentes e tokens reais.

### Passo 4 — Adicionar contexto de concorrentes
No projeto (não no design system), anexe os prints dos concorrentes com uma instrução do tipo:
> "Aqui estão 3 apps concorrentes. Quero que nosso onboarding seja mais rápido que o do [Concorrente A] e mais visual que o do [Concorrente B]. Não copie o layout, use como referência de padrão de mercado."

### Passo 5 — Escrever o prompt inicial
Um bom prompt cobre 4 pontos: **objetivo, layout, conteúdo, público**. Exemplo:
> "Crie o fluxo de onboarding do [nome do app] em 4 telas: boas-vindas, cadastro, permissões e tela principal. Público: [ex. pequenos produtores rurais / gestores bancários]. Use o design system carregado. Modo Wireframe primeiro, depois evoluímos para alta fidelidade."

Dica: comece em **Wireframe** (estrutura) e só depois peça **High-Fidelity** (visual polido) — economiza iterações.

### Passo 6 — Refinar
- **Chat**: mudanças estruturais ("reorganize o dashboard", "mostre 2-3 layouts alternativos").
- **Comentários inline**: clique num elemento específico da tela e peça algo pontual ("aumente o padding deste botão").
- **Edição direta no canvas**: ajustes rápidos de espaçamento/cor/alinhamento.

### Passo 7 — Exportar / entregar
No botão **Export** (canto superior direito), as opções incluem:
- Download em `.zip`
- Exportar como PDF ou PPTX
- Enviar para Canva
- Exportar como HTML autônomo
- Enviar direto para Replit, Lovable, Vercel, Adobe, Miro, Wix, Base44, Gamma
- **Handoff para Claude Code** (local ou Claude Code Web) — transforma o protótipo em projeto real de código

---

## 4. Integração via MCP (para quem usa Claude Code / terminal)

Se preferir trabalhar pelo terminal (Claude Code) em vez do navegador:

```bash
# 1. Adicionar o servidor MCP do Claude Design
claude mcp add --scope user --transport http claude-design https://api.anthropic.com/v1/design/mcp

# 2. Autenticar
/design-login

# 3. Sincronizar o design system existente no projeto local
/design-sync
```

Depois disso, dá para criar/editar designs sem sair do terminal, importar o resultado direto no seu código, ou exportar como protótipo vivo.

### Sobre o Figma
Você já tem um conector MCP do Figma ativo neste workspace. Ele é útil em dois sentidos:
- **Entrada**: se você já tem telas ou um design system no Figma, pode usá-lo como referência/fonte em vez de recomeçar do zero.
- **Saída**: Claude Design não substitui o Figma para trabalho pixel-perfect colaborativo — ele é mais forte em velocidade de exploração e handoff para código. Para refinamento final de design system corporativo com múltiplos designers, o fluxo comum é: protótipo no Claude Design → ajuste fino no Figma (ou vice-versa).

---

## 5. Vídeos para estudar (YouTube)

1. **Claude Design Tutorial for Beginners (Full Walkthrough)** — visão geral prática para quem nunca usou.
   https://www.youtube.com/watch?v=CL2_prlfX9w

2. **Master Claude Design in 11 Minutes | 8 Real Use Cases** — vários casos de uso reais, incluindo apps.
   https://www.youtube.com/watch?v=nRFfVgTXMvs

3. **Claude Design: Full Walkthrough** — sessão ao vivo de quase uma hora, workflow completo ponta a ponta.
   https://www.youtube.com/watch?v=vyLaimDeK_g

4. **Claude Design: The Complete Guide** — cobre workflows com Claude Code e Figma.
   https://www.youtube.com/watch?v=eXlSgQmz02E

5. **Full Tutorial: From Idea to App with Claude Design and Claude Code in 25 Minutes** — processo de 6 passos: definir problema → design.md → protótipo no Claude Design → especificação HTML → app funcional.
   https://www.youtube.com/watch?v=G9o8eoHzpxc

6. **Claude Design Tutorial — Prototype Apps Fast** — foco em velocidade de prototipagem de apps.
   https://www.youtube.com/watch?v=NIM0prx3enY

---

## 6. Checklist rápido

- [ ] Reunir logo, paleta de cores e prints de concorrentes
- [ ] Criar Design System no Claude Design e publicá-lo
- [ ] Escrever prompt com objetivo + layout + conteúdo + público
- [ ] Gerar primeira versão em Wireframe
- [ ] Anexar concorrentes como referência (não cópia)
- [ ] Refinar via chat/comentários/canvas
- [ ] Evoluir para High-Fidelity
- [ ] Exportar (PDF/HTML/ZIP) ou fazer handoff para Claude Code
- [ ] (Opcional) Sincronizar com Figma via MCP para refino colaborativo

---

## 7. Referência oficial

- Documentação oficial: https://support.claude.com/en/articles/14604416-get-started-with-claude-design
- Setup do design system: https://support.claude.com/en/articles/14604397-set-up-your-design-system-in-claude-design
- Anúncio oficial da Anthropic: https://www.anthropic.com/news/claude-design-anthropic-labs
