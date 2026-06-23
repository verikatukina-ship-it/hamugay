import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  try {
    print('Fetching from INMET condicoes...');
    final response = await dio.get('https://apitempo.inmet.gov.br/condicoes');
    print('Status: ' + response.statusCode.toString());
    if (response.data is List && response.data.isNotEmpty) {
       print('First item: ' + response.data[0].toString());
    }
  } catch (e) {
    print('Error: ' + e.toString());
  }
}
