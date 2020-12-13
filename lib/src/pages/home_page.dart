import 'package:flutter/material.dart';
import 'package:hispanos/src/models/registrosmodel.dart';
import 'package:hispanos/src/pages/gastos.dart';
import 'package:hispanos/src/pages/ingresos.dart';
import 'package:hispanos/src/pages/login_page.dart';
import 'package:hispanos/src/pages/pagos.dart';
import 'dart:async';

import 'package:hispanos/src/providers/estado_cuenta_todos.dart';

class HomePage extends StatefulWidget {
  @override
  HomePage() : super();
  _DetailsScreenState createState() => _DetailsScreenState();
  static final String routeName = 'homepage';
}

class _DetailsScreenState extends State<HomePage> {
  final controller = ScrollController();
  double offset = 0;
  final pagosProvider = new EstadosProvider();

  Future<List<IngresosRegistrados>> _func;
  List<IngresosRegistrados> selectedUsers;

  @override
  void initState() {
    selectedUsers = [];
    _func = pagosProvider.cargarEstados();
    controller.addListener(onScroll);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<IngresosRegistrados>>(
        future: _func,
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            List<IngresosRegistrados> data = snapshot.data;
            print(snapshot);

            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text('HISPANOS SOLUCIONES'),
                  backgroundColor: Color.fromRGBO(0, 0, 139, 1.0),
                ),
                body: SafeArea(
                  left: true,
                  top: true,
                  right: true,
                  bottom: true,
                  child: SizedBox.expand(
                      child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: <Color>[
                      Color.fromRGBO(0, 0, 0, 0.1),
                      Color.fromRGBO(0, 0, 0, 0.1)
                    ])),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      verticalDirection: VerticalDirection.down,
                      children: <Widget>[
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Center(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        showCheckboxColumn: false,
                                        dividerThickness: 2.0,
                                        horizontalMargin: 0.0,
                                        columnSpacing: 5.0,
                                        columns: [
                                          DataColumn(
                                            label: Text(
                                              'ID',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                              ),
                                            ),
                                            numeric: true,
                                            tooltip: "id archivo",
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Categoria',
                                              style: TextStyle(
                                                color: Colors.orange.shade900,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                            tooltip: "categoria de registro",
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Concepto',
                                              style: TextStyle(
                                                color: Colors.orange.shade900,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                            tooltip: "concepto de registro",
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Fecha',
                                              style: TextStyle(
                                                color: Colors.orange.shade900,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                            tooltip: "fecha de registro",
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Monto',
                                              style: TextStyle(
                                                color: Colors.orange.shade900,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                            numeric: true,
                                            tooltip: "monto de registro",
                                          ),
                                        ],
                                        rows: data
                                            .map(
                                              (user) => DataRow(
                                                cells: [
                                                  DataCell(
                                                    Text(user.index.toString()),
                                                    onTap: () {
                                                      print(
                                                          'Selected ${user.id}');
                                                    },
                                                  ),
                                                  DataCell(
                                                    Text(user.categoria),
                                                  ),
                                                  DataCell(
                                                    Text(user.concepto),
                                                  ),
                                                  DataCell(
                                                    Text(user.fecha),
                                                  ),
                                                  DataCell(
                                                    Text(user.monto.toString() +
                                                        ' \$'),
                                                  ),
                                                ],
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                // SizedBox(height: 500),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
                drawer: SafeArea(
                    left: true,
                    top: true,
                    right: true,
                    bottom: true,
                    child: _crearmenu(context)));
          } else if (snapshot.hasError) {
            return AlertDialog(
              title: Text(
                '¡Ha ocurrido un error!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              content: Text(
                "${snapshot.error}",
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Regresar',
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
          // By default, show a loading spinner.
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('HISPANOS SOLUCIONES'),
                backgroundColor: Color.fromRGBO(0, 0, 139, 1.0),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text('Cargando..')
                  ],
                ),
              ),
              drawer: SafeArea(
                  left: true,
                  top: true,
                  right: true,
                  bottom: true,
                  child: _crearmenu(context)));
        });
  }

  Drawer _crearmenu(BuildContext context) {
    return Drawer(
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Color.fromRGBO(0, 0, 139, 1),
                Color.fromRGBO(0, 0, 139, 1)
              ]),
            ),
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
              DrawerHeader(
                  child: Container(),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/captura.PNG'),
                          fit: BoxFit.cover))),
              Divider(),
              Card(
                  margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
                  child: ListTile(
                    leading: Icon(Icons.add,
                        size: 30, color: Color.fromRGBO(0, 0, 179, 1.0)),
                    title: Text('Ingresos'),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        size: 30, color: Color.fromRGBO(0, 0, 0, 1.0)),
                    onTap: () {
                      Navigator.pushNamed(context, Ingresos.routeName);
                    },
                  )),
              Card(
                  margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
                  child: ListTile(
                    leading: Icon(Icons.new_releases,
                        size: 30, color: Color.fromRGBO(0, 0, 179, 1.0)),
                    title: Text('Gastos'),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        size: 30, color: Color.fromRGBO(0, 0, 0, 1.0)),
                    onTap: () {
                      Navigator.pushNamed(context, Gastos.routeName);
                    },
                  )),
              Card(
                  margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
                  child: ListTile(
                    leading: Icon(Icons.flag,
                        size: 30, color: Color.fromRGBO(0, 0, 179, 1.0)),
                    title: Text('Pagos'),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        size: 30, color: Color.fromRGBO(0, 0, 0, 1.0)),
                    onTap: () {
                      Navigator.pushNamed(context, Pagos.routeName);
                    },
                  )),
              Divider(),
              Card(
                margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
                child: ListTile(
                  leading: Icon(Icons.exit_to_app,
                      color: Color.fromRGBO(0, 0, 179, 1.0)),
                  title: Text('Cerrar Sesión',
                      style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, LoginPage.routeName);
                  },
                ),
              ),
            ])));
  }
}
