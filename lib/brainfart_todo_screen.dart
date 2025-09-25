import 'package:flutter/material.dart';
import 'package:OpenBreath/gemini_service.dart';
import 'dart:convert';

class BrainfartTodoScreen extends StatefulWidget {
  final String brainfartText;

  const BrainfartTodoScreen({super.key, required this.brainfartText});

  @override
  State<BrainfartTodoScreen> createState() => _BrainfartTodoScreenState();
}

class _BrainfartTodoScreenState extends State<BrainfartTodoScreen> {
  bool _isLoading = false;
  List<String> _todoItems = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _processBrainfartText();
  }

  Future<void> _processBrainfartText() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final geminiService = GeminiService();
      
      // Process the brainfart text using Gemini
      final response = await geminiService.processBrainfartText(widget.brainfartText);

      // Parse the response as JSON
      if (response != null) {
        try {
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
          
          final jsonResponse = jsonDecode(cleanResponse);
          if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('todos')) {
            final todos = jsonResponse['todos'] as List<dynamic>;
            setState(() {
              _todoItems = todos.map((item) => item.toString()).toList();
            });
          } else {
            // Fallback to simple sentence splitting
            _splitTextToTodos();
          }
        } catch (e) {
          print('JSON parsing error: $e');
          // Fallback to simple sentence splitting if JSON parsing fails
          _splitTextToTodos();
        }
      } else {
        // Fallback to simple sentence splitting if Gemini service fails
        _splitTextToTodos();
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to process brainfart text: $e';
      });
      // Fallback to simple sentence splitting
      _splitTextToTodos();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _splitTextToTodos() {
    // Simple fallback: split by sentences
    final sentences = widget.brainfartText.split(RegExp(r'[.!?]+'));
    setState(() {
      _todoItems = sentences
          .map((sentence) => sentence.trim())
          .where((sentence) => sentence.isNotEmpty)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brainfart To-Do'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Captured Thoughts:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(widget.brainfartText),
            ),
            const SizedBox(height: 24.0),
            if (_isLoading) ...[
              const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 24.0),
            ] else if (_error != null) ...[
              Text(
                'Error: $_error',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              const SizedBox(height: 24.0),
            ] else if (_todoItems.isNotEmpty) ...[
              Text(
                'To-Do List:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: ListView.builder(
                  itemCount: _todoItems.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        leading: const Icon(Icons.check_box_outline_blank),
                        title: Text(_todoItems[index]),
                      ),
                    );
                  },
                ),
              ),
            ] else ...[
              const Text('No actionable items found in your thoughts.'),
            ],
          ],
        ),
      ),
    );
  }
}