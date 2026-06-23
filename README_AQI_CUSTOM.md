# Integração Camada Qualidade do Ar (CUSTOM/Open-Meteo)

Este documento descreve a implementação técnica da camada de Qualidade do Ar (AQI) com dados reais, utilizando o provedor **Open-Meteo Air Quality**.

## Base de Dados
A API do Open-Meteo (European/US AQI Models) foi escolhida devido à inexistência de uma API nacional governamental em tempo real consolidada para JSON que suporte todas as regiões. O aplicativo consulta a qualidade do ar simultaneamente para as 27 principais capitais brasileiras, simulando as estações monitoras do IBAMA/CONAMA no território.

## Padrão CONAMA
Os valores brutos retornados pela API (US AQI) foram convertidos e enquadrados na classificação oficial do **CONAMA** (Conselho Nacional do Meio Ambiente) implementada no `AirQualityAlertMapper`:
- **Boa (0 a 40)**: Risco mínimo. Ícone: Verde.
- **Moderada (41 a 80)**: Sensíveis devem evitar esforço prolongado. Ícone: Amarelo.
- **Ruim (81 a 120)**: Grupos sensíveis podem ter impactos na saúde. Ícone: Laranja.
- **Muito Ruim (121 a 200)**: Risco geral para toda a população. Ícone: Vermelho.
- **Péssima (> 200)**: Condições de emergência na saúde pública. Ícone: Roxo.

## Interface Interativa
- **Legenda Inteligente**: Quando a camada de Qualidade do Ar está ativa no menu do mapa, uma caixa flutuante informativa (Legenda) aparece no canto inferior esquerdo detalhando as faixas de cores do padrão CONAMA.
- **Cache Seguro**: Os alertas ficam em `SharedPreferences` por 3 horas, garantindo visualização offline com a data da última aferição.

## Como Testar
1. Acesse o mapa e clique no botão de "Camadas".
2. Selecione "Qualidade do Ar".
3. A legenda "Qualidade do Ar (CONAMA)" aparecerá e marcadores interativos com ícone de ar serão distribuídos no mapa.
4. Clicando num marcador, você visualiza a mensagem explicativa daquele índice de poluição.
