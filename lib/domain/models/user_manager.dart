import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:missyy/domain/models/user_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:missyy/helpers/firebase_errors.dart';

class UserManager with ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user;

  bool _loading = false;
  bool get loading => _loading;
  // UserLogin userLogin = UserLogin(name: '', email: '', password: '');

  UserLogin? userLogin;

  bool get isLoggedIn => userLogin != null;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  //LOGIN DO USUÁRIO
  Future<void> signIn(
      {required UserLogin userlogin,
      Function? onFail,
      Function? onSuccess}) async {
    loading = true;
    try {
      final UserCredential authResult = await auth.signInWithEmailAndPassword(
          email: userlogin.email, password: userlogin.password);

      // user = authResult.user;

      // await Future.delayed(const Duration(seconds: 2));

      //userlogin.id = authResult.user!.uid;

      await _loadCurrentUser(firebaseUser: authResult.user);

      //user = authResult.user;

      onSuccess!();
    } on FirebaseAuthException catch (e) {
      loading = false;
      onFail!(getErrorString(e.code));
      notifyListeners();
    }
    loading = false;
  }

  //CRIA USUÁRIO NO BCO FIREBASE
  Future<void> signUp(
      {required UserLogin userlogin,
      Function? onFail,
      Function? onSuccess}) async {
    loading = true;

    try {
      final UserCredential authResult =
          await auth.createUserWithEmailAndPassword(
              email: userlogin.email, password: userlogin.password);

      //user = authResult.user;
      userlogin.id = authResult.user?.uid;
      userLogin = userlogin;

      await userlogin.saveData();

      onSuccess!();
    } on FirebaseAuthException catch (e) {
      loading = false;
      onFail!(getErrorString(e.code));
      notifyListeners();
    }
    loading = false;
  }

  //DESLOGAR O USUÁRIO
  void signOut() {
    auth.signOut();
    userLogin = null;
    notifyListeners();
  }

  //CARREGA USUÁRIO AO ENTRAR
  Future<void> _loadCurrentUser({User? firebaseUser}) async {
    final User currentUser = firebaseUser ?? await auth.currentUser!;

    final DocumentSnapshot docUser =
        await firestore.collection('users').doc(currentUser.uid).get();
    userLogin = UserLogin.fromDocument(docUser);

    //user.saveToken();

    final docAdmin =
        await firestore.collection('admins').doc(userLogin?.id).get();
    if (docAdmin.exists) {
      userLogin?.admin = true;
    }

    notifyListeners();

    print(userLogin?.admin);

    print(userLogin?.name);
    print(userLogin?.id);
  }

  //Verifica se o admin está habilitado ou não
  bool get adminEnable => user != null && userLogin!.admin;
}
