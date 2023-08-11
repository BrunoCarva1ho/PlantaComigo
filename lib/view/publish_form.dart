// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'preview_page.dart';

class Publish extends StatefulWidget {
  Publish({super.key});

  @override
  _Publish createState() => _Publish();
}

class _Publish extends State<Publish> {
  File? arquivo;
  final picker = ImagePicker();

  showPreview(file) async {
    file = await Get.to(()=> PreviewPage(file: file));

    if(file!=null)
    {
      setState(()=> arquivo = file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dados da Publicação'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => Get.to(
                    () => CameraCamera(onFile: (file) => showPreview(file)),
                  ),
                  icon: Icon(Icons.camera_alt),
                  label: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Tirar uma foto'),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 0.0, textStyle: TextStyle(fontSize: 18)),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('ou'),
                ),
                OutlinedButton.icon(
                    onPressed: ()=>{}, icon: Icon(Icons.attach_file),
                    label: Text('Selecione na galeria'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
