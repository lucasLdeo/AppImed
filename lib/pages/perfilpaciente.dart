import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imed/pages/CardItemModel.dart';
import 'package:imed/pages/prontuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  MyHomePage(this.iddocumento);

  final String iddocumento;

  @override
  _MyHomePageState createState() => new _MyHomePageState(iddocumento);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.idDocumento);

  final String idDocumento;
  QuerySnapshot prontuarioPaciente;
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
      body: new ListView(
        children: <Widget>[
          Column(
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
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
                          child: Text(
                            "Exemplo da Silva",
                            style:
                                TextStyle(fontSize: 30.0, color: Colors.black),
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
              ]),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 64.0, vertical: 16.0),
            child: Text(
              "Prontuarios",
              style: TextStyle(fontSize: 20.0, color: Colors.blueAccent),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: prontuarioPaciente.documents.length,
              padding: EdgeInsets.all(5.0),
              itemBuilder: (context, i) {
                return new ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('images/avatar.png'),
                  ),
                  title: Text(prontuarioPaciente.documents[i].data['alergia']),
                  subtitle:
                      Text(prontuarioPaciente.documents[i].data['doenca']),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    showAlertDialog3(
                        context,
                        prontuarioPaciente.documents[i].data['doenca'],
                        prontuarioPaciente.documents[i].data['alergia'],
                        prontuarioPaciente.documents[i].data['medicacao'],
                        prontuarioPaciente.documents[i].data['observacao'],
                        prontuarioPaciente.documents[i].data['problema'],
                        prontuarioPaciente.documents[i].data['suplementacao']);
                  },
                );
              })
        ],
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
              MaterialPageRoute(
                builder: (context) => Prontuario(this.idDocumento),
              ));
        },
        tooltip: 'Increment Counter',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  showAlertDialog3(
      BuildContext context,
      String doenca,
      String alergia,
      String medicacao,
      String observacao,
      String problema,
      String suplementacao) {
    // configura o  AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Prontuário"),
      content: Text('Deonça: ' +
          doenca +
          '\n\nAlergia: ' +
          alergia +
          '\n\nMedicação: ' +
          medicacao +
          '\n\nObservação: ' +
          observacao +
          '\n\nProblema: ' +
          problema +
          '\n\nSuplementação: ' +
          suplementacao),
      actions: [],
    );
    // exibe o dialogo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    final db = Firestore.instance;
    db
        .collection("Pacientes")
        .document(idDocumento)
        .collection("Prontuario")
        .getDocuments()
        .then((results) {
      if (results != null) {
        setState(() {
          prontuarioPaciente = results;
        });
      }
    });
    super.initState();
  }
}
