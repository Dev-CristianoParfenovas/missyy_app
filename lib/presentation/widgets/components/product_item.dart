import 'package:flutter/material.dart';
import 'package:missyy/utils/utils_services.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/product.dart';
import '../../../utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final UtilsServices utilsServices = UtilsServices();

    return Stack(
      children: [
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),

          child: Consumer<Product>(builder: (_, product, __) {
            return Container(
              height: 100,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: Image.asset(
                        product.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 1),
                          child: Text(
                            'A partir de',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Text(
                          utilsServices.priceToCurrency(product.price),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.pink.shade300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          //
          /*child: GridTile(
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              leading: Consumer<Product>(
                builder: (ctx, product, _) => IconButton(
                  onPressed: () {
                    product.toggleFavorite();
                  },
                  icon: Icon(
                      product.isFavorite ? Icons.favorite : Icons.favorite_border),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              title: Text(
                product.name,
                textAlign: TextAlign.center,
              ),
              trailing: IconButton(
                onPressed: () {
                  cart.addItem(product);
                },
                icon: const Icon(Icons.shopping_cart),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            child: GestureDetector(
              child: Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.product_detail,
                  arguments: product,
                );
              },
            ),
          ),*/
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.product_detail,
                arguments: product,
              );
            },
            child: const SizedBox(
              height: 145,
              width: 28,
              child: Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
