import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:missyy/_core/screen_colors.dart';
import 'package:missyy/domain/models/user_manager.dart';
import 'package:missyy/presentation/pages/base/base_screen.dart';

import 'auth/login_screen.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final Color corPadrao = ScreenColors.corPadraoApp;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  UserManager userManager = UserManager();

  @override
  void initState() {
    super.initState();

    _getUser();
    Future.delayed(const Duration(seconds: 3), () {
      //Get.offNamed(PagesRoutes.signInRoute);
    });
  }

  _getUser() async {
    setState(() {
      User? user = _auth.currentUser;
      _user = user;

      if (_user != null) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return BaseScreen();
          }));
        });
      }
      if (_user == null) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return Login();
          }));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corPadrao,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Carregando...',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
