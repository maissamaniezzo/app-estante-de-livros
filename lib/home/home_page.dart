import 'package:estante_livros/book/book.dart';
import 'package:estante_livros/adds_books/book_options.dart';
import 'package:estante_livros/book/finished_books_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Book> _books = [
    // Book(name: 'aAaAaA', author: 'aaaaaa', pages: '11', pubComp: 'AAAAAA', image: null, initialDate: DateTime.now(), finalDate: DateTime.now()),
    // Book(name: 'bBbBbB', author: 'bbbbbb', pages: '22', pubComp: 'BBBBBB', image: null, initialDate: DateTime.now(), finalDate: DateTime.now()),
  ];

  _addBook(String name, String author, String pages, String pubComp, String image, DateTime initialDate, DateTime finalDate) {
    final newBook = Book(
      name: name,
      author: author,
      pages: pages,
      pubComp: pubComp,
      image: image,
      initialDate: initialDate,
      finalDate: finalDate,
    );

    setState(() {
      _books.add(newBook);
    });

    print(_books.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Estante de livros")),
      ),
      body: LayoutBuilder(
        builder: (ctx, constraints) {
          return Column(
            children: [
              Container(
                height: constraints.maxHeight * 0.9,
                child: Column(
                  children: [
                    FinishedBooksList(_books),
                  ],
                ),
              ),
              Container(
                height: constraints.maxHeight * 0.1,
                color: Colors.brown,
              )
            ],
          );
        },
      ),
      floatingActionButton: LayoutBuilder(
        builder: (ctx, constraints) {
          return Container(
            height: 30,
            width: constraints.maxWidth * 0.91,
            child: FloatingActionButton(
              child: Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_rounded),
                  const SizedBox(width: 10),
                  Text(
                    "Adicionar novo livro", 
                    textAlign: TextAlign.center, 
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ], 
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              backgroundColor: Colors.blue[800],
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BookOptions(_addBook)));
              },
            ),
          );
        },
      ),
    );
  }
}