// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criando Transferência'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: <Widget>[
          Editor(controlador:  _controladorCampoNumeroConta, rotulo: 'Numero da conta',dica:  '0000'),
          Editor(controlador: _controladorCampoValor, rotulo: 'Valor', dica: '00.00', icone: Icons.monetization_on),
          ElevatedButton(
              onPressed: () {
                final int? numeroConta =
                    int.tryParse(_controladorCampoNumeroConta.text);
                final double? valor =
                    double.tryParse(_controladorCampoValor.text);
                if (numeroConta != null && valor != null) {
                  final transferenciaCriada = Transferencia(valor, numeroConta);
                  debugPrint('$transferenciaCriada');
                }
              },
              child: Text('Confirmar'))
        ],
      ),
    );
  }
}

class Editor extends StatelessWidget {

  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData? icone;

  Editor({required this.controlador, required this.rotulo, required this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 24.0),
        decoration:     
            InputDecoration(
               icon: icone != null ? Icon(icone) : null,
              labelText: rotulo, hintText: dica),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: <Widget>[
          ItemTransferencia(Transferencia(100.00, 1000)),
          ItemTransferencia(Transferencia(120.00, 1000)),
          ItemTransferencia(Transferencia(150.00, 1000)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: const Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencias{valor: $valor, numeroConta: $numeroConta}';
  }
}
