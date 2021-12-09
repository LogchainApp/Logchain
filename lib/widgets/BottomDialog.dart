import 'dart:ui';

import 'package:flutter/material.dart';

class BottomDialog {
  static void show(BuildContext context, {Widget? title, Widget? body}) {
    showModalBottomSheet(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          topLeft: Radius.circular(32),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(32),
                  topLeft: Radius.circular(32),
                ),
              ),
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
                    Center(child: body),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
