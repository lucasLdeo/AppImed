import 'package:flutter/material.dart';
import 'package:imed/pages/perfilpaciente.dart';
import 'package:imed/pages/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imed/pages/cadastro_paciente.dart';
class Pacientes extends StatefulWidget {
  @override
  _PacientesState createState() => _PacientesState();
}

class _PacientesState extends State<Pacientes> {
  Widget appBarTitle = new Text("Pacientes");
  Icon actionIcon = new Icon(Icons.search);
  QuerySnapshot pacientes;

  @override
  Widget build(BuildContext context) {
    final title = 'Pacientes';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: appBarTitle,
          actions: <Widget>[
            new IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon = new Icon(Icons.close);
                    this.appBarTitle = new TextField(
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                      decoration: new InputDecoration(
                          prefixIcon:
                              new Icon(Icons.search, color: Colors.white),
                          hintText: "Search...",
                          hintStyle: new TextStyle(color: Colors.white)),
                    );
                  } else {
                    this.actionIcon = new Icon(Icons.search);
                    this.appBarTitle = new Text("AppBar Title");
                  }
                });
              },
            ),
          ],
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView.builder(
            itemCount: pacientes.documents.length,
            padding: EdgeInsets.all(5.0),
            itemBuilder: (context, i) {
              return new ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('images/avatar.png'),
                ),
                title: Text(pacientes.documents[i].data['name']),
                subtitle: Text(pacientes.documents[i].data['cpf']),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PerfilPaciente(),
                      ));
                },
              );
            }),
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
              MaterialPageRoute(builder: (context) => CadastroPaciente(),)
            );
          },
          tooltip: 'Increment Counter',
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget _showCircularProgress() {
    Center(child: CircularProgressIndicator());
  }

  @override
  void initState() {
    final db = Firestore.instance;
    db.collection("Pacientes").getDocuments().then((results) {
      if (results != null) {
        setState(() {
          pacientes = results;
        });
      } else {
        setState(() {
          _showCircularProgress();
        });
      }
    });
    super.initState();
  }
}
