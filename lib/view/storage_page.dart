// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantecomigo/view/profile.dart';
import '../model/db.dart';

//Instancia única da classe SQLUser
final instance = SQLUser.instance;


class StoragePage extends StatefulWidget {

  int id;
  bool? load;
  
  StoragePage({Key? key, required this.id, this.load}) : super(key:key);

  @override
  _StoragePageState createState() => _StoragePageState(id: id, load: load);
}


class _StoragePageState extends State<StoragePage> {
  bool uploading = false;
  double total = 0;
  List<Reference> refs = [];
  List<String> arquivos = [];
  bool loading = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImages();
  }

  loadImages() async {
    refs = (await storage.ref('images').listAll()).items;
    for (var ref in refs) {
      arquivos.add(await ref.getDownloadURL());
    }
    setState(() {
      loading = false;
    });
  }

  //Instancia do Firebase Storage
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<XFile?> getImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image =
        await _picker.pickImage(source: ImageSource.camera); //ou galeria
    return image;
  }


  List<Map<String, dynamic>> _dataUser = [];


  
  

  Future<String> _refreshData(int id) async {
    final data = await instance.getSingleData(id);
    _dataUser = data;
    String nome = _dataUser[0]['nome'];
    String contato = _dataUser[0]['contato'];
    
    return 'Usuário: $nome -      Contato(WhatsApp): $contato';
  }
  
  
  int id;
  bool? load;
  //Construtor
  _StoragePageState({required this.id, this.load});

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
    XFile? file = await getImage();
    if (file != null) {
      UploadTask task = await upload(file.path);

      task.snapshotEvents.listen((TaskSnapshot snapshot) async {
        if (snapshot.state == TaskState.running) {
          setState(() {
            uploading = true;
            total = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          });
        } else if (snapshot.state == TaskState.success) {
          arquivos.add(await snapshot.ref.getDownloadURL());
          refs.add(snapshot.ref);
          setState(() => uploading = false);
        }
      });
    }
  }

  deleteImage(int index) async {
    await storage.ref(refs[index].fullPath).delete();
    arquivos.removeAt(index);
    refs.removeAt(index);
    setState(() {});
  }

  //------------

  negociarPlanta(int index) async {
    await storage.ref(refs[index].fullPath);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: uploading
            ? Text('${total.round()}% enviado')
            : const Text('Planta Comigo'),
        actions: [
          uploading
              ? const Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Center(
                      child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    ),
                  )),
                )
              : IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: pickAndUploadImage,
                ),
            
            IconButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ProfileScreen(id: id)
                  ),
                );
              }, 
            icon: Icon(Icons.account_circle_rounded))

        ],
        elevation: 0,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(24),
              child: arquivos.isEmpty
                  ? const Center(
                      child: Text('Não há publicações ainda.'),
                    )
                  : ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        print(index);
                        print(arquivos.length);
                        if (index < arquivos.length) {
                          return ListTile(
                              title: SizedBox(
                                width: 500,
                                height: 350,
                                child: Image.network(
                                  arquivos[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(refs[index].fullPath),
                                    TextButton(
                                      child: Text('Negociar troca!'),
                                      onPressed: () => negociarPlanta(index),
                                    ),
                                  ])
                              );
                        }else{
                          return Column();
                        }
                      },
                      itemCount: arquivos.length,
                    )),
    );
  }
}
