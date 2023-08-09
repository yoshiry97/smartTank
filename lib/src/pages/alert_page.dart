import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  final bool _flujo = false; // Variable de estado para controlar el mensaje de alerta

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: AppBar(
            centerTitle: true,
            toolbarHeight: 250,
            title: Image.asset(
              'assets/SmartTank.png',
              height: 150,
              fit: BoxFit.fitHeight,
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color.fromARGB(255, 11, 38, 85),
                    Color.fromARGB(255, 132, 168, 229),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 5), // Separación entre AppBar y el botón
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                backgroundColor: Color.fromARGB(255, 17, 83, 197),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Consulta Presión de Agua',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => _mostrarAlert(context),
            ),
            const SizedBox(height: 15), // Separación entre el botón y la capacidad del tinaco
            const Text(
              'Litros disponibles',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 38, 73, 135)),
            ),
            const SizedBox(height: 10), // Separación entre la capacidad del tinaco y el LinearGauge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SfLinearGauge(
                minimum: 0,
                maximum: 60,
                orientation: LinearGaugeOrientation.vertical,
                axisTrackStyle: LinearAxisTrackStyle(
                  color: Colors.grey.shade300,
                  thickness: 15,
                ),
                barPointers: [
                  LinearBarPointer(
                    value: 30, // Cambia este valor para reflejar la capacidad actual del tinaco
                    color: Color.fromARGB(255, 115, 171, 216),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      
    );
  }

  void _mostrarAlert(BuildContext context) {
    String alertMessage = _flujo
        ? 'Tu tinaco tiene presión de agua'
        : 'En este momento tu tinaco no tiene presión de agua';

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Text('Presión del tinaco'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.water_drop_rounded),
              Text(alertMessage),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
