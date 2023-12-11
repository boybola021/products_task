import 'package:products/domain/model/user_model.dart';
import 'package:products/pages/user_detail_page.dart';
import 'package:products/service/all_package.dart';

class UserCartPage extends StatefulWidget {
  const UserCartPage({super.key});

  @override
  State<UserCartPage> createState() => _UserCartPageState();
}

class _UserCartPageState extends State<UserCartPage> {
  List<UserModel> userName = [];

  @override
  void initState() {
    orderRepository.orderUserCart();
    fetch();
    super.initState();
  }

  void fetch() async {
    userName = await repozitory.fetchUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderGetUserCartState && userName.isNotEmpty) {
            debugPrint("USER name: $userName");
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              itemCount: state.orderModel.length,
              itemBuilder: (context, i) {
                final data = state.orderModel[i];
                final name = userName.firstWhere((element) => element.id == data.userId);
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserCartDetail(
                                    orderModel: data,
                                    username: name.username,
                                  )));
                    },
                    leading: CircleAvatar(
                      backgroundColor:
                          Colors.primaries[i % Colors.primaries.length],
                      child: Text(
                        data.id.toString(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                    title: Text(
                      "username: ${name.username}",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    subtitle: Text(
                      data.date.toString().substring(0, 10),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                );
              },
            );
          } else if (state is OrderLoadingState || state is OrderInitialState || userName.isEmpty) {
            return const LoadingPage();
          } else {
            return Center(
              child: Text(
                KTStrings.checkData,
                style: TextStyle(fontSize: 30.sp),
              ),
            );
          }
        },
      ),
    );
  }
}

