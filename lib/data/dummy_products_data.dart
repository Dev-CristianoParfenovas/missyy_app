import '../domain/models/product.dart';

final dummyProducts = [
  Product(
    id: '1',
    name: 'Anéis',
    description: 'Anéis de alta qualidade',
    price: 19.99,
    imageUrl: 'assets/aneis.jpg',
    images: [],
  ),
  Product(
      id: '1',
      name: 'Argola Fixa',
      description: 'Argola perfeita para utilizar em festas',
      price: 39.99,
      imageUrl: 'assets/argolafixa.jpg',
      images: []),
  Product(
      id: '1',
      name: 'Bracelete',
      description: 'Perfeito para o dia a dia',
      price: 53.99,
      imageUrl: 'assets/braceletecoracao.jpg',
      images: []),
  Product(
      id: '1',
      name: 'Bracelete Masc.',
      description: 'Perfeito para o dia a dia',
      price: 179.00,
      imageUrl: 'assets/braceletemasculino.jpg',
      images: []),
  Product(
      id: '1',
      name: 'Brinco Flor Azul',
      description: 'Lindo brinco azul para eventos',
      price: 89.00,
      imageUrl: 'assets/brincoflorazul.jpg',
      images: []),
];

/*List<CartItemModel> cartItems = [
  CartItemModel(
    item: ,
    quantity: 2,
  ),
  CartItemModel(
    item: mango,
    quantity: 1,
  ),
  CartItemModel(
    item: guava,
    quantity: 3,
  ),
];*/
