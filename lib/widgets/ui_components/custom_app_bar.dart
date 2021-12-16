import 'package:flutter/material.dart';
import 'package:logchain/models/filter_type.dart';
import 'package:logchain/models/period_type.dart';
import 'package:logchain/screens/crypto_page.dart';

import 'package:logchain/widgets/ui_components/period_picker.dart';
import 'package:logchain/widgets/ui_components/filter_widget.dart';
import 'package:logchain/widgets/ui_components/search_bar.dart';
import 'package:logchain/widgets/ui_components/bottom_dialog.dart';

import '../../screens/menu.dart';

class CustomAppBar extends StatelessWidget {
  final FilterType filterType;
  final FilterOrder filterOrder;
  final PeriodType periodType;

  final PeriodPickerOnChangeCallback? onPeriodChanged;
  final OnFilterChangedCallback? onFilterChangedCallback;

  const CustomAppBar({
    this.filterType = FilterType.None,
    this.filterOrder = FilterOrder.Increasing,
    this.periodType = PeriodType.Hours24,
    this.onPeriodChanged,
    this.onFilterChangedCallback,
    key: const Key("appBar"),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      height: 128,
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
                  padding: EdgeInsets.only(left: 16),
                  child: SearchBar(
                    onItemTapCallback: (currency) {
                      BottomDialog.show(
                        context,
                        title: Text(
                          "${currency.name} (${currency.symbol})",
                        ),
                        body: CryptoPage(currency: currency),
                        height: 0.8,
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
                      body: Menu(),
                      height: 0.64,
                    );
                  },
                ),
              ),
            ],
          ),
          Container(
            height: 48,
            child: PeriodPicker(
              onPeriodChanged: onPeriodChanged,
              periodType: this.periodType,
            ),
          ),
        ],
      ),
    );
  }
}
