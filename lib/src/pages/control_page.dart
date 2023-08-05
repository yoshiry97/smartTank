import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../apis/apis.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  //bool _switchCurrentValue = false;
  //bool _switchCurrentValue = true;
  bool _switchCurrentValue = false;
  late bool? _estadoSwitch;

  late List accessToken;
  var service = HttpService();

  @override
  void initState() {
    super.initState();
    service.getThings().then((value) {
      setState(() {
        accessToken = value;
        _estadoSwitch = value[2]['last_value'];
        _switchCurrentValue = _estadoSwitch ?? false; 
      });
      //bool _estadoSwitch = value[2]['last_value'];
      //_switchCurrentValue = _estadoSwitch;
      print(value[2]['last_value']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: AppBar(
              centerTitle: true,
              toolbarHeight: 250,
              title: Image.asset(
                'assets/SmartTank.png',
                //width: 100,
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
                      Color.fromARGB(255, 132, 168, 229)
                    ])),
              )),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: FlutterSwitch(
                activeText: 'Sistema Encendido',
                inactiveText: 'Sistema Apagado',
                value: _switchCurrentValue,
                toggleSize: 35.0,
                activeTextColor: Colors.black,
                activeColor: Color.fromARGB(255, 132, 168, 229),
                activeToggleColor: Color.fromARGB(255, 11, 38, 85),
                inactiveToggleColor: Color.fromARGB(255, 239, 241, 244),
                inactiveTextColor: Colors.white,
                inactiveColor: const Color.fromARGB(255, 11, 38, 85),
                valueFontSize: 16.0,
                width: 140,
                height: 50,
                borderRadius: 20.0,
                showOnOff: true,
                onToggle: (bool valueIn) {
                  setState(() {
                    _switchCurrentValue = valueIn;
                  });
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: const Text(
              "Capacidad actual del tinaco:",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(minimum: 0, maximum: 60, ranges: <GaugeRange>[
                GaugeRange(startValue: 0, endValue: 20, color: Colors.red),
                GaugeRange(startValue: 20, endValue: 40, color: Colors.orange),
                GaugeRange(startValue: 40, endValue: 60, color: Colors.green)
              ], pointers: const <GaugePointer>[
                NeedlePointer(value: 60)
              ], annotations: const <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Text('60 litros',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    angle: 90,
                    positionFactor: 0.5)
              ])
            ],
          )
        ],
      ),
    );
  }
}
