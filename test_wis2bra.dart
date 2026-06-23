import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  try {
    print('Fetching from INMET wis2bra...');
    final response = await dio.get('http://wis2bra.inmet.gov.br/oapi/collections/urn:wmo:md:br:inmet:weather:cap/items?f=json');
    print('Status: ' + response.statusCode.toString());
    if (response.data is Map && response.data['features'] != null) {
       final features = response.data['features'] as List;
       if (features.isNotEmpty) {
          print('First feature: ' + features[0].toString());
       } else {
          print('No features');
       }
    }
  } catch (e) {
    print('Error: ' + e.toString());
  }
}
