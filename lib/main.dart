import 'package:products/app/app.dart';
import 'package:products/src/service_locator.dart';
import 'package:products/service/all_package.dart';

final cartController = CartController();
final cartRepository =  CartRepository();
final orderRepository =  OrderCubit();
final localCubit = LocalCubit();
final uploadCubit = UploadCubit();
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  /// #http service
  serviceLocator();
  /// #local service
  await serviceLocatorLocal();
  runApp(const App());
}