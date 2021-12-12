import 'package:flutter/material.dart';

import 'package:logchain/models/crypto_currency.dart';
import 'package:logchain/network/network_provider.dart';
import 'package:logchain/providers/UserDataProvider.dart';
import 'package:logchain/utils/extensions.dart';

import '../widgets/CryptoRow.dart';

typedef OnItemTapCallback = void Function(CryptoCurrency currency);

class SearchList extends StatefulWidget {
  final OnItemTapCallback? onItemTapCallback;
  final OnFavouriteTapCallback? onFavouriteTapCallback;

  var currencyList = CryptoCurrency.presets
      .sorted((p0, p1) => -p0.changePercents.compareTo(p1.changePercents))
      .toList();

  SearchList({this.onItemTapCallback, this.onFavouriteTapCallback});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          color: Theme.of(context).backgroundColor,
          padding: const EdgeInsets.only(top: 16),
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          setState(
                            () {
                              widget.currencyList = CryptoCurrency.presets
                                  .where(
                                    (element) =>
                                        text.toLowerCase().maxCommonSubsequence(
                                                  element.name.toLowerCase(),
                                                ) >
                                            text.length / 2 ||
                                        text.toUpperCase().maxCommonSubsequence(
                                                  element.symbol,
                                                ) >
                                            text.length / 2,
                                  )
                                  .toList()
                                  .sorted(
                                    (p0, p1) => -p0.changePercents
                                        .compareTo(p1.changePercents),
                                  );
                            },
                          );
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
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: (index + 1 == widget.currencyList.length
                              ? 16
                              : 0),
                          top: 16,
                        ),
                        child: FutureBuilder<CryptoCurrency>(
                          future: NetworkProvider.instance
                              .fetchCurrency(widget.currencyList[index]),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return CryptoRow(
                                currency: snapshot.data!,
                                onItemTapCallback: widget.onItemTapCallback,
                                onFavouriteTapCallback: (currency) {
                                  setState(() {
                                    UserDataProvider.instance
                                            .isFavourite(currency)
                                        ? UserDataProvider.instance
                                            .removeFromFavourite(currency)
                                        : UserDataProvider.instance
                                            .addToFavourite(currency);
                                  });
                                },
                              );
                            }

                            return CryptoRow(
                              currency: widget.currencyList[index],
                              onItemTapCallback: widget.onItemTapCallback,
                              onFavouriteTapCallback: (currency) {
                                setState(() {
                                  UserDataProvider.instance
                                          .isFavourite(currency)
                                      ? UserDataProvider.instance
                                          .removeFromFavourite(currency)
                                      : UserDataProvider.instance
                                          .addToFavourite(currency);
                                });
                              },
                            );
                          },
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
    );
  }
}
