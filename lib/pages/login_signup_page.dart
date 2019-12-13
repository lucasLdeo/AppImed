import 'package:flutter/material.dart';
import 'package:imed/services/authentication.dart';
import 'package:imed/pages/cadastro_Medico.dart';

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;
  String email;
  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;

  bool _isLoginForm;
  bool _isLoading;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          _isLoading = true;
          userId = await widget.auth.signIn(_email, _password);
        }
        setState(() {
          _isLoading = false;
        });
        if (userId.length > 0 && userId != null && _isLoginForm) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            _showForm(),
            _showCircularProgress(),
          ],
        ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget _showForm() {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              new Form(
                key: _formKey,
                child: new ListView(
                  padding: EdgeInsets.all(0.0),
                  shrinkWrap: true,
                  children: <Widget>[
                    showLogo(),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Column(
                        children: <Widget>[
                          showEmailInput(),
                          showPasswordInput(),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(85, 20, 85, 0),
                      child: showPrimaryButton(),
                    ),
                    showSecondaryButton(),
                    Container(
                      padding: EdgeInsets.fromLTRB(84, 0, 84, 0),
                      child: Column(
                        children: <Widget>[
                          showFacebookButton(),
                          showGoogleButton(),
                        ],
                      ),
                    ),
                    showErrorMessage(),
                    SizedBox(
                      height: 90,
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new AlertDialog(

        title: Text("Erro: "),
        content: Text(_errorMessage, style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),),
        actions: [
          FlatButton(
            child: new Text("ok"),
          )
        ],
        elevation: 24.0,
        backgroundColor: Colors.blueGrey,
      );

    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty
            ? 'Campo do email não pode estar vazio'
                ''
            : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty
            ? 'Campo da senha não pode'
                ' estar vazio'
            : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget showSecondaryButton() {
    return new FlatButton(
        child: new Text(
            _isLoginForm ? 'Criar uma conta' : 'Have an account? Sign in',
            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new Cadastro();
          }));
        });
  }

  Widget showFacebookButton() {
    return new RaisedButton(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 28),
          Text(
            ' Login com Facebook',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, height: 1.5),
          )
        ],
      ),
      onPressed: () {},
      color: Color(0xFF4267b2),
    );
  }

  Widget showGoogleButton() {
    return new RaisedButton(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 28),
          Text(
            ' Login com Google',
            style: TextStyle(
                color: Color(0xFFF7F7F7),
                fontWeight: FontWeight.bold,
                height: 1.5),
          )
        ],
      ),
      onPressed: () {},
      color: Color(0xFFdd4b39),
    );
  }

  Widget showPrimaryButton() {
    return new Container(
      height: 45.0,
      width: 0,
      child: FlatButton(
        onPressed: validateAndSubmit,
        child: Text('Login'.toUpperCase(),
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9DEBFF), Color(0xFF91AFFF)],
          ),
          borderRadius: BorderRadius.all(Radius.circular(50))),
    );
  }

  Widget showLogo() {
    return new Padding(
      padding: EdgeInsets.all(0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 225,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF9DEBFF), Color(0xFF91AFFF)],
            ),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.healing,
                size: 90,
                color: Colors.white,
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32, right: 32),
                child: Text(
                  'Saúde na palma da sua mão'.toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
