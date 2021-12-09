import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:logchain/models/Currency.dart';
import 'package:logchain/styles/ColorResources.dart';
import 'package:logchain/styles/TextStyles.dart';

import 'package:logchain/utils/extensions.dart';

typedef OnItemTapCallback = void Function(Currency currency);

class MainGrid extends StatelessWidget {
  late final OnItemTapCallback? onItemTapCallback;

  MainGrid({this.onItemTapCallback});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
      buildTitle(context, "Favourites"),
      buildGrid(
        context,
        Currency.presets
            .shuffled()
            .take(2)
            .map((it) => it.copyWith(isFavourite: true))
            .toList(),
      ),
      buildTitle(context, "Trending"),
      buildGrid(
        context,
        Currency.presets
            .shuffled()
            .take(4)
            .map((it) => it.copyWith(isFavourite: false))
            .toList(),
      ),
    ]);
  }

  Widget buildTitle(BuildContext context, String text) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 16, top: 32),
        child: Text(text, style: TextStyles.title),
      ),
    );
  }

  Widget buildGrid(BuildContext context, List<Currency> currencyList) {
    return SliverPadding(
      padding: EdgeInsets.all(16.0),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => buildCurrencyCard(context, currencyList[index]),
          childCount: currencyList.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
        ),
      ),
    );
  }

  Widget buildCurrencyCard(BuildContext context, Currency currency) {
    return GestureDetector(
      onTap: () => onItemTapCallback?.call(currency),
      child: Container(
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
