import 'package:sicontigoVisita/model/responseinciofinactividad.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:sicontigoVisita/model/t_formulario.dart';
import 'package:sicontigoVisita/model/t_respuestaBACKUP.dart';
import 'dart:convert';
import 'package:sicontigoVisita/utils/resources_apis.dart';

import '../../../model/t_insertarEncuestaRSPTA.dart';
import '../../../model/t_respuesta.dart';

class apiprovider_formulario {


  final client = GetIt.I.get<Client>();

  final api_get_LoginForm = apisResources.REST_FORMLIST;

  final api_get_FormList = apisResources.REST_SICONTIGO_CONSULTA;
  final api_get_FormAnswerd= apisResources.REST_SICONTIGO_INSERTAR;

  //EJEMPLO 1 CON LISTAS
/*
  Future<List<Formulario>> get_FormularioLista() async {
    try {
      print("iniciando api_get_LoginForm...");
    String url_login = api_get_LoginForm;
    Uri uri = Uri.parse(url_login);
    final response = await client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    print("response api_get_LoginForm...${response.body}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Formulario.listFromJson(data['formulario']);
      } else {
        List<Formulario> ubi = List.empty();
        return  ubi;
      }
    } catch (e) {
      List<Formulario> ubi = List.empty();
      return  ubi;
    }
  }
*/

  //AUTOGENERADO YA NO SE USA
  Future<List<Formulario>> post_FormularioLista(String token) async {
    final Map<String, dynamic> bodyData = {'idFormato': apisResources.api_idFormato};
    try {
      print("iniciando api_get_LoginForm...");
      print(bodyData);
      String url_login = api_get_FormList;
      Uri uri = Uri.parse(url_login);
      final response = await client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(bodyData),
      );
      print("response api_get_LoginForm...${response.body}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Formulario.listFromJson(data['formulario']);
      } else {
        List<Formulario> ubi = List.empty();
        return  ubi;
      }
    } catch (e) {
      List<Formulario> ubi = List.empty();
      return  ubi;
    }
  }

  //ENVIAR RPTA
  Future<insertarEncuestaRSPTA> post_EnviarRspt(RespuestaENVIO resp, String token) async {
    try {
      print("iniciando api_get_FormAnswerd...");
      print(resp);
      String url_login = api_get_FormAnswerd;
      Uri uri = Uri.parse(url_login);
      String body = json.encode(resp.toMap());
      final response = await client.post(
        uri,
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      print("response api_get_FormAnswerd...${response.body}");
      if (response.statusCode == 200) {
        return insertarEncuestaRSPTA.fromJson(json.decode(response.body));
      } else {
        return insertarEncuestaRSPTA.fromJson(json.decode(response.body));
      }
    } catch (e) {
      throw Exception(e);
    }
  }










}