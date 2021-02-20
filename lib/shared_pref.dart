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

  // static Future<bool> getFavs(String key, {List<String> defaultValue}) async {
  //   if (key == null || key.isEmpty) return Future.value(emptyList());
  //   final SharedPreferences sharedPreferences = await _getInstance();
  //   final value = sharedPreferences.getString(key); // serialise it first then save as prefs does not support list
  //   if (value == null){
  //     return Future.value(defaultValue);
  //   }
  //   return value;
  // }

  Future<List<Book>> getAllSavedBooks({String key = "favourites"}) async {
    if (key == null || key.isEmpty) return Future.value([]);
    final prefs = await SharedPreferences.getInstance();
    List<Book> books = [];
    if (prefs.getString(key) == null) {
      await saveOnInit();
      books = Book.decode(prefs.getString(key));
    } else {
      books = Book.decode(prefs.getString(key));
    }

    return books;
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
      prefs.setString(key, Book.encode(getAllBooks));
    }
  }
}
