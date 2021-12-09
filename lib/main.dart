import 'package:flutter/material.dart';
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
      home: MyHomePage(title: 'Logchain'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar("Logchain"),
            Expanded(
                child: MainGrid(
              onItemTapCallback: (currency) => {
                BottomDialog.showWithTitle(
                  context,
                  "${currency.name} (${currency.symbol})",
                  height: 0.8,
                )
              },
            )),
          ],
        ),
      ),
    );
  }
}
