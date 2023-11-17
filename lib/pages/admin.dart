
import 'package:products/service/all_package.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> with TickerProviderStateMixin{
  late PageController controller;
  int selectedIndex = 0;
  int lastPage = 0;
  @override
  void initState() {
    controller = PageController();
    super.initState();
  }
  void onTap(int i){
      selectedIndex = i;
      setState(() {});
      controller.jumpToPage(i);
  }
  void onPressed(int i){
    selectedIndex = i;
    setState(() {});
    controller.jumpToPage(selectedIndex);
  }
  List<String> tabBarText = [
    "Order",
    "Upload"
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Admin panel",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23.sp),),
        centerTitle: true,
        bottom:  PreferredSize(
          preferredSize: Size(MediaQuery.sizeOf(context).width,60),
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for(int i = 0;i < tabBarText.length;i++)
                  TabBarButton(
                    onPressed: () => onTap(i),
                    sellectedIndex: selectedIndex,
                    i: i,
                    text: tabBarText[i],
                  ),
              ],
            ),
          ),
        ),
      ),
      body:  PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          UserCartPage(),
          UploadPage(),
        ],
      ),
    );
  }
}


