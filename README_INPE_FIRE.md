# Integração de Focos de Queimadas do INPE no Hamugay App

Este documento descreve como a integração com os dados abertos do Instituto Nacional de Pesquisas Espaciais (INPE) via Programa BDQueimadas foi implementada no Hamugay App.

## Fonte de Dados

Utilizamos o satélite MODIS com dados das últimas 24 horas, que é o padrão da indústria para monitoramento ambiental rápido e preciso.

**URL de Consumo:** `https://dataserver.inpe.br/queimadas/queimadas/focos/csv/24h/Brasil_MODIS_24h.csv`

## Arquitetura e Cache

Para proteger o aplicativo contra lentidões e evitar acessos desnecessários à API do INPE, foi criado o `FireAlertCacheService`.
- **TTL (Time to Live):** 3 horas. Os dados no cache são válidos por até 3 horas.
- **Armazenamento Local:** As informações são cacheadas em JSON usando o `SharedPreferences`.

Se o aplicativo estiver sem internet ou o cache for válido, o mapa carrega instantaneamente usando os dados salvos em memória local.

## Regras de Negócio (Severidade)

A severidade (`AlertSeverity`) de um foco de calor é classificada dinamicamente pela classe `FireAlertMapper` com as seguintes regras:
- **Alerta (Vermelho):** Fogo detectado há 6 horas ou menos.
- **Atenção (Laranja):** Fogo detectado entre 6 e 24 horas.
- **Crítico (Roxo):** Independentemente da hora, se o "Fire Radiative Power" (FRP) ultrapassar 50 MW (MegaWatts).
- **Informativo (Amarelo):** Outros focos menores ou fora desses escopos críticos que aparecem na lista do INPE.

## Limitações do CSV do INPE

O CSV público do INPE pode ocasionalmente sofrer instabilidades em picos de acessos no Brasil e apresentar quebra de linhas inesperadas. 
Para resolver isso:
- Implementamos o pacote `csv` que consegue analisar e processar textos separados por vírgula mantendo a segurança nas _strings_ encapsuladas.
- Qualquer linha do arquivo que vier corrompida ou impossível de parsear pelo Dart será ignorada silenciosamente para não causar o _crash_ do aplicativo.

## Próximos Passos
Caso queiram alterar o satélite de MODIS para satélites da NASA (como Suomi NPP) ou dados agregados, basta trocar a constante em `lib/config/fire_alert_config.dart`.
