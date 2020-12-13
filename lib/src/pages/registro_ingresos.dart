import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hispanos/src/models/registrosmodel.dart';
import 'package:hispanos/src/providers/ingresos_providers.dart';
import 'package:hispanos/src/utils/utils.dart' as utils;

class RegistroIngresos extends StatefulWidget {
  static final String routeName = 'RegistroIngresos';
  @override
  RegistroIngreClass createState() => RegistroIngreClass();
}

class RegistroIngreClass extends State<RegistroIngresos> {
  String _fecha = '';
  String _opcionCat = 'Nivel 1';
  List<String> _cat = ['Nivel 1', 'Nivel 2', 'Nivel 3'];

  TextEditingController _inputFieldDateController = new TextEditingController();

  final formKey = GlobalKey<FormState>();
  final ingresoProvider = new IngresosProvider();

  IngresosRegistrados registro = new IngresosRegistrados();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Registrar'),
          backgroundColor: Color.fromRGBO(0, 0, 139, 1.0)),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'REGISTRAR INGRESO',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                _crearDropdownCat(),
                Divider(),
                _crearMonto(),
                Divider(),
                _crearConcepto(),
                Divider(),
                _crearFecha(context),
                Divider(),
                _crearBoton(context),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2020),
      lastDate: new DateTime.now(),
    );

    TimeOfDay hola = TimeOfDay.now();

    if (picked != null) {
      setState(() {
        _fecha =
            "${picked.day}-${picked.month}-${picked.year}\n${hola.hour}:${hola.minute}";
        _inputFieldDateController.text = _fecha;
      });
    }
  }

  Widget _crearFecha(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: false,
      controller: _inputFieldDateController,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Fecha',
          labelText: 'Fecha',
          icon: Icon(Icons.date_range, color: Color.fromRGBO(0, 0, 0, 1.0))),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
      onSaved: (value) => registro.fecha = value,
    );
  }

  Widget _crearBoton(BuildContext context) {
    // formValidStream
    // snapshot.hasData
    //  true ? algo si true : algo si false

    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Registrar', style: TextStyle(fontSize: 15.0)),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Color.fromRGBO(0, 0, 139, 1),
          textColor: Colors.white,
          onPressed: _submit,
        );
      },
    );
  }

  Widget _crearMonto() {
    return TextFormField(
      // autofocus: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Monto',
          labelText: 'Monto',
          icon:
              Icon(Icons.monetization_on, color: Color.fromRGBO(0, 0, 0, 1.0))),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      onSaved: (value) => registro.monto = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
      onChanged: (valor) {
        setState(() {});
      },
    );
  }

  Widget _crearConcepto() {
    return TextFormField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Concepto',
          labelText: 'Concepto',
          icon: Icon(Icons.assignment, color: Color.fromRGBO(0, 0, 0, 1.0))),
      onSaved: (value) => registro.concepto = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese concepto';
        } else {
          return null;
        }
      },
      onChanged: (valor) {
        setState(() {});
      },
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdownMes() {
    List<DropdownMenuItem<String>> listacat = new List();

    _cat.forEach((cats) {
      listacat.add(DropdownMenuItem(
        child: Text(cats),
        value: cats,
      ));
    });

    return listacat;
  }

  Widget _crearDropdownCat() {
    return Row(
      children: <Widget>[
        Icon(Icons.assistant_photo, color: Color.fromRGBO(0, 0, 0, 1.0)),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Categoria',
            ),
            value: _opcionCat,
            items: getOpcionesDropdownMes(),
            onChanged: (opt) {
              setState(() {
                _opcionCat = opt;
              });
            },
            onSaved: (opt) => registro.categoria = opt,
          ),
        )
      ],
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    ingresoProvider.crearRegistro(registro);
    Navigator.of(context).pop();
  }
}
