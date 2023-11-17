import 'package:flutter/cupertino.dart';
import '../domain/model/product_model.dart';
import 'package:products/service/all_package.dart';

class CustomListTileShopPage extends StatelessWidget {
  final Products items;
  final CartItem data;
  const CustomListTileShopPage({super.key,required this.items,required this.data});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(vertical: 5.sp),
      alignment: Alignment.center,
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        border: Border.all(color: Colors.grey),
      ),
      child: ListTile(
        title: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text(
              items.title.length < 10
                  ? items.title
                  : items.title.replaceRange(
                  10, null, "..."),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "\$ ${data.total} ",
              style: const TextStyle(
                  color: KTColors.orange,
                  fontSize: 20),
            ),
          ],
        ),
        leading: Image.network(
          height: 90.h,
          width: 90.w,
          items.image,
          fit: BoxFit.contain,
        ),
        subtitle: SizedBox(
          width: 100.sp,
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 50.sp,
                    width: 120.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      const BorderRadius.all(
                          Radius.circular(10)),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            cartController
                                .addToCard(
                                product: items,
                                quantity: -1);
                          },
                          icon: const Icon(
                              Icons.remove),
                        ),
                        Text(
                          data.quantity.toString(),
                          style:  TextStyle(
                              fontSize: 20.sp),
                        ),
                        IconButton(
                          onPressed: () {
                            cartController
                                .addToCard(
                                product: items,
                                quantity: 1);
                          },
                          icon:
                          const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      cartController.removeCartProduct(product: items,);
                    },
                    icon: const Icon(
                        CupertinoIcons.delete),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
