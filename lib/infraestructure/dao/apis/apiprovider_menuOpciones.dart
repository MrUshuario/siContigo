import 'package:shared_preferences/shared_preferences.dart';
import 'package:sicontigoVisita/model/responseinciofinactividad.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:sicontigoVisita/model/t_padron.dart';
import 'dart:convert';
import 'package:sicontigoVisita/utils/resources_apis.dart';

class apiprovider_menuOpciones {


  final client = GetIt.I.get<Client>();


  final api_post_Login = apisResources.REST_SICONTIGO_LOGIN;
  final api_post_padron = apisResources.REST_SICONTIGO_PADRON;




  Future<ReponseInicioFinActividades> post_LoginUsuarios(String nrDoc, String password) async {
    try {
      print("iniciando post_LoginUsuarios...");
      String url_login = api_post_Login;
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
      print("response login2...${response.body} AND \n ${bodyData}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        //TOKEN
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = data["token"];
        print(token);
        await prefs.setString('token', token);

        //DEVOLVER DATOS LOGIN
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

  Future<List<Padron>> post_DescargarUsuarios() async {
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? "ERROR";
      print("iniciando post_DescargarUsuarios...");
      String url_login = api_post_padron;
      Uri uri = Uri.parse(url_login);
      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      print("response login2...${response.body}");
        final Map<String, dynamic> data = jsonDecode(response.body);
        print("response genero ...${data['object']}");
        //DEVOLVER DATOS LOGIN
        return Padron.listFromJson(data['object']);

      } catch (e) {
      List<Padron> tipo = List.empty();
      return  tipo;
    }
  }






}