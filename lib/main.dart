import 'package:flutter/material.dart';
import 'package:logchain/models/FilterType.dart';
import 'package:logchain/models/PeriodType.dart';
import 'package:logchain/providers/ThemeProvider.dart';
import 'package:logchain/providers/UserDataProvider.dart';
import 'package:logchain/screens/MainGrid.dart';
import 'package:logchain/styles/ColorResources.dart';
import 'package:logchain/utils/extensions.dart';
import 'package:logchain/widgets/ui_components/BottomDialog.dart';
import 'package:logchain/widgets/ui_components/CustomAppBar.dart';
import 'package:provider/provider.dart';
import 'network/network_provider.dart';
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
        ChangeNotifierProvider(create: (_) => ThemeProvider(light)),
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
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Logchain',
              theme: context.watch<ThemeProvider>().getTheme,
              darkTheme: dark,
              home: MainPage(title: 'Logchain'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustomAppBar(
              "Logchain",
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
            Expanded(
              child: Container(
                decoration:
                    BoxDecoration(color: Theme.of(context).backgroundColor),
                child: MainGrid(
                  onItemTapCallback: (currency) {
                    BottomDialog.show(
                      context,
                      title: Text(
                        "${currency.name} (${currency.symbol})",
                      ),
                      body: CryptoPage(currency: currency),
                    );
                  },
                  onFavouriteTapCallback: (currency) {
                    setState(() {
                      UserDataProvider.instance.isFavourite(currency)
                          ? UserDataProvider.instance
                              .removeFromFavourite(currency)
                          : UserDataProvider.instance.addToFavourite(currency);
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
