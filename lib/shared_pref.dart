import 'package:shared_preferences/shared_preferences.dart';

import 'book.dart';

class SharedPref {
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

  Future<List<Book>> read2(String key) async {
    if (key == null || key.isEmpty) return Future.value([]);
    final prefs = await SharedPreferences.getInstance();
    final value = Book.decode(prefs.getString(key));
    if (value == null) {
      return Future.value([]);
    }
    return value;
  }

  Future<void> save2(String key, Book book) async {
    if (key == null || key.isEmpty) return Future.value([]);
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(key);
    List<Book> booklist;
    if (cached == null) {
      booklist = [];
    } else {
      booklist = Book.decode(prefs.getString(key));
    }
    booklist.add(book);
    prefs.setString(key, Book.encode(booklist));
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, Book.encode(value));
  }

  remove(String key, Book book) async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(key);
    final cachedBookList =
        cached == null ? [] : Book.decode(prefs.getString(key));
    if (cachedBookList.isEmpty) return;
    if (cachedBookList.contains(book.id)) {
      cachedBookList.remove(book.id);
    }
  }
}
