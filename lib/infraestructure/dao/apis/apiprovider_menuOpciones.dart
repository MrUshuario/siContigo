import 'package:sicontigo/model/responseinciofinactividad.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:sicontigo/utils/resources_apis.dart';

class apiprovider_menuOpciones {


  final client = GetIt.I.get<Client>();

  final api_post_LoginUsuarios = apisResources.REST_LOGIN;




  //LOGIN2
  Future<ReponseInicioFinActividades> post_LoginUsuarios(String nrDoc, String password) async {
    try {
      print("iniciando post_LoginUsuarios...");
    String url_login = api_post_LoginUsuarios;
      final Map<String, dynamic> bodyData = {
        "nroDoc": nrDoc,
        "password": password,
      };
    Uri uri = Uri.parse(url_login);
    final response = await client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(bodyData),
    );
    print("response login2...${response.body}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return ReponseInicioFinActividades.fromJson(data['loginUser']);
      } else {
        ReponseInicioFinActividades resp = ReponseInicioFinActividades();
        return  resp;
      }

    } catch (e) {
      ReponseInicioFinActividades resp = ReponseInicioFinActividades();
      return  resp;
    }
  }







}