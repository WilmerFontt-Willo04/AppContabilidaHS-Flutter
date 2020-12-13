import 'package:flutter/material.dart';
import 'package:hispanos/src/models/registrosmodel.dart';
import 'package:hispanos/src/pages/ingresos.dart';
import 'package:hispanos/src/providers/ingresos_providers.dart';

class DetailPage extends StatelessWidget {
  static final String routeName = 'Detalles';
  final IngresosRegistrados user;

  DetailPage(this.user);
  final ingresosProvider = new IngresosProvider();

  @override
  Widget build(BuildContext context) {
    showAlertDialog(BuildContext context) {
      // set up the buttons
      Widget cancelButton = FlatButton(
        child: Text("Cancelar"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = FlatButton(
        child: Text("Continuar"),
        onPressed: () {
          ingresosProvider.borrarProducto(user.id);
          Navigator.of(context)
              .popUntil(ModalRoute.withName(Ingresos.routeName));
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("¿Desea eliminar este Ingreso?"),
        content: Text("Se eliminará el ingreso de " +
            user.monto.toString() +
            ' \$ y de concepto ' +
            user.concepto),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      //show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                showAlertDialog(context);
              })
        ],
        title: Text(user.categoria),
      ),
      body: Container(
        //height: 120.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
          child: Card(
            margin: EdgeInsets.all(10.0),
            elevation: 2.0,
            child: new Column(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(
                    Icons.assistant_photo,
                    color: Color.fromRGBO(0, 0, 139, 1.0),
                    size: 26.0,
                  ),
                  title: Row(
                    children: <Widget>[
                      new Text("Categoria:  ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      new Text(
                        user.categoria,
                        style: new TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                new Divider(color: Color.fromRGBO(0, 0, 0, 1.0)),
                new ListTile(
                  leading: new Icon(
                    Icons.assignment,
                    color: Color.fromRGBO(0, 0, 139, 1.0),
                    size: 26.0,
                  ),
                  title: Row(
                    children: <Widget>[
                      new Text("Concepto:  ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      new Text(
                        user.concepto,
                        style: new TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                new Divider(color: Color.fromRGBO(0, 0, 0, 1.0)),
                new ListTile(
                  leading: new Icon(
                    Icons.date_range,
                    color: Color.fromRGBO(0, 0, 139, 1.0),
                    size: 26.0,
                  ),
                  title: Row(
                    children: <Widget>[
                      new Text("Fecha:  ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      new Text(
                        user.fecha,
                        style: new TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                new Divider(color: Color.fromRGBO(0, 0, 0, 1.0)),
                new ListTile(
                  leading: new Icon(
                    Icons.monetization_on,
                    color: Color.fromRGBO(0, 0, 139, 1.0),
                    size: 26.0,
                  ),
                  title: Row(
                    children: <Widget>[
                      new Text("Monto:  ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      new Text(
                        user.monto.toString() + ' \$',
                        style: new TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                new Divider(color: Color.fromRGBO(0, 0, 0, 1.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
