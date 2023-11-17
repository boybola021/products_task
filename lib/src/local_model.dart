import 'package:products/domain/model/product_model.dart';

class HistorySRC{
  List<CartItem> history;
  int id;
  HistorySRC({
    required this.history,
     required this.id,
});

  factory HistorySRC.fromJson(Map<String,Object?> json){
    return HistorySRC(
        id: json["id"] as int,
        history: (json["history"] as List).map((e) => CartItem.fromJson(e as Map<String,Object?>)).toList(),
    );
  }

  Map<String,Object?> toJson() => {
    "id": id,
    "history": history,
  };

   @override
  bool operator == (Object other){
     return (other is HistorySRC) && other.history == history && other.id == id;
   }
  @override
  int get hashCode => history.hashCode ^ id.hashCode;
}