import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Prontuario extends StatelessWidget {
  Prontuario(this.documento);

  final String documento;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProntuarioScreen(documento),
    );
  }
}

class ProntuarioScreen extends StatefulWidget {
  ProntuarioScreen(this.documento);

  final String documento;

  @override
  _ProntuarioScreenState createState() => _ProntuarioScreenState(documento);
}

class _ProntuarioScreenState extends State<ProntuarioScreen> {
  _ProntuarioScreenState(this.documento);

  final String documento;
  String doenca, medicacao,suplementacao, alergia, problema, observacao;

  Future<void> saveProntuario() async {
    print(doenca);
    print(alergia);
    final db = Firestore.instance;
    print(documento);
    await db
        .collection('Pacientes')
        .document(documento)
        .collection('Prontuario')
        .document()
        .setData({
        'doenca': doenca,
        'medicacao':medicacao,
        'suplementacao': suplementacao,
        'alergia': alergia,
        'problema': problema,
        'observacao':observacao,
        }).then((documentReference) {
        Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Center(
      child: Container(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            new TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                labelText: 'Sofre de alguma doença?',
                hintText: 'Ex.: bronquite ou nenhuma...',
              ),
              validator: (value) =>
                  value.isEmpty ? 'este campo não pode ser nulo' : null,
              onSaved: (value) => doenca = value.trim(),
            ),
            SizedBox(height: 10),
            new TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                labelText: 'Fazendo uso de alguma medicação?',
                hintText: 'Ex.: antibióticos... ',
              ),
              validator: (value) =>
                  value.isEmpty ? 'este campo não pode ser nulo' : null,
              onSaved: (value) => medicacao = value.trim(),
            ),
            SizedBox(height: 10),
            new TextFormField(
              scrollPadding:
                  EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                labelText: 'Faz uso de alguma suplementação?',
                hintText: 'Ex.: Vitamina C, Ômega 3... ',
              ),
              validator: (value) => value.isEmpty ? 'este campo não pode ser nulo' : null,
              onSaved: (value) => suplementacao = value.trim(),
            ),
            SizedBox(height: 10),
            new TextFormField(
              scrollPadding:
                  EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                labelText: 'Teve alguma alergia?',
                hintText: 'Ex.: Rinite',
              ),
              validator: (value) =>
                  value.isEmpty ? 'este campo não pode ser nulo' : null,
              onSaved: (value) => alergia = value.trim(),
            ),
            SizedBox(height: 10),
            new TextFormField(
              scrollPadding:
                  EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                labelText: 'Teve algum problema recentemente?',
                hintText: 'Ex.: problemas com alergia, hemorragia...',
              ),
              validator: (value) =>
                  value.isEmpty ? 'este campo não pode ser nulo' : null,
              onSaved: (value) => problema = value.trim(),
            ),
            SizedBox(height: 10),
            new TextFormField(
              scrollPadding:
                  EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 60.0),
                labelText: 'Alguma outra observação?',
                hintText: 'Ex.: qualquer anotação.',
              ),
              validator: (value) =>
                  value.isEmpty ? 'este campo não pode ser nulo' : null,
              onSaved: (value) => observacao = value.trim(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('Salvar'),
                onPressed: () {
                  saveProntuario();
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
