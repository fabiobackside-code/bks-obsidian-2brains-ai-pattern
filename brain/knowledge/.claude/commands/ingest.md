# /ingest — ingestão de conhecimento (fonte única, lote ou pasta drop-zone)

Uso:
```
/ingest raw/papers/nome.pdf         → ingere um PDF específico
/ingest raw/articles/nome.md        → ingere um artigo já salvo em Markdown
/ingest raw/articles/nome.html      → ingere uma página web salva localmente
/ingest raw/videos/nome-transcricao.md   → ingere uma transcrição de vídeo
/ingest https://exemplo.com/artigo  → busca o link, salva cópia em raw/, ingere
/ingest tools/batch-ingest.md       → processa a tabela de lote (várias fontes)
/ingest raw/_inbox/                 → classifica e processa TUDO que estiver na pasta
```

## Regras (sempre válidas, vêm de `../CLAUDE.md`)
- `raw/` é imutável: a fonte original nunca é editada, só lida e resumida.
- Toda página nova/atualizada em `wiki/` leva o frontmatter YAML padrão
  (ver `../CLAUDE.md` seção "YAML Frontmatter Standard").
- Atualize `wiki/index.md` e `wiki/log.md` ao final de CADA fonte processada.
- Se não for possível extrair conteúdo real (PDF protegido, vídeo sem
  transcrição disponível, link bloqueado/pago), PARE e diga isso —
  nunca invente o conteúdo a partir do nome do arquivo ou da URL.
- **Idempotência:** se a fonte já tem página correspondente na wiki (mesmo
  arquivo/URL registrado em `wiki/log.md`), NÃO reprocesse por conta própria —
  avise que já existe e pergunte se é para atualizar mesmo assim. Só force
  reprocessamento se o usuário pedir explicitamente.

## Passo a passo por tipo de fonte

**PDF / paper** (`raw/papers/*.pdf`) — leia o arquivo diretamente (PDFs longos:
leia por intervalo de páginas). Resuma, extraia os conceitos-chave, crie ou
atualize a página certa em `wiki/`.

**Artigo em Markdown** (`raw/articles/*.md`) — normalmente já veio de um
clipper (ex. Obsidian Web Clipper). Leia e cure normalmente.

**Página HTML salva localmente** (`raw/articles/*.html`) — leia o arquivo como
texto/markup e extraia o conteúdo relevante (ignore nav/menu/rodapé/scripts).
Se o HTML estiver muito ruidoso para uma boa curadoria, diga isso e sugira
salvar a página como Markdown antes (Obsidian Web Clipper, ou "Reader mode" +
copiar/colar).

**Link web ainda não salvo** (URL direta) — busque o conteúdo da URL. ANTES de
curar para a wiki, salve uma cópia do conteúdo extraído em
`raw/articles/<slug-do-titulo>.md`, com a URL original no topo do frontmatter —
isso preserva a fonte mesmo se a página sair do ar depois. Só então gere/edite
a página em `wiki/`.

**Vídeo** (`raw/videos/*`) — este comando NÃO transcreve áudio/vídeo sozinho.
Espera um arquivo de TEXTO (`.txt`, `.md` ou `.srt`) com a transcrição. Se
receber um `.mp4`/`.mov` diretamente, PARE e oriente a gerar a transcrição
antes — legendas exportadas do YouTube, ou uma ferramenta local de
transcrição (ex. Whisper) — nunca invente o conteúdo do vídeo a partir do
nome do arquivo ou da descrição.

**Lote via tabela** (`tools/batch-ingest.md`) — leia a tabela
(# | Type | Path or URL | Title | Priority). Processe uma fonte por vez, na
ordem `high` → `medium` → `low`, cada uma seguindo a regra do seu tipo acima
(`pdf`, `article` = markdown/html local, `video` = transcrição, `link` = URL).
Ao final, imprima um resumo linha a linha no formato:
```
✓ [prioridade] <arquivo/URL de origem> → <página(s) de wiki/ criada(s) ou atualizada(s)>
```
usando `✗ [prioridade] <origem> → falhou: <motivo>` para as que falharem —
uma falha não interrompe o processamento das demais linhas da tabela. Feche
confirmando que `wiki/index.md` e `wiki/log.md` foram atualizados.

**Pasta drop-zone** (`raw/_inbox/`, ou outra pasta que você indicar) — liste
todos os arquivos. Para cada um: identifique o tipo pela extensão/conteúdo
(`.pdf` → `papers/`, `.md`/`.html` de artigo → `articles/`, transcrição de
vídeo → `videos/`, lista de URLs → `links/`), MOVA para a subpasta correta
dentro de `raw/` (nunca deixe duplicado na `_inbox`), e então ingira cada um
normalmente pela regra do seu tipo. Ao final, resuma quantos arquivos de cada
tipo foram processados e para onde foram.
