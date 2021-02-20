import 'package:shared_preferences/shared_preferences.dart';

import 'book.dart';

class SharedPref {
  static SharedPref _instance;

  SharedPref._();

  static SharedPref get getInstance => _instance ??= SharedPref._();

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return Book.decode(prefs.getString(key));
  }

  Future<List<Book>> getAllSavedBooks({String key = "favourites"}) async {
    if (key == null || key.isEmpty) return Future.value([]);
    final prefs = await SharedPreferences.getInstance();
    final value = Book.decode(prefs.getString(key));
    if (value == null) {
      return Future.value([]);
    }
    return value;
  }

  Future<void> saveBook(Book book, {int index, String key = "favourites"}) async {
    if (key == null || key.isEmpty) return Future.value([]);
    final prefs = await SharedPreferences.getInstance();
    List<Book> bookList = Book.decode(prefs.getString(key));
    bookList[index] = book;
    prefs.setString(key, Book.encode(bookList));
  }

  void save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, Book.encode(value));
  }

  Future<void> saveOnInit({String key = "favourites"}) async {
    final List<Book> books = getAllBooks;
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) == null) {
      prefs.setString(key, Book.encode(books));
    } else {
      List<Book> bookList = Book.decode(prefs.getString(key));
      if (bookList != null && bookList.isNotEmpty) return;
      final bookToString = Book.encode(getAllBooks);
      prefs.setString(key, bookToString);
    }
  }
}
