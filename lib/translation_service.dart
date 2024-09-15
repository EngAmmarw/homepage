import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  final String apiKey = 'YOUR_GOOGLE_CLOUD_API_KEY'; // Add your API key here

  Future<String> translateText(String text, String targetLanguage) async {
    final String url =
        'https://translation.googleapis.com/language/translate/v2?key=$apiKey';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'q': text,
        'target': targetLanguage,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['data']['translations'][0]['translatedText'];
    } else {
      throw Exception('Failed to translate text');
    }
  }
}
