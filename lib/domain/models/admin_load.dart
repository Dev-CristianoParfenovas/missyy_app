import 'package:flutter/material.dart';
import 'package:missyy/domain/models/user_manager.dart';

class AdminLoad with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  UserManager? userManager;

  void updateIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  IconData get selectedIcon {
    if (_selectedIndex == userManager?.adminEnable) {
      return Icons.search;
    } else {
      return Icons.person_outline;
    }
  }

  /*AdminLoad() {
    LoggedAdmin();
  }
}

class LoggedAdmin extends StatelessWidget {
  const LoggedAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    /*return Consumer<UserManager>(builder: (_, userManager, __) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
          return CadProducts();
        }));
      });*/

      /*if (userManager.adminEnable) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return CadProducts();
          }));
        });
      } else
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return Login();
          }));
        });*/
     // return Container();
    //});
  }*/
}
