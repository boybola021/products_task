import '../domain/model/product_model.dart';
import '../pages/detail_page.dart';
import 'package:products/service/all_package.dart';

class CustomSliverGridView extends StatelessWidget {
  final Products item;
  const CustomSliverGridView({super.key,required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
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
                    item.image,
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
      ),
    );
  }
}
