import 'package:flutter/material.dart';
import 'package:logchain/styles/TextStyles.dart';
import 'package:logchain/widgets/DatePicker.dart';
import 'package:logchain/widgets/SearchBar.dart';

import 'BottomDialog.dart';
import 'FilterWidget.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar(
    this.title, {
    key: const Key("appBar"),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      child: Column(
        children: [
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: SearchBar(onItemTapCallback: (currency) {
                    BottomDialog.show(
                      context,
                      title: Text("${currency.name} (${currency.symbol})"),
                      height: 0.8,
                    );
                  }),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: IconButton(
                  iconSize: 48,
                  icon: Image.asset(
                    "assets/icons/menu_icon.png",
                  ),
                  onPressed: () {
                    BottomDialog.show(
                      context,
                      title: Text("Menu"),
                      body: Text("Menu Content", style: TextStyles.title),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 40, child: DatePicker((value) => {})),
          SizedBox(height: 8),
          FilterWidget(),
        ],
      ),
    );
  }
}
