import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormPage extends StatefulWidget {

  final void Function(String, String, String, String, String, DateTime, DateTime) onSubmit;

  FormPage(this.onSubmit);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  String nameController;
  String authorController;
  String pagesController;
  String publisherController;
  final image = null;
  DateTime initialDate = DateTime.now();
  DateTime finalDate = DateTime.now(); 

  _submitForm() {
    final name = nameController;
    final author = authorController;
    final pages = pagesController;
    final pubComp = publisherController;

    print("name = $name");
    print("author = $author");

    if(name == null || author == null || pages == null || pubComp == null || initialDate == null || finalDate == null) {
      return;
    }

    widget.onSubmit(name, author, pages, pubComp, image, initialDate, finalDate);
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

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar livro"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                //controller: nameController,
                decoration: InputDecoration(
                  labelText: "Título",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                onSubmitted: (text) {
                  setState(() {
                    nameController = text;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                //controller: authorController,
                decoration: InputDecoration(
                  labelText: "Autor",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                onSubmitted: (text) {
                  setState(() {
                    authorController = text;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                // controller: pagesController,
                decoration: InputDecoration(
                  labelText: "Número de paginas",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                onSubmitted: (text) {
                  setState(() {
                    pagesController = text;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                // controller: publisherController,
                decoration: InputDecoration(
                  labelText: "Editora",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                onSubmitted: (text) {
                  setState(() {
                    publisherController = text;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 20,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        initialDate == null 
                          ? 'Nenhuma data selecionada.' 
                          : 'Início da leitura: ${DateFormat('dd/MM/y').format(initialDate)}',
                      ),
                    ),
                    FlatButton(
                      textColor: Colors.blue[800],
                      child: Text(
                        'Selecionar outra data', 
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      onPressed: () => _showDatePickerInitial(context),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 20,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        finalDate == null 
                          ? 'Nenhuma data selecionada.' 
                          : 'Fim da leitura: ${DateFormat('dd/MM/y').format(finalDate)}',
                      ),
                    ),
                    FlatButton(
                      textColor: Colors.blue[800],
                      child: Text(
                        'Selecionar outra data', 
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      onPressed: () => _showDatePickerFinal(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 40,
        width: 120,
        child: FloatingActionButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_rounded),
              const SizedBox(width: 10),
              Text(
                "Finalizar", 
                textAlign: TextAlign.center, 
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Colors.blue[800],
          onPressed: _submitForm(),
        ),
      ),
    );
  }
}