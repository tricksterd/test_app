import 'package:flutter/material.dart';
import 'package:test_app/models/book_model.dart';
import 'package:test_app/services/api_service.dart';

class BookProvider extends ChangeNotifier {
  List<Book> books = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String choosenSorting = 'Alphabetical';

  final ApiService _apiService = ApiService();

  BookProvider() {
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    isLoading = true;

    try {
      books = await _apiService.fetch();
    } catch (e) {
      print(e);
    } finally {
      sortBooks();
      isLoading = false;
    }
  }

  void removeBook(Book book) {
    books.remove(book);
    notifyListeners();
  }

  bool addBook(String title) {
    if (title.isNotEmpty) {
      books.add(Book(
        id: books
                .reduce(
                    (current, next) => current.id > next.id ? current : next)
                .id +
            1,
        title: title,
      ));
      sortBooks();
      return true;
    }
    return false;
  }

  void sortBooks() {
    isLoading = true;

    if (choosenSorting == 'Alphabetical') {
      books.sort((a, b) => a.title.compareTo(b.title));
    } else if (choosenSorting == 'Index') {
      books.sort((a, b) => a.id.compareTo(b.id));
    }

    isLoading = false;
  }
}
