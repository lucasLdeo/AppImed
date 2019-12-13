import 'package:flutter/material.dart';
import 'package:imed/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:imed/models/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imed/pages/cadastro_paciente.dart';
import 'package:imed/pages/perfilpaciente.dart';
class CID extends StatefulWidget {
  @override
  _CIDState createState() => _CIDState();
}

class _CIDState extends State<CID> {
  TextEditingController controller = new TextEditingController();
  String filter;
  Widget appBarTitle = new Text("Tabela CID");
  Icon actionIcon = new Icon(Icons.search);
  QuerySnapshot doencas;

  @override
  Widget build(BuildContext context) {
    final title = 'CID';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: appBarTitle,
          actions: <Widget>[
          ],
        ),
        body: ListView.builder(
            itemCount: doencas.documents.length,
            padding: EdgeInsets.all(5.0),
            itemBuilder: (context, i) {

              return new ListTile(
                title: Text(doencas.documents[i].data['Nome_Doenca']),
                subtitle: Text(doencas.documents[i].data['Codigo_Doenca']),
              );
            }),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(
            height: 50.0,
          ),
        ),
      ),
    );
  }
  Widget _showCircularProgress() {
    Center(child: CircularProgressIndicator());
  }

  @override
  void initState() {
    final db = Firestore.instance;
    db.collection("CID").getDocuments().then((results) {
      if (results != null) {
        setState(() {
          doencas = results;
        });
      } else {
        setState(() {
          _showCircularProgress();
        });
      }
    });
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


}