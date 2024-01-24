import 'package:firebase_core/firebase_core.dart';
import 'package:missyy/_core/screen_colors.dart';
import 'package:missyy/domain/models/cart.dart';
import 'package:missyy/domain/models/product_list.dart';
import 'package:missyy/domain/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:missyy/presentation/pages/cart_page.dart';
import 'package:missyy/presentation/pages/loading_page.dart';
import 'package:missyy/presentation/pages/product_detail_page.dart';
import 'package:missyy/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // final UserManager userManager = UserManager();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => UserManager(),
        lazy: false,
      ),
      ChangeNotifierProvider(
        create: (_) => ProductList(),
      ),
      ChangeNotifierProvider(
        create: (_) => Cart(),
      ),
    ],
    child: MaterialApp(
      theme: ThemeData(
        //primarySwatch: Colors.pink,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: ScreenColors.corPadraoApp)
            .copyWith(secondary: ScreenColors.corPadraoApp),
      ),
      home: const LoadingPage(),
      routes: {
        AppRoutes.product_detail: (ctx) => const ProductDetailPage(),
        AppRoutes.cart: (ctx) => const CartPage(),
      },
      debugShowCheckedModeBanner: false,
    ),
  ));

  // FirebaseFirestore.instance.collection('teste').add({'teste': 'teste'});
}
