import 'package:flutter/material.dart';
import 'package:hispanos/src/pages/filtrarestados_de_cuenta.dart';

class EstadoCuenta extends StatefulWidget {
  static final String routeName = 'EstadoCuenta';
  @override
  EstadoCuentaClass createState() => EstadoCuentaClass();
}

class EstadoCuentaClass extends State<EstadoCuenta> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estados de Cuenta'),
        backgroundColor: Color.fromRGBO(0, 0, 139, 1.0),
      ),
      body: ListView(
  children: <Widget>[
    Card(
      child: ListTile(
        leading: Icon( Icons.filter_list, size: 50,color: Color.fromRGBO(0, 0, 0, 0.8)),
        title: Text('Filtrar Estados'),
        subtitle: Text('Filtrar Estados Registrados'),
        trailing: Icon( Icons.keyboard_arrow_right, size: 30,color: Color.fromRGBO(0, 0, 0, 0.8) ),
        onTap: (){
          Navigator.pushNamed(context, FiltrarEstadoCuenta.routeName);
        },
      ),
    ),
    Card(
      child: ListTile(
        leading: Icon( Icons.archive, size: 50,color: Color.fromRGBO(0, 0, 0, 0.8)),
        title: Text('Estados'),
        subtitle: Text('Visualizar Todos los Estados'),
        trailing: Icon( Icons.keyboard_arrow_right, size: 30,color: Color.fromRGBO(0, 0, 0, 0.8) ),
        onTap: (){},
      ),
    ),
  ],
),
    );
  }

  
}
