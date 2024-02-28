import 'package:flutter/material.dart';
import 'package:missyy/_core/screen_colors.dart';
import 'package:missyy/presentation/widgets/components/cart_grid.dart';
//import '../../../domain/models/product.dart';
import '../../../utils/utils_services.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    /* double cartTotalPrice() {
    double total = 0;
    for (var item in appData.car) {
      total += item.totalPrice();
    }
    return total;
  }*/

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ScreenColors.corPadraoApp,
        centerTitle: true,
        title: const Text(
          'Carrinho',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 5,
          left: 5,
          right: 5,
        ),
        child: Stack(children: [
          Column(
            children: [
              const Expanded(
                child: CartGrid(),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 3,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                //TOTAL E PREÇO
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Total geral',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      utilsServices.priceToCurrency(50.5),
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.pink.shade300,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          disabledBackgroundColor:
                              ScreenColors.corPadraoApp.withAlpha(100),
                          backgroundColor: ScreenColors.corPadraoApp,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        label: const Text(
                          'Concluir pedido',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
