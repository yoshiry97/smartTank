import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';


class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  bool _switchCurrentValue = false;




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
      body: Center(
        child: FlutterSwitch(
          activeText: 'Sistema Encendido',
          inactiveText: 'Sistema Apagado',
          value: _switchCurrentValue,
          toggleSize: 42.0,
          activeTextColor: Colors.white,
          activeColor: Color.fromARGB(255, 15, 87, 230),
          activeToggleColor: Color.fromARGB(255, 249, 249, 249),
          inactiveToggleColor: Colors.black,
          inactiveTextColor: Colors.black,
          inactiveColor: const Color.fromARGB(255, 196, 193, 193),
          valueFontSize: 16.0,
          width: 140,
          height: 80,
          borderRadius: 30.0,
          showOnOff: true,
          onToggle: (bool valueIn) {
            setState(() {
              _switchCurrentValue = valueIn;
            });
            
          },
        ),
      ),
    );
  }
}
