class ProductsModel {
  String? message;
  String? type;
  List<Product> products = [];
  List<Product> plants = [];
  List<Product> seeds = [];
  List<Product> tools = [];
  ProductsModel();
  ProductsModel.fromjson(Map<String, dynamic>? json) {
    if (json != null) {
      message = json['message'];
      type = json['type'];
      if (json['data'] != null) {
        json['data'].forEach((e) {
          products.add(Product.fromjson(e));
          if (e['type'] == "PLANT") plants.add(Product.fromjson(e));
          if (e['type'] == "SEED") seeds.add(Product.fromjson(e));
          if (e['type'] == "TOOL") tools.add(Product.fromjson(e));
        });
      }
    }
  }
}

class Product {
  String? productId;
  String? name;
  String? description;
  String? imageUrl;
  String? type;
  int? price;
  bool? available;

  Product.fromjson(Map<String, dynamic>? json) {
    if (json != null) {
      productId = json['productId'];
      name = json['name'];
      description = json['description'];
      imageUrl = json['imageUrl'];
      type = json['type'];
      price = json['price'];
      available = json['available'];
    }
  }
}
