import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sicontigo/utils/resources.dart';
import 'package:sicontigo/viewmodels/UI/menu_login.dart';
import 'infraestructure/dao/database/database.dart';

class SplashPage extends StatefulWidget {

  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => SplashPage());

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  late final _appDatabase;

  @override
  void initState() {
    super.initState();
    toHome();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: Container(
          width: 420,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Resources.splash),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
            ],
          )),
    ),

    );
  }

  void toHome() {



    Timer.periodic(Duration(seconds: 3), (time) async {
      _appDatabase = await GetIt.I.get<AppDatabase>();

      int? existeVersion = 0;
      //existeVersion = await _appDatabase.formDataModelDaoVersion.totalFormDataModels();
      //if(existeVersion! > 0){
        _showDialog();
      //} else {
      //  _showPermise();
      //}



      time.cancel();

    });
  }

  _showDialog() async {
    Navigator.pushAndRemoveUntil(context, login.route(), (route) => false);

  }




}