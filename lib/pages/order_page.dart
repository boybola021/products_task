
import 'package:products/service/all_package.dart';

import '../domain/model/product_model.dart';

class OrderPage extends StatelessWidget {
  final List<CartItem> item;
  const OrderPage({super.key, required this.item});

  Future<void> pushAlert(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
            return AlertDialog(
              alignment: Alignment.center,
              title:  Text("Attention",textAlign: TextAlign.center,style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.w700),),
              content:  Text("Your order has been received",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w600),),
              actions: [
                TextButton(
                  onPressed: () {
                    localCubit.createHistoryOrder(item: item);
                    cartController.allDeleteItems(item);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
                  },
                  child:  Text("Ok",style: TextStyle(fontSize: 20.sp),),
                ),
              ],
            );
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Order Page",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23.sp),),
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderGetState) {
            return SafeArea(
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
                          text: state.orderModel.userId.toString(),
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
                          text: state.orderModel.date.toString().substring(0,10),
                          style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  for(var item in state.orderModel.products)
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
                  SizedBox(height: 20.h,),
                  SizedBox(
                    height: 45.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size( MediaQuery.sizeOf(context).width, 45.h),
                        alignment: Alignment.center,
                        backgroundColor: KTColors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40.r)),
                        ),
                      ),
                      onPressed: () => pushAlert(context),
                      child: Text("Next",style: TextStyle(fontSize: 23.sp,color: Colors.white),),
                    ),
                  ),
                ],
              ),
            );
          }
          else {
            return const LoadingPage();
          }
        },
      ),
    );
  }
}
