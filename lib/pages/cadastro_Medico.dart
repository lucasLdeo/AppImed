import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imed/pages/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imed/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MaterialApp(title: "Cadastro", home: Cadastro()));

class Cadastro extends StatefulWidget {
  Cadastro({this.auth, this.logoutCallback});

  final BaseAuth auth;
  final VoidCallback logoutCallback;

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = new GlobalKey<FormState>();
  final db = Firestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String userId = "";
  String nome,
      cpf,
      crm,
      telefone,
      email,
      senha,
      _errorMessage,
      msg = 'Fazer Cadastro';
  bool _isLoading = false;

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
    );
  }

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
    _isLoading = false;
    if (validateAndSave()) {
      _isLoading = true;
      String userId = "";
      try {
        AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: senha);
        FirebaseUser user = result.user;
        userId = user.uid;
        print('Signed up user: $userId');
        if (userId != null) {
          await db.collection("Medico").document().setData({
            'name': nome,
            'cpf': cpf,
            'crm': crm,
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
        } else {
          _isLoading = false;
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
  TextEditingController controller = TextEditingController();
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Form(
          key: _formKey,
          child: Align(
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                
                child: ListView(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  children: <Widget>[

                    SizedBox(height: 15),
                    new TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.lightBlueAccent,
                        ),
                        labelText: 'Nome completo:',
                        hintText: 'Digite o seu nome',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Nome can\'t be empty' : null,
                      onSaved: (value) => nome = value.trim(),
                    ),
                    SizedBox(height: 10),
                    new TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        prefixIcon: const Icon(
                          Icons.info,
                          color: Colors.lightBlueAccent,
                        ),
                        labelText: 'CPF:',
                        hintText: 'XXX.XXX.XXX-XX',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) => value.isEmpty
                          ? 'CPF can\'t be empty'
                          : value.length != 11
                              ? 'CPF inesperado, deve ter 11 digitos'
                              : null,
                      onSaved: (value) => cpf = value.trim(),
                    ),
                    SizedBox(height: 10),
                    new TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        prefixIcon: const Icon(
                          Icons.info,
                          color: Colors.lightBlueAccent,
                        ),
                        labelText: 'CRM:',
                        hintText: 'XXXXXXXX',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'CRM can\'t be empty' : null,
                      onSaved: (value) => crm = value.trim(),
                    ),
                    SizedBox(height: 10),
                    new TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        prefixIcon: const Icon(
                          Icons.call,
                          color: Colors.lightBlueAccent,
                        ),
                        labelText: 'Celular:',
                        hintText: '(DDD) X XXXX-XXXX',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value.isEmpty ? 'Telefone can\'t be empty' : null,
                      onSaved: (value) => telefone = value.trim(),
                    ),
                    SizedBox(height: 10),
                    new TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.lightBlueAccent,
                        ),
                        labelText: 'Email: ',
                        hintText: 'digite o seu email ',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Email can\'t be empty' : null,
                      onSaved: (value) => email = value.trim(),
                    ),
                    SizedBox(height: 10),
                    new TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        prefixIcon: const Icon(
                          Icons.vpn_key,
                          color: Colors.lightBlueAccent,
                        ),
                        labelText: 'Senha:',
                        hintText: 'escolha uma senha',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Senha can\'t be empty' : null,
                      onSaved: (value) => senha = value.trim(),
                    ),
                    SizedBox(height: 10),
                    new TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        prefixIcon: const Icon(
                          Icons.vpn_key,
                          color: Colors.lightBlueAccent,
                        ),
                        labelText: 'Senha novamente:',
                        hintText: 'digite sua senha novamente',
                      ),
                      validator: (value) => value.isEmpty
                          ? 'Senha can\'t be empty'
                          : identical(value, senha)
                              ? 'Senhas não conferem, tente novamente'
                              : null,
                      onSaved: (value) => senha = value.trim(),
                    ),
                    validator: (value) => value.isEmpty ? 'Senha can\'t be empty' : identical(value,senha) ? 'Senhas não conferem, tente novamente':null,
                    onSaved: (value) => senha = value.trim(),
                  ),
                  SizedBox(height: 15),
                    Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: FlatButton(
                        onPressed: () {
                          _showCircularProgress();
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

    );
  }
}
