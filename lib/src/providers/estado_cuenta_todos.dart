import 'package:hispanos/src/models/registrosmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'dart:async';

class EstadosProvider {
  final String _url = 'https://appestadocuenta.firebaseio.com/';

  Future<List<IngresosRegistrados>> cargarEstados() async {
    final urlingresos = '$_url/ingresos.json';
    final urlgastos = '$_url/gastos.json';
    final urlpagos = '$_url/pagos.json';

    final respin = await http.get(urlingresos);
    final respgas = await http.get(urlgastos);
    final resppa = await http.get(urlpagos);

    final Map<String, dynamic> dataIngresos = json.decode(respin.body);
    final Map<String, dynamic> dataGastos = json.decode(respgas.body);
    final Map<String, dynamic> dataPagos = json.decode(resppa.body);
    final List<IngresosRegistrados> registros = new List();
    int col = 1;

    if (dataIngresos == null) return [];
    dataIngresos.forEach((id, regis) {
      final regisTemp = IngresosRegistrados.fromJson(regis);
      regisTemp.id = id;
      regisTemp.index = col;
      registros.add(regisTemp);
      col++;
    });

    if (dataGastos == null) return [];
    dataGastos.forEach((id, regis) {
      final regisTemp = IngresosRegistrados.fromJson(regis);
      regisTemp.id = id;
      regisTemp.index = col;
      registros.add(regisTemp);
      col++;
    });

    if (dataPagos == null) return [];
    dataPagos.forEach((id, regis) {
      final regisTemp = IngresosRegistrados.fromJson(regis);
      regisTemp.id = id;
      regisTemp.index = col;
      registros.add(regisTemp);
      col++;
    });

    return registros;
  }
}
