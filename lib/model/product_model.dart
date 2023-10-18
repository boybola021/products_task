

import 'package:equatable/equatable.dart';

class Products{
 int id;
 String title;
 num price;
 String description;
 String category;
 String image;
  Rating rating;
 Products({
   required this.id,
   required this.title,
   required this.price,
   required this.description,
   required this.category,
   required this.image,
   required this.rating,
});

 factory Products.fromJson(Map<String,Object?> json) {
   return Products(
       id: json["id"] as int,
       title: json["title"] as String,
       price: json["price"] as num,
       description: json["description"] as String,
       category: json["category"] as String,
       image: json["image"] as String,
       rating : Rating.fromJson(json["rating"] as Map<String,Object?>),
   );
 }


 Map<String,Object> toJson() => {
        "id" : id,
       "title" : title,
       "price" : price,
       "description" : description,
       "category" : category,
       "image" : image,
       "rating" : rating.toJson(),
 };

 @override
  String toString() {
    return 'Products{id: $id, title: $title, price: $price, description: $description, category: $category, image: $image, rating: $rating}';
 }
}

 class Rating{
  num rate;
  int count;

  Rating({required this.rate,required this.count});

  factory Rating.fromJson(Map<String,Object?> json){
    return Rating(
        rate: json["rate"] as num,
        count: json["count"] as int
    );
  }
  Map<String,Object> toJson() => {
   "rate" : rate,
   "count" : count,
  };
}



class CartItem{
  final int id;
  int quantity;
  num total;
  final Products products;

  CartItem({
    required this.id,
    this.quantity = 1,
    required this.products,
}) : total = quantity * products.price;

  @override
  String toString() {
    return 'CartItem{id: $id, quantity: $quantity, total: $total, products: $products}';
  }
  CartItem copyWith({
    int? id,
    int? quantity,
    Products? products,
}) {
    return CartItem(
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        products: products ?? this.products,
    );
  }
}

class CartState extends Equatable{
  final int id;
  List<CartItem> item;
  double total;

  CartState({required this.id,required this.item}) : total = item.fold(0.0, (sum, element) => sum + element.total);

  CartState copyWith({int? id,List<CartItem>? item}){
   return CartState(id: id ?? this.id,item: item ?? this.item,);
 }
  @override
  String toString() {
    return "Cart{total: $total, items: $item}";
  }

  @override
  List<Object?> get props => [id,item,total];
}
