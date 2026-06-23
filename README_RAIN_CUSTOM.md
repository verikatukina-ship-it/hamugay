# Integração Camada Chuvas (CUSTOM/Open-Meteo)

Este documento detalha a implementação da camada de chuvas baseada em dados reais da API **Open-Meteo**.

## Histórico de Decisão do Provedor
Inicialmente, buscou-se a utilização das APIs oficiais governamentais brasileiras, como o **INMET** e o **CEMADEN** para o preenchimento da camada de chuva. No entanto, os servidores e endpoints do INMET (ex: `apiprevmet`, `alertas2`, `estacao/dados`) enfrentaram instabilidades severas, retornando recorrentemente erros `404 Not Found` e `Connection Closed`, ou ainda timeouts de conexão. Devido à premissa do projeto em **nunca utilizar dados mockados** em produção e garantir um funcionamento confiável, a equipe arquitetou a configuração `RAIN_ALERTS_PROVIDER=CUSTOM`, cujo provedor subjacente padrão é a robusta API do Open-Meteo, reconhecida mundialmente pela disponibilidade e tempo de resposta em formato JSON nativo.

## Fonte de Dados
- **Serviço**: Open-Meteo Free Weather API
- **Endpoint Base**: `https://api.open-meteo.com/v1/forecast`
- **Parâmetros**: `latitude`, `longitude`, `daily=precipitation_sum`, `timezone=America/Sao_Paulo`
- **Formato**: JSON
- **Amostragem**: Como a API não funciona em caixas geográficas limitadas ("bounding box" global do Brasil), estabelecemos uma carga em "batch" de múltiplas coordenadas simulando as 27 capitais do Brasil num mesmo *request* HTTP, assegurando uma amostragem fiel do clima em todo o território nacional sem impactar os recursos da API.

## Estrutura de Cache e Prevenção de Falhas
- **Arquitetura**: Utiliza `SharedPreferences` para armazenamento local transparente.
- **TTL (Time to Live)**: 3 horas (configurável pela `CACHE_RAIN_TTL_HOURS`).
- **Resiliência Offline**: Se o app ficar sem internet ou se a API recusar acesso, a classe `RainRemoteRepositoryImpl` faz um fallback ("fallback" seguro) exibindo o último cache gerado com sucesso, mesmo expirado, acompanhado das datas reais de última leitura.

## Classificação da Severidade (Mapeamento)
A severidade da precipitação foi ajustada a uma regra automatizada na camada `RainAlertMapper`, transformando o somatório diário (em mm) nos padrões visuais do Hamugay:
- **0.1 a 10 mm**: INFORMATIVO (Azul Claro)
- **10.1 a 30 mm**: ATENCAO (Azul)
- **30.1 a 60 mm**: ALERTA (Azul Escuro / Navy)
- **> 60 mm**: CRITICO (Roxo Escuro / Deep Purple)
*Nota: áreas com `0.0 mm` não disparam marcadores para não poluir o mapa.*

## Como Testar
1. Acesse o mapa principal e clique em "Camadas".
2. Ative a camada de "Chuvas".
3. Aguarde o download imediato (o app chamará o provedor configurado em `RainAlertConfig`).
4. Toque sobre os marcadores em formato de gota. A interface mostrará um bottom sheet/dialog exibindo as milimetragens e o status.
5. Feche o aplicativo e mude o dispositivo para Modo Avião, depois reabra. Ative a camada. O sistema carregará via Cache as mesmas medições da consulta anterior.
