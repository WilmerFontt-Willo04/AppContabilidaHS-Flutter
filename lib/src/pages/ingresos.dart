import 'package:flutter/material.dart';
import 'package:hispanos/src/pages/filtrar_ingresos.dart';
import 'package:hispanos/src/pages/registro_ingresos.dart';
import 'package:hispanos/src/pages/registrosguardados.dart';

class Ingresos extends StatefulWidget {
  static final String routeName = 'Ingresos';
  @override
  IngresosClass createState() => IngresosClass();
}

class IngresosClass extends State<Ingresos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Ingresos'),
          backgroundColor: Color.fromRGBO(0, 0, 139, 1.0)),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.add_circle,
                  size: 50, color: Color.fromRGBO(0, 0, 0, 0.8)),
              title: Text('Registrar'),
              subtitle: Text('Registrar Nuevos Ingresos'),
              trailing: Icon(Icons.keyboard_arrow_right,
                  size: 30, color: Color.fromRGBO(0, 0, 0, 0.8)),
              onTap: () {
                Navigator.pushNamed(context, RegistroIngresos.routeName);
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.filter_list,
                  size: 50, color: Color.fromRGBO(0, 0, 0, 0.8)),
              title: Text('Filtrar'),
              subtitle: Text('Filtrar información de ingresos registrados'),
              trailing: Icon(Icons.keyboard_arrow_right,
                  size: 30, color: Color.fromRGBO(0, 0, 0, 0.8)),
              onTap: () {
                Navigator.pushNamed(context, FiltrarIngresos.routeName);
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.archive,
                  size: 50, color: Color.fromRGBO(0, 0, 0, 0.8)),
              title: Text('Registros'),
              subtitle: Text('Visualizar Registros'),
              trailing: Icon(Icons.keyboard_arrow_right,
                  size: 30, color: Color.fromRGBO(0, 0, 0, 0.8)),
              onTap: () {
                Navigator.pushNamed(context, RegistrosGuardados.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
