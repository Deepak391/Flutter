import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:notereader/model/item.model.dart';

class ApiService {
  static Future<List<Item>> fetchArticleList() async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<Item> data = jsonData.map((item) => Item.fromJson(item)).toList();
        return data;
      } else {
        throw Exception("Failed to fetch. Status code: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Error while fetching: $error");
    }
  }
}
