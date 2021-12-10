import 'dart:ui';

import 'package:logchain/models/crypto_currency.dart';
import 'package:flutter/material.dart';
import 'package:logchain/styles/ColorResources.dart';

typedef OnItemTapCallback = void Function(CryptoCurrency currency);

class CryptoCard extends StatelessWidget {
  final CryptoCurrency currency;
  final OnItemTapCallback? onItemTapCallback;

  CryptoCard({required this.currency, this.onItemTapCallback});

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
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(currency.link, width: 48, height: 48),
                Text(
                  currency.symbol,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  currency.name,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Text(
                  "\$${currency.price}",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  change,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: currency.change >= 0
                            ? ColorResources.green
                            : ColorResources.red,
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
