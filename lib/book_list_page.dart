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
  SharedPref sharedPref = SharedPref.getInstance;

  @override
  void initState() {
    super.initState();
    save();
    readBooks();
  }

  void save() async => sharedPref.saveOnInit();

  void readBooks() async {
    bookList = await sharedPref.getAllSavedBooks();
    debugPrint("book is $bookList");
  }

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
                MaterialPageRoute(builder: (context) => FavouriteBooks()),
              );
            },
            child: Padding(padding: EdgeInsets.only(right: 10), child: Icon(Icons.favorite_border)),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: this.bookList.length,
        itemBuilder: (context, index) {
          Book book = this.bookList[index];
          bool isSaved = book.favourite;
          return GestureDetector(
            onTap: () {
              print(index);
            },
            child: Column(
              children: [
                ListTile(
                  leading: Image.network(
                    book.image,
                  ),
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  trailing: Container(
                    child: InkWell(
                      onTap: () {
                        debugPrint("isSaved is $isSaved");
                        setState(() {
                          if (isSaved) {
                            book.favourite = false;
                            sharedPref.saveBook(book, index: index);
                          } else {
                            book.favourite = true;
                            sharedPref.saveBook(book, index: index);
                            Scaffold.of(context).showSnackBar(SnackBar(content: new Text("Saved!"), duration: const Duration(milliseconds: 500)));
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
                            ),
                    ),
                  ),
                ),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
