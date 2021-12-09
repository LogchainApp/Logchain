import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:logchain/screens/SearchList.dart';
import 'package:logchain/styles/ColorResources.dart';
import 'package:logchain/styles/TextStyles.dart';

typedef OnSearchCallback = void Function();

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
        color: ColorResources.grey,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          splashColor: ColorResources.grey,
          child: Container(
            height: 40,
            width: double.infinity,
            child: Stack(
              alignment: AlignmentDirectional.centerStart,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.search,
                        color: ColorResources.darkGrey,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text("Search crypto", style: TextStyles.regular),
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            onSearchCallback?.call();
            Navigator.of(context)
                .push(PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (_, __, ___) => SearchList(onItemTapCallback: onItemTapCallback)
                ));
          },
        ),
      ),
    );
  }
}
