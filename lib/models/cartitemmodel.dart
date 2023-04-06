import 'package:flutter/material.dart';

class Cart {
  late final int? snackId;
  final String? snackName;
  final double? snackPrice;
  final ValueNotifier<int>? quantity;
  final String? imagepath;

  Cart(
      {
        required this.snackId,
        required this.snackName,
        required this.snackPrice,
        required this.quantity,
        required this.imagepath});

  Cart.fromMap(Map<dynamic, dynamic> data)
      : snackId = data['SnackItemId'],
        snackName = data['SnackItemName'],
        snackPrice = data['Price'],
        quantity = ValueNotifier(data['Quantity']),
        imagepath= data['ImagePath'];

 Map<String, dynamic> toMap() {
    return {
      'SnackItemId': snackId,
      'SnackItemName': snackName,
      'Price': snackPrice,
      'Quantity': quantity?.value,
      'ImagePath': imagepath,
    };
  }
}
