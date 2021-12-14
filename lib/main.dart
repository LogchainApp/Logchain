import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logchain/models/FilterType.dart';
import 'package:logchain/models/PeriodType.dart';
import 'package:logchain/network/network_provider.dart';
import 'package:logchain/models/crypto_currency.dart';
import 'package:logchain/providers/ThemeProvider.dart';
import 'package:logchain/providers/UserDataProvider.dart';
import 'package:logchain/screens/MainGrid.dart';
import 'package:logchain/screens/actions_menu.dart';
import 'package:logchain/styles/ColorResources.dart';
import 'package:logchain/utils/extensions.dart';
import 'package:logchain/widgets/ui_components/BottomDialog.dart';
import 'package:logchain/widgets/ui_components/CustomAppBar.dart';
import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
import 'screens/CryptoPage.dart';
import 'styles/themes.dart';

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
        body: CryptoPage(currency: currency),
        height: 0.8,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                decoration:
                    BoxDecoration(color: Theme.of(context).backgroundColor),
                child: MainGrid(
                  data: NetworkProvider.instance.fetchPrices(),
                  onItemTapCallback: (currency) => showDetails(currency),
                  onFavouriteTapCallback: (currency) {
                    onFavouritesTapped(currency);
                  },
                  onLongPressCallback: (currency) {
                    setState(() {
                      HapticFeedback.lightImpact();
                      BottomDialog.show(
                          context,
                          // title: Text("Actions"),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Actions"),
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Image.network(currency.pictureLink, width: 44, height: 44),
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
                              }
                          ),
                            height: 0.35
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
