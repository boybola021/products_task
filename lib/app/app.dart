
import 'package:products/service/all_package.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartController>(create: (context)=> cartController),
        BlocProvider<CartRepository>(create: (context)=> cartRepository),
        BlocProvider<OrderCubit>(create: (context)=> orderRepository),
        BlocProvider<LocalCubit>(create: (context)=> localCubit),
        BlocProvider<UploadCubit>(create: (context)=> uploadCubit),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        child: const AdminPage(),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(useMaterial3: true),
            themeMode: ThemeMode.light,
            darkTheme: ThemeData.dark(useMaterial3: true),
            home: child,
          );
        },
      ),
    );
  }
}
