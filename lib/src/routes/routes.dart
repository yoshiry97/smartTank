import 'package:flutter/cupertino.dart';
import 'package:smarttank/src/pages/control_page.dart';
import '../pages/alert_page.dart';
import '../pages/home_page.dart';
import '../pages/statistics_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext) => HomePage(),
    'alert': (BuildContext) => AlertPage(),
    'statistics': (BuildContext) => StatisticsPage(),
    'control': (BuildContext) => ControlPage(),
  };
}
