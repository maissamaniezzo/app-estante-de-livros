import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormPage extends StatefulWidget {

  final void Function(String, String, String, String, String, DateTime, DateTime) onSubmit;

  FormPage(this.onSubmit);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  final nameController = TextEditingController();
  final authorController = TextEditingController();
  final pagesController = TextEditingController();
  final publisherController = TextEditingController();
  final image = null;
  DateTime initialDate = DateTime.now();
  DateTime finalDate = DateTime.now(); 

  _submitForm() {
    final name = nameController.text;
    final author = authorController.text;
    final pages = pagesController.text;
    final pubComp = publisherController.text;

    if(name.isEmpty || author.isEmpty || pages.isEmpty || pubComp.isEmpty || initialDate == null || finalDate == null) {
      print("algum campo vazio");
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

      print("pickedDate1 $pickedDate");
      setState(() {
        initialDate = pickedDate;
      });
      print("initialDate $initialDate");

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

      print("pickedDate2 $pickedDate");
      setState(() {
        finalDate = pickedDate;
      });
      print("finalDate $finalDate");

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
                controller: nameController,
                onSubmitted: _submitForm(),
                decoration: InputDecoration(
                  labelText: "Título",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: authorController,
                onSubmitted: _submitForm(),
                decoration: InputDecoration(
                  labelText: "Autor",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: pagesController,
                onSubmitted: _submitForm(),
                decoration: InputDecoration(
                  labelText: "Número de paginas",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: publisherController,
                onSubmitted: _submitForm(),
                decoration: InputDecoration(
                  labelText: "Editora",
                  labelStyle: TextStyle(color: Colors.grey),
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