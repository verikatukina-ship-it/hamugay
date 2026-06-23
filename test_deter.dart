import 'package:dio/dio.dart';
import 'dart:convert';

void main() async {
  final dio = Dio();
  final url = 'https://terrabrasilis.dpi.inpe.br/geoserver/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=deter-amz:deter_amz&outputFormat=application/json&maxFeatures=5';
  
  try {
    print('Fetching from TerraBrasilis...');
    final response = await dio.get(url);
    print('Status: \${response.statusCode}');
    
    final Map<String, dynamic> data = response.data is String ? jsonDecode(response.data) : response.data;
    
    if (data.containsKey('features')) {
      final features = data['features'] as List;
      for (var f in features) {
         print(f['properties']);
         print(f['geometry']['type']);
      }
    }
  } catch (e) {
    print('Error: \$e');
  }
}
