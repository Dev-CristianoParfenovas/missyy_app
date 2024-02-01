import 'package:flutter/material.dart';
import 'package:missyy/_core/screen_colors.dart';
import 'package:missyy/presentation/pages/base/base_screen.dart';
import 'auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final Color corPadrao = ScreenColors.corPadraoApp;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _getUser();
    Future.delayed(const Duration(seconds: 3), () {
      //Get.offNamed(PagesRoutes.signInRoute);
    });
  }

  Future<void> _getUser() async {
    User? user = _auth.currentUser;
    setState(() {
      _user = user;

      // Consumer<UserManager>(builder: (_, userManager, __) {
      if (_user != null) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return const BaseScreen();
          }));
        });
      } else {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return Login();
          }));
        });
      } //if
      // });
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
