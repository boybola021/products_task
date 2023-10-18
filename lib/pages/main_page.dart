
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products/pages/favourite.dart';
import 'package:products/pages/shop_page.dart';
import 'home_page.dart';
import 'notfication_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{

  int currentIndex = 0;

  late final PageController controller;


  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return const [
      BottomNavigationBarItem(
          icon: Icon(Icons.home_filled,size: 30,), label: ""),
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.heart,size: 30,), label: "",
          activeIcon: Icon(CupertinoIcons.heart_fill,size: 30,)
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_bag,size: 30,),
        label: "Cart",),
      BottomNavigationBarItem(
          icon: Icon(Icons.notifications_none,size: 30,), label: ""),
    ];
  }

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedItemColor: const Color.fromRGBO(198, 124, 78, 1),
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          currentIndex = index;
          controller.jumpToPage(currentIndex);
          setState(() {});
        },
        items: buildBottomNavBarItems(),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children:   const [
          HomePage(),
         Favourite(),
          ShopPage(),
          NotficationPage(),
        ],
      ),
    );
  }
}


