
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products/cart/cart_cubit.dart';
import 'package:products/main.dart';
import 'package:products/pages/detail_page.dart';



class ShopPage extends StatelessWidget {
  const ShopPage({
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order page",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          children: [
            SizedBox(
              height: 600,
              child: StreamBuilder<CartState>(
                  initialData: cartController.state,
                  stream: cartController.stream,
                  builder: (context, state) {
                    return state.hasData ?
                    ListView.builder(
                      itemCount: state.data?.item.length,
                      itemBuilder: (context, i) {
                        final data = state.data!.item[i];
                        final items = data.products;
                        return SizedBox(
                          height: 150,
                          child: ListTile(
                            title:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  items.title.length < 10
                                      ? items.title
                                      :items.title
                                      .replaceRange(10, null, "..."),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 20,),
                                ),
                                Text("\$ ${data.total} ",style: const TextStyle(color: KTColors.orange,fontSize: 20),),
                              ],
                            ),
                            leading: Transform.scale(
                              scale: 1.5,
                              child: Transform.translate(
                                offset: const Offset(0, -30),
                                child: Image.network(
                                  height: 90,
                                  width: 90,
                                  items.image,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            subtitle: SizedBox(
                              width: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey,),),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(onPressed: (){
                                              cartController.addToCard(product: items, quantity: -1);
                                            }, icon: const Icon(Icons.remove),),
                                            Text(
                                                data.quantity.toString(),style: const TextStyle(fontSize: 20),),
                                            IconButton(onPressed: (){
                                              cartController.addToCard(product: items, quantity: 1);
                                            }, icon: const Icon(Icons.add),),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: (){
                                          cartController.addToCard(product: items, quantity: -1);
                                        },
                                        icon: const Icon(CupertinoIcons.delete),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ): const Center(child: Text("No Data",style: TextStyle(fontSize: 20),),);
                  }
              ),
            ),

          ],
        ),
      ),
    );
  }
}