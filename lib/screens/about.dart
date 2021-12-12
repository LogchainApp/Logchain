import 'package:flutter/material.dart';
import 'package:logchain/widgets/about_card.dart';

class AboutBlock {
  final String title;
  final List<String> about;

  AboutBlock({
    required this.title,
    required this.about
  }) {
  
  }

  static List<AboutBlock> DEFAULTS = [
    AboutBlock(title: "Version", about: ["0.0.1"]),
    AboutBlock(title: "Developers", about: ["Bogdan Lukin", "Egor Baranov", "Ilya Zakoulov", "Konstantin Fedotov"]),
    AboutBlock(title: "Send Feedback", about: ["github.com/Logchain"]),
    AboutBlock(title: "Made Using", about: ["Flutter in Sirius"]),
  ];
}

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.chevron_left, size: 32),
                    ),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("About", style: Theme.of(context).textTheme.headline1),
                  ),
                  SizedBox(height: 36),
                  AboutCard(aboutBlock: AboutBlock.DEFAULTS[0]),
                  AboutCard(aboutBlock: AboutBlock.DEFAULTS[1]),
                  AboutCard(aboutBlock: AboutBlock.DEFAULTS[2]),
                  AboutCard(aboutBlock: AboutBlock.DEFAULTS[3])
                  // ListView.separated(
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return AboutCard(aboutBlock: AboutBlock.DEFAULTS[index]);
                  //     },
                  //     separatorBuilder: (BuildContext context, int index) => SizedBox(height: 16),
                  //     itemCount: AboutBlock.DEFAULTS.length
                  // )
                ],
              ),
            ),
          )
        )
    );
  }
}
