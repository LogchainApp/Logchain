import 'package:flutter/material.dart';
import 'package:logchain/screens/about.dart';

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
      child: Row(
        // direction: Axis.horizontal,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).shadowColor.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 4)
                  ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(aboutBlock.title, style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 8),
                    Text(aboutBlock.about.join("\n"), style: Theme.of(context).textTheme.bodyText1)
                  ],
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
