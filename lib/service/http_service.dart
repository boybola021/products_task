
import 'package:http/http.dart';
import 'package:products/service/all_package.dart';

abstract class Network{
  Future<String?>getMethod({String baseUrl = Api.baseUrl,String api = Api.apiGetSingleCategory,required String category});
  Future<String?>getSingleMethod({String baseUrl = Api.baseUrl,String api = Api.apiProduct});
  Future<String?>getCategory({String baseUrl = Api.baseUrl,String api = Api.apiCategory});
  Future<String?>getUserCart({String baseUrl = Api.baseUrl,String api = Api.apiAddCart});
  Future<String?>postMethod({String baseUrl = Api.baseUrl,String api = Api.apiAddCart,required Map<String,Object> data});
  Future<String?>postProducts({String baseUrl = Api.baseUrl,String api = Api.apiProduct,required Map<String,Object> data});
  }

class HttpNetwork extends Network {

  @override
  Future<String?> getMethod({String baseUrl = Api.baseUrl, String api = Api
      .apiGetSingleCategory, required String category}) async {
    try {
      Uri url = Uri.http(
          baseUrl, "$api/${category.isNotEmpty ? category : ""}");
      final response = await get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } catch (e) {
      debugPrint("Error: getMethod => $e");
      throw Exception("ERROR: getMethod => $e");
    }
    return null;
  }

  @override
  Future<String?> getCategory(
      {String baseUrl = Api.baseUrl, String api = Api.apiCategory}) async {
    try {
      Uri url = Uri.http(baseUrl, api);
      final response = await get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception("ERROR: $e");
    }
    return null;
  }

  @override
  Future<String?> postMethod(
      {String baseUrl = Api.baseUrl, String api = Api.apiAddCart, required Map<
          String,
          Object?> data}) async {
    try {
      Uri url = Uri.http(baseUrl, api);
      final response = await post(url, body: jsonEncode(data));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } catch (e) {
      debugPrint("Error: postMethod => $e");
      throw Exception("ERROR: postMethod => $e");
    }
    return null;
  }

  @override
  Future<String?> getUserCart(
      {String baseUrl = Api.baseUrl, String api = Api.apiAddCart}) async {
    try {
      Uri url = Uri.http(baseUrl, api);
      final response = await get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } catch (e) {
      debugPrint("Error: getUserCart => $e");
      throw Exception("ERROR: getUserCart => $e");
    }
    return null;
  }

  @override
  Future<String?> postProducts(
      {String baseUrl = Api.baseUrl, String api = Api.apiProduct, required Map<
          String,
          Object> data, Map<String, String> header = Api.headersMedia}) async {
    try {
      Uri url = Uri.http(baseUrl, api);
      final response = await post(url, body: jsonEncode(data));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } catch (e) {
      debugPrint("Error: postProducts => $e");
      throw Exception("ERROR: postProducts => $e");
    }
    return null;
  }

  @override
  Future<String?> getSingleMethod({String baseUrl = Api.baseUrl, String api = Api.apiProduct})async{
    try {
      Uri url = Uri.http(
          baseUrl, api);
      final response = await get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } catch (e) {
      debugPrint("Error getSingleMethod => : $e");
      throw Exception("ERROR getSingleMethod => : $e");
    }
    return null;
  }
}