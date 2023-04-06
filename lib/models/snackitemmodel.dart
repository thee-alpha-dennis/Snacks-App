class Item {
  final String name;
  final double price;
  final String image;

  Item({required this.name,required this.price, required this.image,});
  Map toJson() {
    return {
      'name': name,
      'price': price,
      'image': image,
    };
  }
  Map<String, dynamic> toMap() {
    return {
      'SnackItemName': name,
      'Price': price,
      'ImagePath': image,
    };
  }
}
