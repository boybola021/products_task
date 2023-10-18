part of 'cart_cubit.dart';


 class CartState extends Equatable {
  final int id;
  List<CartItem> item;
  double total;
   CartState({required this.id,required this.item}) : total = item.fold(0.0, (sum, element) => sum + element.total);
  CartState copyWith({int? id,List<CartItem>? item}){
    return CartState(id: id ?? this.id,item: item ?? this.item,);
  }

  @override
  List<Object?> get props => [id,item,total];
}

class CartAllDataState{
  final List <Products> products;
  const CartAllDataState({required this.products});
}
