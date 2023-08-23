// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plantecomigo/view/login_screen.dart';
import 'view/error_page.dart';
import 'view/loading_page.dart';
import 'controller/firebase_options.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _inicializacao = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  MyApp({super.key});

  //Chamada da classe Singleton
  final themeStore = ThemeStore.instance;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planta Comigo',
      darkTheme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: FutureBuilder(
        future: _inicializacao,
        builder: (context, app){
          if(app.connectionState == ConnectionState.done){
            return LoginScreen();
          }

          if(app.hasError) return const ErrorPage();

          return const LoadingPage();
        },
      )
    );
  }
}


//Padrão de Projeto Singleton
class ThemeStore extends ChangeNotifier{
  static ThemeStore instance = ThemeStore();

  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  bool get isDartTheme => _themeMode == ThemeMode.dark;

  switchTheme(){
    _themeMode = isDartTheme ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}