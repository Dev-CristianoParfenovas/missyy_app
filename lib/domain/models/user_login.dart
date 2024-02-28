import 'package:cloud_firestore/cloud_firestore.dart';

class UserLogin {
  UserLogin({
    required this.name,
    required this.email,
    required this.password,
  });

  //RECUPERA USUÁRIO ATRAVÉS DO DOCUMENTO
  UserLogin.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document.get('name') as String;
    email = document.get('email') as String;
  }

  String? id;
  String name = '';
  String email = '';
  String password = '';
  String? confirmPassword = '';
  bool admin = false;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  //GRAVA/SALVA NO BCO DE DADOS
  Future<void> saveData() async {
    await firestoreRef.set(toMap());
    //await FirebaseFirestore.instance.collection('users').doc(id).set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}
