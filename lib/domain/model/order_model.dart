

class OrderModel{
  final int id;
  final int userId;
  final DateTime date;
  List<OrderProduct> products;
  OrderModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
});
 factory OrderModel.fromJson(Map<String,Object?> json){
   return OrderModel(
       id: json["id"] as int,
       userId: json["userId"] as int,
       date: DateTime.parse(json["date"] as String),
       products: (json["products"] as List).map((e) => OrderProduct.fromJson(e as Map<String,Object?>)).toList()
   );
 }
 Map<String,Object> toJson() => {
   "userId": userId,
   "date" : DateTime.now().toIso8601String(),
   "products": products,
 };
}

class OrderProduct{
  final int productId;
  final int quantity;
  OrderProduct({required this.productId,required this.quantity});
  factory OrderProduct.fromJson(Map<String,Object?> json){
    return OrderProduct(
        productId: json["productId"] as int,
        quantity: json["quantity"] as int
    );
  }

  Map<String,Object> toJson() => {
    "productId" : productId,
        "quantity" : quantity,
  };
}