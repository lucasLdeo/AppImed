import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imed/pages/CardItemModel.dart';
import 'package:imed/pages/prontuario.dart';

class PerfilPaciente extends StatelessWidget {
  PerfilPaciente(this.idDocumento);

  final String idDocumento;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(idDocumento),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage (this.iddocumento);
  final String iddocumento;
  @override
  _MyHomePageState createState() => new _MyHomePageState(iddocumento);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.idDocumento);
  final String idDocumento;

  var profileImage = NetworkImage(
      'https://cdn3.iconfinder.com/data/icons/avatars-15/64/_Bearded_Man-17-512.png');
  var appColors = [
    Color.fromRGBO(231, 129, 109, 1.0),
    Color.fromRGBO(99, 138, 223, 1.0),
    Color.fromRGBO(111, 194, 173, 1.0)
  ];
  var cardIndex = 0;
  ScrollController scrollController;
  var currentColor = Color.fromRGBO(231, 129, 109, 1.0);

  var cardsList = [
    CardItemModel("Prontuário 1", Icons.dvr, 9, 0.83),
    CardItemModel("Prontuário 2", Icons.dvr, 12, 0.24),
    CardItemModel("Prontuário 3", Icons.dvr, 7, 0.32)
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CircleAvatar(
                        backgroundImage: profileImage,
                        maxRadius: 55.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
                      child: Text(
                        "Exemplo da Silva",
                        style: TextStyle(fontSize: 30.0, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 64.0, vertical: 16.0),
                  child: Text(
                    "Ultima Consulta : JUL 21, 2018",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            new Divider(
              color: Colors.blueGrey,
              height: 5.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 64.0, vertical: 16.0),
                  child: Text(
                    "Prontuarios:",
                    style: TextStyle(fontSize: 20.0, color: Colors.blueAccent),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Prontuario(this.idDocumento),)
          );
        },
        tooltip: 'Increment Counter',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
