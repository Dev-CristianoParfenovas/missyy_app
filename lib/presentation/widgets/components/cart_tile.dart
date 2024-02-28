import 'package:flutter/material.dart';
import 'package:missyy/presentation/widgets/components/quantity_widget.dart';
import 'package:missyy/utils/utils_services.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/product.dart';

class CartTile extends StatefulWidget {
  const CartTile({
    Key? key,
  }) : super(key: key);

  @override
  _CartTileState createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final UtilsServices utilsServices = UtilsServices();
  //final CartItemModel cartItem;
  // final Product product; //Provider.of<Product>(context, listen: true);

  void removeItemFromCart(Product prodItem) {
    setState(() {
      prodItem.removeListener(() {
        prodItem.name;
      });
      utilsServices.showToast(
          message: '${prodItem.name} removido(a) do carrinho');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Consumer<Product>(builder: (_, product, __) {
        return Stack(
          children: [
            ListTile(
              //IMAGEM DO PRODUTO
              leading: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  height: 60,
                  width: 60,
                ),
              ),
              //NOME PRODUTO
              title: Text(
                product.name,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),

              //VALOR PRODUTO
              subtitle: Text(
                utilsServices.priceToCurrency(
                  product.totalPrice(),
                ),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.pink.shade300,
                ),
              ),
              //QUANTIDADE
              trailing:
                  //BOTÃO QUANTIDADE
                  GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                  ),
                  child: Column(
                    children: [
                      QuantityWidget(
                        //suffixText: product.unit,
                        value: product.quantity,

                        result: (quantity) {
                          setState(() {
                            product.quantity = quantity;
                            //removeItemFromCart(product);
                          });
                        },
                        isRemovable: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
