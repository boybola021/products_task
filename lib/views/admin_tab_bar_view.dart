
import 'package:products/service/all_package.dart';

class TabBarButton extends StatelessWidget {
  final void Function()? onPressed;
  final int sellectedIndex;
  final int i;
  final String text;
  const TabBarButton({Key? key, this.onPressed, required this.sellectedIndex, required this.i, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Text(text,
            style:
            TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 19.sp),),
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 3,
            width: text.length * 9,
            color: (sellectedIndex == i)?
            Colors.red : Colors.transparent,
          )
        ],
      ),
    );
  }
}

