import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logchain/styles/ColorResources.dart';

class MenuItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final VoidCallback onChanged;
  final bool isActive;
  final bool alwaysLight;

  const MenuItem(
      {required this.icon,
      required this.title,
      required this.subtitle,
      required this.isActive,
      required this.onChanged,
      this.alwaysLight = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 72,
              width: 72,
              child: GestureDetector(
                onTap: this.onChanged,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).shadowColor.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 4),
                    ],
                    color: alwaysLight ? ColorResources.white : (
                        this.isActive
                            ? Theme.of(context).primaryColorDark
                            : Theme.of(context).canvasColor
                    ),
                  ),
                  child: IconTheme.merge(
                    data: IconThemeData(
                      color: alwaysLight ? ColorResources.black : (
                        this.isActive
                          ? Theme.of(context).primaryColorLight
                          : Theme.of(context).primaryColorDark
                      ),
                    ),
                    child: this.icon,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              this.title,
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(fontSize: 14),
            ),
            Text(
              this.subtitle,
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
