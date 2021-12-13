import 'package:flutter/material.dart';
import 'package:logchain/widgets/about_card.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
              color: Theme
                  .of(context)
                  .backgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Icon(Icons.chevron_left, size: 48),
                      ),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("About", style: Theme
                          .of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 48),),
                    ),
                    SizedBox(height: 16),
                    AboutCard(aboutBlock: AboutBlock.Defaults[0]),
                    AboutCard(aboutBlock: AboutBlock.Defaults[1]),
                    AboutCard(aboutBlock: AboutBlock.Defaults[2]),
                    AboutCard(aboutBlock: AboutBlock.Defaults[3])
                  ],
                ),
              ),
            )
        )
    );
  }
}
