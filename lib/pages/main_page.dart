
import 'package:products/service/all_package.dart';

import 'history_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  final int? index;
  const MainPage({super.key,this.index});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  late final PageController controller;

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return const [
      BottomNavigationBarItem(
          icon: Icon(
            Icons.home_filled,
            size: 30,
          ),
          label: ""),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.shopping_bag,
          size: 30,
        ),
        label: "",
      ),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.history,
            size: 30,
          ),
          label: ""),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.admin_panel_settings_outlined,
          size: 30,
        ),
        label: "",
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: widget.index ?? currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedItemColor: const Color.fromRGBO(198, 124, 78, 1),
        unselectedItemColor: Colors.grey,
        currentIndex: widget.index ?? currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          currentIndex = index;
          controller.jumpToPage(currentIndex);
          setState(() {});
        },
        items: buildBottomNavBarItems(),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: const [
          HomePage(),
          ShopPage(),
          HistoryPage(),
          AdminPage(),
        ],
      ),
    );
  }
}
