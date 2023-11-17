
import 'package:products/pages/order_page.dart';
import 'package:products/service/all_package.dart';


class ShopPage extends StatelessWidget {
  const ShopPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Order page",
          style: TextStyle(fontSize: 20.sp),
        ),
      ),
      body: BlocBuilder<CartController, CartState>(
        builder: (context, state) {
         if(state is CartLoadingState || state is CartInitialState){
           return const LoadingPage();
         }
         else if(state.item.isNotEmpty){
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.item.length,
                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                itemBuilder: (context, i) {
                  final data = state.item[i];
                  final items = data.products;
                  return CustomListTileShopPage(items: items,data: data,);
                },
              ),
              SizedBox(height: 20.h,),
              SizedBox(
                height: 45.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size( MediaQuery.sizeOf(context).width, 45.h),
                      alignment: Alignment.center,
                      backgroundColor: KTColors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.r)),
                      ),
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  OrderPage(item: state.item,)));
                      orderRepository.orderMethod(
                          orderModel: OrderModel(
                              id: 1,
                              userId: 4,
                              date: DateTime.now(),
                              products: state.item.map((e) => OrderProduct(productId: e.id ?? 1, quantity: e.quantity)).toList(),
                          )
                      );
                    },
                    child: Text("Buy Now",style: TextStyle(fontSize: 23.sp,color: Colors.white),),
                  ),
                ),
              ),
            ],
          );
         }else if(state is CartFailureState){
           return Center(
             child: Padding(
               padding:  EdgeInsets.symmetric(horizontal: 20.sp),
               child: Text(state.message,style: TextStyle(fontSize: 23.sp),),
             ),
           );
         }
         else{
           return Center(child: Text("Cart empty",style: TextStyle(fontSize: 25.sp),),);
         }
        },
      ),
    );
  }
}
