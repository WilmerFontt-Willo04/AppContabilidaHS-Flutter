import 'package:flutter/material.dart';
import 'package:hispanos/src/pages/filtrar_gastos.dart';
import 'package:hispanos/src/pages/gastos_ingresos.dart';
import 'package:hispanos/src/pages/gastosguardados.dart';

class Gastos extends StatefulWidget {
  static final String routeName = 'Gastos';
  @override
  GastosClass createState() => GastosClass();
}

class GastosClass extends State<Gastos> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gastos'),
        backgroundColor: Color.fromRGBO(0, 0, 139, 1.0)
      ),
      body: ListView(
  children: <Widget>[
    Card(
      child: ListTile(
        leading: Icon( Icons.add_circle, size: 50,color: Color.fromRGBO(0, 0, 0, 0.8)),
        title: Text('Registrar'),
        subtitle: Text('Registrar Nuevos Gastos'),
        trailing: Icon( Icons.keyboard_arrow_right, size: 30,color: Color.fromRGBO(0, 0, 0, 0.8) ),
        onTap: (){
          Navigator.pushNamed(context, RegistroGastos.routeName);
        },
      ),
    ),
    Card(
      child: ListTile(
        leading: Icon( Icons.filter_list, size: 50,color: Color.fromRGBO(0, 0, 0, 0.8)),
        title: Text('Filtrar'),
        subtitle: Text('Filtrar información de Gastos Registrados'),
        trailing: Icon( Icons.keyboard_arrow_right, size: 30,color: Color.fromRGBO(0, 0, 0, 0.8) ),
        onTap: (){
          Navigator.pushNamed(context, FiltrarGastos.routeName);
        },
      ),
    ),
    Card(
      child: ListTile(
        leading: Icon( Icons.archive, size: 50,color: Color.fromRGBO(0, 0, 0, 0.8)),
        title: Text('Registros'),
        subtitle: Text('Visualizar Gastos'),
        trailing: Icon( Icons.keyboard_arrow_right, size: 30,color: Color.fromRGBO(0, 0, 0, 0.8) ),
        onTap: (){    Navigator.pushNamed(context, GastosGuardados.routeName);    },
      ),
    ),
  ],
),
    );
  }

  
}
