// To parse this JSON data, do
//
//     final kit = kitFromJson(jsonString);

import 'dart:convert';

Kit kitFromJson(String str) => Kit.fromJson(json.decode(str));

String kitToJson(Kit data) => json.encode(data.toJson());

class Kits {
  Kits({
    this.kits,
  });

  List<Kit> kits;

  factory Kits.fromJson(Map<String, dynamic> json) => Kits(
    kits: List<Kit>.from(json["kits"].map((x) => Kit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "kits": List<dynamic>.from(kits.map((x) => x.toJson())),
  };
}

class Kit {
  Kit({
    this.id,
    this.categoryId,
    this.name,
    this.reference,
    this.sheet,
    this.price,
    this.size,
    this.weight,
    this.description,
    this.category,
    this.products,
    this.tools,
  });

  int id;
  int categoryId;
  String name;
  String reference;
  String sheet;
  String price;
  int size;
  int weight;
  String description;
  Category category;
  List<Product> products;
  List<Category> tools;

  factory Kit.fromJson(Map<String, dynamic> json) => Kit(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],
    reference: json["reference"],
    sheet: json["sheet"],
    price: json["price"],
    size: json["size"],
    weight: json["weight"],
    description: json["description"],
    category: json["category"] != null ?Category.fromJson(json["category"]): null,
    products: json["products"] != null ? List<Product>.from(json["products"].map((x) => Product.fromJson(x))): [],
    tools: json["tools"] != null ? List<Category>.from(json["tools"].map((x) => Category.fromJson(x))): [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
    "reference": reference,
    "sheet": sheet,
    "price": price,
    "size": size,
    "weight": weight,
    "description": description,
    "category": category.toJson(),
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "tools": List<dynamic>.from(tools.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.coefficient,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  int id;
  String name;
  int coefficient;
  DateTime createdAt;
  DateTime updatedAt;
  CategoryPivot pivot;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    coefficient: json["coefficient"] == null ? null : json["coefficient"],
    createdAt: json["created_at"] == null? null :DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null? null : DateTime.parse(json["updated_at"]),
    pivot: json["pivot"] == null ? null : CategoryPivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "score": coefficient == null ? null : coefficient,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pivot": pivot == null ? null : pivot.toJson(),
  };
}

class CategoryPivot {
  CategoryPivot({
    this.kitId,
    this.toolId,
  });

  int kitId;
  int toolId;

  factory CategoryPivot.fromJson(Map<String, dynamic> json) => CategoryPivot(
    kitId: json["kit_id"],
    toolId: json["tool_id"],
  );

  Map<String, dynamic> toJson() => {
    "kit_id": kitId,
    "tool_id": toolId,
  };
}

class Product {
  Product({
    this.id,
    this.name,
    this.reference,
    this.sheet,
    this.unitPrice,
    this.size,
    this.weight,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  int id;
  String name;
  String reference;
  String sheet;
  String unitPrice;
  int size;
  int weight;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  ProductPivot pivot;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    reference: json["reference"],
    sheet: json["sheet"],
    unitPrice: json["unit_price"],
    size: json["size"],
    weight: json["weight"],
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: ProductPivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "reference": reference,
    "sheet": sheet,
    "unit_price": unitPrice,
    "size": size,
    "weight": weight,
    "description": description,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pivot": pivot.toJson(),
  };
}

class ProductPivot {
  ProductPivot({
    this.kitId,
    this.productId,
  });

  int kitId;
  int productId;

  factory ProductPivot.fromJson(Map<String, dynamic> json) => ProductPivot(
    kitId: json["kit_id"],
    productId: json["product_id"],
  );

  Map<String, dynamic> toJson() => {
    "kit_id": kitId,
    "product_id": productId,
  };
}
