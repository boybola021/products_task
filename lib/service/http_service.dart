
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import '../core/api.dart';

abstract class Network{
  Future<String?>getMethod({String baseUrl = Api.baseUrl,String api = Api.apiProduct});
}

class HttpNetwork extends Network{

  @override
  Future<String?> getMethod({String baseUrl = Api.baseUrl, String api = Api.apiProduct}) async{
    try{
      Uri url = Uri.http(baseUrl,api);
      final response = await get(url);
      if(response.statusCode == 200 || response.statusCode == 201){
        return response.body;
      }
    }catch(e){
      debugPrint("Error: $e");
      throw Exception("ERROR: $e");
    }
    return null;
  }

}