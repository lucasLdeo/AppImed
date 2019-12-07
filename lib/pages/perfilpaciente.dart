import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imed/pages/CardItemModel.dart';
import 'package:imed/pages/prontuario.dart';

class PerfilPaciente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var profileImage = NetworkImage('https://cdn3.iconfinder.com/data/icons/avatars-15/64/_Bearded_Man-17-512.png');
  var appColors = [Color.fromRGBO(231, 129, 109, 1.0),Color.fromRGBO(99, 138, 223, 1.0),Color.fromRGBO(111, 194, 173, 1.0)];
  var cardIndex = 0;
  ScrollController scrollController;
  var currentColor = Color.fromRGBO(231, 129, 109, 1.0);

  var cardsList = [CardItemModel("Prontuário 1", Icons.dvr, 9, 0.83),CardItemModel("Prontuário 2", Icons.dvr, 12, 0.24),CardItemModel("Prontuário 3", Icons.dvr, 7, 0.32)];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: new Text("Paciente"),
        centerTitle: true,
      ),
      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(),
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
                      padding: const EdgeInsets.fromLTRB(0.0,16.0,0.0,12.0),
                      child: Text("Exemplo da Silva", style: TextStyle(fontSize: 30.0, color: Colors.black),),
                    ),
                  ],
                ),

              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 16.0),
                  child: Text("Ultima Consulta : JUL 21, 2018", style: TextStyle(color: Colors.black),),
                ),
                Container(
                  height: 350.0,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, position) {
                        return GestureDetector (
                          child: Padding (
                            padding: const EdgeInsets.all(8.0),
                            child: Card (
                              child: Container (
                                width: 250.0,
                                child: Column (
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding (
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row (
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          InkWell(child: Icon(Icons.create, color: Colors.grey),
                                            onTap: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => Prontuario(),));
                                            },
                                          ),


                                        ],
                                      ),
                                    ),
                                    Padding (
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column (
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          Padding (
                                            padding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 8.0,
                                                vertical: 4.0),
                                          ),
                                          Padding (
                                            padding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 8.0,
                                                vertical: 4.0),
                                            child: Text (
                                              "${cardsList[position]
                                                  .cardTitle}",
                                              style: TextStyle (
                                                  fontSize: 28.0),),
                                          ),
                                          Padding (
                                            padding: const EdgeInsets.all(
                                                8.0),
                                            child: LinearProgressIndicator (
                                              value: cardsList[position]
                                                  .taskCompletion,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              shape: RoundedRectangleBorder (
                                  borderRadius: BorderRadius.circular (
                                      10.0)
                              ),
                            ),
                          ),

                        );
                      }
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}