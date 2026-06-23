import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  try {
    print('Fetching from Open-Meteo Air Quality...');
    final lats = '-15.78,-23.55,-22.90';
    final lons = '-47.92,-46.63,-43.20';
    final response = await dio.get('https://air-quality-api.open-meteo.com/v1/air-quality?latitude=\$lats&longitude=\$lons&current=european_aqi,us_aqi&timezone=America%2FSao_Paulo');
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
