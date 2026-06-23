import 'package:dio/dio.dart';
import 'lib/config/rain_alert_config.dart';

void main() async {
  final dio = Dio();
  try {
    final rainUrl = RainAlertConfig.openMeteoUrl + '?latitude=' + RainAlertConfig.capitalsLats + '&longitude=' + RainAlertConfig.capitalsLons + '&daily=precipitation_sum&timezone=America/Sao_Paulo&forecast_days=1';
    final response = await dio.get(rainUrl);
    print('Rain Status: ' + response.statusCode.toString());
    if (response.data is List) {
      print('Is List');
    } else {
      print('Not list. Data type: ' + response.data.runtimeType.toString());
    }
  } catch (e) {
    print('Rain Error: ' + e.toString());
  }
}
