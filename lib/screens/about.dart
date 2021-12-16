import 'package:flutter/material.dart';
import 'package:logchain/widgets/menu_button.dart';
import '../widgets/about_card.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

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
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                height: 800,
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
                            "About",
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(fontSize: 48),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Information about app and developers.",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    TextCard(
                      textBlock: TextBlock(
                        title: "App Version",
                        body: ["0.0.1"],
                      ),
                    ),
                    SizedBox(height: 16),
                    TextCard(
                      textBlock: TextBlock(
                        title: "Developers",
                        body: [
                          "Bogdan Lukin",
                          "Egor Baranov",
                          "Ilya Zakoulov",
                          "Konstantin Fedotov"
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    MenuButton(
                      icon: Icons.bug_report_rounded,
                      title: "Report a bug.",
                    ),
                    SizedBox(height: 16),
                    MenuButton(
                      icon: Icons.link,
                      title: "Subscribe to a channel.",
                    ),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
