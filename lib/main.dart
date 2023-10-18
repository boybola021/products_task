
import 'package:flutter/cupertino.dart';
import 'package:products/app/app.dart';
import 'package:products/cart/cart_cubit.dart';
import 'package:products/core/service_locatore.dart';

final cartController = CartController();
final cartRepozitory =  CartRepozitory();
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  serviceLocator();
  runApp(const App());
}