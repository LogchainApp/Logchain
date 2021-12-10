import 'dart:ui';

import 'package:logchain/models/crypto_currency.dart';
import 'package:flutter/material.dart';
import 'package:logchain/styles/ColorResources.dart';

typedef OnItemTapCallback = void Function(CryptoCurrency currency);

class CryptoRow extends StatelessWidget {
  final CryptoCurrency currency;
  final OnItemTapCallback? onItemTapCallback;

  CryptoRow({required this.currency, this.onItemTapCallback});

  @override
  Widget build(BuildContext context) {
    var change = (currency.change > 0 ? "\$" : "-\$") +
        currency.change.abs().toStringAsFixed(2) +
        " (${(currency.change / currency.price).toStringAsFixed(2)}%)";
    return GestureDetector(
      onTap: () => onItemTapCallback?.call(currency),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.all(Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 0,
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 16),
          child: Center(
            child: Row(
              children: [
                Image.network(currency.link, width: 36, height: 36),
                SizedBox(width: 16),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            currency.symbol,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            currency.name,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$${currency.price}",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            change,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: currency.change >= 0
                                          ? ColorResources.green
                                          : ColorResources.red,
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
      ),
    );
  }
}
