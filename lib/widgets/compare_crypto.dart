import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletons/skeletons.dart';
import 'package:logchain/models/crypto_currency.dart';

class CompareCrypto extends StatelessWidget {
  final CryptoCurrency currency;

  const CompareCrypto({required this.currency, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
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
          SizedBox(height: 8),
          Text(
            currency.symbol,
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(height: 4),
          Text(
            currency.name,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
