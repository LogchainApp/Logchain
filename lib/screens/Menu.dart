import 'package:flutter/material.dart';
import 'package:logchain/models/currency.dart';
import 'package:logchain/providers/ThemeProvider.dart';
import 'package:logchain/styles/themes.dart';
import 'package:logchain/widgets/MenuItem.dart';
import 'package:logchain/widgets/MenuButton.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import 'about.dart';

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
    var _themeProvider = Provider.of<ThemeProvider>(context);
    this.isNightModeOn = _themeProvider.getTheme == dark;

    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        children: [
          Spacer(),
          Row(
            children: [
              MenuItem(
                icon: Icon(Icons.dark_mode_outlined),
                title: "Night Mode",
                subtitle: this.isNightModeOn ? "On" : "Off",
                isActive: this.isNightModeOn,
                onChanged: () {
                  setState(() {
                    this.isNightModeOn = !this.isNightModeOn;
                    _themeProvider.setTheme(
                      this.isNightModeOn ? dark : light,
                    );
                  });
                },
              ),
              MenuItem(
                icon: RotatedBox(quarterTurns: 1, child: Icon(Icons.sync_alt)),
                title: "Live Update",
                subtitle: this.isLiveUpdateOn ? "On" : "Off",
                isActive: this.isLiveUpdateOn,
                onChanged: () {
                  setState(() => this.isLiveUpdateOn = !this.isLiveUpdateOn);
                },
              ),
              MenuItem(
                icon: Icon(Icons.attach_money),
                title: "Currency",
                subtitle: this.currencies[this.currentCurrencyIndex].label,
                isActive: false,
                onChanged: () {
                  setState(
                    () => this.currentCurrencyIndex =
                        (this.currentCurrencyIndex + 1) %
                            this.currencies.length,
                  );
                },
              ),
            ],
          ),
          Spacer(),
          MenuButton(
            icon: Icons.folder_outlined,
            title: "Folders",
            onPressed: () {},
          ),
          Spacer(),
          MenuButton(
            icon: Icons.info_outlined,
            title: "About",
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return About();
                }),
              );
            },
          ),
          Spacer(),
        ],
      ),
    );
  }
}
