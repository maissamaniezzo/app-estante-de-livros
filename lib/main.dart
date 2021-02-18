import 'home/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        color: Colors.blue[300],
      ),
      hintColor: Colors.grey[400],
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: 
          OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusedBorder: 
          OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[800])),
      ),
    )
  ));
}
