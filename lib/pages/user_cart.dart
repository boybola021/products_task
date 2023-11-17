import 'package:products/service/all_package.dart';

class UserCartPage extends StatefulWidget {
  const UserCartPage({super.key});

  @override
  State<UserCartPage> createState() => _UserCartPageState();
}

class _UserCartPageState extends State<UserCartPage> {
  @override
  void initState() {
    orderRepository.orderUserCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          debugPrint(state.runtimeType.toString());
          if (state is OrderGetUserCartState) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
              itemCount: state.orderModel.length,
              itemBuilder: (context, i) {
                final data = state.orderModel[i];
                return Card(
                  child: ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserCartDetail(orderModel: data,)));
                    },
                    leading: CircleAvatar(
                      backgroundColor:
                          Colors.primaries[i % Colors.primaries.length],

                      child: Text(
                        data.id.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                    title: Text(
                      "userId: ${data.userId}",
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
          } else if (state is OrderLoadingState || state is OrderInitialState) {
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

class UserCartDetail extends StatelessWidget {
  final OrderModel orderModel;

  const UserCartDetail({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "User Cart Detail",
          style: TextStyle(fontSize: 20.sp),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
                children: [
                  const TextSpan(
                    text: "userId:",
                  ),
                  TextSpan(
                    text: orderModel.userId.toString(),
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
                children: [
                  const TextSpan(
                    text: "date: ",
                  ),
                  TextSpan(
                    text: orderModel.date.toString().substring(0, 10),
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            for (var item in orderModel.products)
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                  children: [
                    const TextSpan(
                      text: "productId: ",
                    ),
                    TextSpan(
                      text: "${item.productId}\n",
                      style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                    const TextSpan(
                      text: "quantity: ",
                    ),
                    TextSpan(
                      text: "${item.quantity}\n",
                      style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
