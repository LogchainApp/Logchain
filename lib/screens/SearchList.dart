import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:logchain/models/crypto_currency.dart';
import 'package:logchain/utils/extensions.dart';

import '../widgets/CryptoRow.dart';

typedef OnItemTapCallback = void Function(CryptoCurrency currency);

class SearchList extends StatelessWidget {
  final OnItemTapCallback? onItemTapCallback;

  SearchList({this.onItemTapCallback});

  @override
  Widget build(BuildContext context) {
    var currencyList = CryptoCurrency.presets.shuffled();

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).backgroundColor,
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              SizedBox(height: 4),
              Hero(
                tag: "search",
                child: Container(
                  height: 40,
                  child: Material(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).primaryColorLight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        autofocus: false,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          focusColor: Theme.of(context).primaryColor,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Theme.of(context).primaryColor,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return CryptoRow(
                        currency: currencyList[index],
                        onItemTapCallback: onItemTapCallback,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: 16),
                    itemCount: currencyList.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCurrencyCard(BuildContext context, CryptoCurrency currency) {
    return GestureDetector(
      onTap: () => onItemTapCallback?.call(currency),
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.all(Radius.circular(32)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColorDark.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 0,
            )
          ],
        ),
        child: Center(
          child: Text(
            currency.symbol,
            style: Theme.of(context).textTheme.headline6!,
          ),
        ),
      ),
    );
  }
}
