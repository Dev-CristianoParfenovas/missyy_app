import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Product with ChangeNotifier {
  late String id;
  late String name;
  late String description;
  late double price;
  late String imageUrl;
  late bool isFavorite;
  late int quantity;
  late List<String> images;

  Product({
    this.quantity = 1,
    required this.images,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  }) {
    images = images;
  }

  Product.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document['images'] as List<dynamic>);
    deleted = (document['deleted'] ?? false) as bool;
    // sizes = (document['sizes'] as List<dynamic> ?? [])
    //   .map((s) => ItemSize.fromMap(s as Map<String, dynamic>))
    // .toList();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  late bool deleted;

  DocumentReference get firestoreRef => firestore.doc('products/$id');
  Reference get storageRef => storage.ref().child('products').child(id);

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  void delete() {
    firestoreRef.update({'deleted': true});
  }

  double totalPrice() => price * quantity;
}
