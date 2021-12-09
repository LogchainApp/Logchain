import 'package:flutter/material.dart';
import 'package:logchain/styles/ColorResources.dart';
import 'package:logchain/styles/TextStyles.dart';

class FilterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: ColorResources.grey),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              rowGroup(context, Icons.arrow_drop_up, "Name"),
              rowGroup(context, Icons.arrow_drop_down, "Vol"),
              rowGroup(context, Icons.arrow_drop_down, "Price"),
              rowGroup(context, Icons.arrow_drop_up, "Chg"),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Icon(
                  Icons.view_agenda_outlined,
                  color: ColorResources.darkGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowGroup(BuildContext context, IconData iconData, String label) {
    return Row(children: [
      Icon(iconData, color: ColorResources.darkGrey),
      SizedBox(width: 8),
      Text(label, style: TextStyles.regular),
    ]);
  }
}
