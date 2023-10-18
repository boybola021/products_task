import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:products/core/service_locatore.dart';
import 'package:products/main.dart';
import 'package:products/pages/detail_page.dart';

import '../model/product_model.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int onTapIndex = 0;
  List<Products> list = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData()async{
    list = await repozitory.fetchData();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return   Scaffold(
      body: StreamBuilder(
        initialData: cartRepozitory.state,
        stream: cartRepozitory.stream,
        builder: (context, snapshot) {
          return  CustomScrollView(
           slivers: [
            SliverToBoxAdapter(
              child: SafeArea(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: height * 0.28.h,
                          color: Colors.black87,
                          padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                          child:  Column(
                            children: [
                               SizedBox(height: 15.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Location",style: TextStyle(fontSize: 18,color: Colors.white70),),
                                      Row(
                                        children: [
                                          Text("Blizen,Tanjungbale ",style: TextStyle(fontSize: 20,color: Colors.white70),),
                                          Icon(Icons.arrow_drop_down,size: 20,color: Colors.white,)
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 45.h,
                                    width: 45.w,
                                    decoration:  const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      image: DecorationImage(
                                        image: AssetImage("assets/userimage/Image 1.png"),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                               SizedBox(height: 20.h,),
                              TextField(
                                clipBehavior: Clip.antiAlias,
                                style: const TextStyle(fontSize: 18,color: Colors.white),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  focusColor: const Color.fromRGBO(198, 124, 78, 1),
                                  focusedBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(color: Color.fromRGBO(198, 124, 78, 1)),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.2),
                                  prefixIcon: const Icon(CupertinoIcons.search,color: Colors.white,),
                                  suffixIcon: Padding(
                                    padding:  EdgeInsets.only(right: 10.w),
                                    child: Image.asset(
                                        height: 42.h,
                                        width : 42.w,
                                        "assets/icons/textfild_icon.png"
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Transform.translate(
                          offset:  Offset(0.0,80.h),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                            height: 150.h,
                           width: double.infinity,
                           decoration: BoxDecoration(
                             color: Colors.white.withOpacity(0.2),
                             boxShadow: const [
                               BoxShadow(
                                 color: Colors.black12,
                                 spreadRadius: 3,
                                 blurRadius: 10,
                               )
                             ],
                             image: const DecorationImage(
                               fit: BoxFit.fill,
                               image: AssetImage("assets/icons/krosofka.jpg"),
                             ),
                             borderRadius: BorderRadius.all(Radius.circular(28.r)),
                           ),
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 35.h,
                                  width: 80.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(237, 81, 81, 1),
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  child:  const Text("Promo",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white),
                                  ),
                                ),
                                RichText(
                                    text: const TextSpan(
                                      style: TextStyle(fontWeight: FontWeight.w900,fontSize: 30,color: Colors.black87),
                                      children: [
                                        TextSpan(text: "Buy one get\none Free")
                                      ]
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 100.h,),
                    SizedBox(
                      height: 50.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 15.w, top: 5.h),
                        itemCount: 10,
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () {
                              onTapIndex = i;
                              setState(() {});
                            },
                            child: Container(
                              height: 40.h,
                              width: 100.w,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 5),
                              decoration: BoxDecoration(
                                color: onTapIndex == i
                                    ? const Color.fromRGBO(198, 124, 78, 1)
                                    : const Color.fromRGBO(243, 243, 243, 1),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Text("Item ${i + 1}"),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              ) ,
            ),
             SliverGrid(
               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                 crossAxisSpacing: 10,
                 mainAxisSpacing: 10,
                 childAspectRatio: 3 / 4,
               ),
               delegate: SliverChildBuilderDelegate(
                     childCount: list.length,
                     (context, i) {
                       final item =  list[i];
                      log("$item");
                   return Card(
                     clipBehavior: Clip.antiAlias,
                     surfaceTintColor: Colors.white,
                     elevation: 10,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20),
                     ),
                     child: Container(
                       padding: const EdgeInsets.all(15),
                       child: Column(
                         mainAxisSize: MainAxisSize.max,
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Expanded(
                             child: Center(
                               child: Image.network(
                                 item!.image,
                                 errorBuilder: (context,child,error){
                                   return const Center(child: Icon(Icons.no_photography));
                                 },
                               ),
                             ),
                           ),
                           Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             mainAxisSize: MainAxisSize.min,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children:  [
                               SizedBox(height: 15.h,),
                               Text(item.title,overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w800),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Rate",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,color: Colors.yellow,),
                                      Text(" ${item.rating.rate}",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w900,color: Colors.black87),),
                                    ],
                                  ),
                                ],
                              ),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text("\$ ${item.price}",style: const TextStyle(fontSize: 23,fontWeight: FontWeight.w900),),
                                  Container(
                                    height: 30.h,
                                    width: 35.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(198, 124, 78, 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: const EdgeInsets.only(top: 10),
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  DetailPage(products: item,)));
                                        setState(() {});
                                      },
                                      child: const Icon(Icons.add,color: Colors.white,),
                                    ),
                                  ),
                                 ],
                               )
                             ],
                           )
                         ],
                       ),
                     ),
                   );
                 },
               ),
             ),
           ],
        );
        }
      ),
    );
  }
}
