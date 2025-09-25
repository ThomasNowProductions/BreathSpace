import 'dart:convert';

void main() {
  // Test the parsing logic with the response we received from Gemini
  String response = '''```json
{
  "todos": []
}
```''';
  
  print('Raw response: $response');
  
  // Extract JSON from markdown code block if present
  String cleanResponse = response;
  if (cleanResponse.startsWith('```json')) {
    cleanResponse = cleanResponse.substring(7);
  }
  if (cleanResponse.endsWith('```')) {
    cleanResponse = cleanResponse.substring(0, cleanResponse.length - 3);
  }
  cleanResponse = cleanResponse.trim();
  print('Clean response: $cleanResponse');
  
  try {
    final jsonResponse = jsonDecode(cleanResponse);
    if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('todos')) {
      final todos = jsonResponse['todos'] as List<dynamic>;
      print('Parsed todos: $todos');
    }
  } catch (e) {
    print('JSON parsing error: $e');
  }
  
  // Test with a response that has actual todos
  String response2 = '''```json
{
  "todos": [
    "Call mom tomorrow",
    "Buy groceries",
    "Finish project by Friday"
  ]
}
```''';
  
  print('\nRaw response 2: $response2');
  
  // Extract JSON from markdown code block if present
  String cleanResponse2 = response2;
  if (cleanResponse2.startsWith('```json')) {
    cleanResponse2 = cleanResponse2.substring(7);
  }
  if (cleanResponse2.endsWith('```')) {
    cleanResponse2 = cleanResponse2.substring(0, cleanResponse2.length - 3);
  }
  cleanResponse2 = cleanResponse2.trim();
  print('Clean response 2: $cleanResponse2');
  
  try {
    final jsonResponse = jsonDecode(cleanResponse2);
    if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('todos')) {
      final todos = jsonResponse['todos'] as List<dynamic>;
      print('Parsed todos 2: $todos');
    }
  } catch (e) {
    print('JSON parsing error: $e');
  }
}