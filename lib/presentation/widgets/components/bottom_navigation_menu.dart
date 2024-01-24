import 'package:flutter/material.dart';
import 'package:missyy/_core/screen_colors.dart';

class MenuBottomNavigation extends StatefulWidget {
  const MenuBottomNavigation({super.key});

  @override
  State<MenuBottomNavigation> createState() => _MenuBottomNavigationState();
}

class _MenuBottomNavigationState extends State<MenuBottomNavigation> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: ScreenColors.corPadraoApp,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withAlpha(180),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: 'Carrinho',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Pedidos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Perfil',
        ),
      ],
    );
  }
}
