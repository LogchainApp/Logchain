import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:logchain/models/crypto_currency.dart';
import 'package:logchain/utils/extensions.dart';

import '../widgets/CryptoRow.dart';

typedef OnItemTapCallback = void Function(CryptoCurrency currency);

class SearchList extends StatefulWidget {
  final OnItemTapCallback? onItemTapCallback;
  var currencyList = CryptoCurrency.presets
      .sorted((p0, p1) => p0.name.compareTo(p1.name))
      .reversed
      .toList();

  SearchList({this.onItemTapCallback});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: .0),
          child: Container(
            padding: const EdgeInsets.only(top: 16),
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Hero(
                    tag: "search",
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                      height: 40,
                      child: Material(
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).primaryColorLight,
                        child: TextField(
                          onChanged: (text) {
                            setState(() {
                              widget.currencyList = CryptoCurrency.presets
                                  .where(
                                    (element) =>
                                        text.toLowerCase().isSubsequence(
                                            element.name.toLowerCase()) ||
                                        text.toUpperCase().isSubsequence(
                                              element.symbol,
                                            ),
                                  )
                                  .toList()
                                  .sorted(
                                    (p0, p1) => -p0.changePercents
                                        .compareTo(p1.changePercents),
                                  );
                            });
                          },
                          autofocus: false,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            fillColor: Theme.of(context).primaryColorLight,
                            focusColor: Theme.of(context).primaryColor,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Theme.of(context).primaryColor,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                          child: CryptoRow(
                            currency: widget.currencyList[index],
                            onItemTapCallback: widget.onItemTapCallback,
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(height: 0),
                      itemCount: widget.currencyList.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCurrencyCard(BuildContext context, CryptoCurrency currency) {
    return GestureDetector(
      onTap: () => widget.onItemTapCallback?.call(currency),
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
