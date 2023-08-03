import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class _MenuElements {
  List<dynamic> opciones = [];
  _MenuElements() {
    //cargarData();
  }

  Future<List<dynamic>> cargarData() async {
    final resp = await rootBundle.loadString('data/menu_opts.json');
    opciones = json.decode(resp)['rutas'];
    return opciones;
  }
}

final menuElements = new _MenuElements();
