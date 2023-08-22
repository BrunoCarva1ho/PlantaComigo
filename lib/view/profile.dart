

// ignore_for_file: library_private_types_in_public_api, unused_element

import 'package:flutter/material.dart';
import 'package:plantecomigo/model/db.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget{

  int id;

  ProfileScreen({required this.id});

  @override
  _ProfileScreen createState() => _ProfileScreen(id: id);

}


class _ProfileScreen extends State<ProfileScreen>{
  late String nome = "";
  late String contato = "";
  late String email = '';

  List<Map<String, dynamic>> _dataUser = [];
  
  void _getDataUser() async {
    final data = await SQLUser.getSingleData(id);
    setState(() {
       _dataUser = data;
    });
  }
  
  int id;

  _ProfileScreen({required this.id});


  @override
  Widget build(BuildContext context, ) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Minhas Informações'),
        actions: [
          IconButton(onPressed: (){
            _getDataUser();
            nome = _dataUser[0]['nome'];
            contato = _dataUser[0]['contato'];
            email = _dataUser[0]['email'];

          }, icon: Icon(Icons.update))
        ]),

        body: ListTile(
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                
                "Nome de Usuário: $nome \n"
                "Contato(WhatsApp): $contato \n"
                "E-mail: $email \n"
                'Identificador único: $id'
                
              ),
            ),
        )
    );
  }
}