

import 'package:products/service/all_package.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int onTapIndex = 0;
  String category = "electronics";
  List<String> list = [];
  @override
  void initState() {
    super.initState();
    cartRepository.allData(category: category);
    fetchCategory();
  }
  void fetchCategory()async{
    list = await repozitory.fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Home page",style: TextStyle(fontSize: 25.sp,),),
        actions: const [
          CustomBadgeView(),
         SizedBox(width: 10,),
        ],
      ),
      body: BlocBuilder<CartRepository,CartAllDataState>(
        builder: (context, state) {
          if(state is GetAllProductState){
            return  CustomScrollView(
              slivers: [
                 SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SafeArea(
                        child: SizedBox(
                          height: 250.sp,
                          child: Image.asset(
                           "assets/icons/krosofku.jpeg",
                          ),
                        ),
                      ),
                       SizedBox(
                         height: 60.h,
                         child: ListView.builder(
                           scrollDirection: Axis.horizontal,
                           padding: EdgeInsets.only(left: 15.w, top: 5.h,bottom: 10.h),
                           itemCount: list.length,
                           itemBuilder: (context, i) {
                             return GestureDetector(
                               onTap: () {
                                 onTapIndex = i;
                                 category = list[i];
                                 cartRepository.allData(category: category);
                               },
                               child: Container(
                                 margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                                  padding:  EdgeInsets.symmetric(horizontal: 10.sp,vertical: 10.h),
                                 alignment: Alignment.center,
                                 decoration: BoxDecoration(
                                   color: onTapIndex == i
                                       ? KTColors.orange
                                       : KTColors.grey243,
                                   borderRadius:
                                   const BorderRadius.all(Radius.circular(15)),
                                 ),
                                 child: Text(list[i],style:  TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w700),),
                               ),
                             );
                           },
                         ),
                       ),
                    ],
                  )
                ),
                 SliverGrid(
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2,
                     mainAxisSpacing: 5,
                     childAspectRatio: 3 / 4,
                   ),
                   delegate: SliverChildBuilderDelegate(
                     childCount: state.products.length,
                         (context, i) {
                       final item = state.products[i];
                       return CustomSliverGridView(item:item);
                     },
                   ),
                 ),
              ],
            );
          }
          else if(state is CartLoading || state is CartInitial){
            return const LoadingPage();
          }
           else{
            return const Center(child: Text("No Data",style: TextStyle(fontSize: 30),),);
          }
        },
      ),
    );
  }
}

