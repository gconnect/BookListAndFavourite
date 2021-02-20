import 'package:flutter/material.dart';
import 'package:list_with_favourite/book.dart';
import 'package:list_with_favourite/shared_pref.dart';

import 'book.dart';
import 'shared_pref.dart';

class FavouriteBooks extends StatefulWidget {
  @override
  _FavouriteBooksState createState() => _FavouriteBooksState();
}

class _FavouriteBooksState extends State<FavouriteBooks> {
  SharedPref sharedPref = SharedPref.getInstance;
  List<Book> book = [];
  List<Book> fav = [];

  @override
  void initState() {
    super.initState();
    readFav();
  }

  readFav() async {
    List<Book> bookList = await sharedPref.getAllSavedBooks();
    this.fav = bookList.where((e) => e.favourite == true).toList();

    setState(() {
      this.book = bookList;
      print("favourite bookList $fav");
      print("favourite bookList 2 $bookList");
    });
  }

  // readFav2() async {
  //   List<Book> booklist = await sharedPref.read2("fav");
  //   setState(() {
  //     widget.book = booklist;
  //     print(" booklist2 $booklist");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite Page"),
      ),
      body: ListView.builder(
        itemCount: fav.length ?? 0,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                leading: Image.network(
                  fav[index].image,
                ),
                title: Text(fav[index].title),
                subtitle: Text(fav[index].author),
              ),
            ],
          );
        },
      ),
    );
  }
}
