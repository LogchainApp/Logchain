import 'package:flutter/material.dart';
import 'package:logchain/models/crypto_currency.dart';
import 'package:logchain/network/network_provider.dart';
import 'package:skeletons/skeletons.dart';

import '../utils/extensions.dart';
import '../widgets/CryptoCard.dart';

typedef OnItemTapCallback = void Function(CryptoCurrency currency);

class MainGrid extends StatelessWidget {
  final OnItemTapCallback? onItemTapCallback;

  MainGrid({this.onItemTapCallback});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        buildTitle(context, "Favourites"),
        buildGrid(
          context,
          CryptoCurrency.presets.where((it) => it.isFavourite).toList(),
        ),
        buildTitle(context, "Trending"),
        buildGrid(
          context,
          CryptoCurrency.presets.sorted(
            (a, b) => -a.change.compareTo(b.change),
          ),
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
                return CryptoCard(
                  currency: snapshot.data!,
                  onItemTapCallback: onItemTapCallback,
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
