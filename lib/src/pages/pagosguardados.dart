import 'package:flutter/material.dart';
import 'package:hispanos/src/models/registrosmodel.dart';
import 'dart:async';

import 'package:hispanos/src/providers/pagos_providers.dart';

class PagosGuardados extends StatefulWidget {
  @override
  PagosGuardados() : super();
  _DetailsScreenState createState() => _DetailsScreenState();
  static final String routeName = 'pagosguardados';
}

class _DetailsScreenState extends State<PagosGuardados> {
  final controller = ScrollController();
  double offset = 0;
  final pagosProvider = new PagosProvider();

  Future<List<IngresosRegistrados>> _func;
  List<IngresosRegistrados> selectedUsers;
  bool sort;

  @override
  void initState() {
    selectedUsers = [];
    sort = false;
    _func = pagosProvider.cargarRegistros();
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
                title: Text('REGISTROS'),
                backgroundColor: Color.fromRGBO(0, 0, 139, 1.0),
              ),
              body: Column(
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
                                  sortColumnIndex: 0,
                                  sortAscending: sort,
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
                                        'USUARIO',
                                        style: TextStyle(
                                          color: Colors.orange.shade900,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      tooltip: "Usu de registro",
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
                                        'Fecha',
                                        style: TextStyle(
                                          color: Colors.orange.shade900,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      numeric: true,
                                      tooltip: "fecha de registro",
                                    ),
                                  ],
                                  rows: data
                                      .map(
                                        (user) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(user.index.toString()),
                                              onTap: () {
                                                print('Selected ${user.id}');
                                              },
                                            ),
                                            DataCell(
                                              Text(user.usuario),
                                            ),
                                            DataCell(
                                              Text(user.monto.toString()),
                                            ),
                                            DataCell(
                                              Text(user.concepto),
                                            ),
                                            DataCell(
                                              Text(user.categoria),
                                            ),
                                            DataCell(
                                              Text(user.fecha),
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
            );
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
                title: Text('REGISTROS'),
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
              ));
        });
  }
}
