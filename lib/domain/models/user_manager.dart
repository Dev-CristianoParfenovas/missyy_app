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

  bool get isLoggedIn => user != null;
  bool _loading = false;
  bool get loading => _loading;
  UserLogin? userLogin;
  User? user;

  Future<void> signIn(
      {required UserLogin userlogin,
      Function? onFail,
      Function? onSuccess}) async {
    loading = true;
    try {
      final UserCredential authResult = await auth.signInWithEmailAndPassword(
          email: userlogin.email, password: userlogin.password);

      // await Future.delayed(const Duration(seconds: 2));

      //userlogin.id = authResult.user!.uid;

      await _loadCurrentUser(firebaseUser: authResult.user);
      //user = user;

      onSuccess!();
    } on FirebaseAuthException catch (e) {
      loading = false;
      onFail!(getErrorString(e.code));
      notifyListeners();
    }
    loading = false;
  }

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

  void signOut() {
    auth.signOut();
    user = null;
    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  //CARREGA USUÁRIO AO ENTRAR
  Future<void> _loadCurrentUser({User? firebaseUser}) async {
    final User currentUser = firebaseUser ?? auth.currentUser!;

    final DocumentSnapshot docUser =
        await firestore.collection('users').doc(currentUser.uid).get();

    //Aqui tenho o usuário
    userLogin = UserLogin.fromDocument(docUser);

    print(userLogin?.name);
    print(userLogin?.id);
    notifyListeners();
  }
}
