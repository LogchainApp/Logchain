import 'package:flutter/material.dart';
import 'package:logchain/models/FilterType.dart';
import 'package:logchain/models/PeriodType.dart';

import 'package:logchain/widgets/PeriodPicker.dart';
import 'package:logchain/widgets/SearchBar.dart';

import 'BottomDialog.dart';
import 'FilterWidget.dart';
import '../screens/Menu.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  final FilterType filterType;
  final PeriodType periodType;

  final PeriodPickerOnChangeCallback? onPeriodChanged;
  final OnFilterChangedCallback? onFilterChangedCallback;

  const CustomAppBar(
    this.title, {
    this.filterType = FilterType.None,
    this.periodType = PeriodType.Hours24,
    this.onPeriodChanged,
    this.onFilterChangedCallback,
    key: const Key("appBar"),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
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
                  child: SearchBar(
                    onItemTapCallback: (currency) {
                      BottomDialog.show(
                        context,
                        title: Text("${currency.name} (${currency.symbol})")
                      );
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: IconButton(
                  iconSize: 48,
                  icon: Image.asset(
                    "assets/icons/menu_icon.png",
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    BottomDialog.show(
                      context,
                      title: Text("Menu"),
                      body: Menu()
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
            child: PeriodPicker(
              onPeriodChanged: onPeriodChanged,
              periodType: this.periodType,
            ),
          ),
          SizedBox(height: 8),
          FilterWidget(
            onFilterChangedCallback: onFilterChangedCallback,
            filterType: this.filterType,
          ),
        ],
      ),
    );
  }
}
