import 'package:logchain/models/crypto_currency.dart';
import 'package:flutter/material.dart';
import 'package:logchain/screens/search_screen.dart';
import 'package:logchain/styles/ColorResources.dart';
import 'package:logchain/utils/page_routes/fade_page_route.dart';
import 'package:logchain/widgets/MenuButton.dart';
import 'package:logchain/widgets/ui_components/BottomDialog.dart';
import 'package:logchain/widgets/ui_components/PeriodPicker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletons/skeletons.dart';

import '../providers/UserDataProvider.dart';
import 'Compare.dart';

typedef OnItemTapCallback = void Function(CryptoCurrency currency);

class CryptoPage extends StatefulWidget {
  final CryptoCurrency currency;

  CryptoPage({required this.currency});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  @override
  Widget build(BuildContext context) {
    var change = (widget.currency.change >= 0 ? "+\$" : "-\$") +
        widget.currency.change.abs().toStringAsFixed(2) +
        " (${(widget.currency.change / widget.currency.price * 100).toStringAsFixed(2)}%)";
    return Container(
      height: 596,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    width: 64,
                    height: 64,
                    imageBuilder: (context, imageProvider) =>
                        Image(image: imageProvider),
                    imageUrl: widget.currency.pictureLink,
                    placeholder: (context, url) => SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        shape: BoxShape.circle,
                        width: 64,
                        height: 64,
                      ),
                    ),
                    errorWidget: (context, url, error) => SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        shape: BoxShape.circle,
                        width: 64,
                        height: 64,
                      ),
                    ),
                  ),
                  SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        "Change",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        "Volume",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$${widget.currency.price.toStringAsFixed(2)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: Theme.of(context).primaryColorDark,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              change,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: widget.currency.change >= 0
                                        ? ColorResources.green
                                        : ColorResources.red,
                                  ),
                            ),
                            Text(
                              "2.60B",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: Theme.of(context).primaryColorDark,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(height: 64, child: PeriodPicker()),
          Divider(),
          MenuButton(
            icon: UserDataProvider.instance.isFavourite(widget.currency)
                ? Icons.star_border_rounded
                : Icons.star_rounded,
            title: UserDataProvider.instance.isFavourite(widget.currency)
                ? "Remove from favourites"
                : "Add to favourites",
            onPressed: () {
              setState(() {
                UserDataProvider.instance.isFavourite(widget.currency)
                    ? UserDataProvider.instance
                        .removeFromFavourite(widget.currency)
                    : UserDataProvider.instance.addToFavourite(widget.currency);
              });
            },
          ),
          MenuButton(
            icon: Icons.sync_alt,
            title: "Compare",
            onPressed: () {
              Navigator.of(context).push(
                FadePageRoute(
                  SearchList(
                    hintText: "Compare ${widget.currency.symbol} with...",
                    onItemTapCallback: (other) {
                      BottomDialog.show(
                        context,
                        title: Text("Compare"),
                        body: Compare(
                          cryptoCurrencyLeft: widget.currency,
                          cryptoCurrencyRight: other,
                        ),
                        height: 0.8,
                      );
                    },
                  ),
                  context: context,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
