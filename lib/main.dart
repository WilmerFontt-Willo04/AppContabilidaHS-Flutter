import 'package:flutter/material.dart';
import 'package:hispanos/src/bloc/provider.dart';
import 'package:hispanos/src/pages/estados.dart';
import 'package:hispanos/src/pages/filtrarestados_de_cuenta.dart';
import 'package:hispanos/src/pages/filtrar_gastos.dart';
import 'package:hispanos/src/pages/gastos.dart';
import 'package:hispanos/src/pages/gastosguardados.dart';
import 'package:hispanos/src/pages/home_page.dart';
import 'package:hispanos/src/pages/ingresos.dart';
import 'package:hispanos/src/pages/login_page.dart';
import 'package:hispanos/src/pages/pagos.dart';
import 'package:hispanos/src/pages/pagos_filtro.dart';
import 'package:hispanos/src/pages/pagos_registro.dart';
import 'package:hispanos/src/pages/pagosguardados.dart';
import 'package:hispanos/src/pages/registro_ingresos.dart';
import 'package:hispanos/src/pages/registrosguardados.dart';

import 'src/pages/filtrar_ingresos.dart';
import 'src/pages/gastos_ingresos.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HISPANOS SOLUCIONES',
        initialRoute: LoginPage.routeName,
        routes: {
          HomePage.routeName: (BuildContext context) => HomePage(),
          LoginPage.routeName: (BuildContext context) => LoginPage(),
          EstadoCuenta.routeName: (BuildContext context) => EstadoCuenta(),
          FiltrarEstadoCuenta.routeName: (BuildContext context) =>
              FiltrarEstadoCuenta(),
          Pagos.routeName: (BuildContext context) => Pagos(),
          PagosGuardados.routeName: (BuildContext context) => PagosGuardados(),
          Gastos.routeName: (BuildContext context) => Gastos(),
          GastosGuardados.routeName: (BuildContext context) =>
              GastosGuardados(),
          Ingresos.routeName: (BuildContext context) => Ingresos(),
          RegistroIngresos.routeName: (BuildContext context) =>
              RegistroIngresos(),
          FiltrarIngresos.routeName: (BuildContext context) =>
              FiltrarIngresos(),
          RegistroGastos.routeName: (BuildContext context) => RegistroGastos(),
          FiltrarGastos.routeName: (BuildContext context) => FiltrarGastos(),
          RegistroPagos.routeName: (BuildContext context) => RegistroPagos(),
          FiltrarPagos.routeName: (BuildContext context) => FiltrarPagos(),
          RegistrosGuardados.routeName: (BuildContext context) =>
              RegistrosGuardados(),
        },
        theme: ThemeData(
          primaryColor: Color.fromRGBO(0, 0, 139, 1),
        ),
      ),
    );
  }
}
