import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../http/httpservice.dart';
import '../../models/things_properties.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  StatisticsPageState createState() => StatisticsPageState();
}

class StatisticsPageState extends State<StatisticsPage> {
  late TooltipBehavior _tooltipBehavior;
  var service = HttpService();
  late List accessToken;
  Map<String, double> litrosData = {
    'litrosLunes': 0,
    'litrosMartes': 0,
    'litrosMiercoles': 0,
    'litrosJueves': 0,
    'litrosViernes': 0,
    'litrosSabado': 0,
    'litrosDomingo': 0,
  };

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    print("InitState: Inicio de initState");
    _fetchLitrosData(); // Llamar a la función para obtener los datos de litros al inicio
  }

  Future<void> _fetchLitrosData() async {
    try {
      List<ThingsProperty> properties = await service.getThingsV2();

      properties.forEach((element) {
        if (litrosData.containsKey(element.name)) {
          if (element.lastValue is int) {
            litrosData[element.name] = (element.lastValue as int).toDouble();
          } else if (element.lastValue is double) {
            litrosData[element.name] = element.lastValue as double;
          }
        }
      });
      print("Litros Data: $litrosData");
      setState(() {}); // Actualizar la interfaz con los nuevos valores
    } catch (error) {
      print('Error fetching litros data: $error');
    }
  }

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
        child: Container(
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(text: 'Consumo de litros por día'),
            // Enable legend
            legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: _tooltipBehavior,
            series: <LineSeries<UsageData, String>>[
              LineSeries<UsageData, String>(
                dataSource: <UsageData>[
                  UsageData('Lunes', litrosData['litrosLunes']!),
                  UsageData('Martes', litrosData['litrosMartes']!),
                  UsageData('Miercoles', litrosData['litrosMiercoles']!),
                  UsageData('Jueves', litrosData['litrosJueves']!),
                  UsageData('Viernes', litrosData['litrosViernes']!),
                  UsageData('Sabado', litrosData['litrosSabado']!),
                  UsageData('Domingo', litrosData['litrosDomingo']!),
                ],
                xValueMapper: (UsageData uso, _) => uso.day,
                yValueMapper: (UsageData uso, _) => uso.litros,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UsageData {
  UsageData(this.day, this.litros);
  final String day;
  final double litros;
}
