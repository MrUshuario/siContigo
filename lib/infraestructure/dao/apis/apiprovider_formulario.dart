import 'package:sicontigo/model/responseinciofinactividad.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:sicontigo/model/t_formulario.dart';
import 'dart:convert';
import 'package:sicontigo/utils/resources_apis.dart';

class apiprovider_formulario {


  final client = GetIt.I.get<Client>();

  final api_get_LoginForm = apisResources.REST_FORMLIST;


  //EJEMPLO 1 CON LISTAS
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







}