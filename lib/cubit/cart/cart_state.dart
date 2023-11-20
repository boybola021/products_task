part of 'cart_cubit.dart';


 class CartState extends Equatable {
   final int id;
  final List<CartItem> item;
  final double total;
   CartState({required this.id,required this.item}) : total = item.fold(0.0, (sum, element) => sum + element.total);
  CartState copyWith({int? id,List<CartItem>? item}){
    return CartState(id: id ?? this.id,item: item ?? this.item,);
  }

  @override
  List<Object?> get props => [id,item,total];
}


class CartInitialState extends CartState{
   CartInitialState({required super.id, required super.item});
}

class CartLoadingState extends CartState{
  CartLoadingState({required super.id, required super.item});
}
class CartFailureState extends CartState{
   final String message;
  CartFailureState({required super.id, required super.item,required this.message});
}


class CartAllDataState extends Equatable{
  const CartAllDataState();
  @override
  List<Object?> get props => [];
}

class ProductCategoryState extends CartAllDataState{
   final List<String> list;
   const ProductCategoryState({required this.list});
}

class GetAllProductState extends CartAllDataState{
   final List<Products> products;
   const GetAllProductState({required this.products});
}

class GetAllOrderProductState extends CartAllDataState{
   final List<Products> products;
   const GetAllOrderProductState({required this.products});
}

class GetSingleProductState extends CartAllDataState{
   final Products products;
   const GetSingleProductState({required this.products});
}

class CartInitial extends CartAllDataState{}

class CartLoading extends CartAllDataState{}

class CartAllDataFailureState extends CartAllDataState {
  final String message;
  const CartAllDataFailureState({required this.message});
}