import 'package:hispanos/src/models/registrosmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'dart:async';

class PagosProvider {
  final String _url = 'https://appestadocuenta.firebaseio.com/';

  Future<bool> crearRegistro(IngresosRegistrados registro) async {
    final url = '$_url/pagos.json';

    final resp =
        await http.post(url, body: ingresosRegistradosToJson(registro));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<IngresosRegistrados>> cargarRegistros() async {
    final url = '$_url/pagos.json';

    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<IngresosRegistrados> registros = new List();
    if (decodedData == null) return [];
    int col = 1;
    decodedData.forEach((id, regis) {
      final regisTemp = IngresosRegistrados.fromJson(regis);
      regisTemp.id = id;
      regisTemp.index = col;
      registros.add(regisTemp);
      col++;
    });

    return registros;
  }

  Future<int> borrarProducto(String id) async {
    final url = '$_url/pagos/$id.json';
    final resp = await http.delete(url);

    print(json.decode(resp.body));

    return 1;
  }
}
