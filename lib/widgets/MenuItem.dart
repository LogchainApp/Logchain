import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logchain/styles/ColorResources.dart';
import 'package:logchain/styles/TextStyles.dart';

class MenuItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final VoidCallback onChanged;
  final bool isActive;

  const MenuItem(
      {required this.icon,
      required this.title,
      required this.subtitle,
      required this.isActive,
      required this.onChanged,
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
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    boxShadow: [
                      BoxShadow(
                          color: ColorResources.black.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 4),
                    ],
                    color: this.isActive ? Colors.black : Colors.white,
                  ),
                  child: IconTheme.merge(
                    data: IconThemeData(
                      color: this.isActive ? Colors.white : Colors.black,
                    ),
                    child: this.icon,
                  ))),
        ),
        SizedBox(height: 8),
        Text(this.title, style: TextStyles.bold.copyWith(fontSize: 16)),
        Text(this.subtitle, style: TextStyles.regular.copyWith(fontSize: 14))
      ],
    )));
  }
}
