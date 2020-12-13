import 'package:flutter/material.dart';

class FiltrarEstadoCuenta extends StatefulWidget {
  static final String routeName = 'FiltrarEstadoCuenta';
  @override
  FiltrarClass createState() => FiltrarClass();
}

class FiltrarClass extends State<FiltrarEstadoCuenta> {
  String _fecha = '';
  String _opcionMes = 'Mayo';
  List<String> _mes = ['Enero', 'Mayo', 'Julio', 'Septiembre'];
  String _opcionAno = '2018';
  List<String> _ano = ['2018', '2019', '2020'];

  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Estados de Cuenta'),
          backgroundColor: Color.fromRGBO(0, 0, 139, 1.0)),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        children: <Widget>[
          Text(
            'FILTRAR INFORMACIÓN',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          _crearDropdownMes(),
          Divider(),
          _crearDropdownAno(),
          Divider(),
          _crearCategoria(),
          Divider(),
          _crearConcepto(),
          Divider(),
          _crearFecha(context),
          Divider(),
          _crearBoton(context),
          Divider(),
        ],
      ),
    );
  }

  Widget _crearFecha(BuildContext context) {
    return TextField(
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
              child: Text('Filtrar', style: TextStyle(fontSize: 15.0)),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Color.fromRGBO(0, 0, 139, 1),
            textColor: Colors.white,
            onPressed: () {});
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

  Widget _crearCategoria() {
    return TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Categoria',
          labelText: 'Categoria',
          suffixIcon: Icon(Icons.accessibility),
          icon: Icon(Icons.account_circle)),
      onChanged: (valor) {
        setState(() {});
      },
    );
  }

  Widget _crearConcepto() {
    return TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Concepto',
          labelText: 'Concepto',
          suffixIcon: Icon(Icons.accessibility),
          icon: Icon(Icons.account_circle)),
      onChanged: (valor) {
        setState(() {});
      },
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdownMes() {
    List<DropdownMenuItem<String>> listames = new List();

    _mes.forEach((meses) {
      listames.add(DropdownMenuItem(
        child: Text(meses),
        value: meses,
      ));
    });

    return listames;
  }

  List<DropdownMenuItem<String>> getOpcionesDropdownAno() {
    List<DropdownMenuItem<String>> listaano = new List();

    _ano.forEach((anos) {
      listaano.add(DropdownMenuItem(
        child: Text(anos),
        value: anos,
      ));
    });

    return listaano;
  }

  Widget _crearDropdownMes() {
    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButton(
            value: _opcionMes,
            items: getOpcionesDropdownMes(),
            onChanged: (opt) {
              setState(() {
                _opcionMes = opt;
              });
            },
          ),
        )
      ],
    );
  }

  Widget _crearDropdownAno() {
    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButton(
            value: _opcionAno,
            items: getOpcionesDropdownAno(),
            onChanged: (opt) {
              setState(() {
                _opcionAno = opt;
              });
            },
          ),
        )
      ],
    );
  }
}
