import 'package:flutter/material.dart';
import 'package:logchain/models/crypto_currency.dart';
import 'package:logchain/providers/UserDataProvider.dart';
import 'package:logchain/widgets/MenuButton.dart';

import 'MainGrid.dart';

typedef OnShowDetailsCallback = void Function(CryptoCurrency currency);

class ActionsMenu extends StatefulWidget {
  final CryptoCurrency cryptoCurrency;
  final OnFavouriteTapCallback onFavouriteTapCallback;
  final OnShowDetailsCallback onShowDetailsCallback;

  const ActionsMenu({
    required this.cryptoCurrency,
    required this.onFavouriteTapCallback,
    required this.onShowDetailsCallback,
    Key? key}) : super(key: key);

  @override
  State<ActionsMenu> createState() => _ActionsMenuState();
}

class _ActionsMenuState extends State<ActionsMenu> {
  @override
  Widget build(BuildContext context) {
    var isFavourite = UserDataProvider.instance.isFavourite(widget.cryptoCurrency);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          MenuButton(
              icon: isFavourite ? Icons.star_border : Icons.star,
              title: isFavourite ? "Remove from favourites" : "Add to favourites",
              onPressed: () {
                setState(() {
                  widget.onFavouriteTapCallback.call(widget.cryptoCurrency);
                });
              }
          ),
          MenuButton(
              icon: Icons.info_outlined,
              title: "Show details",
              onPressed: () => widget.onShowDetailsCallback.call(widget.cryptoCurrency)
          )
        ],
      ),
    );
  }
}
