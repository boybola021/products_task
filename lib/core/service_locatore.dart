
import 'package:products/domain/repozitory/product_repozitory.dart';
import 'package:products/service/http_service.dart';

late RepozitoryProduct repozitory;


void serviceLocator(){
  repozitory = RepozitoryProductImpl(network: HttpNetwork());
}