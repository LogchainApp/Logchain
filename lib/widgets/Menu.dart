import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logchain/models/currency.dart';
import 'package:logchain/widgets/MenuItem.dart';
import 'package:logchain/widgets/MenuButton.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool isNightModeOn = false;
  bool isLiveUpdateOn = false;
  int currentCurrencyIndex = 0;
  List<Currency> currencies = Currency.presets;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            MenuItem(
                icon: Icon(Icons.dark_mode_outlined),
                title: "Night Mode",
                subtitle: this.isNightModeOn ? "On" : "Off",
                isActive: this.isNightModeOn,
                onChanged: () {
                  setState(() {
                    this.isNightModeOn = !this.isNightModeOn;
                  });
                }),
            MenuItem(
                icon: RotatedBox(quarterTurns: 1, child: Icon(Icons.sync_alt)),
                title: "Live Update",
                subtitle: this.isLiveUpdateOn ? "On" : "Off",
                isActive: this.isLiveUpdateOn,
                onChanged: () {
                  setState(() {
                    this.isLiveUpdateOn = !this.isLiveUpdateOn;
                  });
                }),
            MenuItem(
                icon: Icon(Icons.attach_money),
                title: "Currency",
                subtitle: this.currencies[this.currentCurrencyIndex].label,
                isActive: false,
                onChanged: () {
                  setState(() {
                    this.currentCurrencyIndex = (this.currentCurrencyIndex + 1) % this.currencies.length;
                  });
                }),
          ]),
          SizedBox(height: 16),
          MenuButton(icon: Icons.data_usage, title: "Data Usage"),
          MenuButton(icon: Icons.info_outlined, title: "About")
        ])
    );
  }
}
