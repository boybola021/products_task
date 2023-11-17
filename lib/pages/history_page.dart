import 'package:flutter/cupertino.dart';
import 'package:products/service/all_package.dart';

class HistoryPage  extends StatefulWidget {
  const HistoryPage ({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  @override
  void initState() {
    super.initState();
    localCubit.getHistoryOrder();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("History page",style: TextStyle(fontSize: 25.sp,),),
        actions: [
         IconButton(
             onPressed: (){
               localCubit.clearHistoryOrder();
               KTScaffoldMessage.scaffoldMessage(context, KTStrings.successfullyClear,color: Colors.green);
             },
             icon:  Icon(CupertinoIcons.clear,size: 25.sp,),
         ),
          SizedBox(width: 10.sp,),
        ],
      ),
      body:  BlocBuilder<LocalCubit, LocalState>(
        builder: (context, state) {
          debugPrint(state.runtimeType.toString());
          if(state is LocalLoadingState || state is LocalInitial){
            return const LoadingPage();
          }
          else if(state is LocalOrderGetState){
            debugPrint("LocalOrderGetState History page => ${state.item}");
            return state.item.isNotEmpty? SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.item.length,
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    itemBuilder: (context, i) {
                      final data = state.item[i];
                      final items = data.products;
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
                          subtitle: Text(
                            "quantity: ${data.quantity}",
                            style: TextStyle(fontSize: 20.sp),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
                : Center(child: Text("Cart empty",style: TextStyle(fontSize: 25.sp),),);
          }else if(state is LocalFailureState){
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

