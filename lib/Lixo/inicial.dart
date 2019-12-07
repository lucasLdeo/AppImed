import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../pages/profile_screen.dart';
import '../pages/cadastro_Medico.dart';

void main() => runApp(iMedic());

class iMedic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  /*AnimationController controller;
  Animation<double> animation_rotation;
  Animation<double> animation_radius_in;
  Animation<double> animation_radius_out;*/
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 235,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF9DEBFF), Color(0xFF91AFFF)],
                  ),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90))),
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
            Container(
              height: 248,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 62),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                        hintText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
                    margin: EdgeInsets.only(top: 32),
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.vpn_key,
                          color: Colors.grey,
                        ),
                        hintText: 'Senha',
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, right: 32),
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          'Esqueceu sua senha?'.toUpperCase(),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width / 1.5,
              child: FlatButton(
                onPressed: () {
                  //Use`Navigator` widget to push the second screen to out stack of screens
                  Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return new SecondScreen();
                  }));
                },
                child: Text('Login'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF9DEBFF), Color(0xFF91AFFF)],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
            ),
            SizedBox(height: 5),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width / 1.5,
              child: FlatButton(
                onPressed: () {
                  //Use`Navigator` widget to push the second screen to out stack of screens
                  Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return new Cadastro();
                  }));
                },
                child: Text('Cadastrar'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold)),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlueAccent, width: 1.2),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
            ),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.bottomLeft / 1.2,
              heightFactor: 1.4,
              child: Container(
                  height: 45,
                  width: 195,
                  child: Align(
                    child: RaisedButton(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/facebook.png',
                            height: 28,
                            color: Colors.white,
                          ),
                          Text(
                            ' Login com Facebook',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                height: 1.5),
                          )
                        ],
                      ),
                      onPressed: () {},
                      color: Color(0xFF4267b2),
                    ),
                  )),
            ),
            SizedBox(
              height: 2,
            ),
            Align(
              alignment: Alignment.bottomLeft / 1.2,
              heightFactor: 1,
              child: Container(
                  height: 33,
                  width: 195,
                  child: Align(
                    child: RaisedButton(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 4),
                              color: Colors.white,
                            ),
                            child: Image.asset(
                              'assets/images/google_logo.png',
                              height: 25,
                              alignment: Alignment.center,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              child: Text(
                                ' Login com Google',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  height: 1.1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                      color: Color(0xFF4885ed),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
