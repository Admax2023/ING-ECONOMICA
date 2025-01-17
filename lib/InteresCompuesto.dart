import 'dart:math';

import 'package:flutter/material.dart';

class InterestCalculatorPage extends StatefulWidget {
  InterestCalculatorPage({Key? key}) : super(key: key);

  @override
  _InterestCalculatorPageState createState() => _InterestCalculatorPageState();
}

class _InterestCalculatorPageState extends State<InterestCalculatorPage> {
  final TextEditingController _capitalController = TextEditingController();
  final TextEditingController _tasaController = TextEditingController();
  final TextEditingController _aniosController = TextEditingController();
  final TextEditingController _mesesController = TextEditingController();
  final TextEditingController _diasController = TextEditingController();
  final TextEditingController _montoCompuestoController =
      TextEditingController();
  final TextEditingController _montoCompuestoEspecificoController =
      TextEditingController();

  String selectedRateType = 'Diariamente';

  void _calcularMonto() {
    double capital = double.tryParse(_capitalController.text) ?? 0;
    double tasa = double.tryParse(_tasaController.text) ?? 0;
    int anios = int.tryParse(_aniosController.text) ?? 0;
    int meses = int.tryParse(_mesesController.text) ?? 0;
    int dias = int.tryParse(_diasController.text) ?? 0;
    int totalDias = (anios * 360) + (meses * 30) + dias;
    double monto = 0;

    if (_montoCompuestoEspecificoController.text.isNotEmpty) {
      monto = double.tryParse(_montoCompuestoEspecificoController.text) ?? 0;
      _montoCompuestoController.text = monto.toStringAsFixed(2);
    } else {
      if (selectedRateType == 'Diariamente') {
        monto = capital * pow(1 + ((tasa / 100) / 360), totalDias);
      }
      if (selectedRateType == 'Mensualmente') {
        monto = capital * pow(1 + ((tasa / 100) / 12), (totalDias / 30));
      }
      if (selectedRateType == 'Trimestralmente') {
        monto = capital * pow(1 + ((tasa / 100) / 4), (totalDias / 90));
      }
      if (selectedRateType == 'Cuatrimestralmente') {
        monto = capital * pow(1 + ((tasa / 100) / 3), (totalDias / 120));
      }
      if (selectedRateType == 'Semestralmente') {
        monto = capital * pow(1 + ((tasa / 100) / 2), (totalDias / 180));
      }
      if (selectedRateType == 'Anualmente') {
        monto = capital * pow(1 + (tasa / 100), (totalDias / 360));
      }
      _montoCompuestoController.text = monto.toStringAsFixed(2);
    }
    setState(() {}); // Agrega esta línea para actualizar la pantalla
  }

  String _calcularTiempo(double montoCompuesto) {
    double capital = double.tryParse(_capitalController.text) ?? 0;
    double tasa = double.tryParse(_tasaController.text) ?? 0;

    double tiempo = log(montoCompuesto / capital) / log(1 + (tasa / 100));

    String unidadTiempo = '';
    if (selectedRateType == 'Diariamente') {
      unidadTiempo = 'días';
    } else if (selectedRateType == 'Mensualmente') {
      unidadTiempo = 'meses';
    } else if (selectedRateType == 'Trimestralmente') {
      unidadTiempo = 'trimestres';
    } else if (selectedRateType == 'Cuatrimestralmente') {
      unidadTiempo = 'cuatrimestres';
    } else if (selectedRateType == 'Semestralmente') {
      unidadTiempo = 'semestres';
    } else if (selectedRateType == 'Anualmente') {
      unidadTiempo = 'años';
    }

    return tiempo.toStringAsFixed(2) + ' ' + unidadTiempo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Interés Compuesto'),
        backgroundColor: Color.fromARGB(116, 108, 175, 238),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(
                    16.0), // Padding interno dentro del cuadro
                decoration: BoxDecoration(
                  color: Color.fromARGB(
                      116, 108, 175, 238), // Color de fondo del cuadro
                  borderRadius: BorderRadius.circular(20), // Bordes ovalados
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),

                child: Text(
                    'El interés compuesto es un método financiero donde los intereses se calculan no solo sobre el capital inicial, sino también sobre los intereses acumulados. Con el tiempo, esto resulta en un crecimiento exponencial de la inversión. A medida que los intereses se reinvierten, el capital total aumenta, generando mayores ganancias en comparación con el interés simple.'),
              ),
              SizedBox(height: 20),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      "VF = VP (1+i) n ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      " N = Log MC - Log C / Log (1+i) ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      "VF: Valor Futuro ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      "VP: Valor Presente ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      "i: tasa de interes periodica vencida ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      "n: numero de periodos  ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      "N : Tiempo ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      "MC: Monto Compuesto ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      "C: Capital ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _capitalController,
                decoration: InputDecoration(
                  labelText: 'Capital',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero, // Bordes cuadrados
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius
                        .zero, // Bordes cuadrados cuando está enfocado
                    borderSide: BorderSide(
                      color: Colors.blue, // Color del borde al enfocarse
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _tasaController,
                decoration: InputDecoration(
                  labelText: 'Tasa (%)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero, // Bordes cuadrados
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius
                        .zero, // Bordes cuadrados cuando está enfocado
                    borderSide: BorderSide(
                      color: Colors.blue, // Color del borde al enfocarse
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _aniosController,
                decoration: InputDecoration(
                  labelText: 'Años',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero, // Bordes cuadrados
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius
                        .zero, // Bordes cuadrados cuando está enfocado
                    borderSide: BorderSide(
                      color: Colors.blue, // Color del borde al enfocarse
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _mesesController,
                decoration: InputDecoration(
                  labelText: 'Meses',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero, // Bordes cuadrados
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius
                        .zero, // Bordes cuadrados cuando está enfocado
                    borderSide: BorderSide(
                      color: Colors.blue, // Color del borde al enfocarse
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _diasController,
                decoration: InputDecoration(
                  labelText: 'Días',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero, // Bordes cuadrados
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius
                        .zero, // Bordes cuadrados cuando está enfocado
                    borderSide: BorderSide(
                      color: Colors.blue, // Color del borde al enfocarse
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              DropdownButton<String>(
                value: selectedRateType,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRateType = newValue!;
                  });
                },
                items: <String>[
                  'Diariamente',
                  'Mensualmente',
                  'Trimestralmente',
                  'Cuatrimestralmente',
                  'Semestralmente',
                  'Anualmente'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextField(
                controller: _montoCompuestoEspecificoController,
                decoration: InputDecoration(
                  labelText: 'Monto Compuesto Específico (Opcional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero, // Bordes cuadrados
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius
                        .zero, // Bordes cuadrados cuando está enfocado
                    borderSide: BorderSide(
                      color: Colors.blue, // Color del borde al enfocarse
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Color de fondo
                ),
                onPressed: () {
                  _calcularMonto();
                  if (_montoCompuestoEspecificoController.text.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Tiempo necesario'),
                          content: Text(
                              'Para alcanzar el monto compuesto, se necesitan ${_calcularTiempo(double.tryParse(_montoCompuestoController.text) ?? 0)}'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cerrar'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Calcular'),
              ),
              SizedBox(height: 20),
              Text('Monto Compuesto: ${_montoCompuestoController.text}'),
            ],
          ),
        ),
      ),
    );
  }
}
