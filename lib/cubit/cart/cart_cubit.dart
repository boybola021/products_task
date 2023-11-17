import '../../domain/model/product_model.dart';
import 'package:products/service/all_package.dart';
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
      final cartItem = CartItem(id: product.id ?? 0, products: product);
      list.add(cartItem);
      emit(CartState(id: state.id, item: [...list]));
    }
  }
  void removeCartProduct({required Products product}){
    final isExist = state.item.any((element) => element.id == product.id);
   if(isExist){
     state.item.removeWhere((element) => element.id == product.id);
     emit(CartState(id: state.id, item: [...state.item]));
   }else{
     emit(CartFailureState(id: state.id, item: [], message:KTStrings.somethingError));
   }
  }

  void allDeleteItems(List<CartItem> items){
    state.item.clear();
  }

}

class CartRepository extends Cubit<CartAllDataState>{
  CartRepository(): super(CartInitial());

  void allData({required String category})async{
    emit(CartLoading());
   try{
     final data = await repozitory.fetchData(category: category);
     emit(GetAllProductState(products: [...data]));
   }catch(e){
     debugPrint("Error: $e");
   }
  }

  void singleProduct({required int id})async{
    emit(CartLoading());
   try{
     final data = await repozitory.fetchSingleData(id: id);
     debugPrint("CartRepository => $data");
     if(data != null) {
       emit(GetSingleProductState(products: data));
     }else{
       emit(const CartAllDataFailureState(message: KTStrings.checkData));
     }
   }catch(e){
     debugPrint("Error: $e");
     emit(const CartAllDataFailureState(message: KTStrings.somethingError));
   }
  }

  void allCategory()async{
    emit(CartLoading());
   try{
     final data = await repozitory.fetchCategory();
     emit(ProductCategoryState(list: [...data]));
   }catch(e){
     debugPrint("Error allCategory: $e");
   }
  }
}