
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'dimension.dart';

SizedBox addHeight(double size) => SizedBox(height: size);
SizedBox addWidth(double size) => SizedBox(width: size);

String? validateMobile(String? value) {
  if (value!.length != 10) {
    return 'Enter Mobile Number & must be of 10 digit';
  } else {
    return null;
  }
}

String? validateName(String? name) {
  if (name!.isEmpty) {
    return 'Please Enter Name';
  } else {
    return null;
  }
}

String? validateAdhar(String? name) {
  if (name!.isEmpty) {
    return 'Please Enter Adhar Number';
  } else {
    return null;
  }
}

String? validatePan(String? name) {
  if (name!.isEmpty) {
    return 'Please Enter Pan Number';
  } else {
    return null;
  }
}

String? validateMoney(String? money) {
  if (money!.isEmpty) {
    return 'Please add money';
  } else {
    return null;
  }
}

// showToast(message) {
//   Fluttertoast.cancel();
//   Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.CENTER,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Color(0xff4DBA4D),
//       textColor: Colors.white,
//       fontSize: 16.0);
// }

// addCartSection() {
//   final myCartController = Get.put(MyCartDataListController());
//   final controller = Get.put(MainHomeController());
//   return BottomAppBar(
//       elevation: 0,
//       color: Colors.transparent,
//       child: Obx(() {
//         return myCartController.isDataLoaded.value
//             ? Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ElevatedButton(
//                 onPressed: () {
//                   Get.back();
//                   Get.back();
//                   Get.back();
//                   Get.back();
//                   Get.back();
//                   Get.back();
//                   controller.onItemTap(1);
//                 },
//                 style: ElevatedButton.styleFrom(
//                     minimumSize:
//                     Size(double.maxFinite, AddSize.size30 * 2),
//                     primary: AppTheme.primaryColor,
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     textStyle: const TextStyle(
//                         fontSize: 20, fontWeight: FontWeight.w600)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "${(myCartController.sum.value ?? "").toString()} Items",
//                               style: const TextStyle(
//                                   fontSize: 15,
//                                   color: AppTheme.backgroundcolor,
//                                   fontWeight: FontWeight.w400),
//                             ),
//                             Text(
//                               "\$${(myCartController.model.value.data!.cartPaymentSummary!.subTotal ?? "").toString()}",
//                               style: const TextStyle(
//                                   fontSize: 18,
//                                   color: AppTheme.backgroundcolor,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Row(
//                         children: const [
//                           Text(
//                             "View Cart",
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 color: AppTheme.backgroundcolor,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                           Icon(
//                             Icons.arrow_right,
//                             size: 30,
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: AddSize.size20,
//             ),
//           ],
//         )
//             : SizedBox();
//       }));
// }

// AppBar backAppBar(
//     {required title,
//       required BuildContext context,
//       String dispose = "",
//       Color? backgroundColor = AppTheme.backgroundcolor,
//       Color? textColor = Colors.black,
//       Widget? icon,
//       disposeController}) {
//   return AppBar(
//     toolbarHeight: 60,
//     elevation: 0,
//     leadingWidth: AddSize.size20 * 1.6,
//     backgroundColor: backgroundColor,
//     title: Text(
//       title,
//       style: Theme.of(context).textTheme.headline6!.copyWith(
//           fontWeight: FontWeight.w500, fontSize: 20, color: textColor),
//     ),
//     leading: Padding(
//       padding: EdgeInsets.only(left: AddSize.padding10),
//       child: GestureDetector(
//           onTap: () {
//             Get.back();
//             if (dispose == "dispose") {}
//           },
//           child: icon ??
//               Image.asset(
//                 AppAssets.back,
//                 height: AddSize.size20,
//               )),
//     ),
//   );
// }
//
AppBar backAppBar2(
    {required title,
      required BuildContext context,
      String dispose = "",
      Color? backgroundColor = Colors.transparent,
      Color? textColor = Colors.black,
      Widget? icon,
      disposeController}) {
  return
    AppBar(
      toolbarHeight: 60,
      elevation: 0,
      leadingWidth: AddSize.size20 * 2.0,
      backgroundColor: backgroundColor,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700, fontSize: 20, color: Color(0xff303D48),),
      ),
      leading: Padding(
        padding: EdgeInsets.only(left: AddSize.padding10),
        child: GestureDetector(
            onTap: () {
              Get.back();
              if (dispose == "dispose") {}
            },
            child: Icon(Icons.arrow_back_ios,color: Colors.black,)),
      ),
    );
}

// class AddText extends StatelessWidget {
//   final String? text;
//   final double? fontSize;
//   final double? height;
//   final int? maxLines;
//   final double? letterSpacing;
//   final double? wordSpacing;
//   final String? fontfamily;
//   final FontWeight? fontWeight;
//   final TextAlign? textAlign;
//   final TextOverflow? textOverflow;
//   final TextDecoration? decoration;
//   final Color? color;
//   const AddText({
//     Key? key,
//     required this.text,
//     this.fontSize = 0,
//     this.fontWeight = FontWeight.w500,
//     this.textAlign,
//     this.textOverflow,
//     this.decoration,
//     this.color = Colors.black,
//     this.height = 1,
//     this.fontfamily,
//     this.maxLines,
//     this.letterSpacing,
//     this.wordSpacing,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text!,
//       maxLines: maxLines,
//       overflow: textOverflow,
//       textAlign: textAlign,
//       style: TextStyle(
//           color: color == Colors.black ? AppTheme.userText : color,
//           fontSize: fontSize == 0 ? AddSize.font14 : fontSize,
//           decoration: decoration,
//           height: height,
//           letterSpacing: letterSpacing,
//           fontFamily: fontfamily,
//           wordSpacing: wordSpacing,
//           fontWeight: fontWeight),
//     );
//   }
// }