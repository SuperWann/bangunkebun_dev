class Product {
  final String name;
  final String price;
  final String imageAsset;
  final String description;
  final int stock;

  Product({
  required this.name,
  required this.price,
  required this.imageAsset,
  required this.description,
  this.stock =0
});

get id => null;
}