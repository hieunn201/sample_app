import 'dart:convert';

class ProductModel {
  ProductModel({
    this.id,
    this.name,
    this.price,
    this.beforeSalePrice,
    this.description,
    this.fullDescription,
    this.order,
    this.category,
    this.images,
    this.extras,
    this.extraItems,
    this.tags,
    this.availability,
  });

  final int id;
  final String name;
  final int price;
  final int beforeSalePrice;
  final String description;
  final String fullDescription;
  final int order;
  final Category category;
  final Images images;
  final List<Extra> extras;
  final List<ExtraItem> extraItems;
  final List<String> tags;
  final String availability;

  factory ProductModel.fromRawJson(String str) => ProductModel.fromJson(json.decode(str));

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    beforeSalePrice: json["before_sale_price"],
    description: json["description"],
    fullDescription: json["full_description"],
    order: json["order"],
    category: Category.fromJson(json["category"]),
    images: Images.fromJson(json["images"]),
    extras: List<Extra>.from(json["extras"].map((x) => Extra.fromJson(x))),
    extraItems: List<ExtraItem>.from(json["extra_items"].map((x) => ExtraItem.fromJson(x))),
    tags: List<String>.from(json["tags"].map((x) => x)),
    availability: json["availability"],
  );

  ProductModel copyWith({
    int id,
    String name,
    int price,
    int beforeSalePrice,
    String description,
    String fullDescription,
    int order,
    Category category,
    Images images,
    List<Extra> extras,
    List<ExtraItem> extraItems,
    List<String> tags,
    String availability,
  }) =>
      ProductModel(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        beforeSalePrice: beforeSalePrice ?? this.beforeSalePrice,
        description: description ?? this.description,
        fullDescription: fullDescription ?? this.fullDescription,
        order: order ?? this.order,
        category: category ?? this.category,
        images: images ?? this.images,
        extras: extras ?? this.extras,
        extraItems: extraItems ?? this.extraItems,
        tags: tags ?? this.tags,
        availability: availability ?? this.availability,
      );
}

class Category {
  Category({
    this.id,
    this.name,
  });

  final int id;
  final String name;

  factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
  );
}

class ExtraItem {
  ExtraItem({
    this.id,
    this.name,
    this.extraId,
    this.price,
  });

  final int id;
  final String name;
  final int extraId;
  final int price;

  factory ExtraItem.fromRawJson(String str) => ExtraItem.fromJson(json.decode(str));


  factory ExtraItem.fromJson(Map<String, dynamic> json) => ExtraItem(
    id: json["id"],
    name: json["name"],
    extraId: json["extra_id"],
    price: json["price"],
  );
}

class Extra {
  Extra({
    this.id,
    this.name,
    this.min,
    this.items,
    this.max,
  });

  final int id;
  final String name;
  final int min;
  final int max;
  List<ExtraItem> items = [];

  factory Extra.fromRawJson(String str) => Extra.fromJson(json.decode(str));

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
    id: json["id"],
    name: json["name"],
    min: json["min"],
    max: json["max"],
  );
}

class Images {
  Images({
    this.fullSize,
    this.thumbnail,
  });

  final String fullSize;
  final String thumbnail;

  factory Images.fromRawJson(String str) => Images.fromJson(json.decode(str));

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    fullSize: json["full_size"],
    thumbnail: json["thumbnail"],
  );
}
