import 'package:flutter/material.dart';
import 'package:missyy/domain/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartitem;
  const CartItemWidget({
    super.key,
    required this.cartitem,
  });

  @override
  Widget build(BuildContext context) {
    return Text(cartitem.name);
  }
}
