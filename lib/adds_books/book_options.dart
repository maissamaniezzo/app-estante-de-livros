import 'dart:convert';

import 'package:estante_livros/adds_books/form_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookOptions extends StatefulWidget {

  final void Function(String, String, String, String, String, DateTime, DateTime) onSubmit;
  
  BookOptions(this.onSubmit);

  @override
  _BookOptionsState createState() => _BookOptionsState(onSubmit);
}

class _BookOptionsState extends State<BookOptions> {

  final void Function(String, String, String, String, String, DateTime, DateTime) onSubmit;
  _BookOptionsState(this.onSubmit);

  DateTime initialDate = DateTime.now();
  DateTime finalDate = DateTime.now();
  
  String bookName;

  Future<Map> _getInfo() async {
    http.Response response;

    if(bookName != null)
      response = await http.get("https://www.googleapis.com/books/v1/volumes?q=intitle:$bookName");

    if(response.statusCode == 200) {
      return json.decode(response.body);
    }
    else
      throw Exception('Error: ${response.statusCode}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar livro"),
        actions: [
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => FormPage(onSubmit),
            )),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Nome do livro",
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
              onSubmitted: (text) {
                setState(() {
                  bookName = text;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done)
                  if (bookName != null && snapshot.hasError) 
                   return Container(child: Text("Erro ao carregar")); 
                  else if (bookName == null)
                    return Container(child: Text(""));
                  else if (snapshot.data["items"] == null)
                    return Container(child: Text("Nenhum resultado disponível"));
                  else
                    return createListOption(context, snapshot);
                else 
                  return Container(
                    width: 200.0,
                    height: 200.0,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[200]),
                      strokeWidth: 3.0,
                    ),
                  );
              }
            )
          )
        ]
      ),
    );
  }

  Widget createListOption(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      child: ListView.builder(
        itemCount: snapshot.data["items"].length + 1,
        itemBuilder: (context, index) {
          if (index < snapshot.data["items"].length)
            return GestureDetector(
              child: Card(
                color: Colors.blueGrey[200],
                elevation: 5,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50, 
                        child: checkThumbnail(snapshot, index)
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 30, 
                          width: 280, 
                          child: Text(
                            snapshot.data["items"][index]["volumeInfo"]["title"],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 30,  
                          width: 280, 
                          child: checkAuthors(snapshot, index)
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () => _submitFoundBook(snapshot, index),
            );
          else
            return GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => FormPage(onSubmit),
              )),
              child: Card(
                color: Colors.blue[800],
                elevation: 5,
                child: Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      "Criar ficha",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ),
              ),
            );
        },
      ),
    );
  }

  Widget checkThumbnail(AsyncSnapshot snapshot, int index) {
    if (snapshot.data["items"][index]["volumeInfo"]["imageLinks"] == null) {
      return Icon(Icons.book_outlined);
    }
    else 
      return Image.network(snapshot.data["items"][index]["volumeInfo"]["imageLinks"]["thumbnail"]);
  }

  Widget checkAuthors(AsyncSnapshot snapshot, int i) {
    if (snapshot.data["items"][i]["volumeInfo"]["authors"] == null) {
      return Container(child: Text("[Não informado]"));
    }
    else 
      return Container(
        child: Text(
          snapshot.data["items"][i]["volumeInfo"]["authors"].toString(),
        ),
      );
  }

  _submitFoundBook(AsyncSnapshot snapshot, int i) {
    final name = snapshot.data["items"][i]["volumeInfo"]["title"];

    final String author = authorExist(snapshot, i);
    
    final pages = pagesExist(snapshot, i).toString();
    
    final pubComp = publisherExist(snapshot, i);

    final image = thumbnailExist(snapshot, i);

    _showDatePickerInitial(context);
    
    _showDatePickerFinal(context);

    if(name.isEmpty || author.isEmpty || pages.isEmpty || pubComp.isEmpty || initialDate == null || finalDate == null) {
      return;
    }

    widget.onSubmit(name, author, pages, pubComp, image, initialDate, finalDate);
  }

  authorExist(AsyncSnapshot snapshot, int i) {
    if (snapshot.data["items"][i]["volumeInfo"]["authors"] == null)
      return "Não informado";
    else
      return snapshot.data["items"][i]["volumeInfo"]["authors"].toString();
  }

  pagesExist(AsyncSnapshot snapshot, int i) {
    if (snapshot.data["items"][i]["volumeInfo"]["pageCount"] == null)
      return "Não informado";
    else
      return snapshot.data["items"][i]["volumeInfo"]["pageCount"];
  }

  publisherExist(AsyncSnapshot snapshot, int i) {
    if (snapshot.data["items"][i]["volumeInfo"]["publisher"] == null)
      return "Não informado";
    else
      return snapshot.data["items"][i]["volumeInfo"]["publisher"];
  }

  thumbnailExist(AsyncSnapshot snapshot, int i) {
    if (snapshot.data["items"][i]["volumeInfo"]["imageLinks"] == null) {
      return null;
    }
    else 
      return snapshot.data["items"][i]["volumeInfo"]["imageLinks"]["thumbnail"];
  }

  _showDatePickerInitial(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null) {
        print("pickedDate = null");
        return;
      }

      setState(() {
        initialDate = pickedDate;
      });

    });
  }

  _showDatePickerFinal(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null) {
        return;
      }

      setState(() {
        finalDate = pickedDate;
      });

    });
  }

}
