import 'package:flutter/cupertino.dart';
import 'package:products/service/all_package.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {

  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();
  final TextEditingController controllerPrice = TextEditingController();
  final ImagePicker picker = ImagePicker();
  String categoryText = "";
  File? file;
  bool isLoading = false;
  bool isValidName = true;
  bool isValidDesc = true;
  bool isValidPrice = true;

  void uploadData() async {
    String name = controllerName.text.trim();
    String desc = controllerDescription.text.trim();
    String price = controllerPrice.text.trim();
    String category = categoryText.trim();

    if ((!isValidPrice || !isValidName || !isValidDesc) && context.mounted) {
      KTScaffoldMessage.scaffoldMessage(context, KTStrings.checkYourField);
      return;
    }

    if (name.isEmpty ||
        desc.isEmpty ||
        price.isEmpty ||
        category.isEmpty ||
        file == null) {
      KTScaffoldMessage.scaffoldMessage(context, KTStrings.checkYourField);
      return;
    } else {
      setState(() => isLoading = true);
      final check = await uploadCubit.uploadProduct(
          uploadModel: UploadModel(
              title: controllerName.text.trim(),
              price: double.parse(controllerPrice.text.trim()),
              description: controllerDescription.text.trim(),
              image: file!.path,
              categoryString: categoryText.trim(),
          ),
      );
      debugPrint(check.runtimeType.toString());
      if (check != null && context.mounted) {
        controllerName.text = "";
        controllerDescription.text = "";
        controllerPrice.text = "";
        categoryText = "";
        file = null;
        setState(() {});
        KTScaffoldMessage.scaffoldMessage(context, KTStrings.successfullyUpload,
            color: Colors.green);
        Navigator.pushReplacement(context,
            CupertinoPageRoute(builder: (builder) => const AdminPage()));
      }
      setState(() => isLoading = false);
    }
  }

  void getImage() async {
    final xFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
    file = xFile != null ? File(xFile.path) : null;
    if (file != null && mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: uploadData,
            backgroundColor: KTColors.orange,
            child: const Icon(Icons.upload),
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            children: [
              GestureDetector(
                onTap: getImage,
                child: SizedBox(
                  height: 200.h,
                  child: file != null
                      ? SizedBox(
                    height: 180.h,
                    child: Image.file(file!),
                  )
                      : Icon(Icons.add,size: 50.sp,),
                ),
              ),

              SizedBox(
                height: 15.h,
              ),

              ///#product name
              CustomTextField(
                controller: controllerName,
                prefixIcon: KTIcons.rename,
                hintText: "Name",
                onChanged: (text) {
                  if (text.trim().isEmpty) {
                    isValidName = false;
                  } else {
                    isValidName = true;
                  }
                  setState(() {});
                },
                helperText:
                isValidName ? null : "The product's name can't be empty!!!",
                maxLine: 1,
              ),
              SizedBox(
                height: 15.h,
              ),

             SizedBox(
               height: 50.h,
               child: DecoratedBox(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10.r),
                   border: Border.all(color: Colors.grey),
                 ),
                 child: Center(
                   child: PopupMenuButton<Widget>(
                     itemBuilder: (context) {
                       return [
                         for (int i = 0; i < KTStrings.categoryList.length; i++)
                           PopupMenuItem(
                             child: Text(
                               KTStrings.categoryList[i],
                               style: const TextStyle(
                                 fontSize: 21,
                                 color: Colors.black
                               ),
                             ),
                             onTap: () {
                               categoryText = KTStrings.categoryList[i];
                               setState(() {});
                             },
                           ),
                       ];
                     },
                     child: Container(
                       height: 56.h,
                       clipBehavior: Clip.antiAlias,
                       padding: EdgeInsets.symmetric(horizontal: 5.w),
                       width: MediaQuery.sizeOf(context).width,
                       decoration: BoxDecoration(
                         border: Border.all(color: Colors.white30),
                         color: Colors.white10,
                         borderRadius: BorderRadius.all(Radius.circular(10.r)),
                       ),
                       child: Row(
                         children: [
                           KTIcons.category,
                           SizedBox(width: 5.w),
                           Text(
                             categoryText.isNotEmpty
                                 ? categoryText
                                 : KTStrings.category,
                             style:
                             TextStyle(fontSize: 20.sp, color: Colors.black),
                           ),
                         ],
                       ),
                     ),
                   ),
                 ),
               ),
             ),
              SizedBox(
                height: 15.h,
              ),
              /// description
              CustomTextField(
                controller: controllerDescription,
                prefixIcon: KTIcons.description,
                hintText: KTStrings.description,
                onChanged: (text) {
                  if (text.trim().isEmpty) {
                    isValidDesc = false;
                  } else {
                    isValidDesc = true;
                  }
                  setState(() {});
                },
                helperText: isValidDesc
                    ? null
                    : "The product's description can't be empty!!!",
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomTextField(
                keyboardType: TextInputType.number,
                controller: controllerPrice,
                prefixIcon: KTIcons.price,
                hintText: KTStrings.price,
                onChanged: (text) {
                  if (double.parse(text.trim()) == 0) {
                    isValidPrice = false;
                  } else {
                    isValidPrice = true;
                  }
                  setState(() {});
                },
                helperText: isValidPrice ? null : "The price can't be 0 !!!",
              ),
            ],
          ),
        ),
        if (isLoading) const LoadingPage(),
      ],
    );
  }
}