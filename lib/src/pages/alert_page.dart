import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({super.key});

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
            padding: const EdgeInsets.all(20.0),
            child: const Center(
                child: Text("Presión de Agua",
                style: TextStyle(fontSize: 20.0)
                )
              ),
          ),
        ],
      ),
    );
  }
}
