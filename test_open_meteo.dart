import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  try {
    print('Fetching from Open-Meteo...');
    // Lats: Brasilia, Sao Paulo, Rio de Janeiro, Manaus, Salvador, Fortaleza, Belo Horizonte, Curitiba, Recife, Porto Alegre
    final lats = '-15.78,-23.55,-22.90,-3.11,-12.97,-3.73,-19.92,-25.42,-8.04,-30.03';
    final lons = '-47.92,-46.63,-43.20,-60.02,-38.50,-38.52,-43.93,-49.27,-34.87,-51.23';
    final response = await dio.get('https://api.open-meteo.com/v1/forecast?latitude=\$lats&longitude=\$lons&daily=precipitation_sum&timezone=America%2FSao_Paulo&forecast_days=1');
    print('Status: ' + response.statusCode.toString());
    if (response.data is List) {
       print('Returned array of size ' + response.data.length.toString());
       print('First: ' + response.data[0].toString());
    } else {
       print('Data: ' + response.data.toString());
    }
  } catch (e) {
    print('Error: ' + e.toString());
  }
}
