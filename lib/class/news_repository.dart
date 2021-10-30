import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_for_pixaero/models/news_description.dart';

class NewsRepository {
  Future<List<NewsDescription>> getNews() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=0cdf0b3244a04ab2af8a0a8491df081f'));

    if (response.statusCode == 200) {
      final parsed =
          jsonDecode(response.body)["articles"].cast<Map<String, dynamic>>();

      return parsed
          .map<NewsDescription>((json) => NewsDescription.fromJson(json))
          .toList();
    } else {
      throw Exception('  ');
    }
  }
}
