import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:imed/services/authentication.dart';
import 'pacientes.dart';
import 'tabelacid.dart';

var color1 = Color(0xFF9DEBFF);
var color2 = Color(0xFF91AFFF);
var profileImage = NetworkImage(
    'https://scontent.fiza1-1.fna.fbcdn.net/v/t31.0-8/p960x960/19983241_1760019'
    '967360965_8543988377281362526_o.jpg?_nc_cat=105&_nc_ohc=1kVKnxeEC5EAQmt'
    '81WvwhHMARUA3W5OVLAn49i3tpPKl1tiFgJQx4171g&_nc_ht=scontent.fiza1-1.fna&'
    'oh=73476aece74ec810cb3f102755779f5b&oe=5E438998');

class SecondScreen extends StatelessWidget {
  SecondScreen({
    Key key,
    this.auth,
    this.userId,
    this.logoutCallback,
    this.email,
  }) : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final String email;
  QuerySnapshot UsuarioAtual;
  final db = Firestore.instance;

  signOut() async {
    try {
      await auth.signOut();
      logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white12,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 0.0,
          ),
          UpperSection(),
          SizedBox(
            height: 10.0,
          ),
          MiddleSection(),
          BottomSection(),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text(
                  'Frederico',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                accountEmail: new Text('CMD'),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: new NetworkImage(
                      'https://musicimage.xboxlive.com/catalog/video.movie.8D6KGX0M8V16/image?locale=pt-br&mode=crop&purposes=BoxArt&q=90&h=225&w=150&format=jpg'),
                ),
              ),
              ListTile(
                title: Text('Pacientes'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Pacientes()));
                },
              ),
              ListTile(
                title: Text('CID'),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => CID()));
                },
              ),
              ListTile(
                title: Text('Configurações'),
                onTap: () {},
              ),
              new Divider(
                color: Colors.blueGrey,
                height: 5.0,
              ),
              SizedBox(height: 0),
              ListTile(
                title: Text('Sair'),
                onTap: () {
                  signOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Gaveta extends StatelessWidget {
  const Gaveta({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Pacientes'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Sair'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class BottomSection extends StatelessWidget {
  const BottomSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.0,
      color: color1.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Segurança e dados'),
                SizedBox(
                  width: 16.0,
                ),
                Text('Configurações'),
              ],
            ),
            Text('Ajuda')
          ],
        ),
      ),
    );
  }
}

class MiddleSection extends StatelessWidget {
  const MiddleSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: <Widget>[
          Divider(
            height: 8.0,
          ),
          ListTile(
            title: Text("Noticia/report Diario"),
            subtitle: Text('Cartão de paciente'),
            trailing: ClipOval(
              child: Container(
                  height: 40.0,
                  width: 40.0,
                  color: Colors.green.withOpacity(0.2),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add),
                    color: Colors.green,
                  )),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              height: 160.0,
              child: ListView(
                padding: EdgeInsets.all(0.0),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ItemCard(Icons.favorite, 'Saude', 'Urgencia: 2'),
                  ItemCard(Icons.favorite, 'Saude', 'Urgencia: 3'),
                  ItemCard(Icons.favorite, 'Saude', 'Urgencia: 4'),
                  ItemCard(Icons.favorite, 'Saude', 'Urgencia: 5'),
                  ItemCard(Icons.favorite, 'Saude', 'Urgencia: 6'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final icon;
  final name;
  final tasks;

  const ItemCard(this.icon, this.name, this.tasks);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        height: 160.0,
        width: 120.0,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [color1, color2])),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.white,
              ),
              Spacer(),
              Text(
                name,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                tasks,
                style: TextStyle(color: Colors.white.withOpacity(0.6)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpperSection extends StatelessWidget {
  UpperSection({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 0.0,
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 8.0,
              ),
              CircleAvatar(
                backgroundImage: profileImage,
                maxRadius: 55.0,
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                'Frederico',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                'Geriatrico',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Container(
            height: 4.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [color1, color2])),
          ),
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 48.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    '0',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Text(
                    'alguma',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'informação',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    '0',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Text(
                    'outra',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'informação',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    '0',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Text(
                    'maisuma',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'funçao',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
