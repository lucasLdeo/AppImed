import 'package:flutter/material.dart';

class Prontuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProntuarioScreen(),
    );
  }
}
class ProntuarioScreen extends StatefulWidget {
  @override
  _ProntuarioScreenState createState() => _ProntuarioScreenState();
}

class _ProntuarioScreenState extends State<ProntuarioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: Container(
          child: ListView(
            padding: EdgeInsets.all(10.0),
            children: <Widget>[
              new TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                  labelText: 'Sofre de alguma doença?',
                  hintText: 'Ex.: bronquite ou nenhuma...',
                ),
              ),
              SizedBox(height: 10),
              new TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                  labelText: 'Fazendo uso de alguma medicação?',
                  hintText: 'Ex.: antibióticos... ',
                ),
              ),
              SizedBox(height: 10),
              new TextFormField(
                scrollPadding: EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                  labelText: 'Faz uso de alguma suplementação?',
                  hintText: 'Ex.: Vitamina C, Ômega 3... ',
                ),
              ),
              SizedBox(height: 10),
              new TextFormField(
                scrollPadding: EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                  labelText: 'Teve alguma alergia?',
                  hintText: 'Ex.: Rinite',
                ),
              ),
              SizedBox(height: 10),
              new TextFormField(
                scrollPadding: EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                  labelText: 'Teve algum problema recentemente?',
                  hintText: 'Ex.: problemas com alergia, hemorragia...',
              ),
              ),
              SizedBox(height: 10),
              new TextFormField(
                scrollPadding: EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 60.0),
                  labelText: 'Alguma outra observação?',
                  hintText: 'Ex.: qualquer anotação.',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Salvar'),
                  onPressed: () {
                  },
                ),)],
        ),

      ),
    ));
  }
}
