import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
class BottomDialog {
  static void show(BuildContext context, {Widget? title, Widget? body, double height: 0.5}) {

    showMaterialModalBottomSheet(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          topLeft: Radius.circular(32),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
            ),
          ),
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
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.headline1!,
                      child: title ?? Spacer(),
                    ),
                  ),
                  if (body != null) Expanded(child: body),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
