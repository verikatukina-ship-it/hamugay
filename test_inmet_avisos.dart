import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  try {
    print('Fetching from INMET...');
    final response = await dio.get('https://apiprevmet3.inmet.gov.br/aviso/ativo');
    print('Status: ' + response.statusCode.toString());
    if (response.data is List && response.data.isNotEmpty) {
       print('First item: ' + response.data[0].toString());
    } else {
       print('Data: ' + response.data.toString());
    }
  } catch (e) {
    print('Error: ' + e.toString());
  }
}
