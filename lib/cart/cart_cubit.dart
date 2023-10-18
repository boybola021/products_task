import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products/core/service_locatore.dart';
import '../model/product_model.dart';
part 'cart_state.dart';

class CartController extends Cubit<CartState>{
  CartController():super(CartState(id: 1, item: []));

  void addToCard({required Products product, required int quantity}) {
    final isExist = state.item.any((element) => element.id == product.id);
    final list = state.item;
    if(isExist) {
      final item = state.item.firstWhere((element) => element.id == product.id);
      if(quantity == 1) {
        item.quantity++;
        emit(CartState(id: state.id, item: [...list]));
      } else if(quantity == -1 && item.quantity > 0){
        item.quantity--;
        emit(CartState(id: state.id, item: [...list]));
      }

      item.total = item.quantity * item.products.price;
      if(item.quantity == 0) {
        list.remove(item);
        emit(CartState(id: state.id, item: [...list]));
      }
    } else if(quantity == 1) {
      final cartItem = CartItem(id: product.id, products: product);
      list.add(cartItem);
      emit(CartState(id: state.id, item: [...list]));
    }
  }
}

class CartRepozitory extends Cubit<CartAllDataState>{
  CartRepozitory(): super(const CartAllDataState(products: []));

  void allData()async{
    final data = await repozitory.fetchData();
    emit(CartAllDataState(products: [...data]));
  }
}