import 'package:products/service/all_package.dart';

late RepozitoryProduct repozitory;

void serviceLocator(){
  repozitory = RepozitoryProductImpl(network: HttpNetwork());
}