// To parse this JSON data, do
//
//     final inventory = inventoryFromJson(jsonString);

import 'dart:convert';

Inventory inventoryFromJson(String str) => Inventory.fromJson(json.decode(str));

String inventoryToJson(Inventory data) => json.encode(data.toJson());

class Inventory {
  Inventory({
    this.inventory,
  });

  InventoryClass inventory;

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
    inventory: InventoryClass.fromJson(json["inventory"]),
  );

  Map<String, dynamic> toJson() => {
    "inventory": inventory.toJson(),
  };
}

class InventoryClass {
  InventoryClass({
    this.products,
    this.tools,
  });

  List<Product> products;
  List<Tool> tools;

  factory InventoryClass.fromJson(Map<String, dynamic> json) => InventoryClass(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    tools: List<Tool>.from(json["tools"].map((x) => Tool.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "tools": List<dynamic>.from(tools.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.id,
    this.image,
    this.name,
    this.reference,
    this.sheet,
    this.selected,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  int id;
  dynamic image;
  String name;
  String reference;
  String sheet;
  bool selected = false; // added for  preperation(checklist)
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  ProductPivot pivot;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    reference: json["reference"],
    sheet: json["sheet"],
    selected: false,
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: ProductPivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
    "reference": reference,
    "sheet": sheet,
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

class Tool {
  Tool({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.selected,
    this.pivot,
  });

  int id;
  String name;
  bool selected;
  DateTime createdAt;
  DateTime updatedAt;
  ToolPivot pivot;

  factory Tool.fromJson(Map<String, dynamic> json) => Tool(
    id: json["id"],
    name: json["name"],
    selected: false,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: ToolPivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pivot": pivot.toJson(),
  };
}

class ToolPivot {
  ToolPivot({
    this.kitId,
    this.toolId,
  });

  int kitId;
  int toolId;

  factory ToolPivot.fromJson(Map<String, dynamic> json) => ToolPivot(
    kitId: json["kit_id"],
    toolId: json["tool_id"],
  );

  Map<String, dynamic> toJson() => {
    "kit_id": kitId,
    "tool_id": toolId,
  };
}
