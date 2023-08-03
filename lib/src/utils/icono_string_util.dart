import 'package:flutter/material.dart';

final _icons = <String, IconData>{
  'power_settings_new': Icons.power_settings_new,
  'add_alert': Icons.add_alert,
  'bar_chart': Icons.bar_chart,
  'folder_open': Icons.folder_open,
};

Icon getIcon(String nombreIcono) {
  return Icon(_icons[nombreIcono], color: Colors.blue);
}
