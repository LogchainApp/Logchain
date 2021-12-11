import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class BottomDialog {
  static void show(
    BuildContext context, {
    Widget? title,
    Widget? body,
    double height: 0.5,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      barrierColor: Theme.of(context).shadowColor.withOpacity(0.1),
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
          height: MediaQuery.of(context).size.height * height,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                Expanded(child: body ?? Spacer()),
              ],
            ),
          ),
        );
      },
    );
  }
}
