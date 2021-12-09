import 'package:flutter/material.dart';
import 'package:logchain/models/FilterType.dart';
import 'package:logchain/models/PeriodType.dart';
import 'package:logchain/screens/MainGrid.dart';
import 'package:logchain/styles/themes.dart';
import 'package:logchain/widgets/BottomDialog.dart';
import 'package:logchain/widgets/CustomAppBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Logchain',
      theme: light,
      home: MainPage(title: 'Logchain'),
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
  PeriodType periodType = PeriodType.Hours24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
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
                  this.filterType = filterType;
                });
              },
              filterType: this.filterType,
              periodType: this.periodType,
            ),
            Expanded(
              child: MainGrid(
                onItemTapCallback: (currency) {
                  BottomDialog.show(
                    context,
                    title: Text("${currency.name} (${currency.symbol})"),
                    height: 0.8,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
