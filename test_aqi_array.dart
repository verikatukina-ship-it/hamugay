import 'package:dio/dio.dart';
import 'lib/config/air_quality_alert_config.dart';
import 'lib/config/rain_alert_config.dart';

void main() async {
  final dio = Dio();
  try {
    final aqiUrl = AirQualityAlertConfig.openMeteoUrl + '?latitude=' + RainAlertConfig.capitalsLats + '&longitude=' + RainAlertConfig.capitalsLons + '&current=us_aqi&timezone=America/Sao_Paulo';
    final response = await dio.get(aqiUrl);
    print('AQI Status: ' + response.statusCode.toString());
    if (response.data is List) {
      print('AQI is List, length: ' + response.data.length.toString());
    } else {
      print('AQI not list. Data type: ' + response.data.runtimeType.toString());
    }
  } catch (e) {
    if (e is DioException) {
      print('AQI Error: ');
      print(e.response?.data);
    } else {
      print('AQI Error: ');
      print(e);
    }
  }
}
