import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imed/pages/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imed/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:imed/main.dart';
import 'package:imed/Lixo/root_page.dart';

void main() => runApp(MaterialApp(title: "Cadastro", home: CadastroPaciente()));

class CadastroPaciente extends StatefulWidget {
  CadastroPaciente({this.auth, this.logoutCallback});
  final BaseAuth auth;
  final VoidCallback logoutCallback;

  @override
  _CadastroPacienteState createState() => _CadastroPacienteState();

}
class _CadastroPacienteState extends State<CadastroPaciente> {
  final db = Firestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String userId = "";
  String _errorMessage = "";
  String nome,cpf,telefone,email;
  String msg = 'Fazer Cadastro';
  final _formKey = new GlobalKey<FormState>();

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }


  Future <void> validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
    });
    setState(() {
      _errorMessage = "";
    });
    if (validateAndSave()) {
      try {
          await db.collection("Medico").document().setData({
            'name': nome,
            'cpf': cpf,
            'telefone': telefone,
            'email': email,

          }).then((documentReference) {
            new SecondScreen(
              userId: userId,
              auth: widget.auth,

            );
          }).catchError((e) {
            print(e);
          });
      } catch (e) {
        print('Error: $e');
        setState(() {
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  Future < void > addPaciente() async {
    if(userId != null) {
      await db.collection("Pacientes").document().setData({
        'name': "texto",
        'cpf': "1234567890",
        'telefone': "1234565432",
        'email': "teste@jesus.com",
      }).then((documentReference) {
        print("kkkkkkkkkkkkkk");
        new SecondScreen(
          userId: userId,
          auth: widget.auth,

        );
      }).catchError((e) {
        print(e);
        _formKey.currentState.reset();
      });
    }else{

    }

  }
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child:new Form(
          key: _formKey,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text('Fazer Cadastro'),
            ),


            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new TextFormField(
                    scrollPadding: EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)

                      ),

                      prefixIcon: const Icon(Icons.person, color: Colors.lightBlueAccent,),
                      labelText: 'Nome completo:',
                      hintText: 'Digite o seu nome',

                    ),
                    validator: (value) => value.isEmpty ? 'Nome can\'t be empty' : null,
                    onSaved: (value) => nome = value.trim(),
                  ),
                  SizedBox(height: 10),
                  new TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)
                      ),
                      prefixIcon: const Icon(Icons.info, color: Colors.lightBlueAccent,),
                      labelText: 'CPF:',
                      hintText: 'XXX.XXX.XXX-XX',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) => value.isEmpty ? 'CPF can\'t be empty' : value.length != 11 ? 'CPF inesperado, deve ter 11 digitos' : null,
                    onSaved: (value) => cpf = value.trim(),
                  ),
                  SizedBox(height: 10),
                  new TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)
                      ),
                      prefixIcon: const Icon(Icons.call, color: Colors.lightBlueAccent,),
                      labelText: 'Celular:',
                      hintText: '(DDD) X XXXX-XXXX',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) => value.isEmpty ? 'Telefone can\'t be empty' : null,
                    onSaved: (value) => telefone = value.trim(),
                  ),
                  SizedBox(height: 10),
                  new TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)
                      ),
                      prefixIcon: const Icon(Icons.email, color: Colors.lightBlueAccent,),
                      labelText: 'Email: ',
                      hintText: 'digite o seu email ',
                    ),
                    validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                    onSaved: (value) => email = value.trim(),
                  ),
                  SizedBox(height: 10),
                  new TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)
                      ),
                      prefixIcon: const Icon(Icons.email, color: Colors.lightBlueAccent,),
                      labelText: 'Observacao: ',
                      hintText: 'observacoes sobre o paciente ',
                    ),
                  ),
                  SizedBox(height: 45),
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: FlatButton(
                      onPressed: () {

                        validateAndSubmit();
                      },
                      child: Text('Cadastrar'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF9DEBFF), Color(0xFF91AFFF)],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}