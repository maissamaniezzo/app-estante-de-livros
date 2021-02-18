import 'package:estante_livros/book/book.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookItem extends StatelessWidget {

  final Book book;

  BookItem({
    @required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      color: Colors.white,
      child: Row(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 90,
                  width: 60,
                  child: book.image == null ? Icon(Icons.book_outlined, size: 60,) : Image.network(book.image),
                ),
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100,
                width: 250,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Título: ${book.name}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("Autores: ${book.author}"),
                      Text("Editora: ${book.pubComp}"),
                      Text("Número de páginas: ${book.pages}"),
                      Text("início da leitura: ${DateFormat('dd/MM/y').format(book.initialDate)}"),
                      Text("fim da leitura: ${DateFormat('dd/MM/y').format(book.finalDate)}"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}