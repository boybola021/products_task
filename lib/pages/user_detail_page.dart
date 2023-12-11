
import '../service/all_package.dart';

class UserCartDetail extends StatelessWidget {
  final OrderModel orderModel;
  final String username;

  const UserCartDetail(
      {super.key, required this.orderModel, required this.username});

  void init() async {
    cartRepository.allOrderProduct();
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "User Cart Detail",
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                  children: [
                    const TextSpan(
                      text: "username: ",
                    ),
                    TextSpan(
                      text: username,
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
              BlocBuilder<CartRepository, CartAllDataState>(
                builder: (context, state) {
                  debugPrint(state.runtimeType.toString());
                  if (state is GetAllOrderProductState) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: orderModel.products.length,
                      itemBuilder: (context, i) {
                        final id = orderModel.products[i];
                        final data = state.products
                            .where((e) => e.id == id.productId)
                            .toList();
                        final items = data.single;
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5.sp),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.r)),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  items.title.length < 10
                                      ? items.title
                                      : items.title
                                      .replaceRange(10, null, "..."),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "\$ ${items.price} ",
                                  style: const TextStyle(
                                    color: KTColors.orange,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            leading: Image.network(
                              height: 90.h,
                              width: 90.w,
                              items.image,
                              fit: BoxFit.contain,
                            ),
                            subtitle: Text(
                              "quantity: ${id.quantity}",
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.w700),
                            ),
                          ),
                        );
                      },
                    );
                  }else if(state is CartLoading || state is CartInitial){
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
            ],
          ),
        ),
      ),
    );
  }
}
