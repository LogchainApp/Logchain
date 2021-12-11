import 'dart:ui';

import 'package:logchain/models/crypto_currency.dart';
import 'package:flutter/material.dart';
import 'package:logchain/styles/ColorResources.dart';
import 'package:logchain/utils/extensions.dart';
import 'package:logchain/widgets/ui_components/BottomDialog.dart';
import 'package:logchain/widgets/ui_components/PeriodPicker.dart';

typedef OnItemTapCallback = void Function(CryptoCurrency currency);

class CryptoPage extends StatelessWidget {
  final CryptoCurrency currency;

  CryptoPage({required this.currency});

  @override
  Widget build(BuildContext context) {
    var change = (currency.change > 0 ? "+\$" : "-\$") +
        currency.change.abs().toStringAsFixed(2) +
        " (${(currency.change / currency.price * 100).toStringAsFixed(2)}%)";
    return Container(
      height: 596,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(currency.pictureLink, width: 64, height: 64),
                  SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        "Change",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        "Volume",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$${currency.price.toStringAsFixed(2)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: Theme.of(context).primaryColorDark,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              change,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: currency.change >= 0
                                        ? ColorResources.green
                                        : ColorResources.red,
                                  ),
                            ),
                            Text(
                              "2.60B",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: Theme.of(context).primaryColorDark,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(height: 64, child: PeriodPicker()),
          Divider(),
        ],
      ),
    );
  }
}
