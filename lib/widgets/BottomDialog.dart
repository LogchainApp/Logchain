import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BottomDialog {
  static void show(BuildContext context,
      {Widget? title, Widget? body}) {
    showModalBottomSheet(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => Wrap(
        children: [
          Padding(
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
                      color: Theme
                              .of(context)
                              .primaryColorLight,
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: DefaultTextStyle(
                        style: Theme.of(context).textTheme.headline1!,
                        child: title ?? Spacer(),
                      ),
                    ),
                    Expanded(child: Center(child: body)),
                  ],
                ),
                Center(child: body),
              ],
            ),
          )
        ],
      ),
    );
  }
}
