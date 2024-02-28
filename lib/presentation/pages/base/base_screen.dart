import 'package:flutter/material.dart';
import 'package:missyy/_core/screen_colors.dart';
import 'package:missyy/domain/models/page_manager.dart';
import 'package:missyy/presentation/widgets/components/commom/custom_drawer/custom_drawer.dart';
import 'package:provider/provider.dart';
import '../cart/cart_page.dart';
import '../products_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({super.key});

//  @override
  // State<BaseScreen> createState() => _BaseScreenState();
//}

//class _BaseScreenState extends State<BaseScreen> {
  int currentIndex = 0;
  final pageController = PageController();
  final Color corPadrao = ScreenColors.corPadraoApp;
//  UserManager userManager = UserManager();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: <Widget>[
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              backgroundColor: corPadrao,
              elevation: 0,
              toolbarHeight: 72,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
              ),
              centerTitle: true,
              title: const Text(
                'Missyy',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /*Text(
                    'Bem vindo acesse o menu acima!!',
                    style: TextStyle(fontSize: 16, color: Colors.pink.shade200),
                  ),*/
                  SizedBox(
                    height: 16,
                  ),
                  Image.asset(
                    "assets/logo.jpg",
                    height: 128,
                  ),
                  SizedBox(
                    height: 30,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      child: AnimatedTextKit(
                        pause: Duration.zero,
                        repeatForever: true,
                        animatedTexts: [
                          FadeAnimatedText(
                            'Seja bem vindo!!',
                            textAlign: TextAlign.center,
                          ),
                          FadeAnimatedText(
                            'Acesse nossa loja!!',
                            textAlign: TextAlign.center,
                          ),
                          FadeAnimatedText(
                            'no menu acima!!',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ProductsPage(),
          CartPage(),
        ],
      ),
    );

    /* bottomNavigationBar:
    //Consumer<UserManager>(builder: (_, userManager, __) {
      return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 700),
            curve: Curves.ease,
          );
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: ScreenColors.corPadraoApp,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withAlpha(180),
        items: [
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
          if (userManager.userLogin.admin == true)
            BottomNavigationBarItem(
              icon: Icon(Icons.production_quantity_limits),
              label: 'Produtos',
            ),
          if (userManager.userLogin.admin == false)
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Perfil',
            ),
        ],
      );*/
    //  });
    //);
    //);

    //);
    //}
  }

/*class NavigationState extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  UserManager? userManager;

  void updateIndex(int newIndex) {
    _selectedIndex = newIndex;
    // notifyListeners();
  }

  IconData get selectedIcon {
    if (_selectedIndex == userManager?.adminEnable) {
      return Icons.search;
    } else {
      return Icons.person_outline;
    }
  }
}*/

}
