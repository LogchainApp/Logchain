import 'package:collection/src/iterable_extensions.dart';
import 'package:logchain/models/PeriodType.dart';
import 'package:logchain/models/crypto_currency.dart';
import 'package:flutter/material.dart';
import 'package:logchain/models/currency.dart';
import 'package:logchain/models/period.dart';
import 'package:logchain/screens/search_screen.dart';
import 'package:logchain/styles/ColorResources.dart';
import 'package:logchain/utils/page_routes/fade_page_route.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:logchain/widgets/MenuButton.dart';
import 'package:logchain/widgets/ui_components/BottomDialog.dart';
import 'package:logchain/widgets/ui_components/PeriodPicker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletons/skeletons.dart';
import 'package:interactive_chart/interactive_chart.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../network/network_provider.dart';
import '../providers/UserDataProvider.dart';
import 'Compare.dart';

typedef OnItemTapCallback = void Function(CryptoCurrency currency);

class CryptoPage extends StatefulWidget {
  final CryptoCurrency currency;
  PeriodType periodType;

  CryptoPage({required this.currency, this.periodType = PeriodType.Hours24});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  List<CandleData> _computeTrendLines(List<CandleData> data) {
    final ma7 = CandleData.computeMA(data, 7);

    for (int i = 0; i < data.length; i++) {
      if (i > 0) {
        data[i] = CandleData(
          timestamp: data[i].timestamp,
          open: data[i - 1].close,
          close: data[i].close,
          low: data[i].low,
          high: data[i].high,
          volume: data[i].volume,
        );
      }
      data[i].trends = [ma7[i]];
    }

    data.forEach((element) {
      if ([element.open, element.close, element.high, element.low]
              .contains(double.nan) ||
          element.low! > element.high!) {
        print("NaN");
      }
    });

    print(data.map((e) => e.low).sorted((a, b) => a!.compareTo(b!)).first);
    print(data.map((e) => e.high).sorted((a, b) => a!.compareTo(b!)).last);

    return data;
  }

  @override
  Widget build(BuildContext context) {
    var change = (widget.currency.change >= 0 ? "+\$" : "-\$") +
        widget.currency.change.abs().toStringAsFixed(2) +
        " (${(widget.currency.change / widget.currency.price * 100).toStringAsFixed(2)}%)";
    return Container(
      height: 596,
      child: RefreshIndicator(
        onRefresh: () async {
          Vibrate.feedback(FeedbackType.medium);
          NetworkProvider.instance.fetchPrices();
        },
        color: Theme.of(context).shadowColor,
        backgroundColor: Theme.of(context).canvasColor,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        color:
                                            Theme.of(context).primaryColorDark,
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
                                        color:
                                            Theme.of(context).primaryColorDark,
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
              Divider(height: 16),
              Container(
                height: 64,
                child: PeriodPicker(
                  periodType: widget.periodType,
                  onPeriodChanged: (period) {
                    setState(() {
                      widget.periodType = period.periodType;
                    });
                  },
                ),
              ),
              Divider(height: 16),
              SizedBox(
                height: 256,
                child: FutureBuilder<List<CandleData>>(
                  future: NetworkProvider.instance.fetchMarketChart(
                    cryptoCurrency: widget.currency,
                    currency: Currency.usd,
                    days: Period.from(widget.periodType).days,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data!.length);
                      try {
                        return InteractiveChart(
                          initialVisibleCandleCount: 64,
                          candles: _computeTrendLines(snapshot.data!),
                          onCandleResize: (zoomLevel) {},
                        );
                      } catch (Error) {
                        return SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            shape: BoxShape.rectangle,
                            height: 256,
                            width: double.infinity,
                          ),
                        );
                      }
                    }

                    return SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        shape: BoxShape.rectangle,
                        height: 256,
                        width: double.infinity,
                      ),
                    );
                  },
                ),
              ),
              Divider(height: 16),
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
                        : UserDataProvider.instance
                            .addToFavourite(widget.currency);
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
                        excludedCryptoCurrency: widget.currency,
                        data: NetworkProvider.instance.fetchPrices(),
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
              if (widget.currency.website != "")
                MenuButton(
                  icon: Icons.link,
                  title: "Website",
                  onPressed: () async {
                    await launch(widget.currency.website);
                  },
                ),
              MenuButton(
                icon: Icons.ios_share_rounded,
                title: "Share",
                onPressed: () {
                  Share.share(
                    'https://www.coingecko.com/en/coins/${widget.currency.id}',
                  );
                },
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
