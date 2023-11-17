import 'package:products/domain/model/product_model.dart';
import '../../src/service_locator.dart';
import 'package:products/service/all_package.dart';
part 'local_state.dart';

class LocalCubit extends Cubit<LocalState> {
  LocalCubit() : super(LocalInitial());
  
  void getHistoryOrder()async{
    emit(LocalLoadingState());
    try{
      final data = localRepository.readHistory();
      final list = data.map((e) => e.history).toList();
      List<CartItem> response = [];
      for (List<CartItem> innerList in list) {
        for (CartItem cartItem in innerList) {
          response.add(cartItem);
        }
      }
      if(data != null){
        debugPrint("getHistoryOrder Parse => ${response.runtimeType}");
        emit(LocalOrderGetState(item: response));
      }else{
        emit(const LocalFailureState(message: KTStrings.checkData));
      }
    }catch(e){
      emit(const LocalFailureState(message: KTStrings.somethingError));
    }
  }

  void createHistoryOrder({required List<CartItem> item})async{
    emit(LocalLoadingState());
    bool response = await localRepository.storeHistory(item);
    debugPrint("Response: $response");
    try{
      if(response){
        debugPrint("Successfully history");
        emit(const LocalCreateState(message: KTStrings.successfullyHistory));
      }else{
        emit(const LocalFailureState(message: KTStrings.checkData));
      }
    }catch(e){
      debugPrint("Error createHistoryOrder => $e");
      emit(const LocalFailureState(message: KTStrings.somethingError));
    }
  }

   Future<bool> clearHistoryOrder()async{
    emit(LocalLoadingState());
    try{
      bool response = await localRepository.deleteProduct();
      if(response){
        emit(const LocalOrderCleanState());
        return true;
      }
    }catch(e){
      emit(const LocalFailureState(message: KTStrings.somethingError));
      return false;
    }
    return false;
  }

}
