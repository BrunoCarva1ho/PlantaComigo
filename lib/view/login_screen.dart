// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:plantecomigo/view/register_screen.dart';
import 'package:plantecomigo/view/storage_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen>{

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      body: Container(
        
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 0,
            ),
            child: Image.asset(
              "./assets/plantacomigo.png",
              height: 200,
            ),
          ),
          Form(
            child: Column(
              children: [
                TextField(
                  controller: _emailController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "E-mail",
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.white,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                TextField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.key_outlined,
                      color: Colors.white,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
            top: 10,
          )),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => RegisterScreen(),
              ));
            },
            child: Text("Não possui conta? Registrar..."),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
          ),
          ElevatedButton(
            child: Text("Entrar"),

            //AUTENTICAÇÃO DO LOGIN
            onPressed: () {
              if (_emailController.text == 'bruno' && _senhaController.text == '123') {
                _emailController.text = "";
                _senhaController.text = "";
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => StoragePage(),
                ));
              } else {
                _emailController.text = "";
                _senhaController.text = "";
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Color.fromARGB(255, 32, 139, 35),
                    content: Text("Login Inválido")));
              }
            },
          )
        ]),
      ),
    );

  
  }

}