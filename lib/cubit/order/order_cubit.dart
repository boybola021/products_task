import 'package:meta/meta.dart';
import 'package:products/domain/model/order_model.dart';
import 'package:products/service/all_package.dart';
part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitialState());

  void orderMethod({required OrderModel orderModel})async{
    try{
      emit(OrderLoadingState());
      final data = await repozitory.postData(orderModel: orderModel);
      if(data != null){
        emit(OrderLoadingState());
        emit(OrderGetState(orderModel: orderModel));
      }else{
        emit(OrderFailureState(message: KTStrings.checkData));
      }
    }catch(e){
      debugPrint(e.toString());
      emit(OrderFailureState(message: KTStrings.somethingError));
    }
  }

  void orderUserCart()async{
    try{
      emit(OrderLoadingState());
      final data = await repozitory.fetchUserCart();
      if(data.isNotEmpty){
       emit(OrderGetUserCartState(orderModel: data));
      }else{
        emit(OrderFailureState(message: KTStrings.checkData));
      }
    }catch(e){
      debugPrint(e.toString());
      emit(OrderFailureState(message: KTStrings.somethingError));
    }
  }
}
