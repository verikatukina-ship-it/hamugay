# Integração Camada Desmatamento (DETER/TerraBrasilis)

Este documento detalha a implementação da camada de desmatamento baseada em dados reais do sistema DETER via INPE/TerraBrasilis.

## Fonte de Dados
- **Serviço**: OGC Web Feature Service (WFS)
- **Endpoint Base**: `https://terrabrasilis.dpi.inpe.br/geoserver/ows`
- **Variável WFS**: `deter-amz:deter_amz` e outras se aplicáveis (atualmente parametrizado no `DeforestationAlertConfig`).
- **Formato**: GeoJSON (`outputFormat=application/json`)

## Estrutura de Cache
- **Arquitetura**: Utiliza `SharedPreferences` para armazenamento local.
- **TTL (Time to Live)**: 24 horas (`cacheTtlHours` no `DeforestationAlertConfig`).
- **Comportamento**: Como o serviço WFS do TerraBrasilis pode sofrer instabilidades e timeouts, a camada de acesso à rede tem um timeout curto configurado no `Dio`. Caso ocorra uma falha e já exista um dado cacheado localmente (mesmo que com mais de 24h), o app fará um *fallback* inteligente exibindo o cache mais recente possível, garantindo que o mapa não fique vazio para o usuário.

## Mapeamento e Regras de Negócio

### Extração de Polígonos
A integração não suporta apenas pontos, mas os verdadeiros polígonos das áreas desmatadas (`Polygon` e `MultiPolygon`).
O `DeforestationAlertMapper` faz a conversão de `FeatureCollection` do GeoJSON para listas de `LatLng` injetadas em um `PolygonLayer` no `flutter_map`.

### Cálculo de Centroide
Para as features com geometria poligonal, é realizado um cálculo simples de centroide. Isso nos dá uma coordenada central, que é usada para plotar um pino interativo (Marcador do ícone de árvore). Quando tocado, abre as informações específicas dessa mancha de desmatamento.

### Severidade e Cores
A severidade da infração ambiental é calculada automaticamente baseando-se na área afetada:
- **Área inexistente ou < 5 ha**: `ATENCAO` (Marrom mais claro / Laranja)
- **Área entre 5 e 20 ha**: `ALERTA` (Laranja avermelhado escuro)
- **Área > 20 ha**: `CRITICO` (Marrom e Vermelho Escuro)

### Performance
Um limite de `maxFeatures` foi incluído na URL parametrizada para prevenir gargalos de RAM do dispositivo (travamentos) causados por milhares de polígonos no mapa.
