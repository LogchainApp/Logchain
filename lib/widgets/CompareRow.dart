import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logchain/models/crypto_currency.dart';

class CompareRow extends StatelessWidget {
  final String title;
  final Widget leftValue;
  final Widget rightValue;
  final bool showDivider;

  const CompareRow({
    required this.title,
    required this.leftValue,
    required this.rightValue,
    this.showDivider = true,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyText1),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: Center(child: leftValue)),
            Expanded(child: Center(child: rightValue))
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Visibility(child: Divider(), visible: showDivider,),
        )
      ],
    );
  }
}
