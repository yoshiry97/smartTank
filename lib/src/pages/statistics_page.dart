import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../http/httpservice.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  late double _litros = 10.0;
  // Variable para almacenar los litros obtenidos de la API
  var service = HttpService();
  late List accessToken;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    print("InitState: Inicio de initState");
    _fetchLitrosData(); // Llamar a la función para obtener los datos de litros al inicio
  }

  Future<void> _fetchLitrosData() async {
    try {
      dynamic response = await service.getThings();
      service.getThingsV2().then(
        (value) {
          setState(() {
            accessToken = value;
          });
          value.forEach((element) {
            if (element.name == 'litros') {
              
            }
          });
        },
      );
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
                  UsageData('Lunes', 35),
                  UsageData('Martes', 28),
                  UsageData('Miércoles', 34),
                  UsageData('Jueves', 32),
                  UsageData('Viernes', 40),
                   UsageData('Sábado', 32),
                  UsageData('Domingo', 40),
                ],
                xValueMapper: (UsageData uso, _) => uso.day,
                yValueMapper: (UsageData uso, _) =>
                    uso.litros, // Corregido aquí
                // Enable data label
                dataLabelSettings: DataLabelSettings(isVisible: true),
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
