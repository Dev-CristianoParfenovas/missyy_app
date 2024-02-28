import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:missyy/_core/screen_colors.dart';
import 'package:missyy/domain/models/user_manager.dart';
import 'package:missyy/presentation/pages/auth/login_screen.dart';
import 'package:missyy/presentation/widgets/components/product_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  favorite,
  all,
  logout,
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPage();
}

class _ProductsPage extends State<ProductsPage> {
  bool _showFavoriteOnly = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  UserManager userManager = UserManager();

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    User? user = _auth.currentUser;

    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ScreenColors.corPadraoApp,
        centerTitle: true,

        /*title: const Text(
          'Produtos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),*/

        actions: [
          /* const Text(
            'Produtos',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
            ),
          ),*/

          Padding(
            padding: const EdgeInsets.only(
              top: 15,
            ),
            child: Consumer<UserManager>(builder: (_, userManager, __) {
              return _user != null
                  ? Text(
                      'Olá, ${userManager.userLogin.name ?? ''}!',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Nenhum usuário logado');
            }),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            color: ScreenColors.fundoPrincipal,
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favorite,
                child: Text('Somente Favoritos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Todos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.logout,
                child: Text('Sair'),
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
                if (selectedValue == FilterOptions.logout) {
                  userManager.signOut();
                  Future.delayed(const Duration(seconds: 3), () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (ctx) {
                      return Login();
                    }));
                  });
                }
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              right: 15,
            ),
            child: GestureDetector(
              onTap: () {},
              child: Badge(
                badgeColor: Colors.red,
                badgeContent: const Text(
                  '1',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ProductGrid(_showFavoriteOnly),
      /* Consumer<UserManager>(builder: (_, userManager, __) {
        return Row(children: [
          userManager.isLoggedIn
              ? Text(
                  'Olá, ${userManager.userLogin?.name ?? ''}!',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                )
              : const Text('Nenhum usuário logado'),
        ]);
      }),*/
    );
  }
}   //ProductGrid(_showFavoriteOnly),
  //drawer: const AppDrawer(),

