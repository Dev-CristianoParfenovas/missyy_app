import 'package:flutter/material.dart';
import 'package:missyy/presentation/widgets/components/cart_tile.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/product.dart';
import '../../../domain/models/product_list.dart';

class CartGrid extends StatelessWidget {
  const CartGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts = provider.items;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(2),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: const CartTile(),
      ),
    );
  }
}
