import 'package:products/domain/model/upload_model.dart';
import 'package:products/service/all_package.dart';
part 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit() : super(UploadInitialState());

  Future<String?> uploadProduct({required UploadModel uploadModel})async{
    try{
      emit(UploadLoadingState());
      String? check = await repozitory.postProduct(uploadModel: uploadModel);
      if(check != null){
        emit(UploadSuccessfulState(message: check));
        return check;
      }else{
        emit(const UploadFailureState(message: KTStrings.checkData));
        return null;
      }
    }catch(e){
      debugPrint("Error UploadCubit => $e");
       emit(const UploadFailureState(message: KTStrings.somethingError));
    }
    return null;
  }
}
