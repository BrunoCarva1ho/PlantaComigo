// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plantecomigo/view/storage_page.dart';

import 'view/error_page.dart';
import 'view/loading_page.dart';
import 'controller/firebase_options.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //await Firebase.initializeApp(
  //  options: DefaultFirebaseOptions.currentPlatform,
  //);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _inicializacao = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Storage',
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.light,
      ),
      home: FutureBuilder(
        future: _inicializacao,
        builder: (context, app){
          if(app.connectionState == ConnectionState.done){
            return const StoragePage();
          }

          if(app.hasError) return const ErrorPage();

          return const LoadingPage();
        },
      )
    );
  }
}
