import 'dart:convert';
import 'package:test_app/models/book_model.dart';
import 'package:http/http.dart' as http;

const String endpoint = 'https://freetestapi.com/api/v1/books';

class ApiService {
  Future<List<Book>> fetch() async {
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);

      List<Book> books =
          body.map((dynamic book) => Book.fromJson(book)).toList();
      return books;
    } else {
      throw Exception('Failed to fetch books.');
    }
  }
}
