// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:plantecomigo/model/db.dart';
import 'package:plantecomigo/view/login_screen.dart';
import 'package:plantecomigo/view/storage_page.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {

   

  Future<void> _updateData(int id) async {
    await instance.createData(_nome_Controller.text, _email_Controller.text,
        _contato_Controller.text, _senha_Controller.text);
  }

  Future<void> _addData() async {
    await instance.createData(_nome_Controller.text, _senha_Controller.text,
        _email_Controller.text, _contato_Controller.text);
    
  }

  final TextEditingController _nome_Controller = TextEditingController();
  final TextEditingController _email_Controller = TextEditingController();
  final TextEditingController _contato_Controller = TextEditingController();
  final TextEditingController _senha_Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Área de Registro"),
        centerTitle: true,
      ),
      body: Form(
        child: Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 2),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _nome_Controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Nome",
                    ),
                    validator: (_nome_Controller) {
                      if (_nome_Controller == null || _nome_Controller == "") {
                        return 'Preencha este campo';
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _email_Controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "E-mail",
                    ),
                    validator: (_email_Controller) {
                      if (_email_Controller == null ||
                          _email_Controller == "") {
                        return 'Preencha este campo';
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _contato_Controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Contato(WhatsApp)",
                    ),
                    validator: (_contato_Controller) {
                      if (_contato_Controller == null ||
                          _contato_Controller == "") {
                        return 'Preencha este campo';
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _senha_Controller,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Senha",
                    ),
                    validator: (_senha_Controller) {
                      if (_senha_Controller == null ||
                          _senha_Controller == "") {
                        return 'Preencha este campo';
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: ElevatedButton(
                      child: Text("Registrar"),
                      onPressed: () async {
                        if (_nome_Controller.text != "" &&
                            _email_Controller.text != "" &&
                            _contato_Controller.text != "" &&
                            _senha_Controller != "") {
                          
                          await _addData();

                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                        
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Preencha todos os Campos!")));
                        }

                        _nome_Controller.text = "";
                        _email_Controller.text = "";
                        _contato_Controller.text = "";
                        _senha_Controller.text = "";

                        
                      },
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}