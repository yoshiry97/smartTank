import 'package:flutter/material.dart';
import 'package:smarttank/src/elements/menu_elements.dart';
import '../utils/icono_string_util.dart';



class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
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
      body: _lista(),
    );
  }

  Widget _lista()  {
   
    //menuProvider.cargarData()
    return FutureBuilder(
      future: menuElements.cargarData(),
      initialData: const [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        print(snapshot.data);
        return ListView(
          children: _listaItems(snapshot.data!, context),
        );
      },
    );
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];
    for (var opt in data) {
      final widgetTemp = ListTile(
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: () {
          Navigator.pushNamed(context, opt['ruta']);
          //final route = MaterialPageRoute(builder: (context)=> AlertPage());
          //Navigator.push(context, route);
        },
      );
      opciones
        ..add(widgetTemp)
        ..add(const Divider());
    }
    return opciones;
  }
}
