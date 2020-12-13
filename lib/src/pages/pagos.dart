import 'package:flutter/material.dart';
import 'package:hispanos/src/pages/pagos_filtro.dart';
import 'package:hispanos/src/pages/pagos_registro.dart';
import 'package:hispanos/src/pages/pagosguardados.dart';

class Pagos extends StatefulWidget {
  static final String routeName = 'Pagos';
  @override
  PagosClass createState() => PagosClass();
}

class PagosClass extends State<Pagos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Pagos'),
          backgroundColor: Color.fromRGBO(0, 0, 139, 1.0)),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.add_circle,
                  size: 50, color: Color.fromRGBO(0, 0, 0, 0.8)),
              title: Text('Registrar'),
              subtitle: Text('Registrar Nuevos Pagos'),
              trailing: Icon(Icons.keyboard_arrow_right,
                  size: 30, color: Color.fromRGBO(0, 0, 0, 0.8)),
              onTap: () {
                Navigator.pushNamed(context, RegistroPagos.routeName);
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.filter_list,
                  size: 50, color: Color.fromRGBO(0, 0, 0, 0.8)),
              title: Text('Filtrar'),
              subtitle: Text('Filtrar información de Pagos registrados'),
              trailing: Icon(Icons.keyboard_arrow_right,
                  size: 30, color: Color.fromRGBO(0, 0, 0, 0.8)),
              onTap: () {
                Navigator.pushNamed(context, FiltrarPagos.routeName);
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.archive,
                  size: 50, color: Color.fromRGBO(0, 0, 0, 0.8)),
              title: Text('Pagos'),
              subtitle: Text('Visualizar Pagos'),
              trailing: Icon(Icons.keyboard_arrow_right,
                  size: 30, color: Color.fromRGBO(0, 0, 0, 0.8)),
              onTap: () {
                Navigator.pushNamed(context, PagosGuardados.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
