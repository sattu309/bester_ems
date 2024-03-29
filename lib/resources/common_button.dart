import 'package:ecom_demo/resources/add_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'dimension.dart';

class CommonButtonGreen extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const CommonButtonGreen({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return

      Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          // color: AppTheme.buttonColor
      ),
      child:
      ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(AddSize.screenWidth, AddSize.size50 * 1.1),
            backgroundColor: AppTheme.buttonColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // <-- Radius
            ),
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: .5,
                      fontSize: 15)),
              addWidth(5),
              const Icon(Icons.arrow_forward_outlined,size: 17,)
            ],
          )),
    );
  }
}

class CommonButtonGreen1 extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const CommonButtonGreen1({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return

      Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          // color: AppTheme.buttonColor
      ),
      child:
      ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(AddSize.screenWidth, AddSize.size50 * 1.1),
            backgroundColor: AppTheme.buttonColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // <-- Radius
            ),
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: .5,
                      fontSize: 15)),
            ],
          )),
    );
  }
}
