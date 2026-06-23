import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  try {
    print('Fetching from CEMADEN...');
    final response = await dio.get('http://sjc.salvar.cemaden.gov.br/resources/graficos/interativo/getJsonObject.php');
    print('Status: \${response.statusCode}');
    if (response.data is List && response.data.isNotEmpty) {
       print('First item: \${response.data[0]}');
    } else {
       print('Data: \${response.data.toString().substring(0, 100)}');
    }
  } catch (e) {
    print('Error: \$e');
  }
}
