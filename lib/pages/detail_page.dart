

import 'package:products/service/all_package.dart';
import '../domain/model/product_model.dart';

class DetailPage extends StatefulWidget {
  final Products products;
  const DetailPage({super.key,required this.products});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage()));
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text("Detail",style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.w600),
        ),
      ),
      bottomSheet: StreamBuilder(
        stream: cartController.stream,
        builder: (context, snapshot) {
          return Container(
            height: 65.h,
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(20),right: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   IconButton(
                       onPressed: (){
                     if(count > 0){
                       count--;
                       cartController.addToCard(product: widget.products, quantity: -1);
                     }
                   }, icon: const Icon(Icons.remove,size: 25,)),
                   Text(count.toString(),style: const TextStyle(fontSize: 25,),),
                   IconButton(
                       onPressed: (){
                         count++;
                         cartController.addToCard(product: widget.products, quantity: 1);
                       },
                       icon: const Icon(Icons.add,size: 25,)),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    if(count > 0){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage()));
                    }
                  },
                  child: Container(
                    height: 45.h,
                    width: 150.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: KTColors.orange,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text("Buy Now",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),),
                  ),
                ),
              ],
            ),
          );
        }
      ),
      body: ListView(
        children: [
          Container(
            height: 200.h,
            margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 5,
                  blurRadius: 5,
                )
              ],
              image: DecorationImage(
                image: NetworkImage(widget.products.image),
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.products.title,style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color: Colors.black),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star,color: Colors.yellow,),
                        Text(" ${widget.products.rating.rate} (${widget.products.rating.count})",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w900,color: Colors.black87),),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset("assets/icons/detil_icon1.png",height: 40.h,width: 40.w,),
                        const SizedBox(width: 10,),
                        Image.asset("assets/icons/detil_icon2.png",height: 40.h,width: 40.w,),
                      ],
                    )
                  ],
                ),
               const SizedBox(height: 10,),
              Divider(
               color: Colors.grey.shade300,
              ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   const Text("Price",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900),),
                   Text("\$ ${widget.products.price}",style: const TextStyle(fontSize: 23,fontWeight: FontWeight.w900,color: KTColors.orange),),
                 ],
               ),
                const Text("Description",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900),),
                const SizedBox(height: 25,),
                Text(widget.products.description,style: TextStyle(fontSize: 20,color: Colors.grey.shade400,fontWeight: FontWeight.w600),),
              ],
            ),
          )
        ],
      ),
    );
  }
}

