import 'package:flutter/material.dart';
import 'package:imed/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:imed/models/todo.dart';


class CID extends StatefulWidget {
  @override
  CIDState createState() {
    return new CIDState();
  }
}

class CIDState extends State<CID> {
  Widget bodyData() => DataTable(
      onSelectAll: (b) {},
      sortColumnIndex: 1,
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Text("Nome"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.Nome.compareTo(b.Nome));
            });
          },
          tooltip: "To display first name of the Name",
        ),
        DataColumn(
          label: Text("Last Name"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.Codigo.compareTo(b.Codigo));
            });
          },
          tooltip: "To display last name of the Name",
        ),
      ],
      rows: names
          .map(
            (name) => DataRow(
          cells: [
            DataCell(
              Text(name.Nome),
              showEditIcon: false,
              placeholder: false,
            ),
            DataCell(
              Text(name.Codigo),
              showEditIcon: false,
              placeholder: false,
            )
          ],
        ),
      )
          .toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CID"),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        child: bodyData(),
      ),
    );
  }
}

class Name {
  String Nome;
  String Codigo;

  Name({this.Nome, this.Codigo});
}

var names = <Name>[
  Name(Nome: "Gripe", Codigo: "1"),
  Name(Nome: "Resfriado", Codigo: "2"),
  Name(Nome: "Virose", Codigo: "3"),
];
