import 'package:flutter/material.dart';

class Prontuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      appBar: new AppBar(
        title: new Text ('Prontuario'),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: new Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0,16.0,0.0,12.0),
                child: Text("-HISTÓRICO CLINICA PREGRESSA-", style: TextStyle(fontSize: 18.0, color: Colors.blue),),
              ),
              new TextField(
                scrollPadding: EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person, color: Colors.lightBlueAccent,),
                  labelText: 'doenças infecciosas',
                  hintText: 'Doeças Infecciosas: ',
                ),
              ),
              SizedBox(height: 10),
              new TextField(
                scrollPadding: EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person, color: Colors.lightBlueAccent,),
                  labelText: 'alergias',
                  hintText: 'Alergias: ',
                ),
              ),
              SizedBox(height: 10),
              new TextField(
                scrollPadding: EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person, color: Colors.lightBlueAccent,),
                  labelText: 'cirurgias',
                  hintText: 'Cirurgias: ',
                ),
              ),
              SizedBox(height: 10),
              new TextField(
                scrollPadding: EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person, color: Colors.lightBlueAccent,),
                  labelText: 'outros',
                  hintText: 'Outros: ',
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0,16.0,0.0,12.0),
                child: Text("-HISTÓRICO OCUPACIONAL-", style: TextStyle(fontSize: 18.0, color: Colors.blue),),
              ),
              new TextField(
                scrollPadding: EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person, color: Colors.lightBlueAccent,),
                  labelText: 'funções anteriores',
                  hintText: 'Funções Anteriores: ',
                ),
              ),
              SizedBox(height: 10),
              new TextField(
                scrollPadding: EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person, color: Colors.lightBlueAccent,),
                  labelText: 'acidentes de trabalho',
                  hintText: 'Acidentes de Trabalho: ',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}