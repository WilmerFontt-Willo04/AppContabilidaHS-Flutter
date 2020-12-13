import 'dart:convert';

IngresosRegistrados ingresosRegistradosFromJson(String str) =>
    IngresosRegistrados.fromJson(json.decode(str));

String ingresosRegistradosToJson(IngresosRegistrados data) =>
    json.encode(data.toJson());

class IngresosRegistrados {
  IngresosRegistrados({
    this.id,
    this.categoria,
    this.usuario,
    this.concepto,
    this.fecha,
    this.monto,
    this.index,
  });

  String id;
  String categoria;
  String usuario;
  String concepto;
  String fecha;
  double monto;
  int index;

  factory IngresosRegistrados.fromJson(Map<String, dynamic> json) =>
      IngresosRegistrados(
        id: json["id"],
        categoria: json["categoria"],
        usuario: json["usuario"],
        concepto: json["concepto"],
        fecha: json["fecha"],
        monto: json["monto"].toDouble(),
        index: json["index"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoria": categoria,
        "usuario": usuario,
        "concepto": concepto,
        "fecha": fecha,
        "monto": monto,
        "index": index,
      };
}
