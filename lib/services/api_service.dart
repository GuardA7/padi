import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictionResult {
  final String
  prediction; // Ini akan berisi nama penyakit (label user-friendly)
  final double confidence;
  final String info;

  PredictionResult({
    required this.prediction,
    required this.confidence,
    required this.info,
  });
}

class ApiService {
  static const String _baseUrl = 'https://08c3-103-148-130-220.ngrok-free.app';

  static Future<PredictionResult> predictDisease(File imageFile) async {
    final uri = Uri.parse('$_baseUrl/predict');

    final request = http.MultipartRequest('POST', uri);
    request.files.add(
      await http.MultipartFile.fromPath('file', imageFile.path),
    );

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    print('Response status: ${response.statusCode}');
    print('Response body: $responseBody');

    if (response.statusCode == 200) {
      final data = json.decode(responseBody);

      return PredictionResult(
        prediction: data['label'], // Ambil label, bukan prediction
        confidence: (data['confidence'] as num).toDouble(),
        info: data['info'],
      );
    } else {
      throw Exception('Failed to get prediction: $responseBody');
    }
  }
}
