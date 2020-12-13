import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hispanos/src/models/registrosmodel.dart';
import 'package:hispanos/src/providers/gastos_providers.dart';
import 'package:hispanos/src/utils/utils.dart' as utils;

class RegistroGastos extends StatefulWidget {
  static final String routeName = 'RegistroGastos';
  @override
  RegistroGastosClass createState() => RegistroGastosClass();
}

class RegistroGastosClass extends State<RegistroGastos> {
  String _fecha = '';
  String _opcionCat = 'Categoria';
  List<String> _cat = ['Uno', 'Dos', 'Categoria'];

  TextEditingController _inputFieldDateController = new TextEditingController();

  final formKey = GlobalKey<FormState>();
  final gastosProvider = new GastosProvider();

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
                    'REGISTRAR GASTOS FAMILIARES',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  _crearMonto(),
                  Divider(),
                  _crearDropdownCat(),
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
        ));
  }

  Widget _crearFecha(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: false,
      controller: _inputFieldDateController,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Fecha',
          labelText: 'Fecha',
          suffixIcon: Icon(Icons.perm_contact_calendar),
          icon: Icon(Icons.calendar_today)),
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
            child: Text('Guardar', style: TextStyle(fontSize: 15.0)),
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

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2025),
    );

    if (picked != null) {
      setState(() {
        _fecha = picked.toString();
        _inputFieldDateController.text = _fecha;
      });
    }
  }

  Widget _crearMonto() {
    return TextFormField(
      // autofocus: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Monto',
          labelText: 'Monto',
          suffixIcon: Icon(Icons.accessibility),
          icon: Icon(Icons.account_circle)),

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
          suffixIcon: Icon(Icons.accessibility),
          icon: Icon(Icons.account_circle)),
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
        Icon(Icons.select_all),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButtonFormField(
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


    gastosProvider.crearRegistro(registro);
    Navigator.of(context).pop();
  }
}
