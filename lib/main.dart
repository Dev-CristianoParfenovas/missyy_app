import 'package:firebase_core/firebase_core.dart';
import 'package:missyy/_core/screen_colors.dart';
import 'package:missyy/bkp_220224/products_page.dart';
import 'package:missyy/domain/models/cart.dart';
import 'package:missyy/domain/models/product_list.dart';
import 'package:missyy/domain/models/product_manager.dart';
import 'package:missyy/domain/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:missyy/presentation/pages/auth/cad_products_screen.dart';
import 'package:missyy/presentation/pages/auth/login_screen.dart';
import 'package:missyy/presentation/pages/base/base_screen.dart';
import 'package:missyy/presentation/pages/cart/cart_page.dart';
import 'package:missyy/presentation/pages/loading_page_screen.dart';
import 'package:missyy/presentation/pages/product_detail_page_screen.dart';
import 'package:missyy/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => UserManager(),
        lazy: false,
      ),
      ChangeNotifierProvider(
        create: (_) => ProductManager(),
        lazy: false,
      ),
      ChangeNotifierProvider(
        create: (_) => ProductList(),
        lazy: false,
      ),
      ChangeNotifierProvider(
        create: (_) => Cart(),
        lazy: false,
      ),
      /* ChangeNotifierProxyProvider(
        create: (_) => AdminUsersManager(),
        lazy: false,
        update: (_, userManager, adminUsersManager) =>
            adminUsersManager!..updateUser(userManager as UserManager),
      ),*/
    ],
    child: MaterialApp(
      theme: ThemeData(
        //primarySwatch: Colors.pink,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: ScreenColors.corPadraoApp)
            .copyWith(secondary: ScreenColors.corPadraoApp),
      ),
      home: LoadingPage(),
      routes: {
        AppRoutes.product_detail: (ctx) => const ProductDetailPage(),
        AppRoutes.cart: (ctx) => const CartPage(),
        AppRoutes.basescreen: (ctx) => BaseScreen(),
        AppRoutes.cad_product: (ctx) => CadProducts(),
        AppRoutes.product_screen: (ctx) => ProductsPage(),
        AppRoutes.login_screen: (ctx) => Login(),
      },
      debugShowCheckedModeBanner: false,
    ),
  ));

  // FirebaseFirestore.instance.collection('teste').add({'teste': 'teste'});
}
