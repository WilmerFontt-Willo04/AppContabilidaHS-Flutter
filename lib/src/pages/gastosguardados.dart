import 'package:flutter/material.dart';
import 'package:hispanos/src/models/registrosmodel.dart';
import 'package:hispanos/src/providers/gastos_providers.dart';
import 'dart:async';

class GastosGuardados extends StatefulWidget {
  @override
  GastosGuardados() : super();
  _DetailsScreenState createState() => _DetailsScreenState();
  static final String routeName = 'gastosguardados';
}

class _DetailsScreenState extends State<GastosGuardados> {
  final controller = ScrollController();
  double offset = 0;
  final gastosProvider = new GastosProvider();

  Future<List<IngresosRegistrados>> _func;
  List<IngresosRegistrados> selectedUsers;
  bool sort;

  @override
  void initState() {
    selectedUsers = [];
    sort = false;
    _func = gastosProvider.cargarRegistros();
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
            print('entro');

            onSortColum(int columnIndex, bool ascending) {
              if (columnIndex == 0) {
                if (ascending) {
                  data.sort((a, b) => a.id.compareTo(b.id));
                } else {
                  data.sort((a, b) => b.id.compareTo(a.id));
                }
              }
            }

            onSelectedRow(bool selected, IngresosRegistrados user) async {
              setState(() {
                if (selected) {
                  selectedUsers.add(user);
                } else {
                  selectedUsers.remove(user);
                }
              });
            }

            deleteSelected() async {
              setState(() {
                if (selectedUsers.isNotEmpty) {
                  List<IngresosRegistrados> temp = [];
                  temp.addAll(selectedUsers);
                  for (IngresosRegistrados user in temp) {
                    data.remove(user);
                    selectedUsers.remove(user);
                    gastosProvider.borrarProducto(user.id);
                  }
                }
              });
            }

            showAlertDialog(BuildContext context) {
              // set up the buttons
              Widget cancelButton = FlatButton(
                child: Text("Cencelar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );
              Widget continueButton = FlatButton(
                child: Text("Continuar"),
                onPressed: () {
                  deleteSelected();
                  Navigator.of(context).pop();
                },
              );

              //set up the AlertDialog
              AlertDialog alert = AlertDialog(
                title: Text("AlertDialog"),
                content: Text("Se eliminaran todos los datos seleccionados"),
                actions: [
                  cancelButton,
                  continueButton,
                ],
              );

              // show the dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            }

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
                                      onSort: (columnIndex, ascending) {
                                        setState(() {
                                          sort = !sort;
                                        });
                                        onSortColum(columnIndex, ascending);
                                      },
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Concepto',
                                        style: TextStyle(
                                          color: Colors.orange.shade900,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      numeric: false,
                                      tooltip: "concepto de registro",
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
                                        '            Fecha',
                                        style: TextStyle(
                                          color: Colors.orange.shade900,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      numeric: false,
                                      tooltip: "fecha de registro",
                                    ),
                                  ],
                                  rows: data
                                      .map(
                                        (user) => DataRow(
                                          selected:
                                              selectedUsers.contains(user),
                                          onSelectChanged: (b) {
                                            print("Onselect");
                                            onSelectedRow(b, user);
                                          },
                                          cells: [
                                            DataCell(
                                              Text((user.index).toString()),
                                              onTap: () {
                                                print('Selected ${user.id}');
                                              },
                                            ),
                                            DataCell(
                                              Text(user.concepto),
                                            ),
                                            DataCell(
                                              Text(user.monto.toString()),
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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: OutlineButton(
                            child: Text('SELECTED ${selectedUsers.length}'),
                            onPressed: () {},
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: OutlineButton(
                            child: Text('DELETE SELECTED'),
                            onPressed: selectedUsers.isEmpty
                                ? null
                                : () {
                                    showAlertDialog(context);
                                    //deleteSelected();
                                  },
                          ),
                        ),
                      ])
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
