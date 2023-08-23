// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/db.dart';

class PreviewPage extends StatelessWidget {
  File file;
  int id;
  
  PreviewPage({
    Key? key,
    required this.file,
    required this.id
  }) : super(key: key);

    //Instancia do Firebase Storage
  final FirebaseStorage storage = FirebaseStorage.instance;

  
  List<Map<String, dynamic>> _dataUser = [];

  Future<String> _refreshData(int id) async {
    final data = await SQLUser.getSingleData(id);
    _dataUser = data;
    String nome = _dataUser[0]['nome'];
    String contato = _dataUser[0]['contato'];
    
    return 'Usuário: $nome -      Contato(WhatsApp): $contato';
  }


  Future<UploadTask> upload(String path) async {
    File file = File(path);

    try {
      String nome = await _refreshData(id);
      String ref =  'images/img-   $nome-                 Data e hora da postagem: ${DateTime.now().toString()}.jpg';
      
      return storage.ref(ref).putFile(file);

    } on FirebaseException catch (e) {
      throw Exception("Erro no upload: ${e.code}");
    }
  }


  pickAndUploadImage() async {
    
    if (file != null) {
      UploadTask task = await upload(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              child: Stack(
            children: [
              Positioned.fill(
                child: Image.file(
                  file,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: EdgeInsets.all(32),
                          child: CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.black.withOpacity(0.5),
                              child: IconButton(
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () => Get.back(result: file),
                              )))),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: EdgeInsets.all(32),
                          child: CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.black.withOpacity(0.5),
                              child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () => Get.back(),
                              )))),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
