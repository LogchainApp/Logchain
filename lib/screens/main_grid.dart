import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logchain/models/crypto_currency.dart';
import 'package:logchain/network/network_provider.dart';
import 'package:skeletons/skeletons.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

import '../providers/user_data_provider.dart';
import '../utils/extensions.dart';
import '../widgets/crypto_card.dart';

typedef OnItemTapCallback = void Function(CryptoCurrency currency);
typedef OnFavouriteTapCallback = void Function(CryptoCurrency currency);
typedef OnLongPressCallback = void Function(CryptoCurrency currency);

typedef Comparator<T> = int Function(T, T);

class MainGrid extends StatelessWidget {
  final Future<Map<String, CryptoCurrency>> data;
  final OnItemTapCallback? onItemTapCallback;
  final OnFavouriteTapCallback? onFavouriteTapCallback;
  final OnLongPressCallback? onLongPressCallback;

  MainGrid({
    required this.data,
    this.onItemTapCallback,
    this.onFavouriteTapCallback,
    this.onLongPressCallback,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 5,
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
                    Text("Price"),
                    Text("Volume"),
                    Text("A-Z"),
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
                UserDataProvider.instance.favourites,
                (a, b) => -a.changePercents.compareTo(b.changePercents),
              ),
              buildGrid(
                context,
                NetworkProvider.instance.currencyList,
                (a, b) => -a.changePercents.compareTo(b.changePercents),
              ),
              buildGrid(
                context,
                NetworkProvider.instance.currencyList,
                (a, b) => -a.price.compareTo(b.price),
              ),
              buildGrid(
                context,
                NetworkProvider.instance.currencyList,
                (a, b) => -a.changePercents.compareTo(b.changePercents),
              ),
              buildGrid(
                context,
                NetworkProvider.instance.currencyList,
                (a, b) => a.symbol.compareTo(b.symbol),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGrid(
    BuildContext context,
    List<CryptoCurrency> currencyList,
    Comparator<CryptoCurrency> comparator,
  ) {
    return RefreshIndicator(
      color: Theme.of(context).shadowColor,
      backgroundColor: Theme.of(context).canvasColor,
      onRefresh: () async {
        Vibrate.feedback(FeedbackType.medium);
        NetworkProvider.instance.fetchPrices();
      },
      child: CustomScrollView(
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
                      var tmp = currencyList
                          .map((e) => snapshot.data![e.symbol])
                          .toList()
                          .sorted((p0, p1) => comparator(p0, p1));
                      print(snapshot.data!.keys);
                      return AnimatedContainer(
                        curve: Curves.easeInBack,
                        duration: Duration(milliseconds: 600),
                        child: CryptoCard(
                          currency: tmp[index]!,
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
      ),
    );
  }
}
