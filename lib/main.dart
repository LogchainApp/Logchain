import 'package:flutter/material.dart';
import 'package:logchain/models/filter_type.dart';
import 'package:logchain/models/period_type.dart';
import 'package:logchain/network/network_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:logchain/models/crypto_currency.dart';
import 'package:logchain/providers/theme_provider.dart';
import 'package:logchain/providers/user_data_provider.dart';
import 'package:logchain/screens/main_grid.dart';
import 'package:logchain/screens/actions_menu.dart';
import 'package:logchain/styles/color_resources.dart';
import 'package:logchain/utils/extensions.dart';
import 'package:logchain/widgets/ui_components/bottom_dialog.dart';
import 'package:logchain/widgets/ui_components/custom_app_bar.dart';
import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:skeletons/skeletons.dart';
import 'screens/crypto_page.dart';
import 'styles/themes.dart';
import 'package:candlesticks/candlesticks.dart';

void main() async {
  await NetworkProvider.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Builder(
        builder: (context) {
          return SkeletonTheme(
            shimmerGradient: LinearGradient(
              colors: [
                ColorResources.lightGrey.avgWith(ColorResources.grey),
                ColorResources.grey,
                ColorResources.lightGrey.avgWith(ColorResources.grey),
              ],
              stops: [0.1, 0.5, 0.9],
            ),
            themeMode: context.watch<ThemeProvider>().getTheme == dark
                ? ThemeMode.dark
                : ThemeMode.light,
            child: BackGestureWidthTheme(
              backGestureWidth: BackGestureWidth.fraction(1 / 2),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Logchain',
                theme: context.watch<ThemeProvider>().getTheme,
                darkTheme: dark,
                home: MainPage(title: 'Logchain'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  FilterType filterType = FilterType.None;
  FilterOrder filterOrder = FilterOrder.Increasing;

  PeriodType periodType = PeriodType.Hours24;

  @override
  void initState() {
    super.initState();
  }

  void onFavouritesTapped(CryptoCurrency currency) {
    setState(() {
      UserDataProvider.instance.isFavourite(currency)
          ? UserDataProvider.instance.removeFromFavourite(currency)
          : UserDataProvider.instance.addToFavourite(currency);
    });
  }

  void showDetails(CryptoCurrency currency) {
    setState(() {
      BottomDialog.show(
        context,
        title: Text(
          "${currency.name} (${currency.symbol})",
        ),
        body: CryptoPage(currency: currency, defaultPeriodType: periodType),
        height: 0.8,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 128,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        shadowColor: Theme.of(context).shadowColor.withOpacity(0.1),
        title: CustomAppBar(
          onPeriodChanged: (period) {
            setState(() {
              this.periodType = period.periodType;
            });
          },
          onFilterChangedCallback: (filterType) {
            setState(() {
              if (this.filterType == filterType) {
                if (filterOrder == FilterOrder.Increasing) {
                  this.filterOrder = FilterOrder.Decreasing;
                } else {
                  this.filterOrder == FilterOrder.Increasing;
                  this.filterType = FilterType.None;
                }
              } else {
                this.filterType = filterType;
                this.filterOrder = FilterOrder.Increasing;
              }
            });
          },
          filterType: this.filterType,
          filterOrder: this.filterOrder,
          periodType: this.periodType,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                ),
                child: MainGrid(
                  data: NetworkProvider.instance.fetchPrices(),
                  onItemTapCallback: (currency) => showDetails(currency),
                  onFavouriteTapCallback: (currency) {
                    onFavouritesTapped(currency);
                  },
                  onLongPressCallback: (currency) {
                    setState(() {
                      Vibrate.feedback(FeedbackType.medium);
                      BottomDialog.show(
                        context,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Actions"),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: CachedNetworkImage(
                                width: 36,
                                height: 36,
                                imageBuilder: (context, imageProvider) =>
                                    Image(image: imageProvider),
                                imageUrl: currency.pictureLink,
                                placeholder: (context, url) => SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                    shape: BoxShape.circle,
                                    width: 36,
                                    height: 36,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                    shape: BoxShape.circle,
                                    width: 36,
                                    height: 36,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        body: ActionsMenu(
                          cryptoCurrency: currency,
                          onFavouriteTapCallback: (currency) {
                            onFavouritesTapped(currency);
                          },
                          onShowDetailsCallback: (currency) {
                            showDetails(currency);
                          },
                        ),
                        height: 0.35,
                      );
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
