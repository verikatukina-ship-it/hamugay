import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  try {
    print('Fetching from INPE...');
    final response = await dio.get('https://dataserver.inpe.br/queimadas/queimadas/focos/csv/24h/Brasil_MODIS_24h.csv');
    print('Status: ${response.statusCode}');
    print('Data length: ${response.data.length}');
  } catch (e) {
    print('Error: $e');
  }
}
