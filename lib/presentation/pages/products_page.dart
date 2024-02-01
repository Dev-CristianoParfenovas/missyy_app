import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:missyy/_core/screen_colors.dart';
import 'package:missyy/domain/models/user_manager.dart';
import 'package:missyy/presentation/pages/auth/login.dart';
import 'package:missyy/presentation/widgets/components/category_tile.dart';
import 'package:missyy/presentation/widgets/components/product_grid.dart';

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

  List<String> categories = [
    'Anéis',
    'Brincos',
    'Colares',
    'Bracelete fem.',
    'Bracelete masc.',
    'Correntes fem.',
    'Correntes masc.',
  ];

  String selectedCategory = 'Anéis';

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
        title: Text(
          'Produtos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white.withAlpha(190),
          ),
        ),
        actions: [
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
      body: Column(
        children: [
          //CAMPO DE PESQUISA
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                hintText: 'Pesquise aqui...',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: ScreenColors.corPadraoApp,
                  size: 21,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),
          //CATEGORIA
          Container(
            padding: const EdgeInsets.only(left: 25),
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return CategoryTile(
                  category: categories[index],
                  isSelected: categories[index] == selectedCategory,
                  onPressed: () {
                    setState(() {
                      selectedCategory = categories[index];
                    });
                  },
                );
              },
              separatorBuilder: (_, index) => const SizedBox(width: 10),
              itemCount: categories.length,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(),
              height: 500,
              child: ProductGrid(_showFavoriteOnly),
            ),
          ),
          // const MenuBottomNavigation(),
        ],
      ),
    );
    // ProductGrid(_showFavoriteOnly),
  }
} //ProductGrid(_showFavoriteOnly),
//drawer: const AppDrawer(),
