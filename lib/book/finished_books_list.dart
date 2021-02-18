import 'package:estante_livros/book/book_item.dart';
import 'package:flutter/material.dart';

import 'book.dart';

class FinishedBooksList extends StatelessWidget {

  final List<Book> books;
  FinishedBooksList(this.books);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.brown,
        child: ListView.builder(
          itemCount: books.length,
          itemBuilder: (ctx, index) {
            final item = books[index];
            return BookItem(
              book: item,
            );
          },
        ),
      ),
    );
  }
}