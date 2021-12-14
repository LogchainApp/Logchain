import 'package:logchain/models/crypto_currency.dart';
import 'package:flutter/material.dart';
import 'package:logchain/styles/ColorResources.dart';

import 'package:skeletons/skeletons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/UserDataProvider.dart';

typedef OnItemTapCallback = void Function(CryptoCurrency currency);
typedef OnFavouriteTapCallback = void Function(CryptoCurrency currency);

class CryptoCard extends StatelessWidget {
  final CryptoCurrency currency;
  final OnItemTapCallback? onItemTapCallback;
  final OnFavouriteTapCallback? onFavouriteTapCallback;

  CryptoCard({
    required this.currency,
    this.onItemTapCallback,
    this.onFavouriteTapCallback,
  });

  @override
  Widget build(BuildContext context) {
    var change = (currency.change >= 0 ? "+\$" : "-\$") +
        currency.change.abs().toStringAsFixed(2) +
        " (${(currency.change / currency.price * 100).toStringAsFixed(2)}%)";

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.all(Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 0,
          )
        ],
      ),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(32)),
          splashColor: Colors.transparent,
          onTap: () => onItemTapCallback?.call(currency),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => onFavouriteTapCallback?.call(currency),
                      child: Icon(
                        UserDataProvider.instance.isFavourite(currency)
                            ? Icons.star_rounded
                            : Icons.star_border_rounded,
                        color: UserDataProvider.instance.isFavourite(currency)
                            ? ColorResources.yellow
                            : ColorResources.grey,
                      ),
                    )
                  ],
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 4),
                      CachedNetworkImage(
                        width: 48,
                        height: 48,
                        imageBuilder: (context, imageProvider) =>
                            Image(image: imageProvider),
                        imageUrl: currency.pictureLink,
                        placeholder: (context, url) => SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            shape: BoxShape.circle,
                            width: 48,
                            height: 48,
                          ),
                        ),
                        errorWidget: (context, url, error) => SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            shape: BoxShape.circle,
                            width: 48,
                            height: 48,
                          ),
                        ),
                      ),
                      Text(
                        currency.symbol,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        currency.name,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        "\$${currency.price.toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        change,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: currency.change >= 0
                                  ? ColorResources.green
                                  : ColorResources.red,
                            ),
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
