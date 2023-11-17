
import 'package:products/service/all_package.dart';
import '../model/product_model.dart';

abstract class RepozitoryProduct{
  Future<List<Products>> fetchData({required String category});
  Future<Products> fetchSingleData({required int id});
  Future<String?> postData({required OrderModel orderModel});
  Future<String?> postProduct({required UploadModel uploadModel});
  Future<List<String>> fetchCategory();
  Future<List<OrderModel>> fetchUserCart();
}

class RepozitoryProductImpl implements RepozitoryProduct{
  final Network network;
  const RepozitoryProductImpl({required this.network});

  @override
  Future<List<Products>> fetchData({required String category}) async{
     String response = await network.getMethod(baseUrl: Api.baseUrl,api: Api.apiGetSingleCategory, category: category) ?? "[]";
     List list = jsonDecode(response);
     List<Products> product = list.map((e) => Products.fromJson(e)).toList();
  return product;
  }

  @override
  Future<List<String>> fetchCategory() async{
     String response = await network.getCategory(baseUrl: Api.baseUrl,api: Api.apiCategory) ?? "[]";
    List list = jsonDecode(response);
    List <String> data = list.map((e) => e as String).toList();
  return data;
  }

  @override
  Future<String?> postData({required OrderModel orderModel}) async{
    String response = await network.postMethod(baseUrl: Api.baseUrl,api: Api.apiAddCart, data: orderModel.toJson(),) ?? "[]";
    if(response.isNotEmpty){
      return "Successful upload";
    }else{
      return "Something error";
    }
  }

  @override
  Future<List<OrderModel>> fetchUserCart()async{
    String response = await network.getUserCart(baseUrl: Api.baseUrl,api: Api.apiAddCart) ?? "[]";
    List list = jsonDecode(response);
    List<OrderModel> carts = list.map((e) => OrderModel.fromJson(e as Map<String,Object?>)).toList();
    debugPrint(carts.toString());
    return carts;
  }

  @override
  Future<String?> postProduct({required UploadModel uploadModel})async{
    String response1 = await network.postMethod(baseUrl: Api.baseUrl,api: Api.apiProduct, data: uploadModel.toJson(),) ?? "[]";
    if(response1.isNotEmpty){
      return response1;//"Successful upload";
    }else{
      return "Something error";
    }
  }

  @override
  Future<Products> fetchSingleData({required int id}) async{
    String response = await network.getSingleMethod(baseUrl: Api.baseUrl,api: Api.apiProduct,) ?? "[]";
    List list = jsonDecode(response);
    List<Products> data = list.map((e) => Products.fromJson(e)).toList();
    Products product = data.last;
    return product;
  }
}