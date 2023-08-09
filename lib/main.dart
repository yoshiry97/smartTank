
import 'package:flutter/material.dart';
import 'src/pages/alert_page.dart';
import 'src/routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Componentes APP',
      debugShowCheckedModeBanner: false,
      //home: HomePage(),
      initialRoute: '/',
      routes: getApplicationRoutes(),
      onGenerateRoute: (RouteSettings settings) {
        print('Ruta llamada: ${settings.name}');

        return MaterialPageRoute(
            builder: (BuildContext context) => const AlertPage());
      },
    );
  }
}
