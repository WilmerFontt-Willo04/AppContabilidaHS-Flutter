import 'package:flutter/material.dart';
import 'package:hispanos/src/models/registrosmodel.dart';
import 'package:hispanos/src/pages/detalles_ingresos.dart';
import 'package:hispanos/src/providers/ingresos_providers.dart';

class RegistrosGuardados extends StatelessWidget {
  static final String routeName = 'registrosguardados';
  final ingresosProvider = new IngresosProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('REGISTROS'),
          backgroundColor: Color.fromRGBO(0, 0, 139, 1.0),
        ),
        //backgroundColor: Color.fromRGBO(0, 0, 119, 1.0),

        body: _crearListado());
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: ingresosProvider.cargarRegistros(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final registros = snapshot.data;

          return ListView.builder(
            itemCount: registros.length,
            itemBuilder: (context, i) =>
                _crearItem(context, i, snapshot, registros[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, i, AsyncSnapshot snapshot,
      IngresosRegistrados registro) {
    return Card(
      child: ListTile(
        trailing: Icon(Icons.keyboard_arrow_right,
            size: 30, color: Color.fromRGBO(0, 0, 0, 0.8)),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            (i + 1).toString(),
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
        title: Row(
          children: <Widget>[
            Text('${registro.categoria}     ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('-     ${registro.concepto}', style: TextStyle(fontSize: 16)),
            Text('\n', style: TextStyle(fontSize: 16)),
          ],
        ),
        subtitle:
            Text('Monto: ${registro.monto} \$ \nFecha: ${registro.fecha} \n'),
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => DetailPage(snapshot.data[i])));
        },
      ),
    );
  }
}
