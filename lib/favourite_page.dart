import 'package:flutter/material.dart';
import 'package:list_with_favourite/book.dart';
import 'package:list_with_favourite/shared_pref.dart';

class FavouriteBooks extends StatefulWidget {
  List<Book> book;

  FavouriteBooks(this.book);

  @override
  _FavouriteBooksState createState() => _FavouriteBooksState();
}

class _FavouriteBooksState extends State<FavouriteBooks> {
  SharedPref sharedPref = SharedPref();
  @override
  void initState() {
    super.initState();
    // readFav();
    readFav2();
  }

  readFav() async {
    List<Book> booklist = await sharedPref.read("fav");
    setState(() {
      widget.book = booklist;
      print(" booklist $booklist");
    });
  }

  readFav2() async {
    List<Book> booklist = await sharedPref.read2("fav");
    setState(() {
      widget.book = booklist;
      print(" booklist2 $booklist");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite Page"),
      ),
      body: ListView.builder(
        itemCount: widget.book.length == null ? 0 : widget.book.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                leading: Image.network(
                  widget.book[index].image,
                ),
                title: Text(widget.book[index].title),
                subtitle: Text(widget.book[index].author),
              ),
            ],
          );
        },
      ),
    );
  }
}
