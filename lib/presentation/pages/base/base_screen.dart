import 'package:flutter/material.dart';
import 'package:missyy/_core/screen_colors.dart';

import '../cart/cart_page.dart';
import '../products_page.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int currentIndex = 0;
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          ProductsPage(),
          CartPage(),
          /*Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.orange,
          ),*/
          //  ProductsPage(),
          //CartPage(),
          //ProductDetailPage(),
          //ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 700),
              curve: Curves.ease,
            );
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
      ),
    );
  }
}
