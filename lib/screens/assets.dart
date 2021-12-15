import 'package:flutter/material.dart';
import 'package:logchain/models/crypto_currency.dart';
import 'package:logchain/network/network_provider.dart';
import 'package:logchain/providers/UserDataProvider.dart';
import 'package:logchain/screens/search_screen.dart';
import 'package:logchain/utils/page_routes/fade_page_route.dart';
import 'package:logchain/widgets/CryptoRow.dart';
import 'package:logchain/widgets/MenuButton.dart';
import 'package:logchain/widgets/about_card.dart';
import 'package:skeletons/skeletons.dart';

class Assets extends StatelessWidget {
  const Assets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 48,
            color: Theme.of(context).shadowColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 128),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Assets",
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(fontSize: 48),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Manage all your assets from one place.",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    TextCard(
                      textBlock: TextBlock(
                        title: "Total",
                        body: ["\$5406.37"],
                      ),
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: (index + 1 ==
                                UserDataProvider.instance.favourites.length
                            ? 16
                            : 0),
                        top: 16,
                      ),
                      child: Container(
                        height: 64,
                        child: FutureBuilder<Map<String, CryptoCurrency>>(
                          future: NetworkProvider.instance.fetchPrices(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return CryptoRow(
                                currency: snapshot.data![UserDataProvider
                                    .instance.favourites[index].symbol]!,
                              );
                            }

                            return SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                borderRadius: BorderRadius.circular(16),
                                shape: BoxShape.rectangle,
                                height: 64,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  childCount: UserDataProvider.instance.favourites.length,
                  addAutomaticKeepAlives: true,
                ),
              ),
              SliverToBoxAdapter(
                child: MenuButton(
                  icon: Icons.add,
                  title: "Add",
                  onPressed: () {
                    Navigator.of(context).push(
                      FadePageRoute(
                        SearchList(
                          data: NetworkProvider.instance.fetchPrices(),
                          onItemTapCallback: (other) {},
                        ),
                        context: context,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
