import 'package:flutter/material.dart';
import 'package:logchain/models/crypto_currency.dart';
import 'package:logchain/network/network_provider.dart';
import 'package:skeletons/skeletons.dart';

import '../providers/UserDataProvider.dart';
import '../utils/extensions.dart';
import '../widgets/CryptoCard.dart';

typedef OnItemTapCallback = void Function(CryptoCurrency currency);
typedef OnFavouriteTapCallback = void Function(CryptoCurrency currency);

class MainGrid extends StatelessWidget {
  final OnItemTapCallback? onItemTapCallback;
  final OnFavouriteTapCallback? onFavouriteTapCallback;

  MainGrid({this.onItemTapCallback, this.onFavouriteTapCallback});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        ...(UserDataProvider.instance.favourites.isNotEmpty
            ? [
                buildTitle(context, "Favourites"),
                buildGrid(
                  context,
                  UserDataProvider.instance.favourites,
                ),
              ]
            : [SliverToBoxAdapter(child: SizedBox())]),
        buildTitle(context, "Trending"),
        buildGrid(
          context,
          CryptoCurrency.presets
              .sorted((a, b) => a.changePercents.compareTo(b.changePercents))
              .reversed
              .toList(),
        ),
      ],
    );
  }

  Widget buildTitle(BuildContext context, String text) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 16, top: 32),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }

  Widget buildGrid(BuildContext context, List<CryptoCurrency> currencyList) {
    return SliverPadding(
      padding: EdgeInsets.all(16.0),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => FutureBuilder<CryptoCurrency>(
            future: NetworkProvider.instance.fetchCurrency(currencyList[index]),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return AnimatedContainer(
                  curve: Curves.easeInBack,
                  duration: Duration(milliseconds: 600),
                  child: CryptoCard(
                    currency: snapshot.data!,
                    onItemTapCallback: onItemTapCallback,
                    onFavouriteTapCallback: onFavouriteTapCallback,
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
    );
  }
}
