import 'package:flutter/material.dart';
import 'package:list_with_favourite/shared_pref.dart';

import 'book.dart';
import 'favourite_page.dart';

class BookListPage extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  List<Book> bookList = [];
  List<Book> favouriteList = [];
  SharedPref sharedPref = SharedPref();
  @override
  void initState() {
    super.initState();
    bookList = getAllBooks;
  }

  // readFav2() async {
  //   List<Book> booklist = await sharedPref.read2("fav2", favouriteList);
  //   setState(() {
  //     favouriteList = booklist;
  //     print(" booklist2 $booklist");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book List"),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FavouriteBooks(favouriteList)),
              );
            },
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.favorite_border)),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: bookList.length,
          itemBuilder: (context, index) {
            Book book = bookList[index];
            bool isSaved = book.favourite;
            return GestureDetector(
              onTap: () {
                print(index);
              },
              child: Column(
                children: [
                  ListTile(
                    leading: Image.network(
                      bookList[index].image,
                    ),
                    title: Text(book.title),
                    subtitle: Text(book.author),
                    trailing: Container(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                if (isSaved) {
                                  favouriteList.remove(book);
                                  sharedPref.remove('fav', book);
                                  book.favourite = false;
                                } else {
                                  favouriteList.add(book);
                                  book.favourite = true;
                                  sharedPref.save2("fav", book);
                                  // sharedPref.save("fav2", favouriteList);
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: new Text("Saved!"),
                                      duration:
                                          const Duration(milliseconds: 500)));
                                }
                              });
                            },
                            child: isSaved
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                  ))),
                  ),
                  Divider(),
                ],
              ),
            );
          }),
    );
  }
}
