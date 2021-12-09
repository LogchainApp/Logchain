import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logchain/styles/ColorResources.dart';
import 'package:logchain/styles/TextStyles.dart';


class MenuButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String title;

  const MenuButton({
    required this.icon,
    required this.title,
    this.onPressed,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                    color: ColorResources.black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 4
                )
              ]
          ),
          child:
          GestureDetector(
              onTap: this.onPressed,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(16)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Row(
                    children: [
                      Icon(
                        this.icon
                      ),
                      SizedBox(
                        width: 16
                      ),
                      Text(
                        this.title,
                        style: TextStyles.bold
                      )
                    ]
                  )
                )
              )
          )
        )
    );
  }
}
