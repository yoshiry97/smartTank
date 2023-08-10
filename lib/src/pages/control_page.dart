import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../http/httpservice.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  bool _switchCurrentValue = false;
  late List accessToken;
  //late bool? estadoSwitch;
  var service = HttpService();
  double volumen = 0.0;

  void _toggleFlujo(bool newValue) {
    setState(() {
      _switchCurrentValue = newValue;
    });
  }

  @override
  void initState() {
    super.initState();
    print("InitState: Inicio de initState");
    service.getThingsV2().then((value) {
      setState(() {
        accessToken = value;
      });

      value.forEach((element) {
        if (element.name == 'flujo') {
          _switchCurrentValue = (element.lastValue as bool);
          print("valor del switch " + _switchCurrentValue.toString());
        }
        if (element.name == 'volumen') {
          volumen = (element.lastValue as double);
          print("valor del volumen " + volumen.toString());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Build: Construyendo la interfaz de usuario");
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: FlutterSwitch(
                activeText: 'Sistema Encendido',
                inactiveText: 'Sistema Apagado',
                value: _switchCurrentValue,
                toggleSize: 35.0,
                activeTextColor: Colors.black,
                activeColor: const Color.fromARGB(255, 132, 168, 229),
                activeToggleColor: const Color.fromARGB(255, 11, 38, 85),
                inactiveToggleColor: const Color.fromARGB(255, 239, 241, 244),
                inactiveTextColor: Colors.white,
                inactiveColor: const Color.fromARGB(255, 11, 38, 85),
                valueFontSize: 16.0,
                width: 140,
                height: 50,
                borderRadius: 20.0,
                showOnOff: true,
                onToggle: (bool valueIn) async {
                  setState(() {
                    _switchCurrentValue = valueIn;
                  });
                  await service.updateFlujo(valueIn);
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: const Text(
              "Nivel de Agua en tu Smart Tank:",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 100,
                ranges: <GaugeRange>[
                  GaugeRange(startValue: 0, endValue: 33, color: Colors.red),
                  GaugeRange(
                      startValue: 33, endValue: 66, color: Colors.orange),
                  GaugeRange(
                      startValue: 66, endValue: 100, color: Colors.green),
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(value: volumen),
                ],
                annotations: const <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Text(
                      '%',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    angle: 90,
                    positionFactor: 0.5,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
