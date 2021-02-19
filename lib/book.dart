import 'dart:convert';

class Book {
  int id;
  String title;
  String author;
  String image;
  bool favourite;

  @override
  String toString() {
    return 'Book{id: $id, title: $title, author: $author, image: $image, favourite: $favourite}';
  }

  Book({this.title, this.author, this.image, this.id, this.favourite});
  Book.named();

  Book.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        author = json['author'],
        image = json['image'],
        favourite = json['favourite'],
        id = json['id'];

  static Map<String, dynamic> toMap(Book book) => {
        'title': book.title,
        'author': book.author,
        'image': book.image,
        'favourite': book.favourite,
        'id': book.id
      };

  static String encode(List<Book> books) => json.encode(
        books.map<Map<String, dynamic>>((book) => Book.toMap(book)).toList(),
      );

  static List<Book> decode(String book) => (json.decode(book) as List<dynamic>)
      .map<Book>((item) => Book.fromJson(item))
      .toList();
}

List<Book> getAllBooks = [
  Book(
      id: 1,
      title: "Becoming a Leader",
      author: "Munroe",
      image:
          "https://cdn.pixabay.com/photo/2021/02/03/14/52/woman-5978200_1280.jpg",
      favourite: false),
  Book(
      id: 2,
      title: "More important than money",
      author: "Kennedy Davis",
      image:
          "https://cdn.pixabay.com/photo/2021/02/03/14/52/woman-5978200_1280.jpg",
      favourite: false),
  Book(
      id: 3,
      title: "Maxwell Leadership Bible",
      author: "John Maxwell",
      image:
          "https://cdn.pixabay.com/photo/2021/02/03/14/52/woman-5978200_1280.jpg",
      favourite: false),
  Book(
      id: 4,
      title: "Awakening the Giant",
      author: "Anthony Robins",
      image:
          "https://cdn.pixabay.com/photo/2021/02/03/14/52/woman-5978200_1280.jpg",
      favourite: false),
  Book(
      id: 5,
      title: "The Richest Man in babylon",
      author: "Munroe",
      image:
          "https://cdn.pixabay.com/photo/2021/02/03/14/52/woman-5978200_1280.jpg",
      favourite: false)
];
