# SEDA e TCP Sockets — minhas decisões padrão

## SEDA
- Estágios desacoplados por filas (in-proc Channels ou broker)
- Cada estágio: pool próprio, métrica própria, backpressure explícito
- Falha em estágio não derruba a pipeline: DLQ + retry policy

## TCP Sockets
- Frame length-prefix (4 bytes big-endian + payload)
- Heartbeat com timeout configurável; reconexão exponencial c/ jitter
- Parser tolerante a fragmentação (buffer acumulador)
- O socket é adapter: Inbound (server) / Outbound (client) — o Core
  só conhece a Port (interface de mensagens)
