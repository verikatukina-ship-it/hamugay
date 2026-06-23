import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  final capitals = [
    {'name': 'Porto Velho/RO', 'lat': -8.7619, 'lon': -63.9039},
    {'name': 'Rio Branco/AC', 'lat': -9.974, 'lon': -67.807},
  ];

  try {
    print('Testing Air Quality...');
    final futures = capitals.map((capital) async {
      try {
        final lat = capital['lat'] as double;
        final lon = capital['lon'] as double;
        final url = 'https://air-quality-api.open-meteo.com/v1/air-quality?latitude=\$lat&longitude=\$lon&current=us_aqi&timezone=America/Sao_Paulo';
        
        final response = await dio.get(
          url,
          options: Options(
            receiveTimeout: const Duration(seconds: 10),
            sendTimeout: const Duration(seconds: 10),
          ),
        );
        print('AQI Status for \$lat: \${response.statusCode}');
        return response.data;
      } catch (e) {
        print('AQI Error: \$e');
        return null;
      }
    });
    await Future.wait(futures);

    print('Testing Rain...');
    final rainUrl = 'https://api.open-meteo.com/v1/forecast?latitude=-8.7619,-9.974&longitude=-63.9039,-67.807&daily=precipitation_sum&timezone=America/Sao_Paulo';
    final rainResponse = await dio.get(rainUrl);
    print('Rain Status: \${rainResponse.statusCode}');
    if (rainResponse.data is List) {
       print('Rain Data length: \${rainResponse.data.length}');
    }

  } catch (e) {
    print('Global Error: \$e');
  }
}
