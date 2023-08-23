import 'package:flutter_test/flutter_test.dart';
import 'package:plantecomigo/view/profile.dart';

import 'package:plantecomigo/view/storage_page.dart';

void main() {

  //Esse teste deve falhar
  test('Testando se o nome do usuário está correto', () {
    
    final profile = ProfileScreen(id: 1,nome: 'Bruno');
    expect(profile.nome, 'Jonata');

  });


  test('Testando se o email do usuário está correto', () {
    final profile = ProfileScreen(id: 2, email: 'igorpassanois@gmail.com');

    expect(profile.email, 'igorpassanois@gmail.com');
  });


  test('Testando se a página de armazenamento carrega corretamente', () async {
    final storagePage = StoragePage(id: 1,load: true);

    expect(storagePage.load, true);
  });


}

