//import 'dart:html';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/things_properties.dart';

class HttpService {
  String baseUrl = "https://api2.arduino.cc/iot/v2";

  HttpService();

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final response =
        await http.get(Uri.parse('$baseUrl/$endpoint'), headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<dynamic> post(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Failed to make a post request: ${response.statusCode}');
    }
  }

  Future<String> getAccessToken() async {
    var dataToSend = <String, String>{};
    dataToSend.addAll({
      "grant_type": "client_credentials",
      "client_id": "lZDtTPLUGuVdngyI7blWEQ4W1ZXjPR0d",
      "client_secret":
          "V4dZwWfMIB2WtwqRlRKXR8RJWxNuUHZTGUw8K293IPMbvsE6xUJDUlY1h7wsOGeV",
      "audience": "https://api2.arduino.cc/iot"
    });
    final response = await http.post(
      Uri.parse(
          'https://api2.arduino.cc/iot/v1/clients/token'), // Reemplaza '/token' con el endpoint real para obtener el token.
      body: dataToSend,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      return result['access_token'];
    } else {
      throw Exception('Failed to get access token: ${response.statusCode}');
    }
  }

  Future<dynamic> getThings() async {
    var accessToken = await getAccessToken();
    final response = await get(
        'things/bc343efd-d578-418c-b510-b9967bbdaffa/properties',
        headers: {"authorization": "Bearer $accessToken"});

    //print(response[0]);
    var thing = jsonDecode(response);
    //print(thing);
    return thing;
  }

  Future<List<ThingsProperty>> getThingsV2() async {
    var accessToken = await getAccessToken();
    final response = await get(
        'things/bc343efd-d578-418c-b510-b9967bbdaffa/properties',
        headers: {"authorization": "Bearer $accessToken"});

    var propertiesJson = jsonDecode(response) as List<dynamic>;
    List<ThingsProperty> properties =
        propertiesJson.map((json) => ThingsProperty.fromJson(json)).toList();
    return properties;
  }

  Future<void> updateFlujo(bool newFlujo) async {
    var accessToken = await getAccessToken();
    final url = Uri.parse(
        'https://api2.arduino.cc/iot/v2/things/bc343efd-d578-418c-b510-b9967bbdaffa/properties/5a85dcbf-7c3d-44aa-a6b5-bac984aabb4d/publish');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer $accessToken', // Reemplaza con tu token de acceso
    };

    final body = jsonEncode({'value': newFlujo});

    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Flujo actualizado exitosamente');
    } else {
      print('Error al actualizar el flujo');
      print('Código de estado: ${response.statusCode}');
      print('Cuerpo de respuesta: ${response.body}');
    }
  }


}
