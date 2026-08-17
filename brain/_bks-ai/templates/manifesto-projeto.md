# Manifesto multi-agente — template BKS

Copie para `{repo}/.claude/multiagente.md` e preencha ao marcar um projeto como
**Alto** ou **Crítico** (campo `criticidade` na ficha `_bks-ai/projects/{projeto}.md`).
Sem manifesto preenchido, não paralelize — não delegue a `/review` obrigatória.
Curto de propósito: é lido em toda delegação, cada linha inútil custa token em toda sessão futura.

---

```markdown
# Manifesto multi-agente — <PROJETO>

**Criticidade:** Crítico | Alto | Padrão
**Atualizado:** <data>

## Comandos de verificação
- Build: `dotnet build`
- Teste: `dotnet test`
- E2E (se houver): `<comando + pré-requisitos>`

## Zonas de contenção
Exclusivas do orquestrador — subagentes descrevem, não editam:

| Arquivo | Por quê |
|---|---|
| `Program.cs` (Composition Root) | Todo registro de feature/adapter passa aqui |
| `{Feature}/{Operacao}/*Steps.cs` do Pipeline Orchestrator | Toda operação registra estágios aqui |
| `db/migrations/NNN_*` | Numeração colide |
| `decisions/ADR-NNN.md` (neste repo) | Numeração ADR-NNN colide |
| `_bks-ai/specs/{cat}/{proj}/spec/tasks/` (índice de tasks) | Numeração TASK-NNN colide |
| mocks/fixtures compartilhados de teste | Dois agentes editando a mesma struct |

## Recursos numerados compartilhados
Reservar ANTES de qualquer fan-out. A fonte da verdade é o repositório, não a spec:
```bash
ls db/migrations/ | tail -1
ls decisions/ | tail -1
ls _bks-ai/specs/{cat}/{proj}/spec/tasks/ | tail -1
```

## Zonas paralelizáveis
Dois agentes só ao mesmo tempo se cada um ficar inteiramente dentro de:
- `Features/{ContextoA}/` vs `Features/{ContextoB}/` (bounded contexts distintos)
- `FEAT-*.md`/`TEST-*.md` de features distintas em `_bks-ai/specs/`

## Áreas sensíveis — revisão independente obrigatória (`/review`)
- Autenticação/autorização (`Identidade/`, JWT, RBAC)
- Qualquer código que mova dinheiro, altere saldo ou grava contábil (TXC: `DataContabil`, `Nsu`)
- Isolamento entre tenants/inquilinos (`InquilinoId` no TXC)
- Dado pessoal/regulado (LGPD)
- Assinatura/validação de webhook, integração TCP externa

## Invariantes do domínio (o `reviewer` verifica explicitamente)
- Zero `float`/`double` em campo monetário — sempre `decimal`
- Idempotência por CONSTRAINT de banco, nunca só checagem em código
- Toda query filtra por `InquilinoId`/`tenant` — sem exceção, inclusive agregados/relatórios
- TXC é lido, nunca mutado pela aplicação (ver `wiki/patterns/txc-transaction-context.md`)
- `<invariantes específicas deste projeto>`

## Perfis disponíveis
| Perfil | Arquivo | Modelo |
|---|---|---|
| builder | `_bks-ai/agents/builder.md` | Sonnet |
| reviewer | `_bks-ai/agents/reviewer.md` | Opus |
| planner | `_bks-ai/agents/planner.md` | Sonnet |
| scribe | `_bks-ai/agents/scribe.md` | Haiku |

## Convenções — aponte, não repita
- Geral: `_bks-ai/memory/user_profile.md`, `_bks-ai/memory/bks-premises.md`
- .NET: `_bks-ai/memory/dotnet-standards.md` · Qualidade: `_bks-ai/memory/calisthenics.md`
- Domínio deste projeto: `{repo}/brain/`
```

## Como descobrir zonas de contenção (se ainda não souber)
```bash
git log --format="" --name-only -n 100 | sort | uniq -c | sort -rn | head -20
```
Arquivo que aparece sempre pelo mesmo motivo (append de registro, numeração, wiring) é zona de
contenção. Arquivo grande que muda por motivos variados é só um arquivo grande.
