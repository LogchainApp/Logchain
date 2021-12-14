import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logchain/models/crypto_currency.dart';
import 'package:logchain/network/network_provider.dart';
import 'package:skeletons/skeletons.dart';

import '../providers/UserDataProvider.dart';
import '../utils/extensions.dart';
import '../widgets/CryptoCard.dart';

typedef OnItemTapCallback = void Function(CryptoCurrency currency);
typedef OnFavouriteTapCallback = void Function(CryptoCurrency currency);
typedef OnLongPressCallback = void Function(CryptoCurrency currency);

class MainGrid extends StatelessWidget {
  final Future<Map<String, CryptoCurrency>> data;
  final OnItemTapCallback? onItemTapCallback;
  final OnFavouriteTapCallback? onFavouriteTapCallback;
  final OnLongPressCallback? onLongPressCallback;

  MainGrid({
    required this.data,
    this.onItemTapCallback,
    this.onFavouriteTapCallback,
    this.onLongPressCallback
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                toolbarHeight: 28,
                pinned: false,
                shadowColor: Colors.transparent,
                backgroundColor: Theme.of(context).backgroundColor,
                bottom: TabBar(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                  indicatorColor: Colors.transparent,
                  labelColor: Theme.of(context).shadowColor,
                  unselectedLabelColor: Theme.of(context).primaryColor,
                  physics: BouncingScrollPhysics(),
                  isScrollable: true,
                  tabs: [
                    Text("Favourite"),
                    Text("Trending"),
                  ],
                  labelStyle: Theme.of(context).textTheme.headline1,
                  unselectedLabelStyle:
                      Theme.of(context).textTheme.headline1!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: 24,
                          ),
                ),
              ),
            ];
          },
          body: TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              buildGrid(
                context,
                UserDataProvider.instance.favourites.sorted(
                  (a, b) => -a.changePercents.compareTo(b.changePercents),
                ),
              ),
              buildGrid(
                context,
                NetworkProvider.instance.currencyList.sorted(
                  (a, b) => -a.changePercents.compareTo(b.changePercents),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGrid(BuildContext context, List<CryptoCurrency> currencyList) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(16.0),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => FutureBuilder<Map<String, CryptoCurrency>>(
                future: data,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data!.keys);
                    return AnimatedContainer(
                      curve: Curves.easeInBack,
                      duration: Duration(milliseconds: 600),
                      child: CryptoCard(
                        currency: snapshot.data!.values.firstWhere(
                          (element) =>
                              element.symbol == currencyList[index].symbol,
                        ),
                        onItemTapCallback: onItemTapCallback,
                        onFavouriteTapCallback: onFavouriteTapCallback,
                        onLongPressCallback: onLongPressCallback,
                      ),
                    );
                  }

                  return SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      borderRadius: BorderRadius.circular(32),
                      shape: BoxShape.rectangle,
                      width: 96,
                      height: 96,
                    ),
                  );
                },
              ),
              childCount: currencyList.length,
              addAutomaticKeepAlives: true,
              addSemanticIndexes: false,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
            ),
          ),
        ),
      ],
    );
  }
}
