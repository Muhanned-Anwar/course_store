class Product {
  String id;
  String imagePath;
  String title;
  String price;
  String description;

  Product({
   this.id = '0',
   this.imagePath = '',
   this.title = '',
   this.price = '',
    this.description = '',
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['imagePath'] = imagePath;
    map['title'] = title;
    map['price'] = price;
    map['description'] = description;

    return map;
  }
}
