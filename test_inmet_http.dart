import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  try {
    print('Fetching from INMET alertas2 http...');
    final response = await dio.get('http://alertas2.inmet.gov.br/api/avisos', options: Options(
      headers: {
        'User-Agent': 'Mozilla/5.0'
      }
    ));
    print('Status: ' + response.statusCode.toString());
    if (response.data is List && response.data.isNotEmpty) {
       print('First item: ' + response.data[0].toString());
    } else {
       print('Data: ' + response.data.toString().substring(0, 100));
    }
  } catch (e) {
    print('Error: ' + e.toString());
  }
}
