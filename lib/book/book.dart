import 'package:flutter/material.dart';

class Book {
  
  final String name;
  final String author;
  final String pages;
  final String pubComp;
  final String image;
  final DateTime initialDate;
  final DateTime finalDate;

  Book({
    @required this.name,
    @required this.author,
    @required this.pages,
    @required this.pubComp,
    @required this.image,
    @required this.initialDate,
    @required this.finalDate,
  });

}