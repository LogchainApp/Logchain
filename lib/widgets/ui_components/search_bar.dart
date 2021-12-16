import 'package:flutter/material.dart';
import 'package:logchain/models/crypto_currency.dart';
import 'package:logchain/styles/text_styles.dart';

import '../../network/network_provider.dart';
import '../../screens/search_screen.dart';
import '../../utils/page_routes/fade_page_route.dart';

typedef OnSearchCallback = void Function();
typedef OnItemTapCallback = void Function(CryptoCurrency currency);

class SearchBar extends StatelessWidget {
  final OnSearchCallback? onSearchCallback;
  final OnItemTapCallback? onItemTapCallback;

  SearchBar({this.onSearchCallback, this.onItemTapCallback});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "search",
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Theme.of(context).primaryColorLight,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          splashColor: Theme.of(context).primaryColorLight,
          child: Container(
            height: 40,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                    size: 24,
                  ),
                ),
                SizedBox(width: 8),
                Text("Search crypto", style: TextStyles.regular),
                SizedBox(width: 32),
              ],
            ),
          ),
          onTap: () {
            onSearchCallback?.call();
            Navigator.of(context).push(
              FadePageRoute(
                SearchList(
                  data: NetworkProvider.instance.fetchPrices(),
                  onItemTapCallback: onItemTapCallback,
                ),
                context: context,
              ),
            );
          },
        ),
      ),
    );
  }
}
