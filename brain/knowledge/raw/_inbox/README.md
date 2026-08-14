# _inbox — pasta drop-zone

Jogue aqui qualquer material bruto sem se preocupar em classificar: PDFs,
artigos em `.md`/`.html`, transcrições de vídeo, listas de links.

Depois, com o Claude Code aberto em `brain/knowledge`, rode:
```
/ingest raw/_inbox/
```
O agente classifica cada arquivo, move para a subpasta certa de `raw/`
(`papers/`, `articles/`, `videos/`, `links/`) e ingere tudo na wiki. Esta
pasta fica vazia depois — é só um ponto de entrada, não um lugar permanente.
