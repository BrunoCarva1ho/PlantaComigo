// ignore_for_file: library_private_types_in_public_api, unused_element, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:plantecomigo/model/db.dart';
import 'package:plantecomigo/view/storage_page.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  int id;
  String? email;
  String? nome;

  ProfileScreen({required this.id, this.nome, this.email});

  @override
  _ProfileScreen createState() => _ProfileScreen(id: id, nome: nome, email: email);
}


class _ProfileScreen extends State<ProfileScreen> {
  late String nomeText = "";
  late String contatoText = "";
  late String emailText = '';

  List<Map<String, dynamic>> _dataUser = [];

  

  void _getDataUser() async {
    final data = await instance.getSingleData(id);
    setState(() {
      _dataUser = data;
    });
    nomeText = _dataUser[0]['nome'];
    contatoText = _dataUser[0]['contato'];
    emailText = _dataUser[0]['email'];
  }

  @override
  void initState() {
    super.initState();
    _getDataUser();
  }

  int id;
  //Variável para o teste
  String? nome;
  String? email;

  _ProfileScreen({required this.id, this.nome, this.email});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Minhas Informações'),
        ),
        body: ListTile(
          
          titleTextStyle: TextStyle(
              fontSize: 20, color: Colors.black, fontFamily: nomeText,),
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text("Nome de Usuário: $nomeText \n"
                "Contato(WhatsApp): $contatoText \n"
                "E-mail: $emailText \n"
                'Identificador único: $id'),
          ),
        ));
  }
}
