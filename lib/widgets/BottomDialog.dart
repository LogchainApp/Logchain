import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:logchain/styles/ColorResources.dart';
import 'package:logchain/styles/TextStyles.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BottomDialog {
  static void showWithTitle(BuildContext context, String title,
          {Widget? body, double height = 0.5}) =>
      show(
        context,
        title: Text(title, style: TextStyles.title),
        body: body,
        height: height,
      );

  static void show(BuildContext context,
      {Widget? title, Widget? body, double height = 0.5}) {
    showMaterialModalBottomSheet(
      backgroundColor: ColorResources.lightGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      context: context,
      builder: (context) => Container(
        child: FractionallySizedBox(
          heightFactor: height,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 8,
                    width: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      color: ColorResources.grey,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: title ?? Spacer(),
                ),
                Expanded(child: Center(child: body)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
