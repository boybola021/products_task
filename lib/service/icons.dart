
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

sealed class KTIcons{
  static final cartBadge =  Icon(
    Icons.shopping_cart_rounded,
    size: 20,
  );

  static Icon add = Icon(Icons.add,size: 50.sp,);
  static Icon rename = Icon(Icons.drive_file_rename_outline,size: 30.sp,);
  static Icon description = Icon(Icons.description,size: 30.sp,);
  static Icon price = Icon(Icons.price_change,size: 30.sp,);
  static Icon category = Icon(Icons.qr_code_rounded,size: 30.sp,);
  static final  Icon uploadFile = Icon(Icons.upload_file,size: 25.sp,);

}