import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  try {
    print('Fetching from Open-Meteo Air Quality Single...');
    final response = await dio.get('https://air-quality-api.open-meteo.com/v1/air-quality?latitude=-23.55&longitude=-46.63&current=european_aqi,us_aqi&timezone=America%2FSao_Paulo');
    print('Status: ' + response.statusCode.toString());
    if (response.data is Map) {
       print('Data: ' + response.data['current'].toString());
    } else {
       print('Data: ' + response.data.toString());
    }
  } catch (e) {
    print('Error: ' + e.toString());
  }
}
