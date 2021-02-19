import 'package:shared_preferences/shared_preferences.dart';

import 'book.dart';

class SharedPref {
  static SharedPref _instance;

  SharedPref._() {
    saveOnInit();
  }

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

  void saveOnInit({String key = "favourites"}) async {
    final prefs = await SharedPreferences.getInstance();
    List<Book> bookList = Book.decode(prefs.getString(key));
    if (bookList != null && bookList.isNotEmpty) return;
    final bookToString = Book.encode(getAllBooks);
    prefs.setString(key, bookToString);
  }
}
