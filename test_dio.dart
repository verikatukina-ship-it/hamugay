import 'package:dio/dio.dart';
import 'lib/data/mappers/air_quality_alert_mapper.dart';
import 'lib/data/mappers/rain_alert_mapper.dart';

void main() async {
  final dio = Dio();
  try {
    final rainUrl = 'https://api.open-meteo.com/v1/forecast?latitude=-8.7619,-9.974&longitude=-63.9039,-67.807&daily=precipitation_sum&timezone=America/Sao_Paulo&forecast_days=1';
    final response = await dio.get(rainUrl);
    final alerts = RainAlertMapper.fromOpenMeteoJson(response.data);
    print('Rain mapped: ' + alerts.length.toString());
  } catch (e) {
    print('Rain Error: ' + e.toString());
  }

  try {
    final aqiUrl = 'https://air-quality-api.open-meteo.com/v1/air-quality?latitude=-8.7619&longitude=-63.9039&current=us_aqi&timezone=America/Sao_Paulo';
    final response = await dio.get(aqiUrl);
    final entity = AirQualityAlertMapper.fromOpenMeteoJson(response.data, 'Mock', 'BR', -8.7619, -63.9039);
    print('AQI mapped: ' + entity!.aqi.toString());
  } catch (e) {
    print('AQI Error: ' + e.toString());
  }
}
