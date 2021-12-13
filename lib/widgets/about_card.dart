import 'package:flutter/material.dart';

class AboutBlock {
  final String title;
  final List<String> about;

  AboutBlock({required this.title, required this.about}) {}

  static List<AboutBlock> Defaults = [
    AboutBlock(title: "Version", about: ["0.0.1"]),
    AboutBlock(title: "Developers", about: [
      "Bogdan Lukin",
      "Egor Baranov",
      "Ilya Zakoulov",
      "Konstantin Fedotov"
    ]),
    AboutBlock(title: "Send Feedback", about: ["github.com/Logchain"]),
    AboutBlock(title: "Made Using", about: ["Flutter in Sirius"]),
  ];
}

class AboutCard extends StatelessWidget {
  final AboutBlock aboutBlock;

  const AboutCard({
    required this.aboutBlock,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 4,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(aboutBlock.title,
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(height: 8),
                  Text(aboutBlock.about.join("\n"),
                      style: Theme.of(context).textTheme.bodyText1)
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
