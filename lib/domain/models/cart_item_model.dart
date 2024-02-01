import 'package:missyy/domain/models/product.dart';

class CartItemModel {
  Product item;
  int quantity;

  CartItemModel({
    required this.item,
    required this.quantity,
  });

  double totalPrice() => item.price * quantity;
}
