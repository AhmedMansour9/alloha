import 'package:alloha/util/images.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  late final String title;
  late final bool isBackButtonExist;
  Function? onBackPressed;
  late final BuildContext context;

  CustomAppBar(
      {this.isBackButtonExist = true, required this.context, onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Imagess.logo,
            height: 60,
            width: 120,
          ),
          Spacer(),
          isBackButtonExist
              ? GestureDetector(
                  onTap: onBackPressed!(),
                  child: Image.asset(
                    Imagess.back,
                  ))
              : SizedBox()
        ],
      ),
    );
  }
}
