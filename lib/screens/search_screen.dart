import 'package:flutter/material.dart';

import 'package:logchain/models/crypto_currency.dart';
import 'package:logchain/network/network_provider.dart';
import 'package:logchain/providers/UserDataProvider.dart';
import 'package:logchain/styles/TextStyles.dart';
import 'package:logchain/utils/extensions.dart';

import 'package:skeletons/skeletons.dart';
import '../widgets/CryptoRow.dart';

typedef OnItemTapCallback = void Function(CryptoCurrency currency);

class SearchList extends StatefulWidget {
  final Future<Map<String, CryptoCurrency>> data;
  final OnItemTapCallback? onItemTapCallback;
  final OnFavouriteTapCallback? onFavouriteTapCallback;
  final String hintText;
  final CryptoCurrency? excludedCryptoCurrency;

  var currencyList = NetworkProvider.instance.currencyList
      .sorted((p0, p1) => -p0.changePercents.compareTo(p1.changePercents))
      .toList();

  SearchList({
    required this.data,
    this.onItemTapCallback,
    this.onFavouriteTapCallback,
    this.hintText = "Search crypto",
    this.excludedCryptoCurrency = null,
  }) {
    currencyList = CryptoCurrency.presets
        .where((element) => element.id != excludedCryptoCurrency?.id)
        .toList()
        .sorted((p0, p1) => -p0.changePercents.compareTo(p1.changePercents))
        .toList();
  }

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Hero(
                  tag: "search",
                  child: Container(
                    height: 40,
                    child: Material(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).primaryColorLight,
                      child: TextFormField(
                        onChanged: (text) {
                          setState(() {
                            widget.currencyList = NetworkProvider
                                .instance.currencyList
                                .where(
                                  (element) =>
                                      text.toLowerCase().maxCommonSubsequence(
                                                element.name.toLowerCase(),
                                              ) >=
                                          text.length / 2 ||
                                      text.toUpperCase().maxCommonSubsequence(
                                                element.symbol,
                                              ) >=
                                          text.length / 2,
                                )
                                .toList()
                                .sorted(
                                  (p0, p1) => -p0.changePercents
                                      .compareTo(p1.changePercents),
                                );
                          });
                        },
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyles.regular,
                        autofocus: false,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          hintText: widget.hintText,
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
              SizedBox(width: 4),
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Cancel",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!,
                ),
              )
            ],
          ),
        ),
        shadowColor: Theme.of(context).shadowColor.withOpacity(0.1),
        elevation: 16,
        toolbarHeight: 80,
        backgroundColor: Theme.of(context).backgroundColor,
        automaticallyImplyLeading: false,
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: (index + 1 == widget.currencyList.length ? 16 : 0),
                    top: 16,
                  ),
                  child: Container(
                    height: 64,
                    child: FutureBuilder<Map<String, CryptoCurrency>>(
                      future: widget.data,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return CryptoRow(
                            currency: snapshot
                                .data![widget.currencyList[index].symbol]!,
                            onItemTapCallback: widget.onItemTapCallback,
                            onFavouriteTapCallback: (currency) {
                              setState(() {
                                UserDataProvider.instance.isFavourite(currency)
                                    ? UserDataProvider.instance
                                    .removeFromFavourite(currency)
                                    : UserDataProvider.instance
                                    .addToFavourite(currency);
                              });
                            },
                          );
                        }

                        return SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            borderRadius: BorderRadius.circular(16),
                            shape: BoxShape.rectangle,
                            height: 64,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              childCount: widget.currencyList.length,
              addAutomaticKeepAlives: true,
            ),
          )
        ],
      ),
    );
  }
}
