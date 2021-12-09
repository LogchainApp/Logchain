import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:logchain/models/Currency.dart';
import 'package:logchain/styles/ColorResources.dart';
import 'package:logchain/styles/TextStyles.dart';
import 'package:logchain/utils/extensions.dart';

typedef OnItemTapCallback = void Function(Currency currency);

class SearchList extends StatelessWidget {
  final OnItemTapCallback? onItemTapCallback;

  SearchList({this.onItemTapCallback});

  @override
  Widget build(BuildContext context) {
    var currencyList = Currency.presets.shuffled();

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.transparent,
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
                    color: ColorResources.grey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        autofocus: false,
                        cursorColor: ColorResources.darkGrey,
                        decoration: InputDecoration(
                          focusColor: ColorResources.darkGrey,
                          prefixIcon: Icon(
                            Icons.search,
                            color: ColorResources.darkGrey,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: ColorResources.grey,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) =>
                        buildCurrencyCard(context, currencyList[index]),
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

  Widget buildCurrencyCard(BuildContext context, Currency currency) {
    return GestureDetector(
      onTap: () => onItemTapCallback?.call(currency),
      child: Container(
        height: 72,
        decoration: BoxDecoration(
            color: ColorResources.white,
            borderRadius: BorderRadius.all(Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                color: ColorResources.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 0,
              )
            ]),
        child: Center(
          child: Text(currency.symbol, style: TextStyles.bold),
        ),
      ),
    );
  }
}
